#How to use the PyMOL-Rosetta server

Metadata
========

Author: Steven Lewis (smlewi@gmail.com)

This document was originally written 4 Jan 2012 by Steven Lewis. This document was last updated 4 Jan 2012 by Steven Lewis.

NOTE: I didn't write any part of this server. Harass the Gray lab to flesh out this document.

Application purpose
===========================================

Jeff Gray's lab wrote an awesome tool to let you watch live Rosetta trajectories in PyMOL. It's like the graphics viewer but even awesomer.

How to use it
=============

1. Open pymol 
2. run /path/to/rosetta/src/python/bindings/PyMOLPyRosettaServer.py 
3. Start a Rosetta run with the flag -show\_simulation\_in\_pymol X, where X is how many seconds pass between PyMOL updates. 5 is default; low values may overload your computer.

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
