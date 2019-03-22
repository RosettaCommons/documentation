#### Running mol2genparams.py

```html
Usage: python mol2genparams.py [-s mol2file or -l mol2filelist] [options]

Options:
  -h, --help            show this help message and exit
  -s INPUTS, --inputs=INPUTS
  -l L                  
  --nm=RESNAME, --resname=RESNAME
                        Residue name
  --auto_nm=AUTO_RESPREFIX
                        Automatically rename resname starting with argument;
                        default L[00-99]
  --am1bcc              Calculate am1bcc charge (currently am1 part only; bcc will be added soon)
  --prefix=PREFIX       Prefix of output names
                        (prefix.params,prefix_0001.pdb), default as the prefix
                        of input mol2 file
  --debug               Report verbose output for debugging
  --no_output           Do not report params or pdb
  --funcgrp             Report functional group assignment to stdout
  --elec_cp_rep         Report elec-countpair info to [prefix].elec_cp_ref
  --elec_grpdef         Report elec-grp-definition info to [prefix].grpref
  --puckering_chi       Define ring puckering torsions as rotatable CHI
  --amide_chi           Define amide as rotatable CHI
  --freeze_ringring     Define  as rotatable CHI
```

**Notes:**

* Requires numpy and scipy installed in order to run the script.
* Requires numba installation for --am1bcc option. This can be readily installed through Anaconda.