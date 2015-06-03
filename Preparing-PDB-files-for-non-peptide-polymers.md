More and more modelers are attempting to use Rosetta to model structures other than those limited to peptide chains, and this will only be increasing. Rosetta has shown great success with RNA modeling, and the modeling of non-canonical amino acids, peptidomimetics, and polysaccharide structures are in active development.

Unfortunately, loading such structures from a PDB file into Rosetta can be challenging. The PDB format is not consistent for non-AA residues, the error-checking of such structures is poor, and researchers often ignore all but the most basic standard PDB record types, that in some cases are necessary for proper loading of a file.

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
Within a special `.codes` file, one can specify a list of alternative 3-letter codes and their corresponding Rosetta 3-letter codes, as specified in the appropriate topology files. These files have a very simple format: the first column is an alternate 3-letter code; the second column is the Rosetta 3-letter code; and the third column (optional) is a Rosetta HETNAM record designation for that code.

An example file might contain a line like this:
```
XXX ALA
```

Codes are **case-sensitive**:
```
XXX ALA
xxx GLY
```

To tell Rosetta to consider the alternate codes, simply use the `-allow_3_letter_codes` flag:
```
-allow_3_letter_codes my_codes.codes
```

Several example files are present in the `database/input_output/3-letter_codes/` directory.

One can specify multiple files for inclusion: (Note that successive files will overwrite previous codes if there are conflicts.)
```
-allow_3_letter_codes my_codes.codes her_codes.codes his_codes.codes
``` 

If you do not provide a full path, Rosetta will assume that you placed the `.codes` file in the `database/input_output/3-letter_codes/` directory. All of the following obtain the same result:
```
-allow_3_letter_codes database/input_output/3-letter_codes/glycam.codes
-allow_3_letter_codes database/input_output/3-letter_codes/glycam
-allow_3_letter_codes glycam.codes
-allow_3_letter_codes glycam
```

When this flag is used, while it is considering which `ResidueType` to assign for a particular residue in the PDB file, it will first check to see if the 3-letter code is found in one of the alternate codes files. If it is, it will use the alternate code to find the `ResidueType` it needs; if not, it will try to use the code it found in the PDB file.

#### HETNAM Records
There are cases when one might have or need to use the same 3-letter code to indicate distinct residue types. In such cases, one can use the PDB `HETNAM` record type to specify the full name of the base (unpatched) `ResidueType` needed that sequence position.

The standard PDB `HETNAM` record format is deficient for specifying this. Thus, Rosetta uses a "backwards-compatible", modified `HETNAM` record format.

Standard PDB `HETNAM` record line:
```
HETNAM GLC BETA-D-GLUCOSE
``` 
…which means that _all_ `GLC` 3-letter codes in the entire file are beta-D-glucose, which is insufficient, as this could mean twelve different beta-D-glucoses!

Rosetta PDB `HETNAM` record line:
```
HETNAM GAL A 1 ->4)-beta-D-Galp
``` 
…which means that the `GAL` residue _at position A1_ requires the `->4)-beta-D-Galp` `ResidueType`.

 **Note:** Currently, `HETNAM` records only work with saccharide residues, but this will be changed soon to include any type of residue.

### Specific Cases
#### Carbohydrates
To load a PDB file with saccharide residues, use the `-include_sugars` and the `-override_rsd_type_limit` flags. If the glycan contains branches, you will need to allow use the `-read_pdb_link_records` flag. (See below.)

Currently, loading of saccharide residues requires the use of `HETNAM` records, as described above, but shortly, one will be able to load (some) PDB files directly from the PDB or those generated from GLYCAM software, (which have their own unique 3-letter-codes,) using the `-alternate_3_letter_codes pdb_sugar` or `-alternate_3_letter_codes glycam` flags, as appropriate.

 **Note:** Rosetta carbohydrate functionality is actively in development and has not been published; please contact <JWLabonte@jhu.edu> for assistance/questions.

#### Mineral Surfaces
To load a PDB file with mineral surface residues, use the `-include_surfaces` flag. This will include all `ResidueTypes` defined in `database/chemical/residue_type_sets/fa_standard/residue_types/mineral_surface/`.

#### Lipids
To load a PDB file with lipid residues, use the `-include_lipids` flag.

 **Note:** Rosetta lipid functionality is actively in development and has not been published; please contact <JWLabonte@jhu.edu> or <rfalford12@gmail.com> for assistance/questions.

## Connectivity
Branching connectivity is defined in PDB files by `LINK` records. If the `-read_pdb_link_records` option is enabled, Rosetta will interpret these `LINK` records appropriately to build a branching `FoldTree`.