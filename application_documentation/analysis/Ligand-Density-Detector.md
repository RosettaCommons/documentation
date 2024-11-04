# Ligand Density Detector 
# Overview
The ligand density detection tool finds unmodelled regions in a cryoEM density map that likely belong to ligands. A mask of the provided PDB model is calculated and subtracted from the EM map to reveal unmodelled regions. Regions are evaluated based on the strength of the density and scored by their size and proximity to the macromolecule.

# Sample command
The ligand density detector is used with the `density_tools` application in `src/apps/public/electron_density/density_tools.cc`. An example command would be:
```
Rosetta/bin/density_tools \
-s mypdbfile.pdb \
-ligand_finder \
-mapfile myEMmap.mrc \
-edensity::mapreso map_resolution
```

### Options
```
Required options:
-s # Input PDB to be used as a mask. Macromolecule should be built into the map as much as possible

-ligand_finder # Required to search for unassigned density

-mapfile #Input cryoEM map in CCP4/MRC format

-edensity::mapreso # Resolution of the EM data

```

# Outputs
The application will output a list of detected density regions in a PDB file called `ligand.pdb`. Each line in the file will contain the coordinates for the center of mass of a blob in the xyz coordinate slots. Additionally, a receptor contact score and the blob volume are provided in columns 56-60 and 61-66, respectively. The receptor contact score is the fraction of surface voxels in the blob that are within 4 Å of the receptor. Blob volume is simply the number of voxels in blob.

# Filtering of blobs
The receptor contact score and voxel volume can be used to determine which regions most likely belong to a ligand. Small molecules will usually have volume greater than 50 voxels, with most being between 70-120 voxels. The receptor contact score will vary by the binding mode of a ligand, but a score of 0.70 or higher is generally a good filter. The blob finder may incorrectly detect regions of density that correspond to unmodeled macromolecule. This often occurs near termini or cuts in the protein for disordered regions. Caution should be used if a blob is found in these areas.