# DockingInitialPerturbation
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Docking Initial Perturbation

This mover carries out the initial perturbation phase of the RosettaDock algorithm.
This contains the functions that create initial positions for docking.
You can either randomize partner 1 or partner 2, spin partner 2, or
perform a simple perturbation.

Most of these options are also described [[here|https://www.rosettacommons.org/manuals/rosetta3.1_user_guide/opt_docking.html]].

```xml
<DockingInitialPerturbation randomize1="(bool)" randomize2="(bool)" use_ellipsoidal_randomization="(bool)" dock_pert="(bool,"false")" trans="(real)" rot="(real)" uniform_trans="(real)" spin="(bool)" center_at_interface="(bool)" slide="(bool)" name="(string)"/>
```

|   Option                      | Description |
| ----------------------------- | ----------- |
| randomize1                    | Randomize the first docking partner  |
| randomize2                    | Randomize the second docking partner |
| use_ellipsoidal_randomization | Use the EllipsoidalRandomizationMover instead of the RigidBodyRandomizeMover |
| dock_pert                     | Read in translational and rotational perturbations and apply to pose (default is false) |
| trans                         | Translational perturbation to apply before docking (requires dock_pert="true") |
| rot                           | Rotational perturbation to apply before docking (requires dock_pert="true") |
| uniform_trans                 | Use the UniformSphereTransMover |
| spin                          | Spin partner about its axis |
| center_at_interface           | Center the spin at the interface |
| slide                         | Slide docking partners into contact |

##See Also

* [Protein-protein docking tutorial](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking)
* [[DockingMover]]
* [[DockWithHotspotMover]]
* [[FlexPepDockMover]]
* [[HighResDockerMover]]
* [[Docking applications]]: Command line applications for docking
* [[I want to do x]]: Choosing a mover