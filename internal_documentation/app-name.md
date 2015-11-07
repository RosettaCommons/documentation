#AppName application


AppName should match the C++ application if applicable. If the document is an extension of a particular app, the c++ application should be within AppName (fixbb vs fixbb\_with\_hpatch)

Metadata
========

Author: DOCUMENTATION AUTHOR GOES HERE

State when the documentation was last updated, by whom. State the PI for this application and their email address. They are the corresponding author.

Code and Demo
=============

Put where the code's application is, where its major protocol Mover is (if applicable), and where the integration tests and/or demos are. Your demo should be set up as a fast-running "try me" version, and this documentation should contain instructions for more serious 'production' runs.

References
==========

Note references associated with this publication. Also note if they contain implementation details that function as documentation.

Purpose
=======

What is this code supposed to do? What sorts of problems does it solve?

Algorithm
=========

Broadly, how does this code work? Does it have a centroid phase? A fullatom phase? Does it run repacking every so often?

Limitations
===========

What does this code NOT do? You'll find a lot of academic users try to get code to do things it was never intended to do, warn them off here.

Modes
=====

If your protocol is a massive multimodal beast (loop modeling, etc), then describe the different modes here. All sections below this should be split for each mode as necessary. You may have only one major mode (fixbb).

Input Files
===========

If there are any special input file types, describe them here.

-   Common file types (loop file, fragment files, etc) will be described in a common place; link to those documents with the ATref command.
-   Uncommon and app-specific file types should be described here.
-   Link to (or at least give paths to) examples of each from your integration test/demo.
-   Mention what you expect the input structure to be: if it's loop modeling, does the loop need to be present, or will it build from scratch? If it's ligand binding, does there need to be a copy of the ligand in the input structure?

Options
=======

Describe the options your protocol uses.

-   First, describe protocol-specific options, in deep detail. Give the value ranges used in 'production' runs for publication, and recommended minima/maxima where possible.
-   Next, describe the application's general-Rosetta options of particular interest. Less detail is necessary for options like nstruct, but be sure to mention all the important ones.

Tips
====

Describe how to get the best use out of the protocol. Does it not require constraints, but work better with them? Do you need to remember -ex1 -ex2 to get much out of it?

Expected Outputs
================

What does your protocol produce? Usually it will be just a PDB and a scorefile, but note if there should be more. Note what the normal exit status of the protocol is (for example, "You'll see the jd2 x jobs completed in y seconds message if successfully completed".)

Post Processing
===============

What post processing steps are typical? Are score vs RMSD plots useful? Are structures clustered (if so, give a command line)? Is it obvious when either the application has succeeded or if it has failed (e.g. if the protocol makes predictions like "This is the docked conformation of proteins A and B"). In the case of designs, how should designs be selected?

New things since last release
=============================

If you've made improvements, note them here.
