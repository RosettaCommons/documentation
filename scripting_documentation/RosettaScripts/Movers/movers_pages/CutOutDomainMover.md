# CutOutDomain
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CutOutDomain

Cuts a pose based on a template pdb. The two structures have to be aligned. The user supplies a start res num and an end res num of the domain on the **template pose** and the mover cuts the corresponding domain from the input PDB.

```xml
<CutOutDomain name="&string" start_res="(&int)" end_res="(&int)" suffix="&string" source_pdb="&string"/>
```

-   start\_res/end\_res: begin and end residues on the template pdb (e.g -s template.pdb)
-   suffix: suffix of outputted structure
-   source\_pdb: name of pdb to be cut

##See Also

* [[ExtractSubposeMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[I want to do x]]: Guide to choosing a mover
