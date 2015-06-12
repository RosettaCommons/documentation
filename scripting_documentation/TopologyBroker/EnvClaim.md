**EnvClaim**s are a human-readable(-ish) way of specifying a need to access or for the existence of particular resources from the brokered pose. `EnvClaim` itself is implemented as an abstract class, which is the parent to a number of other classes that are actually used by [[ClientMovers]].  For example, a TorsionClaim might be assigned to claim all the backbone torsions of a polypeptide chain.

[[_TOC_]]

#JumpClaim

As shown in the example, the JumpClaim simultaneously creates and claims access to a Jump between to arbitrary regions in the consensus Conformation. The position1 option takes either a label (usually a virtual residue) or a ResidueSelector and places one end of the jump-to-be there. If the selection or label refers to more than one residue, the first one is chosen. The position2 option is the same. If the given label does not exist, a virtual residue will be created with that name.

The control_strength option sets the [ControlStrength](#ControlStrength) for the created jump RT. The "cut" option is the same as the position1 and position2 options, except that it sets the position of the cut built be the jump. It need not be between position1 and position2 but, if not specified, is chosen from the range between position1 and position2. The "atom1" and "atom2" options (must be supplied together) choose the atoms to and from (respectively) the jump is to be created. The default is "CA" if "physical_cut" is set to true or is placed such that the stub is within the residue--either "C" or "N" depending on folding direction--if "physical_cut" is false. In addition, the option "physical_cut" determines whether or not the upper and lower cut residues are scored as an artificial chainbreaks (false) or not (true). The jump must also be assigned a name via the "jump_label" option. At the moment, however, this name is only used as an internal unique identifier.

#TorsionClaim

The TorsionClaim claims access to a stretch of torsional angles. For example,

```
<TorsionClaim backbone=1 sidechain=0 selector="ChainA" control_strength="CAN_CONTROL" />
```
 
claims all backbone residues in the region selected by the ResidueSelector with the name "ChainA" with the strength "CAN_CONTROL". The "backbone" and "sidechain" boolean options determine, respectively, if backbone and sidechain angles are to be claimed. The "control_strength" option sets the [ControlStrength](#ControlStrength) with which these residues are to be claimed. 

#XYZClaim

The XYZClaim claims access to all degrees of freedom buidling a particular set of residues. This includes all bond lengths, angles, torisons as well as any applicable jump rotation and translation DoFs. For example,

```
<XYZClaim selection="known_loop1" control_strength="EXCLUSIVE" relative="false" />
```

Asserts EXCLUSIVE control (see ControlStrengths) over all degrees of freedom building the residues in the ResidueSelection "known_loop1".

An important option for this claim is "relative." This option determines if the XYZClaim is intended to claim the XYZ position of the selection *relative* to itself or absolutely in space. This most often determines if the jump building the XYZClaim selection is claimed or not (although it could just as easily be a peptide bond as well).

#VirtResClaim

The VirtResClaim creates a virtual residue and a jump from some base position to build that virtual residue. A cut is also created to ensure the new virtual residue is not attached to any chain.

The "vrt_name" option sets the name of the virtual residue. If this virtual residue is to be used by other ClientMover or claims, this is the name by which is should be referred. Note, however, that two VirtResClaims with the same name are not allowed--JumpClaims should be used to jump to and from the virtual residue when it does not need to be created. This is an intentional choice to allow the system to catch errors of accidental virtual residue duplication. An example demonstrating the importance of this feature is CoMTrackerCMs _really do_ need their own virtual residues--other Claims using that virtual residue are, in some sense, just guests.

Other options include "parent", a ResidueSelector or label indicating where the other end of the jump building the virtual residue should be and "jump_control_strength" setting the control strength of the built jump.

#CutBiasClaim

The CutBiasClaim adjusts the chance that an automatic cut is placed at the selected residues by the value of the option "bias" (required). Also required are "range_start" and "range_end", which indicate the beginning and end of the region within the selection given by the option "label" are to be modified with that bias. For example,

````
<CutBiasClaim bias=0.0 region_start=1 region_end=3 label="ChainA" />
```

would modify the cut bias of the first three residues in the selection ChainA to be zero (i.e. automatic cuts are forbidden). 

# ControlStrength

The available ControlStrengths are: `DOES_NOT_CONTROL`, `CAN_CONTROL`, `MUST_CONTROL`, and `EXCLUSIVE`. Their names are more or less self-explanatory. `DOES_NOT_CONTROL` does not (and hence cannot) control the DoF of interest. `EXCLUSIVE` is always granted access unless another `EXCLUSIVE` claim for the same DoF exists, in which case an exception is thrown. `CAN_CONTROL` is granted access if and only if there are no `EXCLUSIVE` claims. If such access cannot be granted however, nothing happens. `MUST_CONTROL` is as `CAN_CONTROL`, but an exception is thrown if an `EXCLUSIVE` claim prevents this Claim from being granted access to the claim. In almost all cases, `CAN_CONTROL` is the most appropriate choice.


##See Also

* [[TopologyBroker home page|BrokeredEnvironment]]
* [[ClientMovers]]: Movers supported by the TopologyBroker
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaScripts]]: RosettaScripts home page
* [[Writing an app]]: Tutorial for writing a C++ app
* [[Development Documentation]]: Home page for developer documentation
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
