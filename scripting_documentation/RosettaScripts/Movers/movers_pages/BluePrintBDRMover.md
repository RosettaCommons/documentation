# BluePrintBDR
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BluePrintBDR

Build a structure in centroid from a blueprint given an input pdb.

```xml
<BluePrintBDR name="bdr" blueprint="input.blueprint" use_abego_bias="0" use_sequence_bias="0" scorefxn="scorefxn1"/>
```

Options (default):

     num_fragpick ( 200 ), 
     use_sequence_bias ( false ), use sequence bias in fragment picking
     use_abego_bias ( false ), use abego bias in fragment picking
     max_linear_chainbreak ( 0.07 ),
     ss_from_blueprint ( true ),
     constraints_NtoC ( -1.0 ),
     constraints_sheet ( -1.0 ),
     constraint_file ( "" ),
     dump_pdb_when_fail ( "" ),
     rmdl_attempts ( 1 ),
     use_poly_val ( true ),
     tell_vlb_to_not_touch_fold_tree (false),
     invrot_tree_(NULL),
     enzcst_io_(NULL)

Blueprint format:

     resnum  residue  (ss_struct)(abego) rebuild
     resnum = consecutive (starting from 1) or 0 (to indicate a new residue not in the input.pdb)
     residue = one letter code amino acid (e.g. V for Valine)
     ss_struct = secondary structure, E,L or H. ss_struct and abego are single-letter and have no space between them.
     abego = abego type (ABEGO), use X if any is allowed
     rebuild = R (rebuild this position) or "." (leave as is)

Examples

     1   V  LE  R   (position 1, Val, loop, abego type E, rebuild)
     0   V  EX  R   (insert a residue, Val, sheet, any abego, rebuild)
     2   V  EB  .   (position 2, Val, sheet, abego type B, do not rebuild)

Note that this is often used with a SetSecStructEnergies mover, which would be applied first, both calling the same blueprint file with a header indicating the desired pairing. See [[SetSecStructEnergiesMover]] for more.


##See Also

* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
