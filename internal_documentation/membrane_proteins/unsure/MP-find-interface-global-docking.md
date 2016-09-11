## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 4/26/15

## Algorithm Description

This algorithm does a global docking search in the membrane bilayer. It first superimposes partner 1 with the native, then sets up the foldtree to have the membrane residue at the root (i.e. membrane is fixed). It creates a random starting position of the two partners by moving them apart. The first partner is fixed, but the second will move randomly in the membrane, sampling a large variety of interfaces. It does 10 iterations of the following movers, each Mover with a DockingSlideIntoContact at the end: SpinMover, SpinAroundPartnerMover, TiltMover, FlipMover, SpinAroundPartnerMover.  

- SpinMover: spins the second partner around its normal axis (close to z-axis) in the membrane, using a random spin angle between 0 and 360 degrees. 

- SpinAroundPartnerMover: spins partner 2 around the fixed partner 1. Does a random translation into a box of (default 100A), then DockingSlideIntoContact

- TiltMover: tilts partner 2 towards (or away from) partner 1. Angle is random between +/-45 degrees.

- FlipMover: flips partner 1 in the membrane around the axis connecting the partners. Angle is random between +/-45 degrees deviating from 180 flip. 

The application is very coarse grained, i.e. does not do a local minimization around the interfaces. Instead, it samples a wide range of conformations, of which the lowest scoring ones (or better: lowest interface scoring ones) can then be locally refined. Runtimes are very fast, generating a decoy every ~2 seconds for an 80 residue protein, and every ~70 seconds for a 1000 residue protein.

## Code and Demo
The application can be found at `apps/pilot/jkleman/mp_find_interface.cc`. The underlying mover is located in `protocols/docking/membrane/MPFindInterfaceMover`.

## Run the application
The input file is a single PDB file and a single spanfile, which can be generated with the `mp_docking_setup` application. Example flags for finding the interface: 

```
Rosetta/main/source/bin/mp_find_interface.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:file:native 1AFO_tr.pdb \            # superimposes the model onto the native, using CA atoms
-mp:setup:spanfiles 1AFO__tr.span \      # required, spanfile
-mp:no_interpolate_Mpair 1 \             # optional, for better scoring
-mp:scoring:hbond 1 \                    # optional, for better scoring
-mp:dock:lowres 1 \                      # use lowres score function for scoring, EITHER this flag or ...
-mp:dock:highres 1 \                     # ... this flag must be given
-docking:partners A_B \                  # use chain A as docking partner 1 and chain B as docking partner 2
-score::docking_interface_score 1 \      # optional, add the interface score to the score file
-packing:pack_missing_sidechains false \ # don't pack sidechains until the membrane residue is added, sometimes needed
```

## Reference

This protocol is currently not published yet. The framework and previous protocol was published in:

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
