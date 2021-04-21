# Gettng credit for your work: The CitationManager

This page was created on 7 March 2020 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## 1. Why is it important for me to seek credit for my contributions to Rosetta?

We learn from an early age that humility is a virtue.  Nevertheless, in science, it is important to ensure that one gets credit for one's own work.  There are several reasons that we want to make sure that developers of Rosetta features or modules are credited, and these include:

* Credit is the currency of science.  As one progresses in one's scientific career, one's professional reputation -- primarily driven by one's publications, but also by other means by which one makes one's contributions known -- determines the resources to which one will have access.  Hiring decisions, allocations of supercomputing resources, collaborations, operating grants, _etc._ are all heavily influenced by professional reputation.  As a community, it is in our _communal_ interest for those who contribute to Rosetta to be able to obtain the resources that they need to continue their research, and it is therefore in our communal interest to ensure that they get credit for their work.
* Credit influences job satisfaction.  No matter how altruistic one is, an individual who gives to the community and receives nothing in return is unlikely to want to continue to contribute.  As a community, it is in our collective best interest to retain talent.
* Rosetta is greater than the sum of its parts, and can only continue to thrive if developers choose to continue to contribute to it.  We do not want developers to become secretive or self-centered, focusing on developing code for their own projects without making it available to others.  We therefore have an interest in providing incentives to share code.
* If developers' contributions are publicized, it becomes easier to know to whom one should talk about a particular module or feature if one wishes to build upon it.  Credit ensures that knowledge is not lost, effort is not duplicated, and time is not wasted.
* Credit is generally given through coauthorship on publications.   If those who first use a new module, feature, or method include the original developer as a coauthor on their publication, it gives that developer the opportunity to document the module, feature, or method in the publication or its supplement.  That is, the act of awarding credit has the side-benefit of tying Rosetta successes to descriptions of the methods, facilitating reproducibility and extensions, and fighting the tendency to treat Rosetta as a black box.

For all of these reasons, it is _both_ in an individual's best interest _and_ in the community's best interest to ensure that everyone knows who produced which Rosetta module, and which Rosetta modules are published (in which case the original papers should be cited) or unpublished (in which case the developer should be included on the first Rosetta community paper that relies on the module).

## 2. How we document contributions: The Rosetta CitationManager

