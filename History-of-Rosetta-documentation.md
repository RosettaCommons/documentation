#History of Rosetta documentation

Historically, Rosetta has had four major types/sources/locations of documentation:
* in-code documentation that documents classes and functions very granularly, the Doxygen documentation
* with-the-code application documentation, originally written in Doxygen as well, but ported to this wiki instead (the "Gollum wiki", or the "documentation wiki")
* a private MediaWiki (think Wikipedia) wiki, called RosettaWiki
* Collections of demos, usually in a folder or repository associated with the source code
* Supplemental materials of various papers (important ones are probably in the [[Rosetta Canon]])

This wiki (which is also publicly served as static webpages for our users) was first sourced as a scraping of the Doxygen application documents, leavened with pages ported from the MediaWiki.

Rosetta documentation has usually been focused on the needs of the moment, but not the bigger picture.  As a result, there was often too little documentation in some places (meta-Rosetta concepts, organization, cross-references) and too much in others (five different pages about installing Rosetta, all with more or less the correct information).

Early documentation
===================
The only surviving early documentation is that embedded in the literature, particularly in papers of the [[Rosetta Canon]] or others in our 

Doxygen days
============
By the [[early days|Rosetta timeline]] of "mini" (Rosetta3) development, Doxygen ([web link](http://www.doxygen.org) ([Wikipedia entry](http://en.wikipedia.org/wiki/Doxygen)) documentation was used to [[granular code documentation|development_documentation/tutorials/doxygen-tips]].
This documentation has never been very complete but is still otherwise intact and used, and the generated documentation is available (privately) here: TODO LINKY.

When developers began to get serious about writing application documentation, they stuck with the Doxygen system in place and used it to build formatted webpages of just application documentation.

Unfortunately that system did not last wrong: the Rosetta codebase is very large, and Doxygen processing of both the source tree AND the application documentation took prohibitively long, due to Doxygen's tools for automatically linking keywords.
Both documentation sources remained 


XRW 2015
==========
The Rosetta community sought to improve its documentation and organized a week-long meeting during which seven developers would contribute to that cause.

We primarily worked on the following projects:
* Reorganization
	* Useful code navigation
		* navigational sidebars (you'll see it on the left!) for each directory
		* "see also" sections at the end of virtually every page
		* cross-linking most valid uses of Rosetta-relevant phrases to wiki articles and glossary entries
	* Reorganization of files and directories
		* Removal of specific files from top-level directories
	* Indices
		* Glossary of terms
		* Glory of people
		* Gl... something of servers
		* more subfolders for e.g. applications, RosettaScripts, etc.
			* Index pages for every directory
			* individual pages for every RosettaScripts tag

* Meta-Rosetta
	* Analyzing results
	* Choosing sampling scale
	* Problems that arise from macromolecular modeling
	* External educational resources
	* Rosetta history
	* Logic of solving a biological problem
	* Incorporating experimental data as constraints
	* Rosetta literary canon

* Additional information
	* Remaining MediaWiki and externally available but generally useful resources ported
	* All demo and protocol capture readmes are incorporated into the Gollum wiki and formatted 
	* Peptidomimetics documentation



## About this document specifically

This directory contains a static capture of the Rosetta documentation wiki.  It is not supported as a user-editable wiki, but a fixed capture of its contents are released each week with new code releases.  Your weekly release should have a documentation/_site directory, which contains Home.html.  Load Home.html in your browser of choice and the documentation will work as a non-editable wiki in the browser.
