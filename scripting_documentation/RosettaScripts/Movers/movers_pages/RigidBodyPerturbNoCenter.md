# RigidBodyPerturbNoCenterMover

*Back to [[Mover|Movers-RosettaScripts]] page.*

## RigidBodyPerturbNoCenterMover

Documentation by Vikram K. Mulligan (vmullig@uw.edu), written 24 June 2016.  Mover by Monica Berrondo.

## Description

This mover will add a small, random translation and rotation to jump 1 in a pose.  This is useful for moving one body relative another in a protocol (*e.g.* in the context of a Monte Carlo search, as part of a docking problem).  Note that the rotation is *not* centred on the body that's being rotated.

## Usage

```xml
<RigidBodyPerturbNoCenter name="(&string)" rot_mag="(0.1 &Real)" trans_mag="(0.4 &Real)" />
```

## Inputs

* rot_mag: The magnitude of the random rotation.  (Note: I think that this is in degrees, but please correct me if I'm wrong. -VKM.)  Default 0.1.

*trans_mag: The magnitude of the random translation, in Angstroms.  Default 0.4.
