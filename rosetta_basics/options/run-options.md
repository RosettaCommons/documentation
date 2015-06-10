<!-- --- title: Run Options -->

Here is a list of common/useful run options.  Please see the full option list and the particular application you are using for more.

Options control run operations
==============================

```
-run:batches flag1 flag2 flag3  Run a batch.  in flag1 .. flag3 you have those flags that differ 
                                from batch to batch. All the other flags can go onto the cmd-line
                                like normal (Oliver Lange). Works with MPI.     
              
-run:maxruntime                 Maximum runtime in seconds.JobDistributor will signal end if
                                time is exceeded no matter how many jobs were finished.
                                Default='-1'. [Integer]

-run:maxruntime_bufferfactor    If set, the JobDistributor will attempt to stop if there doesn't 
                                appear to be enough time for `maxruntime_bufferfactor` more jobs 
                                before maxruntime occurs. [Real]

-run:constant_seed              Use a constant seed (1111111 unless specified). [Boolean]

-run:jran                       Specify seed (requires -constant_seed).  Used for non-MPI parellel runs
                                Default='1111111'. [Integer]

-run:use_time_as_seed           Use time as random number seed instead of default rng seed
                                device. [Boolean] Used for non-MPI parellel runs

-run:seed_offset                This value will be added to the random number seed. Useful when
                                using time as seed and submitting many jobs to clusters.Using the
                                condor job id will force jobs that are started in the same second
                                to still have different initial seeds. Default='0'. [Integer] 
                                Used for non-MPI parellel runs

-run:delay                      Wait N seconds before doing anything at all. Useful for cluster
                                job staggering. Default='0'. [String]

-run:nodelay                    Do not delay launch of Rosetta [Boolean]

-run:random_delay               Wait a random amount of 0..N seconds before doing anything at all.
                                Useful for cluster job staggering. Default='0'. [Integer]

-run:rng                        Random number generation algorithm: Currently only mt19937 is a
                                accepted here. Default='mt19937'. legal=['mt19937']. [String]

-run:rng_seed_device            Obtain random number seed from specified device.
                                Default='/dev/urandom'. [String]

-run:shuffle                    Shuffle job order. Default='false'. [Boolean]

```

##See Also

* [[Options overview]]: Description of options in Rosetta
* [[Input options]]
* [[Output options]]
* [[Full options list]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications