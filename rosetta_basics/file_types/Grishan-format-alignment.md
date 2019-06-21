The Grishin format is a Rosetta-specific multiple sequence alignment format.  It is primarily used with the [[partial_thread|RosettaCM]] application in Rosetta.  Each template/target pair is specified on 6 lines with the following format:

    ## hsIGF 1k3dA_renum
    #
    scores_from_program: 0
    0 KVTVDTVCKRGFLIQMSGHLECKCEND-VLVNEETCEEKVLKCDE
    0 AVTVDTICKNGQLVQMSNHFKCMCNEGLVHLSENTCEEKN-CKKE
    --

In the above, the '##', '#', and 'scores_from_program: 0' lines _must_ be present.  On the '##' line, there should be two identifiers.  The first identifies the "target name" and the second identifies the "template name".  The _target name_ is unused by Rosetta, while the _template name_ is used for both input and output names:
* The first five characters are used to identify which input PDB is to be aligned.
* The full name is used for the output file

* first sequence = target sequence
* second sequence = template sequence


**Note:**  The output files will be named after the corresponding name in the Grishin alignment file. Furthermore, this name has to be at least 5 characters long. If your name in the alignment file is the same as your input file name, **the input file will be overwritten!** Thus, it is recommended to use "XXXXX_thread" in the alignment file, where 'XXXXX.pdb' is the pdb file of the template; the **partial_thread** application will then produce XXXXX_thread.pdb.

Multiple alignments may be concatenated in a single file:

    ## hsIGF 1k3d.templ
    #
    scores_from_program: 0
    0 KVTVDTVCKRGFLIQMSGHLECKCEND-VLVNEETCEEKVLKCDE
    0 AVTVDTICKNGQLVQMSNHFKCMCNEGLVHLSENTCEEKN-CKKE
    --
    ## hsIGF 1y12.templ
    #
    scores_from_program: 0
    0 DVTVETVCKRGNLIQRSG---CKCENDLVLVNHETCEEKVLKCDL
    0 AVTVDTICKNGQLVQMSNHFKCMCNEGLVHLSENTCEEKN-CKKE
    --
Multiple alignments should be written to the _same_ alignment file.

If your alignment starts at a different position in the template, you can change the numbers at left of the format or add - where they need to be.

    ## 1xxx 1yyy.pdb
    # hhsearch
    scores_from_program: 1.0 0.0
    7 AAAAAAA
    0 AAAAAAA
    --

Alternately, you can add the N term residues unaligned to the ali file:

    ## 1xxx 1yyy.pdb
    # hhsearch
    scores_from_program: 1.0 0.0
    0 AAAAAAAAAAAAAA
    0 -------AAAAAAA
