## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 4/26/15

## Algorithm Description
This application makes a mutation and then runs MPQuickRelax on a membrane protein. The score function it uses is
mpframework_smooth_fa_2012. The mutation can either specified on the command line (-mp:mutate_relax:mutation) or given in a mutation file. The mutation file can contain several independent constructs to run this application for.

To be able to run the application from the mutation file, yet have only one process running it, it runs outside of JD2. The -nstruct flag should therefore always be 1, otherwise the same models will be overwritten! The number of models generated here are 100 by default, but can be changed by the flag -mp:mutate_relax:iter.

## Code and Demo
The application can be found at `apps/pilot/jkleman/mp_mutate_relax.cc`. The underlying mover is located in `protocols/membrane/MPMutateRelaxMover`.

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_mutate_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:file:native 1AFO_tr.pdb \         # superimposes the model onto the native, using CA atoms
-mp:setup:spanfiles 1AFO__tr.span \ 
-mp:quickrelax:angle_max 1.0 \        # optional, maximum allowed dihedral angle change, typical value around 1.0, default 1.0
                                      # 1.0 creates models with RMSDs of 0-2A around the native
-mp:quickrelax:nmoves nres \          # optional, number of times Small and ShearMover makes changes to protein
                                      # can be number or 'nres', taking all residues in the protein
                                      # default: 'nres'
-mp:mutate_relax:mutant_file mutations_1AFO.mut \ # mutation file specifying the mutations
                                      # if no mutation file is given, please use the flag:
-mp:mutate_relax:mutation A163F       # specified mutation to make. Either this flag or above one MUST be given.
-mp:mutate_relax:iter 5 \             # optional, only build 5 models for ddG calculations. Default is 100
-nstruct 1 \                          # required, MUST be 1, otherwise models will be overwritten n times!
```

## Reference

This protocol is currently not published yet. The framework and previous protocol was published in:

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
