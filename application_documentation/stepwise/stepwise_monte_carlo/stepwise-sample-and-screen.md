#StepWiseSampleAndScreen
`StepWiseSampleAndScreen` carries out the main loop for stepwise sampling, either in enumerative mode or in stochastic mode. Look in `src/protocols/stepwise/modeler/StepWiseConnectionSampler` for example setup.

#Ingredients
------------
`StepWiseSampleAndScreen` is initialized with two things:

• a `StepWiseSampler` objects which delineates the degrees of freedom to be sampled, their discrete values, and what order these go in. There are some tricks here to handle rigid body sampling. This `StepWiseSampler` object is typically itself the composition of several `StepWiseSampler` objects.

• a vector of `StepWiseScreener` objects which delineate the gauntlet of filters, packers, and loop closers that are run after each sample is applied to the pose. Having these screeners in a particular order can accelerate sampling, and in a few cases there are some dependencies (e.g. a pose selection screener should go last, after side-chain packers, and after any loop closers pinpoint the backbone).

The architectures of each of these objects are described in the [[StepWiseSampler|stepwise-sampler]] and [[StepWiseScreener|stepwise-screener]] pages.

#How to use
-----------
**Not checked yet**
```
  StepWiseSamplerBaseOP sampler = new StepWiseSampler;
  //  initialize -- see link to documentation for StepWiseSampler...
  sampler->set_random( true );

  utility::vector1< screener::StepWiseScreenerOP > screeners_;
  //  initialize -- see link to documentation for StepWiseScreener...
  clusterer_ = new align::StepWiseClusterer( options_ );
  screeners_.push_back( new PoseSelectionScreener( pose, scorefxn_, clusterer_ ) );

  StepWiseSampleAndScreen sample_and_screen( sampler, screeners );
  sample_and_screen.set_verbose( true );
  sample_and_screen.set_max_ntries( 100 ); // if sampler is in random mode
  sample_and_screen.set_num_random_samples( 5 ); // find 5 poses 
  sample_and_screen.run();

  pose_list_ = clusterer_->pose_list(); // list of up to 5 poses in the last screener.

```

# Why its written in this way
-----------------------------
Basically this object replaces the massive loops within loops within loops that originally plagued the `stepwise` code. We replaced it because:

• With the old nested loops:

 - It was hard to add in new functionalities
 - It was hard to change the order of different screens/filters/actions. 
 - Memory effects: e.g., if side-chains were packed at some point in the loop, we didn't always remember to reinitialize them before checking the next backbone configuration.
 - For speed, we hold different poses with different sets of ResidueTypeVariants (changing those out, e.g. to add chainbreak variants, is costly in Rosetta). Again, keeping track of which poses had accepted the backbone samples, etc., was getting complicated.

The StepWiseSampleAndScreen mostly solves these issues.
 
• Another good feature of the StepWiseSampleAndScreen framework: it  only saves poses into memory when they've passed  all the screens. That allows it to handle sampling calculations that literally enumerate through tens of millions of samples. Alternatives that we considered, where we passed lists of Poses serially through different samplers, led to memory explosions.


#The main loop
--------------
The way these objects works is best seen in the code itself, which is really short, actually:

```
	for ( sampler_->reset(); sampler_->not_end(); ++( *sampler_ ) ) {

			if ( sampler_->random() && ( num_tries() >= max_ntries_ || num_successes() >= num_random_samples_ ) ) break;
			update_movers->clear();
			restore_movers->clear();
			set_ok_to_increment();

			for ( n = 1; n <= num_screeners(); n++ ){

				StepWiseScreenerOP screener = screeners_[ n ];
				screener->get_update( sampler_ );
				if ( n > 1 ) screener->apply_mover( update_movers, 1, n - 1 ); //info from previous screeners.

				if ( screener->check_screen() ){
					screener->increment_count();
					screener->add_mover( update_movers, restore_movers );
					early_exit_check( n ); // for debugging.
				} else {
					screener->fast_forward( sampler_ );	break;
				}
			} // check screens

			Size const last_passed_screener = n - 1;
			for ( Size m = 2; m <= last_passed_screener; m++ ) screeners_[ m ]->apply_mover( restore_movers, m - 1, 1 );

		} // sampler
```

# Notes on the code steps.
--------------------------
• Note that this `StepWiseSampleAndScreen` does **not** take a `pose`! Instead the various poses at play are encoded in the `StepWiseScreener` objects, which hold the actual pose that is displayed in graphics, copies of the pose, a collection of poses (e.g. for the final clustering step), or no pose at all (e.g., in rigid body docking some Screeners just manipulate Stubs for speed).

• As promised, the main loop involves traversing through the `StepWiseSampler` in `sampler`.

• Stochastic sampling involves setting `choose_random()` to true. In this case the sampling proceeds until `num_random_samples` poses are found. 

• Enumerative sampling involves setting `choose_random()` to galse. In this case the sampling proceeds until the `sampler_` is exhausted, i.e., when `sampler_->not_end()` returns `false`. There is a way to stop early for integration tests (a type of `StepWiseScreener` called `IntegrationTestBreaker`, equivalent to a `break` in a loop).

• At the heart of the loop through the `screeners_` gauntlet, is the `check_screen()`. If pass, we increment that screener's counter. This allows the output of a final 'cut table' at the end of the `StepWiseSampleAndScreen` via `output_counts()`. If we do not pass the check, the screener may hold instructions on how to `fast-forward` through the sampler loop. The latter action is equivalent to a `continue` in a loop.

• The `update_movers` objects store information that can be passed from one `StepWiseScreener` to later ones. For example, if early on, there is a ProteinCCD_ClosureScreener, it solves for backbone torsions that close a loop within its own private pose, and then encodes the application of those torsions into a Mover (see `screener->add_mover` line). That mover is passed to later screeners (e.g., packers) holding their own private copies of the pose with potentially different variants or sequences -- they apply the closure solution and then do their thing. That's the line `if ( n > 1 ) screener->apply_mover( update_movers, 1, n - 1 );`.

• The `restore_movers` list is supposed to store the exact opposite of each `update_mover`. That's the line at the end of the loop `for ( Size m = 2; m <= last_passed_screener; m++ ) screeners_[ m ]->apply_mover( restore_movers, m - 1, 1 );`. The `restore_mover` is not put in yet for some `StepWiseScreener` objects to match some historical choices during code development, but will be implemented soon -- its conceptually the right way to go.

• The `set_ok_to_increment()` function is a kind of hack that makes these `StepWiseScreener` counters for inner loops bypass incrementing for certain RNA ribose sampling. (May deprecate soon -- working on a more intuitive way to handle these sampling steps).

• Debugging what is happening in StepWiseSampleAndScreener can require digging into the screeners and finding their internal state and/or poses; an example of this is in `early_exit_check`. This code block is currently bypassed through an early `return` but was left in as an example of how to dig into the main loop.


---
Go back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Writing an application]]
* [[Development Documentation]]: The home page for development documentation
* [[Stepwise]]: The StepWise MonteCarlo application
* Applications for deterministic stepwise assembly:
  * [[Stepwise assembly for protein loops|swa-protein-main]]
    * [[Additional documentation|swa-protein-long-loop]]
  * [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
