# DihedralConstraintGenerator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DihedralConstraintGenerator overview

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
A constraint generator that creates Dihedral constraints for specified residues using a residue selector.
 Uses CircularHarmonic constraints since CircularGaussian func does not exist. 
 By default, it works on Protein and carbohydrate BackBone dihedrals (see dihedral option), however, CUSTOM ARBITRARY DIHEDRALS can be set. 
  See the dihedral_atoms and dihedral_residues tags to set a custom dihedral. Alternatively, you can set any ARBITRARY DIHEDRAL
 with the 'dihedral_angle' option (this option is in degrees). 

 It will only work on ONE type of dihedral angle to allow complete customization.

References and author information for the DihedralConstraintGenerator constraint generator:

DihedralConstraintGenerator ConstraintGenerator's author(s):
Jared Adolf-Bryfogle, Institute for Protein Innovation [jadolfbr@gmail.com]  (Created the DihedralConstraintGenerator.)

```xml
<DihedralConstraintGenerator name="(&string;)" dihedral="(&string;)"
        sd="(&real;)" dihedral_angle="(&string;)" dihedral_atoms="(&string;)"
        dihedral_residues="(&string;)" residue_selector="(&string;)" />
```

-   **dihedral**: The canonical dihedral being set.  Currently, only Backbone dihedrals are accepted here.  Works for proteins and carbohydrates
-   **sd**: The standard deviation used for the CircularHarmonic Func.  Default is 16 degrees, which was found by taking the mean SD of all dihedral angles of either PHI or PSI for each North (Antibody) CDR Cluster (CDRs are the main antibody loops).  This is a fairly tight constraint and allows a bit of movement while not changing the overall structure much.
-   **dihedral_angle**: The desired dihedral angle - must be in degrees.
-   **dihedral_atoms**: Comma-separated list of atom names.  FOUR atoms used for the calculation of a custom dihedral.  Must also pass dihedral_residues.
-   **dihedral_residues**: Comma-separated list of resnums.  Must be FOUR residues to define a custom dihedral. See RosettaScripts resnum definition.  Rosetta or pose numbering (ex. 23 or 42A).  Ranges are accepted as well.   These are completely arbitrary and DO NOT have to be in order. Must also pass dihedral_atoms.
-   **residue_selector**: . The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.

##See Also

* [[DistanceConstraintsGenerator]]
* [[AddConstraintsMover]]
* [[RemoveConstraintsMover]]
* [[Constraints file format|constraint-file]]
* [[AtomCoordinateCstMover]]
* [[AddConstraintsToCurrentConformationMover]]