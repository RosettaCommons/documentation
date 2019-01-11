History of Rosetta
==================

Rosetta started life as a small project in the lab of David Baker at the University of Washington.
It was written in FORTRAN and focused on *ab initio* structure prediction of small proteins.

Over the years the capabilities of Rosetta were extended to do things such as design and small molecule docking.
To allow for better extension of capabilities, Rosetta was translated to C++. This was released as Rosetta2 or Rosetta++.

Despite this success, the structure of the code from the early FORTRAN days was limiting further development.
A project to rewrite Rosetta using good object-oriented practice was launched. This cleaned up code was released as Rosetta3 
(aka "minirosetta" or "mini"). Rosetta3 allowed extension of Rosetta into [[PyRosetta]], [[FoldIt]], [[RosettaScripts]], [[ROSIE|Rosetta-Servers]] and more.  

Timeline
--------

Note: Over the years Rosetta versioning nomenclature has changed. Rosetta has transitioned from no versioning, to CVS, to SVN, to git/GitHub. One of the more stable versioning methods is derived from the SVN years, which has been extended into the git years. These numbers are listed below starting with 'r', and denote either SVN revisions, or git merges to the master branch numbered continuously with SVN.

* ????TODO
 * The RosettaCommons was founded.
This is the organization that manages the Rosetta intellectual property.
It was necessitated by that fact that David Baker's postdocs, the early Rosetta authors, had started their own labs elsewhere and continued to develop Rosetta.


* 2003-08
    * The first [[RosettaCON|Glossary#rosettacon]] meeting. RosettaCON is an annual meeting of Rosetta users and developers from around the world.
As Rosetta grew, the Rosetta development world was no longer confined to just David Baker's lab.

* ?????TODO
    * [[Robetta|Rosetta-Servers]] goes online, serving fragment file generation and protein structure prediction.

* 2003-11
    * Publication of Top7, the first design of a novel topology. [Kuhlman, et al.](http://www.sciencemag.org/content/302/5649/1364) 

* 2004-02 
    * Publication of an alanine scanning protocol in Rosetta [Kortemme et al.](http://stke.sciencemag.org/cgi/content/full/sigtrans;2004/219/pl2)
    * The [Robetta alanine scanning server](http://robetta.bakerlab.org/alascansubmit.jsp) goes online.

* 2005-06
    * [Rosetta@Home](http://en.wikipedia.org/wiki/Rosetta@home) was launched.

* 2005 Summer
    * Rosetta 2.0 released. Rosetta++ was a automatic translation of the FORTRAN code of Rosetta into C++.

* 2006-09
    * Rosetta 2.1 released (r8080)

* Late 2006 to Early 2007
    * The automatic translation of Rosetta++ was found to be unworkable for continued development. An effort to re-write Rosetta using object-oriented design was launched. Codenamed "mini", this was to become Rosetta3. 

* 2007-02
    * Rosetta 2.1.1 released (r13074)

* Summer 2007
    * Development of Rosetta3 is seriously underway.

* 2007-11
    * Rosetta 2.1.2 released (r15394)

* 2007-09
    * Rosetta 2.2 released (r16310)

* 2008-01
    * Most new development switches over to the Rosetta3 platform 

* 2008-04
    * Rosetta 2.3 released (r20729)

* Spring 2008
    * Publication of two papers demonstrating *de novo* enzyme design. [Jiang, et al.](http://www.sciencemag.org/content/319/5868/1387) and [Röthlisberger, et al.](http://www.nature.com/nature/journal/v453/n7192/full/nature06879.html)

* 2008-05
    * The public beta of [Foldit](http://fold.it) is launched.

* 2009-02
    * Rosetta 3.0 released (r26316)
        * Rosetta3 is sometimes referred to as "mini", the "codename" during development.

* 2009-09
    * Rosetta 3.1 released (r32532)

* 2009-11
    * The initial version of [[PyRosetta]] is released.

* 2010-03
    * Rosetta 2.3.1 released

* 2010-07
    * Design of an enzyme for the Diels-Alder reaction, a reaction unprecedented in nature. [Siegel et al.](http://www.sciencemag.org/content/329/5989/309)

* 2010-11
    * Rosetta 3.2 released (r39284)

* 2011-02
    * Rosetta 3.2.1 released (r40885)

* 2011-06
    * Rosetta 3.3 released (r42941)

* 2012-03
    * Rosetta 3.4 released (r48002)
    * [ROSIE](http://rosie.graylab.jhu.edu/about) goes online.

* 2012-06
    * Design of self-assembling nanomaterials. [King, et al.](http://www.sciencemag.org/content/336/6085/1171)

* 2013-02
    * Rosetta 3.5 released (r53488)

* 2013-05
    * Rosetta moves from svn to git for version control.

* 2013-08
    * Rosetta switched the default scorefunction from [[score12|score-types#score12]] to [[talaris2013|score-types#talaris2013]]. (r55611)

* 2013-09
    * *de novo* design of ligand binding proteins. [Tinberg, et al.](http://www.nature.com/nature/journal/v501/n7466/full/nature12443.html) 

* 2014-04
    * Rosetta moves to a weekly release schedule. The first weekly release version is *Rosetta 2014.15.56658*

* 2016-06
    * Rosetta 3.6 released (it is the same as 2016 week 13, dating from April 1 2016).

* 2016-09
    * Rosetta 3.7 released (it is the same as 2016 week 32, dating from August 9 2016).

* 2017-07
    * Rosetta's default scorefunction switches from Talaris14 to REF2015.  REF2015 is the same as beta_nov15.

##See Also

* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of Rosetta terms
* [[Glossary]]: Brief definitions of Rosetta terms
* [[Units in Rosetta]]: Explains measurement units used in Rosetta
* [[Rosetta Canon]]: Landmark Rosetta papers
* [[Scorefunction history]]: history of the Rosetta scorefunction

<!-- Hidden keywords for Gollum's search tool (which is grep), repeats to bump in listing)
History
History
History
History
History
History
History
History
History
History
History
History
History
History
History
History
--->