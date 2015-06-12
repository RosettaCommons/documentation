#Using Fragment Files in Rosetta

Fragments are used in the assembly of proteins whether for structure prediction or design, to cut down on the size of the protein-folding search space. They are a core part of the Rosetta design. : Fragment libraries are used by many protocols but are a core part of ab initio.

Filename Format
======

-   **Fragment libraries follow a complex naming scheme:**

    ```
    {series}{pdb}{chain}{size}_{strategy}.{depth}_{version}
    ```

-   **Terms in fragment filenames** Terms in fragment filenames:

    ```
    series      The two character code used to disambiguate Rosetta runs. For fragment libraries this is almost always aa.
    pdb         The four character code of the PDB the fragments were generated for.
    chain       The one character code of the protein chain the fragments were generated for. Usually "_" for all.
    size        Fragment size, either a 3-mer or 9-mer. Acceptable values are 03 and 09.
    strategy    Fragment selection strategy used in NNMake. Acceptable values are 04, 05 and 06. See below.
    depth       Number of fragments of descending score which are kept in the library, usually 200.
    version     Version of NNMake, usually v1_3.
    ```

File Content Format
==============

Fragment files typically have the following format (Referred to a "rosetta++ format")

```
position:            1 neighbors:          200
{fragment data}
position:            2 neighbors:          200
{fragment data}
```

Where "position" is the pose number of the starting point of the fragment, and "neighbors" is the number of fragments (ignored on reading).

"fragment data" consists of blank-line separated blocks of lines. Each block represents a fragment, and the number of lines in the blocks matches the size of the fragment.

Each line in the fragment data typically looks like the following:

```
 2oqo A   189 I L -140.176  157.939 -179.962   -0.776    5.007    51.121 3     0.000 P  1 F  1
```

The format is column based

```html
Column -- Meaning
1      -- blank
2-5    -- PDB code for the fragment origin
7      -- chain ID for the origin PDB
9-13   -- PDB residue number for the origin PDB
15     -- amino acid identity in the origin PDB
17     -- secondary structure for the origin PDB (Helix, Loop, Extended/beta)
19-27  -- phi
28-36  -- psi
37-45  -- omega
46-54  -- C-alpha x coordinate for origin PDB (optional)
55-63  -- C-alpha y coordinate for origin PDB (optional)
65-73  -- C-alpha z coordinate for origin PDB (optional)
74-79  -- unknown (unused)
80-85  -- unknown (unused)
86     -- Literal "P" (unused)
87-89  -- fragment position number, pose numbered (unused)
91     -- Literal "F"(unused)
92-94  -- fragment number (unused)
```

Everything after omega is ignored/discarded in modern Rosetta runs, and may not even be present in all version of the fragment file.

Make Fragments
==============

