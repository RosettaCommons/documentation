More and more modelers are attempting to use Rosetta to model structures other than those limited to peptide chains, and this will only be increasing. Rosetta has shown great success with RNA modeling, and the modeling of non-canonical amino acids, peptidomimetics, and polysaccharide structures are in active development.

Unfortunately, loading such structures from a PDB file into Rosetta can be challenging. The PDB format is not consistent for non-AA residues, the error-checking of such structures is poor in the PDB, and researchers often ignore all but the most basic standard PDB record types, which in some cases are necessary for proper loading of a file.

Below are some methods of getting your PDB structure to load into Rosetta properly.

[[_TOC_]]

## 3-Letter Codes
The 3-letter code is an unfortunate limitation of the current PDB format. Fortunately, there are a few methods of making sure that your residue is given a 3-letter code in the PDB that will allow it to be loaded into Rosetta.

### General Case
To load any residue from a PDB file into Rosetta, that residue must have its own unique [[topology (`.params`) file|Residue Params file]] defined, which needs to be included in the `ResidueTypeSet`.

This topology file will include the default _Rosetta_ 3-letter code, which _should_—but will not always—be the same as the PDB standard 3-letter code. Some residues will not already be assigned a PDB 3-letter code, so the Rosetta 3-letter code will necessarily not match. Some of these Rosetta codes will conflict with other 3-letter codes. Thus, it is necessary to have methods for specifying the exact residue type required.

#### ResidueTypeSet Inclusion
Some classes of residue types can be "turned on" by the use of specific flag options. (See examples below.) For other, more general cases, you can learn about how to "turn on" residue types here:

[[How to turn on residue types that are off by default]]

#### Alternate 3-Letter Codes Files
Within a special `.codes` file, one can specify a list of alternative 3-letter codes and the corresponding Rosetta 3-letter codes, as specified in the appropriate topology files. These `.codes` files have a very simple format: the first column is an alternate 3-letter code; the second column is the Rosetta 3-letter code; and the (optional) third column is a Rosetta HETNAM record designation for that code.

An example file might contain a line like this:
```
XXX ALA
```

Codes are **case-sensitive**:
```
XXX ALA
xxx GLY
```

To tell Rosetta to consider the alternate codes, simply use the `-alternate_3_letter_codes` option:
```
-alternate_3_letter_codes my_codes.codes
```

Several example files are present in the `database/input_output/3-letter_codes/` directory in the Rosetta database.

One can specify multiple files for inclusion: (Note that if an alternate 3-letter code is present in multiple files or on multiple lines in the same file, the later pairings will overwrite the previous ones.)
```
-alternate_3_letter_codes my_codes.codes her_codes.codes his_codes.codes
``` 

If you do not provide a full path, Rosetta will attempt to read the file from the `database/input_output/3-letter_codes/` directory in the Rosetta database. All of the following obtain the same result:
```
-alternate_3_letter_codes ${ROSETTA}/database/input_output/3-letter_codes/glycam.codes
-alternate_3_letter_codes ${ROSETTA}/database/input_output/3-letter_codes/glycam
-alternate_3_letter_codes glycam.codes
-alternate_3_letter_codes glycam
```

If the `-alternate_3_letter_codes` option is given, when Rosetta reads in a PDB it will first check to see if the 3-letter code is found in one of the alternate codes files. If it is, it will use the pairing in the supplied `.codes` files to translate the alternate code into a Rosetta 3-letter code. If the 3-letter code from the PDB file is not found as a alternate code in the `.codes` files, Rosetta will will try to use the 3-letter code it found in the PDB file directly.

(For an example of the use of the optional third column in `.codes` files, see the Carbohydrates section below.)

#### HETNAM Records
There are cases when one might have or need to use the same 3-letter code to indicate distinct residue types. In such cases, one can use the PDB `HETNAM` record type to specify the full name of the base (unpatched) `ResidueType` needed at that sequence position.

The standard PDB `HETNAM` record format is deficient for specifying this. Thus, Rosetta uses a "backwards-compatible", modified `HETNAM` record format.

Standard PDB `HETNAM` record line:
```
HETNAM GLC BETA-D-GLUCOSE
``` 
…which means that _all_ `GLC` 3-letter codes in the entire file are beta-D-glucose, which is insufficient, as this could mean twelve different beta-D-glucoses!

Rosetta PDB `HETNAM` record line:
```
HETNAM GLC A 1 ->4)-beta-D-Glcp
``` 
…which means that the `GLC` residue _at position A1_ requires the `->4)-beta-D-Glcp` `ResidueType`.

### Specific Cases
#### Carbohydrates
To load a PDB file with saccharide residues, use the `-include_sugars`.

Loading of saccharide residues works best using `HETNAM` records, as described above; however, one can also load (many) PDB files directly from the PDB or those generated from GLYCAM software, (which have their own unique 3-letter-codes,) using the `-alternate_3_letter_codes pdb_sugar` or `-alternate_3_letter_codes glycam` flags, as appropriate.

The `glycam.codes` file makes use of the third column of the list of alternative codes to specify the base `ResidueType` directly. This is an alternative to the use of `HETNAM` records and works because a GLYCAM 3-letter code for a saccharide, unlike a PDB 3-letter code for one, is specific for a particular residue type. For example, using the 3-letter code `4GA` in a PDB file along with `-alternate_3_letter_codes glycam`, which includes the following line:
```
4GA Glc ->4)-alpha-D-Glcp
```
…will net the same result as using the 3-letter code `Glc` and the record
```
HETNAM Glc A 1 ->4)-alpha-D-Glcp
```
within a PDB file.

 **Note:** Rosetta carbohydrate functionality is actively in development; please contact <JWLabonte@jhu.edu> for assistance/questions.

#### Mineral Surfaces
To load a PDB file with mineral surface residues, use the `-include_surfaces` flag. This will include all `ResidueTypes` defined in `database/chemical/residue_type_sets/fa_standard/residue_types/mineral_surface/`.

#### Lipids
To load a PDB file with lipid residues, use the `-include_lipids` flag.

 **Note:** Rosetta lipid functionality is actively in development and has not been published; please contact <JWLabonte@jhu.edu> for assistance/questions.

## Connectivity
Branching connectivity is defined in PDB files by `LINK` records. Rosetta will now interpret these `LINK` records appropriately to build a branching `FoldTree` by default.  Currently, one must add ```-write_pdb_link_records``` for them to be written out to any output PDB.


##See Also

* [[Making Rosetta robust against malformed PDBs|robust]]
* [[Non-protein residues]]: Guide to using non-protein molecules with Rosetta
* [[Residue Params file]]: File to specify chemical and geometric information for ligands and residues.
* [[Preparing structures]]: Preparing typical protein structures for use in Rosetta
* [[Preparing ligands]]: Preparing ligands for use with Rosetta
* [[Preparing PDB files containing protein and RNA|RNA-protein-changes]]
* [[Running Rosetta with options]]: Instructions for running Rosetta applications on the command line
* [[File types list]]: File types used in Rosetta