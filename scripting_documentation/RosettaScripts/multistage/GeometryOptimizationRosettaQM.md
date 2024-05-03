# Geometry Optimization using RosettaQM

## Summary
In this tutorial, we are going to give an example of geometry optimization for a protein.

## Tutorial
In this case, we have part of a zinc-finger protein. We want to optimize the geometry of protein:
* in proximity of zinc, with quantum mechanics,
* its neighbourhood with a lower level of theory quantum mechanics,
* and the rest of protein with Rosetta's score function.

<figure align="center"> 
<img src="../../../images/GeometryOptimizationRosettaQM_region1.png" alt="drawing" width="600"/> 
<figcaption>Figure 1. Atomistic view of region 1 is shown, where the zinc atom is surrounded by two cystein residues and two histidine residues.</figcaption> 
</figure> 
 
Therefore, the protein will be seperated into three regions, which will be called `qm_region1`, `qm_region2` and `region3` (that will not be explicitly defined), respectively. 

Then, different score function will be applied to each reigon with capping rules. 

And then finally geometry optimization will be applied based on the regions and the capping rules applied for each region. 

Residue selectors ae used to specify each region.qm_region1 is selected by residue numbers, and qm_region2 is selected by Neighborhood selector. 

This selector compares the distance between beta carbons of selection (in this case, qm_region1).  
If the distance is less than or equal to the threshold (in this case, 6.0A) it selects that residue.  
This is selected with the tag `distance` and setting to 6.0 (units for this tag are in angstroms).  
Setting the include_focus_in_subset tag to false means that qm_region2 excludes qm_region1. Figure 2. highights qm_region1 with orange, and qm_region2 with red and the remaining region (region3) with blue.  
Note that `region3` is not defined because the MultiScoreFunction will automatically define what is remaining and define that as region3.  


Therefore, the residue selector block looks like this:  

```xml
    <RESIDUE_SELECTORS>
        <!-- Define regions of interest -->
        <!-- qm_region1 is the region where the most computationally expensive calculation is going to take place. -->
        <Index name="qm_region1" resnums="8,11,24,28,29"/>
        <!-- qm_region2 is the region where the second most computationally expensive calculation is going to take place. -->
        <!-- Within the Neighborhood qm_region2 defines the region that is within 6.0 from qm_region1 and not including the atoms in qm_region1 (which is done using the tag include_focus_in_subset  -->
        <Neighborhood name="qm_region2" selector="qm_region1" distance="6.0" include_focus_in_subset="false" />
    </RESIDUE_SELECTORS>
```

<figure align="center">
<img src="../../../images/GeometryOptimizationRosettaQM_region2.png" alt="drawing" width="600"/>
<figcaption>Figure 2. Different regions of the multiscore function are shown here. qm_region1 defined with qm_hf is shown in orange. qm_region2 defined with qm_hf3c_fmo is shown in red and remaining region defined with Ref2015 is shown in blue. </figcaption>
</figure>
For each region, a different method defined within the ScoreFunction of SCOREFXNS of RosettaScripts needs to be used. 
The following table gives a summary of that. 
<br />

| Region's name                           | Score function   |
|-----------------------------------------|------------------|
| qm_region1 (orange)                     | HF/3-21G         |
| qm_region2 (red)                        | HF-3c/FMO        |
| region3 (blue, not explicitly defined)  | Rosetta ref2015  |

<br />
<br />

The following SCOREFXNS shows how each of the ScoreFunction block is set up for each region and how the MultiScoreFunction blocks are set up. To learn more about: 
- ScoreFunction block: [Go here]
- MultiScoreFunction block: [Go here]

