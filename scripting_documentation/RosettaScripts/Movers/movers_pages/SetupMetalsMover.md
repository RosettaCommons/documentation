#SetupMetalsMover

##SetupMetalsMover

Documentation and mover by Sharon Guffy (guffy@email.unc.edu).  Original `-auto_setup_metals` functionality, and note on scoring, added by Vikram K. Mulligan (vmullig@uw.edu).

[[_TOC_]]

### Description
This mover replicates the function of the `-in:auto_setup_metals` command line flag in mover form. "Setting up" a metal ion entails adding covalent bonds between the ion and all bound atoms (detected as metal binding atoms within a distance determined by the Lennard Jones radii of the two atoms) and adding distance, angle, and coordinate constraints between the metal ion and the coordinating atoms. In the process, new variant types are also added to the metal ion and all coordinating residues. By default, all metal ions are set up; the user can specify a residue selector (as a subtag or previously defined selector), which restricts setup to only metal ions contained within the selection.

### Note regarding scoring
The SetupMetalsMover has two effects on scoring.  First, by creating bonds between a metal and metal-coordinating residues, the mover tells the scorefunction not to calculate repulsive and long-range interactions between the metal and the atoms that coordinate it.  Without this, Rosetta scores a structure containing a metal as though there is a clash between the metal and the atoms coordinating it.  Second, by adding constraints between the metal and the coordinating atoms, Rosetta will penalize deviations from the input metal-coordination geometry during scoring, and will "pull" the geometry towards the input coordination geometry during relaxation (minimization).  Without this, the metal centre is likely to become distorted during minimization or other structural manipulation.  Note that the second effect requires that the `metalbinding_constraint` score term is active in the scorefunction used to score or energy-minimize.  If necessary, this can be achieved by adding it to the weights file, or by using the `Reweight` command in RosettaScripts (see the `ScoreFunctions` section of [[this page|RosettaScripts]] for details).

### Note on centroid mode compatibility

The covalent attachments and constraints enabled by this mover should be compatible with centroid mode, with a few caveats. As sidechain atoms are normally missing from centroid mode, residues which are coordinated to metals through sidechain atoms are treated specially. Specifically, a special centroid mode residue type which contains explicit sidechain atoms will be created. As it is not a standard centroid mode type, it will not necessarily be scored equivalently to a non-conjugated residue. Additionally, as centroid mode protocols typically don't sample sidechain flexibility, the sidechain conformation will effectively be "locked" in the starting conformation. While this should work when sampling away from the metal ions, sampling in the vicinity of the metal binding residues may be biased due to the comparative inflexibility of the sidechain/metalbinding geometry.

### Setup and options
```xml
<SetupMetalsMover name="(&string)" metals_detection_LJ_multiplier="(&Real 1.0)" 
  metals_distance_constraint_multiplier="(&Real 1.0)" metals_angle_constraint_multiplier="(&Real 1.0)"
  remove_hydrogens="(&bool true)" resnums="(&nonnegative_int_cslist)" metal_residue_selector="(&string)" constraints_only="(&bool false)" >
         <Optional residue selector subtag />
</SetupMetalsMover>
```
**Note that the resnums option, the residue_selector option, and the residue selector subtag are mutually exclusive. Only one selector OR a resnum list may be provided.**

* **metals_detection_LJ_multiplier**: A multiplier used to increase or decrease the detection radius for metal binding atoms. Setting this value too high may result in false positives in contact detection and can lead to errors due to the detection of more contacts than the metal can bind. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **metals_distance_constraint_multiplier**: Multiplier for the weight of the distance constraints between the metal ion and its coordinating atoms. Increasing this weight will make the binding site more rigid; it can be set to zero to turn off distance constraints. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **metals_angle_constraint_multiplier**: Multiplier for the weight of the angle constraints about metal coordinating atoms (metal-ligand-ligand_base). Increasing this weight will make the binding site more rigid; it can be set to zero to turn off angle constraints. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **remove_hydrogens**: Should extraneous hydrogens be removed from metal binding atoms? Default true.
* **resnums**: Comma-separated list of residue numbers (can include ranges e.g. 1-10) specifying where to search for metal ions to set up. Mutually exclusive with residue selectors.
* **metal_residue_selector**: Name of previously defined residue selector specifying which metal ions to set up. Mutually exclusive with resnums and residue selector subtags.
* **constraints_only**: Only add constraints and do not set up covalent bonds/variant types. Useful for restoring constraints added by metal setup after they have been deleted.

[[include:mover_SetupMetalsMover_type]]

###Example
The following script applies metal-binding constraints to the input pose, then relaxes it using the [[FastRelax|FastRelaxMover]] mover:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15_cst" weights="ref2015_cst.wts" >
                        <Reweight scoretype="metalbinding_constraint" weight="1.0" />
                </ScoreFunction>
        </SCOREFXNS>
        <MOVERS>
                <SetupMetalsMover name="setup_metals" metals_detection_LJ_multiplier="1.0" />
                <FastRelax name="frlx1" scorefxn="r15_cst" />
        </MOVERS>
        <PROTOCOLS>
                <Add mover="setup_metals" />
                <Add mover="frlx1" />
        </PROTOCOLS>
</ROSETTASCRIPTS>

```

###See Also
* [[Metals]]
* [[AddConstraintsToCurrentConformationMover]]
