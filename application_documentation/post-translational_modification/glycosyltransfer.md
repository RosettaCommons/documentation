# glycosyltransfer

This application is currently a simple command-line wrapper for the [[GlycosyltransferaseMover]]. It simulates the activity of a virtual GT or OST on a `Pose` by adding (a) carbohydrate residue(s) at biologically relevant sequon positions. It performs no further refinement or algorithmic steps.

[[_TOC_]]

## Background
Many proteins in nature are post-translationally modified, yet deposited structures often have their PTMs absent or removed. Glycosylation is the most prevalent of all PTMs. The `glycosyltransfer` application allows a user to simulate the action of a virtual glycosyltransferase (GT) or oligosacharyltransferase (OST) enzyme on a "substrate" — the loaded `.pdb` structure. The virtual transferase may be a biologically real transferase or entirely hypothetical or constructed.

## Description
One can use the `glycosyltransfer` application to quickly glycosylate a protein at biologically relevant N, O, or C positions or extend a current glycan tree, depending on the virtual enzyme selected for the application. Further applications, such as the [[GlycanTreeModeler]], can be used to refine the output structure(s) in preparation for other protocols.

## Options
**General Options**

|**Group**|**Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|in:path|s|Name of the `.pdb` file to process.|String|
|in|include_sugars|Set whether or not carbohydrate residues will be loaded into Rosetta. _The default value is false._|Boolean|
|enzymes|species|Set the species name of this simulated enzyme. The default value is `h_sapiens`.|String|
|enzymes|enzyme|Set the specific enzyme name of this simulated enzyme. The default value is `generic`.|String|
|out|nstruct|Number of times to process each input `.pdb` file.|Integer|

**Details**

The application will fail if the `-include_sugars` flag is not set.

Setting the species name limits the behavior of the simulated glycosyltransferase used in this application to consensus sequences used by the homolog found in the given species. A species name must be in the format `e_coli` or `h_sapiens`, (note the underscores,) which must also correspond to a directory in the Rosetta database, _e.g._, `database/virtual_enzymes/glycosyltransferases/h_sapiens/`. If not set, `h_sapiens` is assumed.

If set, the simulated enzyme used in this application will use specific enzymatic details for this reaction from the database. If the species name has not been set, a "generic" enzyme from the glycosyltransferase family is assumed. An enzyme name must be as listed in an appropriate enzyme file in `database/virtual_enzymes/glycosyltransferases/<species_name_>`.

The generic _H. sapiens_ glycosylatransferase is an OST that transfers α-D-Manp-(1→3)-[α-D-Manp-(1→6)]-β-D-Manp-(1→4)-β-D-GlcpNAc-(1→4)-β-D-GlcpNAc- (man3) to the Asn residue of any NX(S/T) sequons on a struture with 100% efficiency.

See [[EnzymaticMover#Enzyme Data Files]] for information on how to format your own enzymatic data for other glycosyltransferases.

## Sample Command Line
`glycosyltransfer -s input/1ABC.pdb -include_sugars -enzymes:species h_sapiens -enzymes:enzyme OGT -nstruct 5`

## Code & Demo
The `glycosyltransfer` application can be found in `/Rosetta/main/source/src/apps/public/post-translational_modification/glycosyltransfer.cc`.

A demo for the `glycosyltransfer` application can be found in `/Rosetta/main/tests/integration/tests/glycosylation/`.

## Contact
Labonte <JWLabonte@jhu.edu>

## See Also
- [[EnzymaticMover]]
- [[SimpleGlycosylateMover]]
- [[GlycanTreeModeler]]
