# N-Terminal Acetylation

[[_TOC_]]

## Background
N-terminal acetyltransferases (NATs) are used in Nature to acetylayte the terminal amino group of a peptide chain.

The `N-terminal_acetylation` application allows a user to simulate the action of a virtual NAT enzyme on a "substrate" — the loaded `.pdb` structure. The virtual transferase may be a biologically real transferase or entirely hypothetical or constructed.

## Description
This application is currently a simple command-line wrapper for the [[NTerminalAcetyltransferaseMover]]. It simulates the activity of a virtual NAT on a `Pose` by modifying the N-terminal residue at biologically relevant sequon positions into a `ACETYLATED_NTERMINUS_VARIANT` `VariantType`. It performs no further refinement or algorithmic steps.

One can use the `N-terminal_acetylation` application to quickly acetylate a protein at biologically relevant positions, depending on the virtual enzyme selected for the application. Further applications can be used to refine the output structure(s) in preparation for other protocols.

## Options
**General Options**

|**Froup**|**Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|in:path|s|Name of the `.pdb` file to process.|String|
|enzymes|species|Set the species name of this simulated enzyme. The default value is `h_sapiens`.|String|
|enzymes|enzyme|Set the specific enzyme name of this simulated enzyme. The default value is `generic`.|String|
|enzymes|efficiency|Set the efficiency of the this simulated enzyme, where 1.0 is 100%. The default value is read from the database.|Real|
|out|nstruct|Number of times to process each input `.pdb` file.|Integer|

**Details**
Setting the species name limits the behavior of the simulated acetyltransferase used in this application to consensus sequences used by the homolog found in the given species. A species name must be in the format `e_coli` or `h_sapiens`, (note the underscores,) which must also correspond to a directory in the Rosetta database, _e.g._, `database/virtual_enzymes/N-terminal_acetyltransferases/h_sapiens/`. If not set, `h_sapiens` is assumed.

If set, the simulated enzyme used in this application will use specific enzymatic details for this reaction from the database. If the species name has not been set, a "generic" enzyme from the DNA methyltransferase family is assumed. An enzyme name must be as listed in an appropriate enzyme file in `database/virtual_enzymes/DNA_methyltransferases/<species_name_>`.

The generic _H. sapiens_ N-terminal acetyltransferase is acetylates any N-terminus with 100% efficiency.

See [[EnzymaticMovers#Enzyme Data Files]] for information on how to format your own enzymatic data for other N-terminal acetyltransferases. (Note that the sequon for an N-terminal virtual enzyme should begin with `<`, as in `<(A/S/T/C)`; otherwise, the `Mover` will needlessly scan the entire `Pose` sequence.)

## Sample Command Line
`N-terminal_acetylation -s input/1ABC.pdb -enzymes:species h_sapiens -enzymes:efficiency 0.50 -nstruct 3`

## Code & Demo
The `N-terminal_acetylation` application can be found in `/Rosetta/main/source/src/apps/public/post-translational_modification/N-terminal_acetylation.cc`.

A demo for the `N-terminal_acetylation` application can be found in `/Rosetta/main/tests/integration/tests/N-terminal_acetylation/`.

## Contact
Labonte <JWLabonte@jhu.edu>
