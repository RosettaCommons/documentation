# Centroid Rotamer Model 

Centroid Rotamer Model adds rotamers in standard Centroid Model for better side-chain representation.
- Author: Yuan Liu (wendao@uw.edu) (if you need more info or find any problem using it, please contact me, thanks!)
- last updated: 8/4/2015

[[_TOC_]]

# Basic idea

For each amino acid, we cluster center of mass of side-chain heavy atoms into rotamer groups. Then we calculate mean value and standard deviation of bond length CEN-CB, bond angle CEN-CB-CA, torsion angle CEN-CB-CA-N for each phi/psi bin using Dunbrack's full-atom rotamer method.

# How to use it

First, add -corrections:score:cenrot in your command line for loading centroid rotamer library (this hack should be fixed after Rocco's refactor, but not completely done yet)

The simplest way to use CenRot model is rosetta_scripts, you can easily switch residue type by
```
<SwitchResidueTypeSetMover name="to_cenrot" set="centroid_rot"/>
```

Typical mover like packer, minimizer et al. should work properly.

# Code example

The lastest version is in my branch (yuan/cenrot_hybird) and will be merged into master very soon.
If you want to use it in your code, check pilot/wendao/cenrot_jd2.cc

## CenRotRepackMover
normal repack
## CenRotRelaxMover
repack + minimize (ramping vdw)
## CenRotRigidBodyRelaxMover
repack + minimize (fix bb)
## CenRotCanonicalMover
repack + bbGausian
## CenRotDockingMover
rigidbody + repack
## SmoothFragRepackMover
fragment insertion + repack
## RepackMinCenrotMover
repack + minimize (sidechain only)
## MinCenrotMover
cartesian/torsion minimize

# Score function
\There are couple of different CenRot score functions optimized for different purpose
- score3_cenrot: for fragment based sampling + repack
- score4_cenrot_repack: for native backbone repack
- score4_cenrot_design: for native backbone design
- score4_cenrot_relax: repack + min in torsion space
- score4_cenrot_relax_cart: repack + min in cartesian space
- score4_cenrot_cartmin.wts: minimize in cartesian space (higher vdw)

# TODO

more CenRot specific protocol