The Rosetta CitationManager is a Rosetta singleton -- a global object of which one instance exists in memory for a given Rosetta session.  Its job is to track which Rosetta modules were used during a Rosetta session, and to issue a report at the end of the session listing the published modules that should be cited (and the relevant papers), plus the unpublished modules whose authors should be included as coauthors on the first publication using those modules (plus the authors' names and contact information).  Any Rosetta module may register itself with the CitationManager, providing information about its citation(s) (if published) or author(s) (if unpublished).  In the case of Movers, Filters, TaskOperations, ResidueSelectors, EnergyMethods (score terms), SimpleMetrics, or PackerPalettes, special function overrides exist to make it easy for the [[RosettaScripts]] application to register all of the scripted modules in a user's script.  At the end of Rosetta execution, a message similar to the following is written:

```
basic.citation_manager.CitationManager: 

The following Rosetta modules were used during this run of Rosetta, and should be cited:

rosetta_scripts Application's citation(s):

Fleishman SJ, Leaver-Fay A, Corn JE, Strauch E-M, Khare SD, Koga N, Ashworth J, Murphy P, Richter F, Lemmon G, Meiler J, and Baker D.  (2011).  RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite.  PLoS ONE 6(6):e20161.  doi: 10.1371/journal.pone.0020161.


The following UNPUBLISHED Rosetta modules were used during this run of Rosetta.  Their authors should be included in the author list when this work is published:

GlycanTreeModeler Mover's author(s):

Jared Adolf-Bryfogle, The Scripps Research Institute, La Jolla, CA <jadolfbr@gmail.com>

```

### 2.1 Adding authorship information for an unpublished Rosetta module

If authorship information is added to a Rosetta module, it will allow Rosetta to report the name of the developer and the fact that the module was used at the end of a Rosetta session in which the module was invoked.  For Movers, Filters, TaskOperations, ResidueSelectors, EnergyMethods (score terms), SimpleMetrics, or PackerPalettes (RosettaScripts-scriptable objects), one need only one function to the module, which will get called automatically by the RosettaScripts machinery.  For other Rosetta modules, the same types of functions should be added in the same way, but you will need to call that function to register it.

#### 2.1.1 Short summary of steps for adding authorship information for RosettaScripts-scriptable modules

To add authorship information for an unpublished Rosetta module, one must:

1.  Implement a function override for `provide_citation_info()`.  This should update the CitationCollectionList object with an `UnpublishedModuleInfo` object that contains a vector of the module name, module type, plus one or more authors (name, affiliation, e-mail address).

It's that simple.

#### 2.1.2 Detailed description of steps for adding authorship information for RosettaScripts-scriptable modules

1.  Override the `provide_citation_info()` function.  First, edit the ".hh" file for your module to add the following as a public member function:

```c++
/// @brief Provide a list of authors for this module.
void provide_citation_info(basic::citation_manager::CitationCollectionList & ) const override;
```

Now edit the ".cc" file.  Let us suppose that this is a mover called "MyMover".  Add the following lines:

```c++
/// @brief Provide a list of authors for this module.
void
MyMover::provide_citation_info(basic::citation_manager::CitationCollectionList & citations ) const {
	using namespace basic::citation_manager;
	
	citations.add(
		utility::pointer::make_shared< UnpublishedModuleInfo >(
		get_name() /*Gets the name of this Mover.*/,
		CitedModuleType::Mover /*Should match the type of module being cited.*/,
		"Your Name" /*Fill this in.*/,
		"Your Affiliation" /*Fill this in.*/,
		"Your e-mail address" /*Fill this in.*/
		)
	);
}
```

In the above, change "MyMover" to the name of your module, and replacee `CitedModuleType::Mover` with the appropriate type (_e.g._ `CitedModuleType::ResidueSelector`, `CitedModuleType::EnergyMethod`, _etc._) if this is not a mover.

Most likely, to get Rosetta to compile, you will also need to add the following to the headers at the top of the ".cc" file:

```c++
#include <basic/citation_manager/UnpublishedModuleInfo.hh>
```

#### 2.1.3 Adding multiple authors

The `UnpublishedAuthorInfo` object can store an arbitrarily long list of authors.  If more than one developer has contributed to a module, all developers who made significant contributions should be listed.  By adding notes about each author's contribution, users can make decisions about which authors should be included as co-authors when it comes time to publish.  In this case, the syntax isn't quite as concise, but here is an example:

```c++
/// @brief Provide a list of authors for this module.
void
MyMover::provide_citation_info(basic::citation_manager::CitationCollectionList & citations ) const {
	using namespace basic::citation_manager;
	
	// Create the UnpublishedModuleInfo object and set the module name and type.  (The type
	// should match the actual module type):
	UnpublishedModuleInfoOP my_author_info(
		utility::pointer::make_shared< UnpublishedModuleInfo >( get_name(), CitedModuleType::Mover )
	);
	
	// Add first author:
	my_author_info->add_author(
		"Susan Calvin" /*Fill in name here.*/,
		"United States Robots and Mechanical Men, Inc." /*Fill in institution here.*/,
		"scalvin@psych.usrobots.com" /*Fill in e-mail address here.*/,
		"Initial logic for this mover."  /*This additional notes field is optional.*/
	);
	
	// Add a second author:
	my_author_info->add_author(
		"Hari Seldon" /*Fill in name here.*/,
		"Streeling University" /*Fill in institution here.*/,
		"hseldon@pscyhohistory.streeling.edu" /*Fill in e-mail address here.*/,
		"Refactored to future-proof the implementation."  /*This additional notes field is optional.*/
	);

	// Add the authorship information to the CitationCollectionList
	citations.add(my_author_info)
}
```

As before, replace "MyMover" with the name of your class in the above, and if it is not a mover, update the `CitedModuleType::Mover` part to reflect the type.

### 2.2 Adding citation information for a published Rosetta module

If (or when) a module is published, the unpublished author information described above should be removed, and replaced with information about how to cite the module when it is used.  Citations are stored centrally in the Rosetta database, and are loaded lazily and in a threadsafe manner by the `CitationManager`.

#### 2.2.1 Short summary of steps for adding citations for RosettaScripts-scriptable modules

To add a citation for a RosettaScripts-scriptable module:

1.  Implement a function override for `provide_citation_info()` that queries the `CitationManager` for the citation, by doi, and updates the `CitationCollectionList` object.
	
2.  If the citation is not yet in the Rosetta database, add it to `database/citations/rosetta_citations.txt`.
	
#### 2.2.2. Detailed description of steps for adding citation information for RosettaScripts-scriptable modules

1.  Implement a function override for `provide_citation_info() const`.  First, add a prototype for a public member function override to the class definition in the ".hh" file:

```c++
/// @brief Provide the citation for this mover.
void provide_citation_info( basic::citation_manager::CitationCollectionList & ) const override;
```

Next, edit the ".cc" file and implement the function:

```c++
/// @brief Returns the citation for this mover.
void
MyMover::provide_citation_info(basic::citation_manager::CitationCollectionList & citations) const {
	using namespace basic::citation_manager;
	
	// Create a citation collection for this module:
        CitationCollectionOP collection(
		utility::pointer::make_shared< basic::citation_manager::CitationCollection >(
			get_name() /*Gets the name of the module.*/,
			CitedModuleType::Mover /*Should be updated for filters, task operations, residue selectors, etc.*/
		)
	);
	
	// Add the relevant citation from the CitationManager to the collection
	collection->add_citation( CitationManager::get_instance()->get_citation_by_doi("10.1073/pnas.1115898108"  /*Update this with the DOI of your citation.*/ ) );
		/*The line above queries the CitationManager for the citation,
		and will throw an error if the citation is not in the database.*/
	
	// Add the collection to the CitationCollectionList
	citations.add( collection );
}
```

In the above, "MyMover" should be replaced with your class name.  If your class is not a mover, replace `CitedModuleType::Mover` with the appropriate type (_e.g._ `CitedModuleType::TaskOperation`, `CitedModuleType::EnergyMethod`, _etc._).  Be sure to fill in the DOI for the citation that you want in the `get_citation_by_doi` line.

Finally, add the necessary headers to the top of the ".cc" file:

```c++
#include <basic/citation_manager/CitationManager.hh>
#include <basic/citation_manager/CitationCollection.hh>
```

3.  If your citation is not already in `database/citations/rosetta_citations.txt`, add it there.  The file format is described in the next section.

#### 2.2.3 Adding citations to the Rosetta database

Rosetta papers are listed in `database/citations/rosetta_citations.txt`.  Please keep citations in order by year, and please enter each citation once and only once.  Fields are separated by `[BEGIN_XXX]` and `[END_XXX]` lines.  Relevant fields are:

* Primary author or co-primary authors (listed one per line as: `"Given name(s)" "Surname" "Initials"` -- for example, `"Barack Hussein" "Obama" "BH"`).
* Co-authors (listed in the same format).
* Senior author(s) (listed in the same format).
* Year (an integer).
* Title (no quotations, no period at the end).
* Journal (abbreviated, no periods).
* Volume, issue, and pages (e.g. "43(6):1325-32").
* DOI

An example is shown here:

```
[BEGIN_CITATION]
    [BEGIN_PRIMARY_AUTHORS]
        "Brandon" "Frenz" "B"
    [END_PRIMARY_AUTHORS]
    [BEGIN_COAUTHORS]
        "Sebastian" "Rämisch" "S"
        "Andrew J" "Borst" "AJ"
        "Alexandra C" "Walls" "AC"
        "Jared" "Adolf-Bryfogle" "J"
        "William R" "Schief" "WR"
        "David" "Veesler" "D"
    [END_COAUTHORS]
    [BEGIN_SENIOR_AUTHORS]
        "Frank" "DiMaio" "F"
    [END_SENIOR_AUTHORS]
    [BEGIN_YEAR]
        2018
    [END_YEAR]
    [BEGIN_TITLE]
        Automatically fixing errors in glycoprotein structures with Rosetta
    [END_TITLE]
    [BEGIN_JOURNAL]
        Structure
    [END_JOURNAL]
    [BEGIN_VOLUME_ISSUE_PAGES]
        27(1):134-139.e3
    [END_VOLUME_ISSUE_PAGES]
    [BEGIN_DOI]
        10.1016/j.str.2018.09.006
    [END_DOI]
[END_CITATION]
```

Manuscripts under review may also be added.  In this case, the Journal and volume/issue/pages fields should be "XXX" (which is a special signal to the CitationManager to treat this as an unpublished manuscript under review).  The DOI can be anything in this case, so long as it is a unique string that allows the manuscript to be uniquely identified in code.  (Journal, volume/issue/pages, and DOI will not be printed in user-facing messages for manuscripts under review).  An example is as follows:

```
[BEGIN_CITATION]
    [BEGIN_PRIMARY_AUTHORS]
        "Vikram Khipple" "Mulligan" "VK"
    [END_PRIMARY_AUTHORS]
    [BEGIN_COAUTHORS]
        "Christine S" "Kang" "CS"
        "Michael R" "Sawaya" "MR"
        "Stephen" "Rettie" "S"
        "Xinting" "Li" "X"
        "Inna" "Antselovich" "I"
        "Timothy" "Craven" "T"
        "Andrew" "Watkins" "A"
        "Jason W" "Labonte" "JW"
        "Frank" "DiMaio" "F"
        "Todd O" "Yeates" "TO"
    [END_COAUTHORS]
    [BEGIN_SENIOR_AUTHORS]
        "David" "Baker" "D"
    [END_SENIOR_AUTHORS]
    [BEGIN_YEAR]
        2020
    [END_YEAR]
    [BEGIN_TITLE]
        Computational design of mixed chirality peptide macrocycles with internal symmetry
    [END_TITLE]
    [BEGIN_JOURNAL]
        XXX
    [END_JOURNAL]
    [BEGIN_VOLUME_ISSUE_PAGES]
        XXX
    [END_VOLUME_ISSUE_PAGES]
    [BEGIN_DOI]
        Mulligan_2020_underreview
    [END_DOI]
[END_CITATION]
```
