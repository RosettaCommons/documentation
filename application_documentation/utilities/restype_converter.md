#Residue Type Converter

Metadata
========

This document was edited Jul 2, 2019 by Rocco Moretti. This application was created and documented by Rocco Moretti, et al.

Description of algorithm
========================

Rosetta can take a number of different ways of specifying the chemical structure of a residue. 
Some of these (most noticably the Rosetta-specific params file format) aren't compatible with other programs.

The `restype_converter` application is able to take these inputs and convert them between formats.

Limitations and Caveats
=======================

Rosetta's residue type outputting isn't necessarily comprehensive at this point. 
There's no guarantee that you're able to round-trip a given residue with the restype_converter application.
(There's not even a guarantee that Rosetta will be able read the files which it output.)

It should suffice for getting something like a PyMol-readable PDB or SDF file from a residue type, though.

Input
=====

The restype_converter application does not make use of the standard Rosetta job distributor machinery, and as such doesn't obey normal input or output options.

By default, the converter works with full atom residue types. If you wish to work with centroid types, add the flag `-in:file:centroid`.

The following options can be used to specify which residue types should be converted:

|**Option**|**Description**|
|:-------|:--------------|
|-restype_convert:types | A list of residue types names to take from the standard database. This can take patched names. |
|-restype_convert:name3 | A list of three letter codes to take from the standard database. If more than one residue shares the same three letter code, all will be output.|
|-extra_res_fa | A list of Rosetta [[Residue Params file]]s to convert. (Not used with `-in:file:centroid` active.) |
|-extra_res_cen | A list of Rosetta [[Residue Params file]]s to convert. (Only used with `-in:file:centroid` active.) |
|-extra_res_mol | A list of SDF/Mol files to convert. (Used in both centroid and fullatom.)|
|-extra_res_mmCIF | A list of CIF formatted ligand files to convert. (Used in both centroid and fullatom.)|

If you wish to load a residue type from the Rosetta-provided Chemical Components Dictionary file, simply prepend `pdb_` to the three letter code, and use it with `-ligand_convert:types`.
(For example, to load the residue TTL from the CCD, pass `-types pdb_TTL` to the ligand_convert application.)

Output
===============

By default, output will be in the current directory. You can control the path of the output with `-out:path:all`.

By default, files will be named with the full residue type name (including patches). You can use `-out:prefix` and `-out:suffix` to further decorate the output.
(Currently there is no special handling of duplicate name detection.)

Output format is controlled by the following Boolean flags. (Multiple flags can be added to get multiple output formats from one run.)

|**Option**|**Description**|**Extension used**|
|:-------|:--------------|:------------------|
|-out:pdb| PDB format, single residue | .pdb |
|-restype_convert:params_out| Rosetta [[Residue Params file]] | .params |
|-restype_convert:sdf_out| SDF | .sdf |

(There's currently no mmCIF output available.)

Command Lines
====================

Sample command:

```
restype_convert.linuxgccrelease -ligand_convert:types TRP:NtermProteinFull  -ligand_convert:name3 CYS -extra_res_fa my_type.params -out:pdb -ligand_convert:sdf_out 
```

Example
=======

See the integration test at `rosetta/main/tests/integration/tests/restype_converter` for an example.


##See Also

* [[Residue Params file]]: Documentation on the Rosetta params file format
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
