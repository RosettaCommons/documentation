# Score Function  (SCOREFXNS)
Documentation created by SM Bargeen Alam Turzo (bturzo@flatironinstitute.org), Flatiron Institute on 05/02/2024

<i>Note:  This page documents the explanation of the ```SCOREFXNS``` in RosetttaScripts. And specifically it dives into how to set up a RosettaQM (Quantum Mechanics) Score Function.</i>

<b><i>Also note:  The ```RosettaQM``` is currently unpublished.  If you use this in your project, please contact Vikram Mulligan (vmulligan@flatironinstitute.org) to list all the others of RosettaQM in your project.</i></b>

[[_TOC_]]

## Purpose and algorithm
The Rosetta score function approximates the energy of a biomolecular conformation. The score function is generally composed of a linear combination of many energy terms (called score terms). 
Each score term corresponds to some physical and/or experimental property of the biomolecule.

The score function is generally used in many application of biomolecular proptocol in Rosetta. Use cases could be in protein structure prediction, design, conformational sampling etc. 

Therefore a score function can be used in conjunction with any existing design algorithm that uses the packer (including the [[FastDesign|FastDesignMover]] and [[PackRotamers|PackRotamersMover]] movers, or the [[fixbb]] application).  
## User control

### RosettaScripts control
The initial block of a score function in RosettaScripts looks something like this: 

```xml
<SCOREFXNS>
    <ScoreFunction name="r15" weights="ref2015_cart.wts"/>
</SCOREFXNS>
```
In the above example RosettaScripts block, we define the main Score Function block as ```<SCOREFXNS> ... </SCOREFXNS>``` and then within this block we define the rosetta default scorefunction ref2015 with the sub-block ```<ScoreFunction>``` 
In the ``` <ScoreFunction> ``` sub-block we have the first tag ``` name ``` which is used to give this score function a name that we can use within our full protocol later on. In this case we are calling ``` r15 ```. 
The next tag is the ```weights``` tag. This is important and this is where we are telling which weights file to pick. Here the ```ref2015_cart.wts``` refers to the ref2015 weights file. More weights file can be found in here 
``` ```


To use this term, it must be turned on by reweighting `netcharge` to a non-zero value, either in the weights file used to set up the scorefunction, or in the scorefunction definition in RosettaScripts, in PyRosetta, or in C++ code.

This scoring term is controlled by ```.charge``` files, which define the desired charge in a pose or a sub-region of a pose defined by residue selectors.  If no ```.charge``` files are provided, then the `netcharge` score term always returns a score of zero.  The ```.charge``` file(s) to use can be provided to Rosetta in three ways:
- The user can provide one or more ```.charge``` files as input at the command line with the ```-netcharge_setup_file <filename1> <filename2> <filename3> ...``` flag.  The charge specifications will be applied globally, to the whole pose, whenever it is scored with the `netcharge` score term.
- The user can provide one or more ```.charge``` files when setting up a particular scorefunction in RosettaScripts (or in PyRosetta or C++ code), using the ```<Set>``` tag to modify the scorefunction.  The charge specification will be applied globally, to the whole pose, whenever this particular scorefunction is used.  For example:

Some hand-written text describing the ScoreFunction.
[[include:sfxn_loader_ScoreFunction_type]]
More hand-written text.
