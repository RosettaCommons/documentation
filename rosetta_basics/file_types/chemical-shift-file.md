#Chemical Shift File

Name
====

```
*.chsft, *.chsft_in 
```

Format
======

Chemical shift data is stored in records one on each line. The records are column-oriented. The fields in each record are as follows:

Fields of chemical shift records

```
Description      Data type                  Columns     
Amino acid code  1- or 3- letter string     1-3
Residue number   decimal                    5-8
C shift          float                      10-15
CA shift         float                      17-22
CB shift         float                      24-29
HA shift         float                      31-36
N shift          float                      38-43
```

**Notes:**

-   Amino acid codes are as specified by IUPAC.
-   Residue ids are positions as indicated in the PDB file.
-   Atom types are as indicated in the PDB file.
-   An unknown chemical shift value is represented by the value 9999.00.
-   For those familiar with printf each line is encoded as follows: 

    ```
    "       0   0.00   0.00   0.00   0.00   0.00\n"
    ```

Example
=======

Chemical shift input :

```
  M    1  170.54   54.45   33.27    4.23 9999.00
  Q    2  175.92   55.08   30.76    5.25  123.22
  I    3  172.45   59.57   42.21    4.21  115.34
  F    4  175.32   55.21   41.48    5.63  118.11
  V    5  174.87   60.62   34.23    4.72  121.00
```

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[CS-Rosetta wiki page|CS-Rosetta]]
* [[Official CS-Rosetta website (external link)|http://csrosetta.chemistry.ucsc.edu/]]
* [[Additional CS-Rosetta information (external link)|http://spin.niddk.nih.gov/bax/software/CSROSETTA/]]
* [[CS Rosetta RNA]]: RNA modeling application that uses chemical shift data
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications