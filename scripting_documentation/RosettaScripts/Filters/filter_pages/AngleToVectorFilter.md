# AngleToVector
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AngleToVector

An ad hoc filter to compute the angle (in degrees, 0-180) between two atoms on the first residue of a chain and a predetermined vector. The purpose of this filter is to test whether a small molecule is bound in a protein pocket in the 'correct' orientation.

```xml
<AngleToVector name="(&string)" atm1="(&string)" atm2="(&string)" chain="(2&size)" refx="(&real)" refy="(&real)" refz="(&real)" min_angle="(0.0&real)" max_angle="(90.0&real)"/>
```
-  atm1, atm2: the names of the atoms from which to compute the directionality vector, for instance, "CA", "NE".
-  chain: on which chain is the ligand?
-  refx, refy, refz: the x,y,z components, respectively, of the reference vector. The reference vector will be normalized by the filter before computing an angle.
-  min_angle, max_angle: for filtering, what minimal and maximal angles to require.

The filter computes the vector atm1 - atm2 and then computes the angle between this difference vector and the reference vector.

If you don't know how to generate a reference vector put your ligand in the desired orientation with respect to the protein and run the filter with arbitrary refx, refy, refz values. You will get a Tracer output:

    protocols.simple_filters.AngleToVector: diff vec ...

Specifying the x,y,z components of the normalized vector atm1 - atm2. Now, use the three values in the filter refx, refy, refz and you're on your way.

## See also

* [[DockingMover]]
* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[TorsionFilter]]
* [[GeometryFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]
