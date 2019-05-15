# phosphorylation

This application is currently a simple command-line wrapper for the [[KinaseMover]]. It simulates the activity of a virtual kinase on a `Pose` by modifying (a) residue(s) at biologically relevant sequon positions into a `PHOSPHORYLATION` `VariantType`. It performs no further refinement or algorithmic steps.

[[_TOC_]]

## Background
Many proteins in nature are post-translationally modified, yet deposited structures often have their PTMs absent or removed. Kinases are enzymes that perform the transfer of a phosphate group from ATP to an substrate peptide/protein. The `phosphorylation` application allows a user to simulate the action of a virtual kinase enzyme on a "substrate" — the loaded `.pdb` structure. The virtual phosphorylation may be a biologically real transfer or entirely hypothetical or constructed.

## Description
One can use the `phosphorylation` application to quickly phosphorylate a protein at biologically relevant O positions, depending on the virtual enzyme selected for the application. Further applications can be used to refine the output structure(s) in preparation for other protocols.

## Options
**General Options**

|**Group**|**Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|in:path|s|Name of the `.pdb` file to process.|String|
|enzymes|species|Set the species name of this simulated enzyme. The default value is `h_sapiens`.|String|
|enzymes|enzyme|Set the specific enzyme name of this simulated enzyme. The default value is `generic`.|String|
|out|nstruct|Number of times to process each input `.pdb` file.|Integer|

**Details**

Setting the species name limits the behavior of the simulated kinase used in this application to consensus sequences used by the homolog found in the given species. A species name must be in the format `e_coli` or `h_sapiens`, (note the underscores,) which must also correspond to a directory in the Rosetta database, _e.g._, `database/virtual_enzymes/kinases/h_sapiens/`. If not set, `h_sapiens` is assumed.

If set, the simulated enzyme used in this application will use specific enzymatic details for this reaction from the database. If the species name has not been set, a "generic" enzyme from the kinase family is assumed. An enzyme name must be as listed in an appropriate enzyme file in `database/virtual_enzymes/kinases/<species_name_>`.

The generic _H. sapiens_ kinase is a highly promiscuous kinase that transfers phopshate group to any Ser or Thr residue on a struture with 100% efficiency.

See [[EnzymaticMover#Enzyme Data Files]] for information on how to format your own enzymatic data for other kinases.

## Sample Command Line
`phosphorylation -s input/2DEF.pdb -nstruct 1`

## Code & Demo
The `phosphorylation` application can be found in `/Rosetta/main/source/src/apps/public/post-translational_modification/phosphorylation.cc`.

A demo for the `phosphorylation` application can be found in `/Rosetta/main/tests/integration/tests/phosphorylation/`.

## Contact
Labonte <JWLabonte@jhu.edu>

## See Also
- [[EnzymaticMover]]
