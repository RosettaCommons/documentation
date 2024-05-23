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
In the ``` <ScoreFunction> ``` sub-block we have the first tag ``` name ``` which is used to give this score function a name that we can use within our full protocol later on. In this case we are calling it ``` r15 ```. 
The next tag is the ```weights``` tag. This is important and this is where we are telling which weights file to pick. Here the ```ref2015_cart.wts``` refers to the ref2015 weights file. More weights file can be found in this part of your Rosetta directory ``` main/database/scoring/weights ```. 

Similarly you can also create a RosettaQM scorefunction with slightly more options. A template for setting up RosettaQM scorefunction is shown below:  

```xml
<SCOREFXNS>
    <ScoreFunction name="sfxn_qm" weights="empty" >
        <Reweight scoretype="gamess_qm_energy" weight="1.0"/>
        <Set gamess_electron_correlation_treatment="HF"
             gamess_ngaussian="3" gamess_basis_set="N21"
             gamess_npfunc="1" gamess_ndfunc="1"
             gamess_threads="4" gamess_use_scf_damping="true"
             gamess_use_smd_solvent="true" gamess_max_scf_iterations="50"
             gamess_multiplicity="1" />
    </ScoreFunction>
</SCOREFXNS>
```
In the above xml block. We are now defining a ScoreFunction block named `sfxn_qm` where we first assign an empty weights, so that no Rosetta energy weights is passed and then we reweight it with the option "gamess_qm_energy" that is energy method defined for the QM software package GAMESS (installed externally by the user). 
Next we set up the QM method (Hartree Fock [HF]) with the basis set 3-21gand to run that in parallel over 4 threads. We are using the smd solvation model and a max SCF iterations of 50. Here the multiplicity is set to 1.  
All these options are system dependent and the above template is an example of what needs to be done to set up a QM scorefunction. This SHOULD NOT be used as default settings to run RosettaQM.  

To get a list of all the available tags and options for ScoreFunction you can excute the rosettascripts executable with the `-info ScoreFunction` flag. So it will look something like this: 

``` rosetta_scripts.linuxgccrelease -info ScoreFunction ```


[[include:sfxn_loader_ScoreFunction_type]]
