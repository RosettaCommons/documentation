#Gettng credit for your work: The CitationManager

This page was created on 7 March 2020 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

##Why is it important for me to seek credit for my contributions to Rosetta?

We learn from an early age that humility is a virtue.  Nevertheless, in science, it is important to ensure that one gets credit for one's own work.  There are several reasons that we want to make sure that developers of Rosetta features or modules are credited, and these include:

* Credit is the currency of science.  As one progresses in one's scientific career, one's professional reputation -- primarily driven by one's publications, but also by other means by which one makes one's contributions known -- determines the resources to which one will have access.  Hiring decisions, allocations of supercomputing resources, collaborations, operating grants, _etc._ are all heavily influenced by professional reputation.  As a community, it is in our _communal_ interest for those who contribute to Rosetta to be able to obtain the resources that they need to continue their research, and it is therefore in our communal interest to ensure that they get credit for their work.
* Credit influences job satisfaction.  No matter how altruistic one is, an individual who gives to the community and receives nothing in return is unlikely to want to continue to contribute.
* Rosetta is greater than the sum of its parts, and can only continue to thrive if developers choose to continue to contribute to it.  We therefore have an interest in providing incentives.
* If developers' contributions are publicized, it becomes easier to know whom to talk to about a particular module or feature if one wishes to build upon it.  Credit ensures that knowledge is not lost, effort is not duplicated, and time is not wasted.
* Credit is generally given through coauthorship on publications.   If those who first use a new module, feature, or method include the original developer as a coauthor on their publication, it gives that developer the opportunity to document the module, feature, or method in the publication or its supplement.  That is, the act of awarding credit has the side-benefit of tying Rosetta successes to descriptions of the methods, facilitating reproducibility and extensions, and fighting the tendency to treat Rosetta as a black box.

For all of these reasons, it is _both_ in an individual's best interest _and_ in the community's best interest to ensure that everyone knows who produced which Rosetta module, and which Rosetta modules are published (in which case the original papers should be cited) or unpublished (in which case the developer should be included on the first Rosetta community paper that relies on the module).

##How we document contributions: The Rosetta CitationManager

The Rosetta CitationManager is a Rosetta singleton -- an global object of which one instance exists in memory for a given Rosetta session.  Its job is to track which Rosetta modules were used during a Rosetta session, and to issue a report at the end of the session listing the published modules that should be cited (and the relevant papers), plus the unpublished modules whose authors should be included as coauthors on the first publication using those modules (plus the authors' names and contact information).  Any Rosetta module may register itself with the CitationManager, providing information about its citation(s) (if published) or author(s) (if unpublished).  In the case of Movers, Filters, TaskOperations, ResidueSelectors, EnergyMethods (score terms), SimpleMetrics, or PackerPalettes, special function overrides exist to make it easy for the [[RosettaScripts]] application to register all of the scripted modules in a user's script.  At the end of Rosetta execution, a message similar to the following is written:

```
basic.citation_manager.CitationManager: 

The following Rosetta modules were used during this run of Rosetta, and should be cited:

rosetta_scripts Application's citation(s):

Fleishman SJ, Leaver-Fay A, Corn JE, Strauch E-M, Khare SD, Koga N, Ashworth J, Murphy P, Richter F, Lemmon G, Meiler J, and Baker D.  (2011).  RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite.  PLoS ONE 6(6):e20161.  doi: 10.1371/journal.pone.0020161.


The following UNPUBLISHED Rosetta modules were used during this run of Rosetta.  Their authors should be included in the author list when this work is published:

GlycanTreeModeler Mover's author(s):

Jared Adolf-Bryfogle, The Scripps Research Institute, La Jolla, CA <jadolfbr@gmail.com>

```
