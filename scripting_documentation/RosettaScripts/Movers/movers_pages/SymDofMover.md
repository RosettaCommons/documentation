# SymDofMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SymDofMover

Used to setup symmetric systems in which the input structures(s) are aligned along the x, y, or z axis. 
All functionality, except for grid sampling, can handle any number of distinct input structures for multi-component symmetric systems (Grid sampling can handle 1 or 2). 
Input subunits are first optionally flipped 180 degrees about the specified axes (x, y, or z) to "reverse" the inputs if desired, then translated along the specified axes (x, y, or z) by the values specified by the user in the radial\_disps option and rotated about the specified axes by the value specified by the user in the angles option, and lastly, if the user specifies axes for the align\_input\_axes\_to\_symdof\_axes option, then for each input subunit the user specified axis (x, y, or z) is aligned to the correct axis corresponding to the sym\_dof\_name in the symmetry definition file. 
Following these initial manipulations of the input structures, a symmetric pose is generated using the user specified symmetry definition file. 
If one wishes to sample around the user defined radial\_disps and angles, then this can be done either through non-random grid sampling, random sampling from a Gaussian distribution within a user defined range, or random sampling from a uniform distribution within a user defined range. 
Each sampling method is driven by nstruct. 
If grid sampling is desired, then the user must specify radial\_disps\_range\_min, radial\_disps\_range\_max, angles\_range\_min, angle\_range\_max to define the range within to sample around the docked configuration and the bin sizes in which to sample these displacements and angles, which are set through the radial\_disp\_steps and angle\_steps options. 
If uniform sampling is desired, then the user must specify radial\_disps\_range\_min, radial\_disps\_range\_max, angles\_range\_min, and angle\_range\_max. 
If Gaussian sampling is desired, then the user must specify the radial\_disp\_deltas and angle\_deltas (a random number derived from a Gaussian distribution between -1 and 1 will then be multiplied by these step values and added to the initial radial\_disps or angles). 
If the auto\_range option is set to true, then the ranges set by the user for the grid or uniform sampling will be interpreted by the mover such that negative values move the structures toward the origin and positive values move the structures away from the origin (this is helpful if you have a mix of structures with negative or positive initial displacements, so that you can use a generic xml or run\_script for all of them).

    <SymDofMover name="(&string)"  symm_file="(&string)"  sym_dof_names="(&comma-delimited list of strings)" flip_input_about_axes="(&comma-delimited list of chars)" translation_axes="(&comma-delimited list of chars)" rotation_axes="(&comma-delimited list of chars)" align_input_axes_to_symdof_axes="(&comma-delimited list of chars)" auto_range="(false &bool)" sampling_mode="('single_dock' &string)" 
    radial_disps="(&string)" angles="(&string)" radial_disps_range_min="(&string)" radial_disps_range_max="(&string)" angles_range_min="(&string)" angles_range_max="(&string)" radial_disp_steps="(&string)" 
    angle_steps="(&string)" radial_disp_deltas="(&strings)" angle_deltas="(&string)" radial_offsets="(&strings)" set_sampler="(true &bool)"/>

-   symm\_file - Symmetry definition file.
-   sym\_dof\_names - Names of the sym\_dofs in the symmetry definition file along which one wishes to move or rotate the input. NOTE: For multicomponent systems, the order of the displacements, angles, ranges, and steps must correspond with the the order of the sym\_dof\_names. Passed as a string with comma-separated list (e.g. sym\_dof\_names="JTP1,JDP1")
-   flip\_input\_about\_axes - Rotate subunits 180 degrees about the specified axes prior to applying transtions, rotations, alignment, and symmetry. ie, "reverse" the component before further manipulation.
-   translation\_axes - Axes (x, y, or z) along which to translate each subunit prior to applying symmetry.
-   rotation\_axes - Axes (x, y, or x) along which to rotate each subunit prior to applying symmetry.
-   align\_input\_axes\_to\_symdof\_axes - If specified, will align the specified axis of each subunit with the corresponding axis of the symdof jump from the symmetry definition file.
-   auto\_range - Boolean to set the manner in which the user defined ranges for radial displacements are interpreted. If set to true, then the negative values for min or max displacement are interpreted as moving the structure closer to the origin and positive values away from the origin.
-   sampling\_mode - Which mode to use to sample around the initial configuration, if desired. "grid", "uniform", or "gaussian"
-   radial\_disps - Initial displacement(s) by which to translate the input structure(s) along the user specified axis. Passed as a string with a comma-separated list (e.g. radial\_disps="-65.4,109.2")
-   angles - Initial angle(s) by which to rotate the input structure(s) about the user specified axis. Passed as a comma-separated list (e.g. angles="-65.4,109.2")
-   radial\_disps\_range\_min - For use with grid or uniform sampling. Minimum distance(s) in Angstroms by which to modify the initial radial\_disps. Passed as a string with a comma-separated list (e.g. radial\_disps\_range\_min="-1,-1".
-   radial\_disps\_range\_max - For use with grid or uniform sampling. Maximum distance(s) in Angstroms by which to modify the initial radial\_disps. Passed as a string with a comma-separated list (e.g. radial\_disps\_range\_max="1,1".
-   angles\_range\_min - For use with grid or uniform sampling. Minimum angle(s) in degrees by which to rotate the structure around the initial angle(s) provided by the user. Passed as a string with a comma-separated list (e.g. angles\_range\_min="-1,-1".
-   angles\_range\_max - For use with grid or uniform sampling. Maximum angle(s) in degrees by which to rotate the structure around the initial angle(s) provided by the user. Passed as a string with a comma-separated list (e.g. angles\_range\_max="1,1".
-   radial\_disp\_steps - For use with grid sampling. Set the bin size(s) by which to sample within the user defined range(s). Passed as a string with a comma-separated list (e.g. radial\_disps\_steps="0.5,0.5".
-   angle\_steps - For use with grid sampling. Set the bin size(s) by which to sample within the user defined range(s). Passed as a string with a comma-separated list (e.g. angle\_steps="0.5,0.5".
-   radial\_disp\_deltas - For use with Gaussian sampling. The range within to sample inward and outward around the user specified initial displacement(s). Passed as a string with a comma-separated list (e.g. radial\_disp\_deltas="0.5,0.5".
-   angle\_deltas - For use with Gaussian sampling. The range within to sample around the user specified initial angle(s). Passed as a string with a comma-separated list (e.g. angle\_deltas="0.5,0.5".
-   radial\_offsets - Can be used in any sampling mode. Offset value(s) are added to the corresponding radial\_disps before grid, uniform, or gaussian sampling is performed. Works with auto\_range. For example, if one wants to space out both symdofs a given structure by 2 angstroms, one can pass radial\_offsets="2,2" and auto\_range=true. Then, regardless of the sign of the radial disps, the subunits will be displaced 2 angstroms further from the origin (assuming the input subunit(s) start at the origin).
-   set\_sampler - For use with the GetRBDOFValues filter.  If set to false, then the RBDOF values will not be updated when the reported DOF values are not affected by the SymDofMoverSampler. Defaults to true.


##See Also

* [[Symmetry]]: Using symmetry in Rosetta
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[SymmetryAndRosettaScripts]]
