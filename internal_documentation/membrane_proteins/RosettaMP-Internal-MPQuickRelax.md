## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 4/26/15

## Algorithm Description
This is the simplest refinement application for membrane proteins that is currently available. The advantage over MPFastRelax is that it is up to 40x faster for large membrane proteins. A 1000 residue protein with MPFastRelax takes about 10 hours per decoy on a single processor, but only 10-15 mins with MPQuickRelax. An 80 residue protein takes about 60 seconds with MPFastRelax, but only about 6 seconds with MPQuickRelax. The disadvantage is that this algorithm is currently not extensively tested, and sometimes generates decoys with positive scores that need to be sorted out. Generally, the scores also seem to be slightly higher than with MPFastRelax. 

The algorithm runs a simple SmallMover and ShearMover that slightly change the dihedral angles of the protein, does sidechain repacking, and a single round of minimization. The maximum dihedral deviation (Small and ShearMover uses a random angle below the maximum set angle) and the number of dihedral angle changes applied to the protein can both be set by commandline. The scorefunction it uses is mpframework_smooth_fa_2012. 

## Code and Demo
The application can be found at `apps/pilot/jkleman/mp_quick_relax.cc`. The underlying mover is located in `protocols/membrane/MPQuickRelaxMover`.

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_quick_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:file:native 1AFO_tr.pdb \         # superimposes the model onto the native, using CA atoms
-mp:setup:spanfiles 1AFO__tr.span \ 
-mp:quickrelax:angle_max 1.0 \        # optional, maximum allowed dihedral angle change, typical value around 1.0, default 1.0
                                      # 1.0 creates models with RMSDs of 0-2A around the native
-mp:quickrelax:nmoves nres \          # optional, number of times Small and ShearMover makes changes to protein
                                      # can be number or 'nres', taking all residues in the protein
                                      # default: 'nres'
```

## Notes

Has currently not been tested with constraints, is coming soon though. 

## Reference

This reference only cites MPFastRelax; MPQuickRelax isn't published yet. 

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
