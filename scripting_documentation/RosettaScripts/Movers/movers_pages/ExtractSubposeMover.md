# ExtractSubpose
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ExtractSubpose

(This is a devel Mover and not available in released versions.)

<!--- BEGIN_INTERNAL -->
Used to extract a subset of the subunits from a symmetric pose based on contacts with a user specified component (via sym\_dof\_name(s)). This subpose is dumped as a pdb with the user specified prefix, suffix, and basename derived from the job distributer. DOES NOT MODIFY THE POSE. For each sym\_dof\_name passed by the user, all neighboring subunits (as assessed by CA or CB contacts with the user specified contact\_distance (10.0 A by default)). If extras=true, then all the full building block for each sym\_dof will be extracted along with all touching building blocks.

    <ExtractSubpose name="(&string)" sym_dof_names="(&string)" prefix="('' &string)" suffix="('' &string)" contact_dist="(10.0 &Real)" extras="(0 &bool)" />

-   sym\_dof\_names - Name(s) of the sym\_dofs corresponding to the primary component(s) to extract along with the neighboring subunits/building blocks. Passed as a string (optionally: with a comma-separated list).
-   prefix - Optional prefix for the output pdb name.
-   suffix - Optional suffix for the output pdb name.
-   contact\_dist - Maximum CA or CB distance from any residue in the primary component(s) to any residue in another component for it to be considered a "neighbor" and added to the extracted subpose.
-   extras - Boolean option to set whether or not full building blocks are extracted rather than just subunits.

<!--- END_INTERNAL --> 

##See Also

* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[CutOutDomainMover]]
* [[SymmetryAndRosettaScripts]]
* [[Symmetry]]: Using symmetry in Rosetta
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
