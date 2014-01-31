<!-- --- title: Directory Core Fragments -->Fragments Directory

Table of Contents
=================

-   Overview of Directory
-   Important Classes/Files in this Directory
-   Lateral Dependencies
-   Readmes, Code Snippets, and Tutorials
-   Code Design, Extension, and Comments
-   Index of Directory

Overview of Directory
=====================

Fragments contains Classes and Functions related to modeling with fragments of structure.

Important Classes/Files in this Directory
=========================================

users will only need to be familar with these classes
-----------------------------------------------------

-   FragSet A container class for fragments
-   FragmentIO A IO class for reading and writing FragSets
-   FragmentMover A mover which takes a FragSet and applies randomly selected fragments to the pose. This class actual exist in the protocols library. It is mentioned here as the main interface for code in this directory.

Lateral Dependencies
====================

Email Oliver asking him to fill in this section.

Readmes, Code Snippets, and Tutorials
=====================================

This section should contain links for Readmes, Code Snippets, and Tutorials enabling developers to use the code/files located in this directory.

Code Design, Extension, and Comments
====================================

FragSet
=======

Don't trust the following! This following is written by Kristian Kaufmann from impressions based on a cursory overview by Oliver.

FragSets contain the basic data required for Fragment based alterations of conformation in polymers. The FragSet contains Fragments for frames in the FoldTree. A Frame contains a list of FragData for a particular set of residues. Each FragData object constains a list of SingleResidueFragData objects. Each SingleResidueFragData object describes how the residue is related to the residue before and behind it in the FoldTree. There are different flavors of SingleResidueFragData (e.g. BBTorsionSRFD, TorsionSRFD, JumpSRFD) to account for the diverse number of FoldTree connections.

You can steal fragments for poses. Say you have a particular set of backbone torsions in one protein that you would like to be available for your modeling. You can extract that fragment from the pose in the following manner

`       //construct a Frame for the pos'th position of a pose with length len using BBTorsionSRFD (this is a rosetta++ like fragment)      `

`       FrameOP frame = new Frame( pos, new FragData( new BBTorsionSRFD, len) );      `

`       //steal the conformational data from pose      `

`       frame->steal(pose);      `

`       //add the frame to a fragset      `

`       fragset->add(frame);      `

the fragset now contains the fragment and can be used by a FragmentMover.

Planned Extensions, Known Limitations, Wish List of things needed
=================================================================

None at this point

Index of Directory
==================

Files
-----

BBTorsionAndAnglesSRFD

BBTorsionSRFD

BaseCacheUnit

ConstantLengthFragSet

ConstantLengthFragSetIterator\_

FragCache

FragData

FragID

FragID\_Iterator

FragSet

FragSetCollection

FragmentIO

Frame

FrameIterator

FrameIteratorWorker\_

FrameList

FrameListIterator\_

JumpSRFD

JumpingFrame

OrderedFragSet

OrderedFragSetIterator\_

README

SRFD\_Implementations

SecstructSRFD

SingleResidueFragData

TorsionSRFD

core/fragment/util

Directory
---------

core/fragment/io/
