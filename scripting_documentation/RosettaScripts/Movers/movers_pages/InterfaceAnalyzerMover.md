# InterfaceAnalyzerMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## InterfaceAnalyzerMover

Calculate binding energies, buried interface surface areas, packing statistics, and other useful interface metrics for the evaluation of protein interfaces.

```
<InterfaceAnalyzerMover name="&string" scorefxn=(&string) packstat=(&bool) pack_input=(&bool) pack_separated=(0, &bool) jump=(&int) fixedchains=(A,B,&string) tracer=(&bool) use_jobname=(&bool) resfile=(&bool) ligandchain=(&string) />
```

-   packstat: activates packstat calculation; can be slow so it defaults to off. See the paper on RosettaHoles to find out more about this statistic (Protein Sci. 2009 Jan;18(1):229-39.)
-   jump: which jump number should be used to determine across which chains to make the interface? NOT RECOMMENDED - use -fixedchains instead.
-   fixedchains: comma-delimited list of chain ids to define a group in the interface.
-   tracer: print to a tracer (true) or a scorefile (false)? Combine the true version with -out:jd2:no\_output and the false with out:file:score\_only (scorefile).
-   use\_jobname: use\_jobname (bool) - if using tracer output, this turns the tracer name into the name of the job. If you run this code on 50 inputs, the tracer name will change to match the input, labeling each line of output with the input to which it applies. Not relevant if not using tracer output.
-   pack\_separated: repack the exposed interfaces when calculating binding energy? Usually a good idea.
-   resfile: warns the protocol to watch for the existence of a resfile if it is supposed to do any packing steps. (This is normally signealed by the existance of the -resfile flag, but here the underlying InterfaceAnalyzerMover is not intended to use -resfile under normal circumstances, so a separate flag is needed. You can still pass the resfile with -resfile.)
-   pack\_input: prepack before separating chains when calculating binding energy? Useful if these are non-Rosetta inputs
-   ligandchain: Specify a single ligand chain by pdb chain ID. All chains in the protein other than this will be marked as fixed as if they were specified using fixedchains.


##See Also

* [[ProteinInterfaceMSMover]]: Mover for multistate design of protein interfaces
* [[DnaInterfacePackerMover]]
* [[InterfaceRecapitulationMover]]
* [[InterfaceScoreCalculatorMover]]
* [[I want to do x]]: Guide to choosing a mover

<!-- SEO
interface analyzer
interface analyzer
interface
analyzer
-->