1.  Making Fragments
2.  Making Fragments from Free Web Server: [Robetta Server](http://robetta.bakerlab.org/)
3.  Making Fragments by yourself: DATABASES: nr - downloadable from [ftp://ftp.ncbi.nih.gov/blast/db/external](ftp://ftp.ncbi.nih.gov/blast/db/external) link nnmake\_database included in release. chemshift\_database include in release. PROGRAMS: [PSI\_BLAST](ftp://ftp.ncbi.nih.gov/blast/executables/release/) [PSIPRED](http://bioinf.cs.ucl.ac.uk/psipred/) [JUFO](http://www.meilerlab.org/) [PROFphd](http://www.predictprotein.org/newwebsite/download/index.php) [SAM](http://www.soe.ucsc.edu/research/compbio/sam.html) nnmake include in release chemshift include in release Configure paths at the top of nnmake/make\_fragments.pl to point to these databases and programs. PSI-BLAST must be installed locally After PSIBLAST and PSIPRED are installed, refer to its README or see quick directions below on how to create a filtered "NR" seqeuence data bank, called "filtnr", which is also used by make\_fragments.pl. Quick directions for creating filtnr:

    ```
    tcsh81538cfilt nr.fasta > filtnr
    tcsh 0.000000ormatdb -t filtnr -i filtnr
    tcsh p filtnr.p?? $BLASTDB
    ```

    1.  Obtain a fasta file for the desired sequence. This file must have 60 characters/line with no white space. First line can be a comment starting with the '\>' character.
    2.  Obtain secondary structure predictions from web servers, or setup shareware locally so that make\_fragment.pl can run secondary structure predictions locally. The fragment maker can use predictions from psipred (.jones or .psipred extension), PhD (.phd) and SAM-T99 rdb format (.rdb) and jufo (.jufo). Up to three predictions can be used. At least one must be used. The getSSpred.pl script can be used to obtain predictions off the web. Edit the config portion of this script to include your email address and to include the correct path to the httpget script. To use this script, provide the fasta filename and the desired method.(invoke the command without arguments to see the usage explanation). Retrieve the secondary structure predictions from your email mail box.
    3.  (Optional) Prepare files with NMR data if avialbe - these include .cst and .dpl files that are the same files that rosetta uses, and the .chsft\_in file that contains chemical shift information. The information from these files can help Rosetta better pick fragments. See the file 'data\_formats.README' for the formatting information.
    4.  Run make\_fragments.pl. Invoke without arguments for usage options. Likely the only argument you need to provide is the fasta file.

        ```
        $> make_fragments.pl -verbose 2ptl_.fasta
        ```

        If you want to exclude homologous seqeunces from the fragment search, add the -nohoms argument. \$\> make\_fragments.pl -verbose -nohoms 2ptl\_.fasta Note that if you want to exclude homologs from the chemical shift/TALOS search, you need to edit the talos database. See the README in the chemshift\_source directory for instructions. If you do not have a particular type of secondary structure prediction (say the .jufo file) and you do NOT want make\_fragments to try to run the method locally, use the -nojufo option.

        ```
        $> make_fragments.pl -verbose -nohoms -nojufo 2ptl_.fasta
        ```

        Two fragment files will be generated with names like aa2ptl\_03\_05.200\_v1\_3 and aa2pt\_09\_05.200\_v1\_3. The prefix "aa" can be changed by -xx option. "2ptl\_" is the five-letter base name which can be specified by -id option or it is derived from the name of fasta file. 03 or 09 indicate the lengths of fragments.

    5.  Generate loop library in addition to fragment files. Run make\_fragments.pl with -template option such as (five-letter code is 2ptl\_ for example):

        ```
        $> make_fragments.pl -template 2ptl_ 2ptl_.fasta
        ```

        it requires 2ptl\_.pdb and 2ptl\_.zones to be present in your run dir and this pdb is a template pdb file which has been generated by createTemplate.pl described in README.loops. From the zone file, loops can be defined and a library of loop conformations for each defined loop are complied into a file called "2pt\_.loops\_all" (which usually contains 2000 loop conformations) based on fragment picking. Then the script "trimLoopLibrary.pl" is automatically called to reduce the size of the loop library and output the file as "2ptl\_.loops". This file is later on used in the Rosetta loop modeling mode to build variable loops onto the template structure. A loop library differs from a fragment library mainly in that geometrical information is considered to pick "loop" fragments with desired length which can roughly close the gap based on the "take-off" stub positions. A newer version vall database (2006-05-05) has been provided in nnmake\_database together with the orginal version 2001-02-02. You can make fragments using either version of database, just modifying make\_fragments.pl to have it pointing to the version you want to use. Currently, making loop library only works with 2001-02-02 version as some newly developed loop modeling methods do not need a loop library any more. **NOTES:**

        1.  name all your files with a five character base name followed by the appropriate extension. The base-name should be the four-letter pdb code and 1 letter chain id.
        2.  See also pNNMAKE? for a listing of the files involved in the fragment process
        3.  If a pdb file is in the directory you are making fragments in, nnmake will evaluate the fragment match to the pdb. Note that if the pdb file disagrees with the fasta file, the program will detect an error and stop.

4.  How to Make a vall Without Knowing What You are Doing.(Jack Schonbrun May 27, 2004) You need to use Rosetta executable to make a vall data.

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[ROBETTA (external link)|http://robetta.bakerlab.org/]]: Web server that provides free fragment picking and other services for academic users
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Structure prediction applications]]: List of applications for structure prediction, many of which use fragments files
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications