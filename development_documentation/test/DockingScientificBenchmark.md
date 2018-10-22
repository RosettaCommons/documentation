Docking Local Refine Scientific Benchmark
=========================================

# **THIS PAGE CONTAINS LEGACY INFORMATION ABOUT SCIENTIFIC TESTS BEFORE THEY WERE RE-IMPLEMENTED IN 2018**

Docking is a an approach to predicting how molecules bind together.
Given the fixed chemical sequences and initial conformations of the
individual partners as input, rigid body alignment, sidechain and
backbone degrees of freedom are sampled to search for bound
conformations that have favorable over all energy.

As a scientific benchmark, accurately predicting experimentally
validated binding interactions is a stringent test of the energy
function and conformational sampling. Depending upon the level of detail
of the input data and how successful predictions are evaluated, the
docking scientific benchmark can emphasize the energy function or the
conformational sampling.

The **docking local refine** scientific benchmark emphasizes evaluation
of the energy function by providing the experimentally validated bound
conformation of both interaction partners as input and limiting the
allowed confomational sampling. A physically realisitic score function
should recovery the native conformation a substantial fraction of the
time. Since sampling is not required to recover the native conformation,
any significant deviation from the native conformation indicates that
configuration molecular interactions in the native conformation is
inappropriately disfavored relative to alternative binding
conformations.

For documentation about how to run the docking\_protocol application see [[docking protocol]]

Data Set
--------

The docking scientific benchmark uses the [ZDOCK benchmark
v4](http://zlab.umassmed.edu/zdock/benchmark.shtml) set.

The **docking local refine** benchmark starts with the native bound
receptor and ligand conformations.

Running
-------

1.  Compile Rosetta

             cd mini_base_dir
             ./scons.py bin mode=release -j<num_processors>

2.  Run test

             cd mini_base_dir/test/scientific
             ./scientific.py docking_local_refine -d mini_database_dir

3.  Investigate results

             cd main/tests/scientific/cluster/docking_local_refine/outputs

##See Also

* [[Scientific Benchmarks]]: Main scientific tests page
    - [[Docking scientific tests|DockingScientificBenchmark]]
* [[Docking definition|Glossary#docking]]
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]
