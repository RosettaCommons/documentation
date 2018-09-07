# Splice
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Splice

**This is a Devel mover, however it was split into different movers that are now in release.**

This is a fairly complicated mover with several different ways to operate:

-   1. given a source pose: splices segments from source pose onto current pose and ccd closes it. Use either with from\_res to\_res options or with the task\_operations. Generates a database file with the dihedral angle data from the spliced segment.
-   2. given a database file: splices segments from the database. If entry is left at 0, splices random entries.
-   3. given a database file and a template file: splices segments from the database. The residue start and end in the database are mapped onto the template rather than the source pose.
-   4. ccd on or off: Obviously ccd is very time consuming.

```xml
<Splice name="&string" from_res="(&integer)" to_res="(&integer)" source_pdb="(&string)" scorefxn="(score12 &string)" ccd="(1 &bool)" res_move="(4 &integer)" rms_cutoff="(99999&real)" task_operations="(&comma-delimited list of taskoperations)" torsion_database="(&string)" database_entry="(0&int)" template_file="(''&string)" thread_ala="(1&bool)" equal_length="(0&bool)"/>
```

-   from\_res: starting res in target pdb
-   to\_res: end res in target pdb
-   source\_pdb: name of pdb file name from which to splice
-   ccd: close chainbreak at the end?
-   res\_move: how many residues to move during ccd? 3 flanking residues outside the inserted segment will be allowed to move, and the remainder will be moved within the segment, so if you specify 5, you'll have 3 flanking and 2 residues within the segment at each end.
-   rms\_cutoff: allowed average displacement of Calpha atoms compared to source pdb. If the average displacement is above this limit, then the mover will set its status to fail and no output will be generated.
-   task\_operations: set which residues will be spliced. This merely goes through all of the designable residues according to the task-factory, takes the min and max, and splices the section in between (inclusive). Logically this replaces from\_res/to\_res, so task\_operations cannot be defined concomitantly with these. these task\_operations are not used to decide how to design/repack residues within the mover, only on the stretch to model.
-   torsion\_database: a database of torsion angles to be spliced. The database is light-weight, removing the requirement to read a pdb for each segment to be spliced in. Each line in the database is a segment entry defining the dofs: ( \<phi\> \<psi\> \<omega\> \<3-letter resn\> ) x number of residues in the segment.
-   database\_entry: which entry in the database to splice. If 0, an entry is chosen randomly at runtime.
-   thread\_ala: thread alanine residues in all positions where source has no gly/pro or disagrees with current pose? If false, allows design at those positions.
-   equal\_length: when sampling from a database, do you want to restrict only to entries with equal length to the current pose?


##See Also

* [[Database IO]]: Information on database input/output in Rosetta
* [[I want to do x]]: Guide to choosing a mover
