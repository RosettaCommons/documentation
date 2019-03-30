Rosetta servers
===============

The [[RosettaCommons (external link)|https://www.rosettacommons.org/about]] (the group of labs that maintain Rosetta) maintains a number of [[servers for free public academic use (external link)|https://www.rosettacommons.org/software/servers]]. Servers for commercial use are also availible from an external provider.

###Public Servers

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

* The [FlexPepDock server](http://flexpepdock.furmanlab.cs.huji.ac.il/) provides access to Rosetta's refinement and ab-initio peptide docking within a receptor pocket [[flex-pep-dock]].

* The [PIPER-FlexPepDock server ](http://piperfpd.furmanlab.cs.huji.ac.il/) provides access to Rosetta's global docking of a peptide onto a receptor (where the binding pocket is unknown).

* [RosettaDiagrams](http://www.rosettadiagrams.org/) provides a graphical interactive service to produce [[RosettaScripts]] XML files, with some ability to run the scripts as well.

* [[FunHunt|http://funhunt.furmanlab.cs.huji.ac.il/]], short for funnel hunt, tries to distinguish correct protein-protein complex orientations from decoy orientations.
It searches for [[energy landscape|Glossary#general-terms_energy-landscape]] funnels using Rosetta's docking code.

* The [[TCRmodel server|https://tcrmodel.ibbr.umd.edu/]] models T cell receptor (TCR) structures from sequence.

###Commercial/Private servers

* [[Cyrus Biotechnology (external link)| https://cyrusbio.com]]'s Bench server is a web app GUI frontend to Rosetta that runs your requested computations on secure cloud servers.  This tool is meant to allow biophysicists to access the power of Rosetta without needing specific training in Rosetta, experience with the command line, or local supercomputing resources.  Bench offers tools for homology modeling (like Robetta), protein design (RosettaDesign), ddG calculation, and other modeling tools like relaxation and minimization.  <sub><sup>(Cyrus Biotechnology is a commercial Rosetta licensee offering a web-based graphical user interface for Rosetta to its customers.  Licensing fees paid by commercial Rosetta licensees to the University of Washington are used to support the RosettaCommons, investing in the maintenance and further development of Rosetta.)</sup></sub>


##See Also

* [[Graphics and GUIs]]: Graphical interfaces for Rosetta
* [[Application Documentation]]: List of Rosetta command line applications
* [[Scripting Documentation]]: List of scripting interfaces to Rosetta
* [[PyRosetta]]
* [[RosettaScripts]]
* [[PyRosetta website (external link)|http://www.pyrosetta.org]]
