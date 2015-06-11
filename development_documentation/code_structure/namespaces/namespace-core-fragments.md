#core::fragment

Overview of Directory
=====================

Fragment contains Classes and Functions related to modeling with fragments of structure.

Important Classes/Files in this Directory
=========================================

###Users will only need to be familar with these classes


-   FragSet A container class for fragments
-   FragmentIO A IO class for reading and writing FragSets
-   FragmentMover A mover which takes a FragSet and applies randomly selected fragments to the pose. This class actual exist in the protocols library. It is mentioned here as the main interface for code in this directory.


Readmes, Code Snippets, and Tutorials
=====================================

For information on generating fragment files, see the [[fragment file]] documentation. 

Examples of code using elements from core::fragments can be found insource/src/protocols/simple_moves/FragmentMover.* among others.  

Code Design, Extension, and Comments
====================================

FragSet
=======

Don't trust the following! This following is written by Kristian Kaufmann from impressions based on a cursory overview by Oliver.

FragSets contain the basic data required for Fragment based alterations of conformation in polymers. The FragSet contains Fragments for frames in the FoldTree. A Frame contains a list of FragData for a particular set of residues. Each FragData object constains a list of SingleResidueFragData objects. Each SingleResidueFragData object describes how the residue is related to the residue before and behind it in the FoldTree. There are different flavors of SingleResidueFragData (e.g. BBTorsionSRFD, TorsionSRFD, JumpSRFD) to account for the diverse number of FoldTree connections.

You can steal fragments for poses. Say you have a particular set of backbone torsions in one protein that you would like to be available for your modeling. You can extract that fragment from the pose in the following manner

```
       //construct a Frame for the pos'th position of a pose with length len using BBTorsionSRFD (this is a rosetta++ like fragment)      
       FrameOP frame = new Frame( pos, new FragData( new BBTorsionSRFD, len) );      
       //steal the conformational data from pose      
       frame->steal(pose);      
       //add the frame to a fragset      
       fragset->add(frame);      
```

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

##See Also

* [[Fragments file format|fragment-file]]
* [[src Index Page]]: Explains the organization of Rosetta code in the `src` directory
* More namespaces in core:
  * [[core::conformation namespace|namespace-core-conformation]]
  * [[core::chemical|namespace-core-chemical]]
  * [[core::conformation::idealization|namespace-core-conformation-idealization]] **NO LONGER EXISTS**
  * [[core::io::pdb|namespace-core-io-pdb]]
  * [[core::scoring|namespace-core-scoring]]
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page