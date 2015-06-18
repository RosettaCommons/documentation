Rosetta servers
===================

The [[RosettaCommons (external link)|https://www.rosettacommons.org/about]] (the group of labs that maintain Rosetta) maintains a number of [[servers for free public academic use (external link)|https://www.rosettacommons.org/software/servers]]. Commercial use, or paid use on cloud resources, is not supported at this time.

* [ROSIE (external link)](http://rosie.rosettacommons.org/) is a server that offers several (14) Rosetta applications through a simple web interface.
It is perfect for use by those new to Rosetta.
Instead of dealing with Rosetta command lines, you are presented with an web page [[GUI|https://en.wikipedia.org/wiki/Graphical_user_interface]] for each application.
Filling in the web form provides the server with the data it needs to run your Rosetta job.
Despite ROSIE's variety it offers only a slice of Rosetta's full functionality, depending on what applications users have written web front-ends for.
Because this is a free public resource, computer time is limited.
ROSIE runs can be downloaded and used to build Rosetta jobs that you run on your own local resources.

* [ROBETTA (external link)](http://robetta.bakerlab.org/) (Robot-Rosetta) is a server that provides *[[ab initio|abinitio-relax]]* folding and structure prediction, as well as [[fragment|fragment-file]] selection for local runs of Rosetta.
This is the oldest Rosetta server, set up to provide for Rosetta's original functions.
It also provides [[interface alanine scanning|interface analyzer]] and [[DNA interface residue scanning|Rosetta DNA]].

* The [Rosetta Design Server](http://rosettadesign.med.unc.edu/) provides access to Rosetta's [[fixbb]] fixed-backbone design protocol.

* The [Backrub Server](https://kortemmelab.ucsf.edu/backrub/cgi-bin/rosettaweb.py?query=index) provides [[backrub]] ensembles, as well as [[alanine scanning|pmut-scan-parallel]].

* The [FlexPepDock server](http://flexpepdock.furmanlab.cs.huji.ac.il/) provides [[flex-pep-dock]]. 

* [RosettaDiagrams](http://www.rosettadiagrams.org/) provides a graphical interactive service to produce [[RosettaScripts]] XML files, with some ability to run the scripts as well.

* [[FunHunt|http://funhunt.furmanlab.cs.huji.ac.il/]], short for funnel hunt, tries to distinguish correct protein-protein complex orientations from decoy orientations.
It searches for [[energy landscape|Glossary#general-terms_energy-landscape]] funnels using Rosetta's docking code.

##See Also

* [[Graphics and GUIs]]: Graphical interfaces for Rosetta
* [[Application Documentation]]: List of Rosetta command line applications
* [[Scripting Documentation]]: List of scripting interfaces to Rosetta
* [[PyRosetta]]
* [[RosettaScripts]]
* [[PyRosetta website (external link)|http://www.pyrosetta.org]]
