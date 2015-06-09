Rosetta servers
===================

LINKY: add links to protocol documentation for the more specific servers?

The [[RosettaCommons|https://www.rosettacommons.org/about]] (the group of labs that maintain Rosetta) maintains a number of servers for free public academic use. Commercial use, or paid use on cloud resources, is not supported at this time.

[[_TOC_]]

* [ROSIE](http://rosie.rosettacommons.org/) is a server that offers several (14) Rosetta applications through a simple web interface.
It is perfect for use by those new to Rosetta.
Instead of dealing with Rosetta command lines, you are presented with an web page [[GUI|https://en.wikipedia.org/wiki/Graphical_user_interface]] for each application.
Filling in the web form provides the server with the data it needs to run your Rosetta job.
Despite ROSIE's variety it offers only a slice of Rosetta's full functionality, depending on what applications users have written web front-ends for.
Because this is a free public resource, computer time is limited.
ROSIE runs can be downloaded and used to build Rosetta jobs that you run on your own local resources.
This server is maintained by Sergey Lyskov, associated with the [[Jeff Gray lab at Johns Hopkins University|http://graylab.jhu.edu/]].

* [ROBETTA](http://robetta.bakerlab.org/) (Robot-Rosetta) is a server that provides _ab initio_ folding and structure prediction, as well as fragment selection for local runs of Rosetta.
This is the oldest Rosetta server, set up to provide for Rosetta's original functions.
It also provides interface alanine scanning and DNA interface residue scanning.
This server is maintained by [[David Baker's lab at the University of Washington|http://www.bakerlab.org/]].

* The [Rosetta Design Server](http://rosettadesign.med.unc.edu/) provides access to Rosetta's [[fixbb]] fixed-backbone design protocol.

* The [Backrub Server](https://kortemmelab.ucsf.edu/backrub/cgi-bin/rosettaweb.py?query=index) provides [[backrub]] ensembles, as well as alanine scanning.

* The [FlexPepDock server](http://flexpepdock.furmanlab.cs.huji.ac.il/) provides [[FlexPepDock]]. 

* [RosettaDiagrams](http://www.rosettadiagrams.org/) provides a graphical interactive service to produce [[RosettaScripts]] XML files, with some ability to run the scripts as well.
