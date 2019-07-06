# DNA_methylation

[[_TOC_]]

## Background
One of the methods of epigenetics is DNA-methylation. While not technically a "post-translational modification", it is conceptually similar and so uses Rosetta's [[EnzymaticMovers]] framework.

The `DNA_methylation` application allows a user to simulate the action of a virtual DNA methyltransferase (Mtase) enzyme on a "substrate" — the loaded `.pdb` structure, which contains DNA residues. The virtual transferase may be a biologically real transferase or entirely hypothetical or constructed.

## Description
This application is currently a simple command-line wrapper for the [[DNAMethyltransferaseMover]]. It simulates the activity of a virtual Mtase on a `Pose` by modifying (a) DNA residue(s) at biologically relevant sequon positions into a `METHYLATED_NA` `VariantType`. It performs no further refinement or algorithmic steps.

One can use the `DNA_methylation` application to quickly methylate DNA at biologically relevant nucleobase positions, depending on the virtual enzyme selected for the application. Further applications can be used to refine the output structure(s) in preparation for other protocols.

## Options
**General Options**

|**Froup**|**Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|in:path|s|Name of the `.pdb` file to process.|String|
|enzymes|species|Set the species name of this simulated enzyme. The default value is `h_sapiens`.|String|
|enzymes|enzyme|Set the specific enzyme name of this simulated enzyme. The default value is `generic`.|String|
|enzymes|efficiency|Set the efficiency of the this simulated enzyme, where 1.0 is 100%. The default value is read from the database.
|out|nstruct|Number of times to process each input `.pdb` file.|Integer|

**Details**
Setting the species name limits the behavior of the simulated methyltransferase used in this application to consensus sequences used by the homolog found in the given species. A species name must be in the format `e_coli` or `h_sapiens`, (note the underscores,) which must also correspond to a directory in the Rosetta database, _e.g._, `database/virtual_enzymes/DNA_methyltransferases/h_sapiens/`. If not set, `h_sapiens` is assumed.

If set, the simulated enzyme used in this application will use specific enzymatic details for this reaction from the database. If the species name has not been set, a "generic" enzyme from the DNA methyltransferase family is assumed. An enzyme name must be as listed in an appropriate enzyme file in `database/virtual_enzymes/DNA_methyltransferases/<species_name_>`.

The generic _H. sapiens_ DNA methyltransferase is a C5 Mtase that methylates the deoxycytidine residue of any CpG sequons on a struture with 100% efficiency.

See [[EnzymaticMovers#Enzyme Data Files]] for information on how to format your own enzymatic data for other DNA methyltransferases.

## Sample Command Line
`DNA_methylation -s input/1ABC.pdb -enzymes:species h_sapiens -enzymes:efficiency 0.33 -nstruct 5`

## Code & Demo
The `DNA_methylation` application can be found in `/Rosetta/main/source/src/apps/public/post-translational_modification/DNA_methylation.cc`.

A demo for the `DNA_methylation` application can be found in `/Rosetta/main/tests/integration/tests/DNA_methylation/`.

## Contact
Labonte <JWLabonte@jhu.edu>
