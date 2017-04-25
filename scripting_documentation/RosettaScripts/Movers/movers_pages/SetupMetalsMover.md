#SetupMetalsMover

This mover replicates the function of the -in:auto_setup_metals command line flag in mover form. "Setting up" a metal ion entails adding covalent bonds between the ion and all bound atoms (detected as metal binding atoms within a distance determined by the Lennard Jones radii of the two atoms) and adding distance, angle, and coordinate constraints between the metal ion and the coordinating atoms. In the process, new variant types are also added to the metal ion and all coordinating residues. By default, all metal ions are set up; the user can specify a residue selector (as a subtag or previously defined selector), which restricts setup to only metal ions contained within the selection. 
```
<SetupMetalsMover name="(&string)" metals_detection_LJ_multiplier="(&Real 1.0)" 
  metals_distance_constraint_multiplier="(&Real 1.0)" metals_angle_constraint_multiplier="(&Real 1.0)"
  remove_hydrogens="(&bool true)" resnums="(&nonnegative_int_cslist)" residue_selector="(&string)" constraints_only="(&bool false)" >
         <Optional residue selector subtag />
</SetupMetalsMover>
```
**Note that the resnums option, the residue_selector option, and the residue selector subtag are mutually exclusive. Only one selector OR a resnum list may be provided.**

* **metals_detection_LJ_multiplier**: A multiplier used to increase or decrease the detection radius for metal binding atoms. Setting this value too high may result in false positives in contact detection and can lead to errors due to the detection of more contacts than the metal can bind. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **metals_distance_constraint_multiplier**: Multiplier for the weight of the distance constraints between the metal ion and its coordinating atoms. Increasing this weight will make the binding site more rigid; it can be set to zero to turn off distance constraints. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **metals_angle_constraint_multiplier**: Multiplier for the weight of the angle constraints about metal coordinating atoms (metal-ligand-ligand_base). Increasing this weight will make the binding site more rigid; it can be set to zero to turn off angle constraints. If this is not set in the mover tag, it uses the value set through the command line (default 1.0).
* **remove_hydrogens**: Should extraneous hydrogens be removed from metal binding atoms? Default true.
* **resnums**: Comma-separated list of residue numbers (can include ranges e.g. 1-10) specifying where to search for metal ions to set up. Mutually exclusive with residue selectors.
* **residue_selector**: Name of previously defined residue selector specifying which metal ions to set up. Mutually exclusive with resnums and residue selector subtags.
* **constraints_only**: Only add constraints and do not set up covalent bonds/variant types. Useful for restoring constraints added by metal setup after they have been deleted.

##See Also
* [[Metals]]
* [[AddConstraintsToCurrentConformationMover]]