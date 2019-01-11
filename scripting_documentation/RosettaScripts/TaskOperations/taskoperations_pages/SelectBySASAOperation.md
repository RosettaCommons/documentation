# SelectBySASA
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SelectBySASA

Select residues by their solvent accessible surface area in either the monomeric, bound, or unbound state of the pose. Accessible surface area cutoffs can be set for positions to be considered core, boundary or surface as follows: residues with accessible surface areas less than core\_asa are considered core, those with areas greater than surface\_asa are considered surface, and those between the core\_asa and surface\_asa cutoffs are considered boundary. These SASAs can be assessed in either the monomeric, bound, our unbound state, and either on all mainchain and CBeta atoms or on all sidechain heavyatoms. All residues that do not match the user-specified criteria are prevented from repacking. Works with asymmetric or asymmetric poses, as well as poses with symmetric-building blocks. Can be used to implement custom "layer design" protocols. For de novo designs, it is likely best to use mode="mc" rather than mode="sc". To set the parameters to be the same as the defaults for the LayerDesign task operation use: mode="mc", state="bound", probe\_radius=2.0, core\_asa=20, surface\_asa=40.

     <SelectBySASA name="(&string)" mode="('sc' &string)" state="('monomer' &string)" probe_radius="(2.2 &Real)" core_asa="(0 &Real)" surface_asa="(30 &Real)" jumps="(1 &Size ',' separated)" sym_dof_names="('' &string ',' separated)" core="(0 &bool)" boundary="(0 &bool)" surface="(0 &bool)" verbose="(0 &bool)" />

Examples:

Only allow repacking at the core positions in the bound state. Useful in combination with other tasks such as RestrictToInterface in order to select just the core of the interface for design.

     <SelectBySASA name="core" mode="sc" state="bound" probe_radius="2.2" core_asa="0" surface_asa="30" core="1" boundary="0" surface="0" verbose="1" />

Only allow repacking at the boundary and surface positions in the bound state.

     <SelectBySASA name="core" mode="sc" state="bound" probe_radius="2.2" core_asa="0" surface_asa="30" core="0" boundary="1" surface="1" verbose="1" />

Prevent the core of the monomers (each chain) from repacking. Useful in combination with other tasks to ensure that one does not design core positions.

     <SelectBySASA name="no_core_mono_repack" mode="sc" state="monomer" probe_radius="2.2" core_asa="0" surface_asa="30" core="0" boundary="1" surface="1" verbose="1" />

Option list

-   mode ( default "sc" ) : Options: "mc" or "sc". Atoms to be evaluated during the SASA calculation. The default is to consider the total SASA of the sidechain atoms of each residue (mode="sc"), but one can alternatively consider the total SASA of the mainchain + CB atoms of each residue (mode="mc").
-   state ( default, "monomer" ) : Options: "monomer", "bound", or "unbound". Specify the state you would like the SASA to be evaluate in. If state="monomer", then each chain will be extracted from the pose and the SASA evaluated separately on each of these monomeric poses. If state="bound", then the pose is not modified before evaluating SASAs. If state="unbound", then the chains are translated 1000 angstroms along the user specified jumps or sym\_dofs prior to evaluating SASAs.
-   probe\_radius ( default, 2.2 ) : Probe radius for calculating the solvent accessible surface area. Note: the default is larger than the typical used to represent water of 1.4 angstroms, but has been found to work well with the other default parameters for protein redesign purposes.
-   core\_asa ( default, 0 ) : Upper accessible surface area cutoff for a residue to be considered core. Any residue with a value below core\_asa will be selected as core.
-   surface\_asa ( default, 30 ) : Lower accessible surface area cutoff for a residue to be considered surface. Any residue with a value above surface\_asa will be selected as surface. Any residue with a value between core\_asa and surface\_asa will be considered boundary.
-   jumps ( default, 1 ) : Comma-separated list of jumps to be translated along if mode="unbound".
-   sym\_dof\_names ( default, "" ) : Comma-separated list of sym\_dof\_names controlling master symmetric DOFs to be translated along if mode="unbound".
-   core ( default, false ) : Should core positions be designable? If yes, then set core=true.
-   boundary ( default, false ) : Should boundary positions be designable? If yes, then set boundary=true.
-   surface ( default, false ) : Should surface positions be designable? If yes, then set surface=true.
-   verbose ( default, false ) : If set to true, then extra information will be output to the tracer, including PyMOL selections of the residues considered to be core, boundary, and surface. Aids in testing out appropriate parameters for a given system and verifying that the positions are being selected as desired.

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
