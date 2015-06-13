#What is a Mover?

A Mover is an object that interacts with a Pose.
Frequnently, a Mover changes the Pose.
It does not need to; the reference to a Pose that a Mover takes can be entirely ignored or merely analyzed.
The reason that a Mover is frequently used for operations that do not even change the Pose is because Rosetta is built so strongly around Movers!
There are many operations that take Movers, and specifically the JobDistributor applies to Movers.

## Mover organization
The sampling in question is generally organized in the apply() function, where other movers, protocols, and pose-altering functionality may be called.
In order to be functional in RosettaScripts, a Mover must implement a parse_my_tag function that interprets the XML tag, a fresh_instance function, and a clone function.

## Novers within Rosetta
The Mover is arguably the second most important class in Rosetta, next to the Pose.
The Pose contains a structure that the Mover has the unique responsibility of managing.
Most Movers fit into one of four categories:
-	Protocols. Very complex, these Movers follow a sequence of heavily input dependent logic and do quite a lot of work.
Frequently, an entire application consists of performing a protocol a specified number of times.
An example would be DockingProtocol.
-	Whole Pose Movers. Generally apply one extensive operation to the whole Pose, but is nonetheless atomic with respect to the operation performed.
A good example would be MinMover.
-	Residue Movers. Manipulate single residues (for example, the backbone dihedrals in SmallMover) or a vector of residues; a subset of a Pose. 
-	Analysis Movers. Do not change the Pose; only report geometric and energetic properties about it. They are Movers nonetheless because it is useful to take advantage of the frameworks in which Movers play a natural part.
Every Protocol is a Mover and is made of Movers: it's Movers all the way down.



<!--
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
Mover
-->
