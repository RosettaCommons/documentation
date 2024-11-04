# Simulated CryoEM Density Data
# Overview
The `sim_cryo` tool realistically simulates cryo-electron microscopy data by creating 2D projection images for 3D reconstruction. The input structure is randomly rotated and images are taken of projections of each plane. To simulate noise, atoms in the image are perturbed and gaussian noise is applied across each image.

# Sample command
`sim_cryo` is used by calling the app in `src/apps/public/electron_density/sim_cryo.cc`. An example command would be:
```
Rosetta/bin/sim_cryo \
-NR 400 \
-gauss_multiplier 0.8 \
-resolution 4 \
-pixel_size 1 \
-box_size_multiplier 2 \
-s mypdbfile.pdb \
-ignore_zero_occupancy false \
-ignore_unrecognized_res \
-particle_wt_offset 0.2 \
-atom_gauss_random_multiplier 3
```

### Options
```
Common options:
-s # Input PDB for which to simulate data

-NR # Number of rotations to project. Final number of images will be 3 times NR

-resolution # Target resolution of the simulated map

-pixel_size # Pixel size of projection images

-box_size_multiplier # Size of the box of projection images

-particle_wt_offset # Offset distance of particle in projection images

-gauss_multiplier # Multiplier of gaussian noise applied to each projection image

-atom_gauss_random_multiplier # Multiplier of gaussian noise for atom perturbation

Other options:
-crystal_refine # When included with -atom_gauss_random_multiplier will scale the multiplier by B-factors provided in the input PDB

```

# Outputs
The application will output the stack of projection images in a `*.mrcs` file along with metadata in a `*.star` file. Both files are needed to import the particles into 3D reconstruction software. We recommend cryoSPARC. Once imported, a 3D map can be reconstructed by ab initio reconstruction and homogenous refinement. **Note:** We recommend manually setting the pixel size when importing particles in cryoSPARC. It will sometimes crash in ab initio reconstruction if it reads the pixel size from the star file.

# Resolution modifications
The resolution of the final reconstructed map may not match the target resolution. The quality and resolution of the final simulated map can be affected by changing all of the above options, but we recommend changing `NR` or `atom_gauss_random_multiplier`. Increasing the number of rotations increases the overall number of particles and thus will likely improve resolution. Lowering the atom gaussian noise will improve the quality of the images which will likely improve resolution. To create more realistic local resolution variation, add the `-crystal_refine` flag to scale the atom gaussian multiplier by B-factor.
