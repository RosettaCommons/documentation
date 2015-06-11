#About this wiki

The Rosetta documentation began as Doxygen tags stripped from the code, combined with material from a MediaWiki.
It was organized roughly according to some of the MediaWiki categories that had been ported. As a result, there was too little documentation in some places (meta-Rosetta concepts, organizing documentation, cross-references) and too much in others (five pages about installing Rosetta).

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
