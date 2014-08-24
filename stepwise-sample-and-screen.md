#StepWiseSampleAndScreen
`StepWiseSampleAndScreen` carries out the main loop for stepwise sampling, either in enumerative mode or in stochastic mode. It is initialized with two things:

• a vector of `StepWiseSampler` objects which delineate the degrees of freedom to be sampled, their discrete values, and what order these go in. There are some tricks here to handle rigid body sampling.

• a vector of `StepWiseScreener` objects which delineate the gauntlet of filters, packers, and loop closers that are run after each sample is applied to the `pose`.

The architectures of each of these objects are described in the [[StepWiseSampler|stepwise-sampler]] and [[StepWiseScreener|stepwise-screener]] pages.

#The main loop.

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