```xml
        <SCOREFXNS>
            <!-- In order to do multi-scale modeling, we need to set up the different score function that will used for the different regions of your system.  -->

            <!-- Here we define ref15 aka Rosetta's score function -->
            <ScoreFunction name="r15" weights="ref2015_cart.wts"/>
            <!-- Here we define the score function with RosettaQM setting for the most rigorous part aka qm_region1  -->
            <!-- Although note that we don't mention qm_region1 in our score function. That is later.-->
            <ScoreFunction name="qm_hf" weights="empty" >
                <Reweight scoretype="gamess_qm_energy" weight="1.0" />
                <Set gamess_electron_correlation_treatment="HF"
                    gamess_ngaussian="3" gamess_basis_set="N21"
                    gamess_npfunc="1" gamess_ndfunc="1"
                    gamess_threads="%%threads%%" gamess_use_scf_damping="true"
                    gamess_use_smd_solvent="true" gamess_max_scf_iterations="%%scf_iter%%"
                    gamess_multiplicity="1" />
            </ScoreFunction>

            <!-- Here we define the score function with RosettaQM setting for the second rigorous part aka qm_region2  -->
            <!-- Although note that we don't mention qm_region2 in our score function. That is later.-->
            <!-- Also note that here we are using hybrid molecular orbital approx (HMO) -->
            <ScoreFunction name="qm_hf3c_fmo" weights="empty" >
                <Reweight scoretype="gamess_qm_energy" weight="1.0" />
                <Set gamess_electron_correlation_treatment="SE"
                    gamess_basis_set="HF-3C" gamess_use_smd_solvent="true"
                    gamess_use_scf_damping="true"
                    gamess_use_h_bond_length_constraints="true"
                    gamess_h_bond_length_constraint_force="10"
                    gamess_threads="%%threads%%" gamess_max_scf_iterations="%%scf_iter%%"
                    gamess_multiplicity="1" gamess_fmo_calculation="true" gamess_hybrid_molecular_orbital="HF-3c"
                    gamess_hybrid_molecular_orbital_file="/mnt/home/bturzo/ceph/Applications/gamess/tools/fmo/HMO/HMOs.txt"
                    gamess_max_fmo_monomer_scf_iterations="%%scf_iter%%" />
            </ScoreFunction>

            <!-- In the MucltiScoreFunction block is where you tell which region is going to be treated with which level calculation-->
            <!-- Since this a onion layer style calculation dump_pdbs="true" option will dump out all the layers of system that has been defined-->
            <MultiScoreFunction name="msfxn" dump_pdbs="true" >
                <!-- SimpleCombinationRule is how to combine the region. And how to subtract of the energies from each region in order avoid double counting-->
                <!-- There are other more complicated rules but that will not be discussed here and is a treat for another tutorial-->
                <SimpleCombinationRule />
                <!-- CappedBondResolutionRule by default does sensible capping, other capping rules available and can be passed with options-->
                <Region scorefxn="qm_hf" residue_selector="qm_region1" >
                    <CappedBondResolutionRule/>
                </Region>
                <!--Same CappedBondResolutionRule for qm_region2-->
                <Region scorefxn="qm_hf3c_fmo" residue_selector="qm_region2">
                    <CappedBondResolutionRule/>
                </Region>
                <!-- Whatever region is left after qm_region2 automatically gets defined to region3 and is now scored with r15 (as in rosetta score function) -->
                <Region scorefxn="r15" >
                    <CappedBondResolutionRule/>
                </Region>
            </MultiScoreFunction>

        </SCOREFXNS>
```

Next we are going to set up TASKOPERATIONS block that we will later use to do a quick FastRelax (defined in the MOVERS block) in Rosetta before QM geometry optimization. 

For mone on how to setup: 
- TASKOPERATIONS: [Go here] 
- IncludeCurrent: [Go here] 
- ExtraRotamersGeneric: [Go here] 

```xml
    <TASKOPERATIONS>
        <IncludeCurrent name="include_current_rotamer" />
        <!-- EXTRA ROTAMERS GENERIC during fast relax ex1 and ex2 adjust number of extra chi cuttoff-->
        <ExtraRotamersGeneric name="extra_sample_rotamers" ex1="1" ex2="1" ex1aro="1" ex2aro="1"/>
    </TASKOPERATIONS>
```


Next we are going to set up the `MOVERS` block. This is where we will call the FastRelax. We will also call the `GamessQMGeometryOptimizationMover` and pass the MultiScoreFunction to the mover. We do this as follows: 
For more on how to setup:
- FastRelax: [Go here]
- GamessQMGeometryOptimizationMover: [Go here]

```xml
    <MOVERS>
        <FastRelax name="fast_relax" scorefxn="r15" disable_design="true" task_operations="include_current_rotamer,extra_sample_rotamers" repeats="100" relaxscript="default" min_type="lbfgs_armijo_nonmonotone"/>
        <GamessQMGeometryOptimizationMover name="qm_geo_opt_msfxn" gamess_threads="%%threads%%" msfxn_name="msfxn" msfxn_classical_cartmin="true" />
    </MOVERS>
```

Next we are goint to set up the `PROTOCOLS` block. In this block we are calling the FastRelax and then the GamessQMGeometryOptimizationMover sequentially. 
So once FastRelax is done Rosetta will pass the Rosetta relaxed structure to GamessQMGeometryOptimizationMover for QM + RosettaMM geometry optimization. 

```xml
    <PROTOCOLS>
        <Add mover="fast_relax" />
        <Add mover="qm_geo_opt_msfxn"/>
    </PROTOCOLS>
```


