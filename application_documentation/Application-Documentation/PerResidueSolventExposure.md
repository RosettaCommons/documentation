# Per Residue Solvent Exposure

Creator Names:
* Melanie Aprahamian (aprahamian.4@osu.edu)
* PI: Steffen Lindert (lindert.1@osu.edu)

Date created: January 16, 2019

One way to quantify solvent exposure on a per residue basis is to look at its relative neighbor count. The application `per_residue_solvent_exposure.cc` utilizes several different methods to calculate and output the neighbor counts on a per residue basis. The app contains two main ways to calculate the neighbor counts: centroid or fullatom (FA). Within each, there are multiple different methods to calculate the neighbor count. 

NOTE: This application is an updated, more comprehensive version of the `burial_measure_centroid` application.

### Centroid
Calculating the neighbor count in centroid mode will represent each sidechain as a single point, a centroid ([Centroid](https://www.rosettacommons.org/docs/wiki/rosetta_basics/Glossary/Glossary#c)). The neighbor count can then be calculated using either the "sphere" or "cone" method.

The "sphere" method counts the number of residues around the target residue and weights the count with a logistic function defined as **neighbor count = 1/(1+exp(distance_steepness * (d - distance_midpoint))**
where **d** is the calculated distance between the target residue's CEN and the neighbor residue's CEN, **distance_steepness** defines the steepness of the curve, and **distance_midpoint** defines the midpoint of the curve.

The "cone" method was adapted from the [LayerSelector](https://www.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/ResidueSelectors/ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector) ResidueSelector. It calculates the neighbor count by weighting not just by the distance from the target residue but also the angle made between the target and the neighbor. The overall neighbor count is determined by taking the product of the distance and angle which are defined as follows:

**distance_factor = 1/(1+exp(distance_steepness * (d - distance_midpoint))** where **d** is the calculated distance between the target residue's CEN and the neighbor residue's CEN, **distance_steepness** defines the steepness of the curve, and **distance_midpoint** defines the midpoint of the curve.

**angle_factor = 1/(1+exp(angle_steepness * (theta - angle_midpoint))** where **theta** is the calculated angle between the vectors (target CA - target CEN) and (target CA - neighbor CEN), **angle_steepness** defines the steepness of the curve, and **angle_midpoint** defines the midpoint of the curve.

### Full Atom (FA)
Calculating the neighbor count in FA mode is identical to that of centroid, but instead of using the centroid representation, the full atom representation is used. The same "sphere" and "cone" methods defined above are used, but can be broken down into smaller sub methods:
* Residue Neighbor Count
 * Sphere Method with Closest Atom (target CA to neighbor closest atom)
 * Sphere Method with CB Atom (target CA to neighbor CB)
 * Cone Method with Closest Atom (distance = CA to closest, angle between CA-CB and CA-closest)
 * Cone Method with CB Atom (distance = CA to CB, angle between CA-CB and CA-CB)

The various methods can be specified through command line options when running the application.

### Usage
To use the application, the following command line options need to be specified:
```
-centroid_version         use flag if centroid mode is desired (FA is default)
-in:file:centroid         use this flag if centroid mode calculations are being done!
-neighbor_closest_atom    use flag if FA calculation requires the nearest neighbor (default behavior is to use CB)
-sphere_method            use flag if you want to use the sphere method
-cone_method              use flag if you want to use the cone method
-dist_midpoint            midpoint of distance calculation (default = 9.0)
-dist_steepness           steepness of distance calculation curve (default = 1.0)
-angle_midpoint           midpoint of angle calculation (default = pi/4)
-angle_steepness          steepness of angle calculation curve (default = 2pi)
```

Expected output will be written to TR and list the residue numbers and their respective neighbor counts.