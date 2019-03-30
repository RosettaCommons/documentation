Performance Benchmarks
=====================

Performance Benchmarks are tests that compare the time it takes Rosetta to do very simple tasks that it generally ought to be able to do very quickly.
The idea is that there are atomic actions that Rosetta should be able to run very quickly: for example, evaluating scoring terms and running the packer.

Each performance benchmark is performed between one and several hundred thousand times, to achieve an approximate runtime intended to fall between thirty seconds and five minutes.
Several methods to collate these data and form stable metrics have been tried:
-	averaging n trials (typically n = 3 or 5)
-	taking the lowest trial of n (assuming that all outliers are slow-downs)
-	performing the benchmarks until n trials within 5% of each other are observed, then logging the minimum or average of those n trials

None of these metrics have proven to be truly stable, even when average cumulative test times of several hours were tried.

In general, as long as this assertion is in the documentation, do not panic if your code breaks a performance test that would appear unrelated. (For example, you add a pilot app and it looks like mm_lj_intra_rep takes longer to score.) Do, please, panic if that performance test continues to be broken for several commits to follow, or if it breaks many performance tests.)

The tests themselves are located in apps/benchmark/performance.

Each benchmark is defined in a .bench.hh and then this central class runs then as many times as it can in a fixed period of time (That is the cycles on the x axis).

##See Also

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]