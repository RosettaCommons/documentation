<!-- --- title: Silent File -->

A silent file is a compact file format that stores information about a structure. Unlike the PDB format, the silent format can contain information for more than one structure. 

There are two encodings of silent files: Protein and Binary. They differ in how they store the coordinate info. Protein silent files store the phi/psi/chi information in a text-based column layout. Binary silent files store the full xyz atom coordinates in an ASCII-encoded version of the binary  IEEE 754 double value.
Protein struct silent files hold the structural information as columns, but in binary files, the structural information is saved as an ASCII string. Binary Silent Struct File is very useful for compressing multiple PDBs and saving computer space. Protein Silent Struct is usually seen in the Abinitio outputs.

* **Caution**: The protein silent files only work with canonical amino acids, with all bond lengths and angles at their ideal values (e.g. in Abinitio protocol). Anything else would lose structural information. So if you have non-ideal bond lengths and three-atom angles, or if you have ligand residues, then you need to use the binary silent file format.

The output encoding can be changed using this flag: 
```
-out:file:silent_struct_type binary 
or
-out:file:silent_struct_type protein
```

**Protein encoding** 

-   Header

    ```
    SEQUENCE                      Structure sequences presented by one-letter amino acid code
    SCORE                         Rosetta score terms
    ```

-   Body

    ```
    Columns 1-4                   Residue sequence number
    Columns 5-7                   Secondary structure one letter code
    Columns 8-17                  Phi angle
    Columns 18-26                 Psi angle
    Columns 27-35                 Omega angle
    Columns 36-44                 CA atom coordinates x
    Columns 45-53                 CA atom coordinates y
    Columns 55-62                 CA atom coordinates z
    Columns 64-98                 Chi angle real data if possible
    ```

**Binary encoding**

-   Header

    ```
    SEQUENCE                      Structure sequences presented by one-letter amino acid code
    SCORE                         Rosetta score terms
    ```

-   Body

    ```
    Binary contents
    ```
## Extracting other file types from silent file

### Extracting PDB from silent

The `extract_pdbs` application can convert silent files into PDB files. Information about the options can be found in the integration test folder /Rosetta/main/tests/integration/tests/extract_pdbs/. 

### Extracting silent from silent

One can use methods native to Linux to extract specific poses from a silent file. For example:

    #Getting the header of silent file
    head -3 file.silent > new.silent 

    #Appending data from pose with tag 'result_0001' to the new silent file
    grep 'result_0001' file.silent >> new.silent

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[Input options]]: Command line options for Rosetta input
* [[Output options]]: Command line options for Rosetta output
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
