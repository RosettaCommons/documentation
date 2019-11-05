#RestrictInteractionGraphThreadsOperation

Documentation created 5 November 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

[[_TOC_]]

## Description

This is a `TaskOperation` that limits the number of threads that can be requested for interaction graph pre-computation.  Note that this only has an effect in the multi-threaded builds of Rosetta (built with `extras=cxx11thread` option appended to the `scons` command).

In multi-threaded builds of Rosetta, a global Rosetta thread pool is maintained.  The number of threads launched per Rosetta process is by default equal to the number of cores detected on the node on which the Rosetta process is running, but can be limited with the `-multithreading:total_threads <number>` command-line option.  When packing, the interaction graph pre-computation will divide its work over available threads, requesting, by default, all available threads from the thread pool.  The number actually assigned may be less depending on thread availability, but is guaranteed to be at least 1.  This `TaskOperation` allows the user to specify that fewer threads than the total count should be requested.  (Note that linear increases in packing performance are only observed up to about 4 threads, beyond which there are diminishing returns.)

The default number of threads requested for interaction graph setup can also be controlled on the command-line using the `-multithreading:interaction_graph_threads <number>` option.
 
## Usage
### RosettaScripts

[[include:to_RestrictInteractionGraphThreadsOperation_type]]

##See Also
* [[The Rosetta thread manager|RosettaThreadManager]]
* [[Building and running multi-threaded Rosetta|running-rosetta-with-options#running-rosetta-with-multiple-threads]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Coventions]]
