#History of Rosetta documentation

Historically, Rosetta has had five major types/sources/locations of documentation:
* In-code documentation that documents classes and functions very granularly, the Doxygen documentation
* With-the-code application documentation, originally written in Doxygen as well, but ported to this wiki instead (the "Gollum wiki", or the "documentation wiki")
* A private MediaWiki (think Wikipedia) wiki, called RosettaWiki
* Collections of demos, usually in a folder or repository associated with the source code
* Supplemental materials of various papers (important ones are probably in the [[Rosetta Canon]])

This wiki (which is also publicly served as static webpages for our users) was first sourced as a scraping of the Doxygen application documents, leavened with pages ported from the MediaWiki.

Rosetta documentation has usually been focused on the needs of the moment, but not the bigger picture.  As a result, there was often too little documentation in some places (meta-Rosetta concepts, organization, cross-references) and too much in others (five different pages about installing Rosetta, all with more or less the correct information).

Early documentation
===================
The only surviving early documentation is that embedded in the literature, particularly in papers of the [[Rosetta Canon]] or others in our [publication list](http://www.rosettacommons.org/about/pubs).

RosettaWiki
===========
The (private) RosettaWiki was created around 2003. Originally, it held all sorts of documentation, as well as RosettaCommons organizational stuff (like RosettaCON agendas). Unfortunately, as a private web wiki, it is neither integrated with the codebase, nor available publicly. We have been transitioning documentation off this wiki (although it will remain in use for private RosettaCommons purposes like planning RosettaCONs).

Doxygen days
============
By the [[early days|Rosetta timeline]] of "mini" (Rosetta3) development, Doxygen ([web link](http://www.doxygen.org) ([Wikipedia entry](http://en.wikipedia.org/wiki/Doxygen)) documentation was used to [[granular code documentation|development_documentation/tutorials/doxygen-tips]].
This documentation has never been very complete but is still otherwise intact and used, and the generated documentation is available [here](http://www.rosettacommons.org/manuals/latest/main/).

When developers began to get serious about writing application documentation, they stuck with the Doxygen system in place and used it to build formatted webpages of just application documentation.

Unfortunately that system did not last wrong: the Rosetta codebase is very large, and Doxygen processing of both the source tree AND the application documentation took prohibitively long, due to Doxygen's tools for automatically linking keywords.
Both documentation sources remained but became split in their purpose.
Doxygen is a terrible markup format for mostly prose application documentation, and so the developers wanted a more useful documentation format, which led to the Gollum wiki.

Gollum Wiki
===========
[[After|Rosetta-timeline]] the Rosetta community transitioned the codebase from SVN to GitHub, Tim Jacobs prototyped the use of a git-based wiki format (Gollum) with the Rosetta documentation. This wiki could be generated off git-maintained files in a Rosetta git repository that lived alongside the code, but also be processed for public release as a live HTML documentation site, meeting most needs. This wiki was populated by copying all of the Doxygen application documentation over, along with (over time) most of the RosettaWiki documentation.

XRW 2015
==========
Despite all the effort we put in to writing documentation, it has never been considered good. Part of the problem is that organization has always been a challenge. 
Rosetta is designed to solve [the hardest problem we know about](http://xkcd.com/1430), and is thus naturally a very complex program. 
Most Rosetta users come in understanding the science but with little knowledge of using command line interfaces to interact with supercomputers, and are understandably frustrated at the unfamiliar equipment and disinclined to forgive the software that they're having trouble with. 
Most Rosetta code (and documentation) is written by amateur programmers who are professional scientists, which leads to awkward code and only afterthought documentation.

In June 2015, the Rosetta community sought to improve its documentation and organized a week-long meeting during which seven developers would meet for 15-hour days to write everything they knew and organize everything they could find about Rosetta. 
This project was called e**X**treme **R**osetta **W**eek 2015: XRW2015.

We primarily worked on the following projects:
* Reorganization  **Note**: Sharon Guffy (guffysl) was primarily responsible for page moving, organization, and linking and is therefore now noted as the author/last person to update many of the pages on this wiki.
	* Useful code navigation
		* navigational sidebars (you'll see it on the left!) for each directory
		* "see also" sections at the end of virtually every page
		* cross-linking most valid uses of Rosetta-relevant phrases to wiki articles and glossary entries
	* Reorganization of files and directories 
		* Removal of specific files from top-level directories
	* Indices
		* Glossary of terms
		* List of public servers
		* more subfolders for e.g. applications, RosettaScripts, etc.
			* Index pages for every directory
			* individual pages for every RosettaScripts tag

* Meta-Rosetta
	* [[Analyzing results]]
	* [[Choosing sampling scale|Rosetta-on-different-scales]]
	* [[Problems that arise in macromolecular modeling|Challenges-in-Macromolecular-Modeling]]
	* [[External educational resources|Resources-for-learning-biophysics-and-computational-modeling]]
	* [[Rosetta history|Rosetta timeline]]
	* Logic of [[solving a biological problem|Solving-a-Biological-Problem]]
	* [[Incorporating experimental data as constraints|Incorporating-Experimental-Data]]
	* [[Rosetta literary canon|Rosetta Canon]]

* Demos
	* Most of the Rosetta demos' READMEs were converted into a separate wiki. It needs to remain separate for technical reasons, and can't display the demo inputs, etc, but allows for easy reading of the demo READMEs.

* Additional information
	* Remaining MediaWiki and externally available but generally useful resources ported (like long emails to the developers' mailing list)
	* Peptidomimetics documentation

Searchability
=============
A large part of the Rosetta documentation's problem is searchability and discoverability of what's already been written. 
We have attempted to address both problems with the XRW2015 rewrite, but are somewhat hobbled by the available search tools. 
Gollum's embedded search tool is not very good, and using Google's page search is effective but injects ads.

<!-- Hidden HTML Keywords for Searchability - (repeats to push it up the list)
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
Documentation
Documentation
Documentation
Documentation
Documentation
Documentation
Documentation
Documentation
Documentation
Documentation
XRW
Wiki
Wikipedia
Wikimedia
Doxygen
RosettaWiki
//-->
