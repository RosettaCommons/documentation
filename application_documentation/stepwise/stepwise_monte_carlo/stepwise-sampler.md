#StepWiseSampler
`StepWiseSampler` objects are concatenated together to define the sampling loop, and can go through millions of poses.

#How to use

Codes in the folder `src/protocols/stepwise/StepWiseSampler` are for the StepWiseSampler class and its subclasses,
which is subclass of moves::Mover.

Folder organization
-------------------
The root path contains generic abstract base classes and simple base
classes for inheritance and basic functionality.

Some classes take multiple rotamer sampler instances and assemble them in
linear of combinatorial way for complex tasks (e.g. StepWiseSamplerComb,
StepWiseSamplerSizedAny).

The `rna/` folder contains RNA specific StepWiseSampler samplers for backbone, sugar
ring and chi angle.

How to use
----------
StepWiseSampler samplers apply new rotamer conformation to a pose until all rotamer
has been navigated.

Example code:
```
RNA_SuiteStepWiseSampler sampler( ... ); //Declaration
//Various settings
sampler.set_fast( true );
sampler.set_random( false ); //Controls random sampling
//NEVER FORGET to initialize after setting
sampler.init();

//For non-random sampling (sampler ends at at finite # of steps)
for ( sampler.reset(); sampler.not_end(); ++sampler ) {
  sampler.apply( pose ); //Apply rotamer to pose
  ...
}

//For random sampling (sampler never ends)
sampler.set_random( true );
sampler.reset();
Size const max_tries = 10000;
for ( Size i = 1; i <= max_tries; ++i, ++sampler ) {
  sampler.apply( pose ); //Apply rotamer to pose
  ...
}
```

----
Go back to [[StepWiseSampleAndScreen|stepwise-sample-and-screen]].

Go all the way back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Writing an application]]
* [[Development Documentation]]: The home page for development documentation
* [[I want to do x]]: Guide to selecting movers for structural perturbations
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