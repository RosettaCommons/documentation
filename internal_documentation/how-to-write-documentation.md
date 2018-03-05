How to write documentation
==========================

General Guidelines
------------------
If you haven't thought much about how to write good documentation, consider 
reading these two articles for inspiration:

* https://jacobian.org/writing/technical-style/

* http://stevelosh.com/blog/2013/09/teach-dont-tell/

Regarding the Rosetta documentation in particular, know that this wiki is meant 
to be the one location for all user-facing Rosetta documentation.  Pages are 
formatted in [[Markdown|http://daringfireball.net/projects/markdown/syntax]], 
so make sure you're familiar with its syntax (for most things it's pretty 
intuitive).  You can also preview your pages to make sure they show up how you 
want.

There are two ways to write documentation that will only be visible to 
developers and not to users who download weekly releases of Rosetta.  The first 
is to put that documentation in the `internal_documents/` folder and the second 
is to put that documentation inside the following comment tags:

    <!--- BEGIN_INTERNAL -->
    ...
    <!--- END_INTERNAL -->

Creating a New Page
===================
When creating a new page using the wiki interface, please make sure that it is placed in the correct folder (see the directory structure [[below|how-to-write-documentation#organization and navigation]] for guidelines). There are three ways to accomplish this:

1. Before creating your page, navigate to another page that is in the directory where your page should be placed. Any page similar to yours should be in the correct directory. If, for example, you want to create a new RosettaScripts filter page, you could navigate to the page for any other RosettaScripts filter before creating your page, and it will be automatically placed in the correct directory. The new location for the page will also be indicated in the window where you name the page when you first create it.

2. When you name your page (in the small pop-up window that appears when you click the "New" button on the wiki), you can give the absolute path to your page instead of just a name. So, for instance, if you are on the wiki home page (or any other part of the wiki) and click New, and you want to make a new RosettaScripts mover, you would name the page "/scripting_documentation/RosettaScripts/Movers/movers_pages/MyNewMover" instead of just "MyNewMover".  Note that this does NOT work for creating a new page from editing, aka <code> [[ link to  | MyNewPage ]]</code>.  See Tip 3 for how to create a new page from wiki syntax properly.

3. If (for whatever reason) you prefer to create new pages by directly navigating to a URL for a page that doesn't exist and then creating it, you can do that as well--the directory structure appears in the URL, so navigating to https://www.rosettacommons.org/docs/wiki/scripting_documentation/RosettaScripts/Movers/movers_pages/MyNewMover would create a page in the correct directory for RosettaScripts movers.

Organization and Navigation
===========================

<a href="organization-and-navigation" />

The directory structure of the documentation repository is given below with a brief description of what belongs in each directory/subdirectory.

* **getting_started**: Pages geared toward people who are completely new to Rosetta. Most of these pages are fairly broad, tutorial-type pages intended to guide new users toward the documentation (or other resources) that is most relevant to their particular problem.
* **build_documentation**: Pages describing how to build Rosetta (but nothing related to actually using Rosetta). If you want to write about different platforms, compilers, etc., then this is the place to put that information.
* **rosetta_basics**: Pages that are generally relevant to running Rosetta and/or understanding specific Rosetta concepts but that aren't specific to a given application. Some pages fit best in the top level of this directory, but there are several subdirectories that are a better fit for many pages:
   * **file_types**: Descriptions of particular input/output file formats (PDB, silent file, params file, etc.). If, for example, someone wanted to write a brief page describing the format of a blueprint file, this is where it would go.
   * **Glossary**: This page currently only contains the Glossary (It's in its own subdirectory so it can have its own sidebar). The RosettaEncyclopedia could also probably go in here, but you probably won't want to add pages to this directory.
   * **non_protein_residues**: As the name suggests, this directory contains general information on working with anything in Rosetta that is not a canonical L amino acid. For example, a new page on carbohydrates in Rosetta would go in this directory.
   * **options**: Other than the full-options-list, which is automatically generated and must stay in the top level directory, pages describing specific options groups belong in this directory. The full-options-list will automatically include the descriptions of your options that you provided in the code; this section would allow you to provide more information, tips on when to use particular flags, which flags should/should not be used together, etc.
   * **preparation**: Guides to preparing structures for use in Rosetta.  Some of the information may seem similar to the non_protein_residues folder; however, that folder is intended for more general information, while this one is intended specifically for tutorial-type pages describing what a user needs to do to make his/her input file Rosetta-friendly.
   * **scoring**: Contains pages describing the process of scoring in Rosetta, score functions, score terms, etc. 
   * **structural concepts**: This is where general pages on important concepts in Rosetta (Mover, Pose, symmetry, etc.) belong. If you, for example, wrote a page describing *conceptually* what a TaskOperation is and does or how Rosetta works with some particular structural feature (e.g. membranes), then it would belong in this folder.
* **application_documentation**: Subdirectories of application_documentation contain pages for specific Rosetta applications and tools. The top-level application_documentation directory should only contain pages relevant to applications in general (for example, the Apps page, which lists all public Rosetta applications).  Of course, some apps might fit in more than one subdirectory (for example, an RNA design app could technically go in either the rna directory or the design directory); in those cases, the app should go in the most specific directory or the directory that fits the most common usage case for the application (so that RNA design app would go in the rna directory, and relax belongs in structure_prediction even though it is sometimes used in design.)
   * **analysis**: Apps that are intended to analyze structures rather than change them (score and ddg_monomer are two examples)
   * **antibody**: Antibody-specific applications
   * **design**: Apps primarily used for design (e.g. fixbb)
   * **docking**: Applications used for docking (e.g. FlexPepDock)
   * **rna**: RNA-specific applications
   * **stepwise**: If your app belongs here, then you'll know it
      * **stepwise_assembly**
      * **stepwise_monte_carlo**
   * **structure_prediction**: Apps used primarily for structure prediction (e.g. AbinitioRelax)
      * **loop_modeling**: Loop modeling applications
   * **tools**: Documentation for scripts in the tools repository belongs here.
   * **utilities**: Applications that don't really fit into the other categories. For example, documentation for the fragment picker, optE, and make_rot_lib all belong here.
* **scripting_documentation**: Pages on scripting interfaces to Rosetta belong in subdirectories of scripting_documentation. Only pages that apply to all of these interfaces (right now, just the overview page) should be in the top level of this directory.
   * **PyRosetta**: All PyRosetta-related pages belong here.
   * **RosettaScripts**: All pages that are specifically RosettaScripts-oriented belong in this directory. The top level contains general information, such as conventions for writing RosettaScripts.
      * **composite_protocols**: If you have an entire protocol that is generally run in RosettaScripts that might include a combination of movers, filters, and/or TaskOperations, it should be documented here (the individual mover/filter/TO pages still go in their respective sections). For instance, If there is a particular sequence of movers that should be used for ligand docking, they should be documented here.
      * **FeaturesReporter**: Documentation for the FeaturesReporter goes in the following subdirectories:
         * **features_reporters**: Pages for specific reporters
         * **rscripts**: R-specific pages relevant to the FeaturesReporter (currently just contains information on setting up R
         * **tutorials**: Guides to working with FeaturesReporters and their output
      * **Filters**: Contains the main Filters-RosettaScripts page. If you have a page that describes some family of related filters, it would also belong here.
         * **filter_pages**: Individual filter pages
      * **Movers**: Contains the main Movers-RosettaScripts page and pages on related groups of movers (e.g. symmetry movers, loop modeling movers)
         * **movers_pages**: Individual mover pages
      * **TaskOperations**: Contains the main TaskOperations-RosettaScripts page; again, any page that gives an overview of some related group of TaskOperations would also belong here.
         * **taskoperations_pages**: Individual TaskOperation pages
   * **TopologyBroker**: Documentation for the TopologyBroker belongs here.
* **development_documentation**: Documentation intended for people who intend to write actual Rosetta C++ code but not requiring GitHub access. The top level contains general pages, primarily on coding conventions.
   * **code_structure**: The top level contains pages that describe Rosetta's library structure.
      * **classes**: Documentation for specific classes belongs here. There's currently very little in this directory (really just some data structures, tracers, and pointers), but we would love to have more high-level documentation of Rosetta classes.
      * **namespaces**: Pages describing what belongs in a particular namespace. Again, there aren't many pages here yet, but we would love to have more.
   * **test**: Any information on running, writing, and interpreting tests in Rosetta belongs in this directory.
   * **tutorials**: Guides to performing some specific development task, such as making a mover compatible with RosettaScripts or writing an application.
* **internal_documentation**: If a page should not be available on the public documentation page, then it should (generally) go in internal documentation. This includes two main types of pages. The first are pages that just aren't ready for users to see yet (e.g. documentation for a protocol that is still in devel/has not been published). The second are pages that are permanently hidden from users because they don't apply to anyone who doesn't have GitHub access (e.g. the GithubWorkflow page).  Feel free to make your own subdirectories in internal_documentation for your particular project.
   * **missing_links**: This is currently the only permanent subdirectory in internal_documentation.
        **Do not put pages in this directory.** The missing_links pages are generated automatically.
* **meta**: Contains pages of mainly historical interest that are not directly relevant to running Rosetta but which should be documented somewhere. Currently contains the Rosetta Timeline (history of Rosetta), History of Rosetta Documentation, and Rosetta People (brief descriptions of people, particularly non-PIs, we might refer to by name and expect everyone to know who we're talking about). 


The top level directory should **only** contain pages that don't fit into any of these categories. This currently includes, for example, the pages describing the Rosetta web servers and CS-Rosetta. It also contains the full-options-list page because that page is generated automatically, so **don't move the full-options-list page**.


Before you add a new page to the documentation, it's also a good idea to check the later sections of this page for specific tips on information to include in your page. Note that **this should include a "See Also" section** that links to related pages or pages that users may have been looking for when they reached your page.  Also make sure that you **add links to your page** from the page a level above it (e.g. if you add a design application, link to it from the design-applications page) and See Also links from related pages. 

How to document a new RosettaScripts Tag
----------------------------------------
If you are looking for information on how to write a new XML RosettaScripts 
tag, check out the [[RosettaScripts Developer Guide]].  Once you've written 
your tag, your next step is to document it.  Each tags should have its own page 
documenting in detail:

* What it does.
* When it makes sense to use it.
* When it doesn't make sense to use it.
* All the options and subtags it understands.
* What other tags it's commonly used with.
* Examples of it being used.

The first step in documenting your tag is to decide where it should fit into 
the documentation.  Every documented mover fits into the hierarchy that begins 
on the [[RosettaScripts]] page.  The first level of hierarchy pertains only to 
what kind of tag you wrote; i.e. a [[Mover|Movers-RosettaScripts]], a [[Filter 
|Filters-RosettaScripts]], a [[TaskOperation|TaskOperations-RosettaScripts]], 
etc.  The next level of hierarchy depends on what your tag actually does.

For example, let me assume that your tag is a Mover.  In this case, to decide 
where your tag should go in the Mover hierarchy, you would read through [[the 
mover page|Movers-RosettaScripts]] and find the category that best describes 
your Mover.  It's a little bit tricky to make sure your new page ends up in the 
right place (which would be 
`scripting_documentation/RosettaScripts/Movers/movers_pages` in this case). The 
most reliable way is to navigate to the documentation page for a mover that's 
in the same category as yours (i.e. that's already in the right place) and to 
click the `New` button at the top of the page.  If you don't see a `New` 
button, it's because you're on the [[static 
snapshot|https://www.rosettacommons.org/docs/latest]] of the wiki and not on 
the [[wiki itself|https://www.rosettacommons.org/docs/wiki]].

Your documentation should include the following sections:

* **Description:** A few paragraphs describing what the mover is supposed to 
  do.

* **Usage**: A "preformatted" block showing all the options and subtags that 
  are understood by your tag.  Each option should be annotated with types 
  default values, and each each subtag should be annotated with its tags.

* **Examples**: A few snippets showing the most common use cases.

* **Caveats**: A list of things users should be aware of when using your tag.  
  This might include situations where you tag isn't applicable or errors that 
  your tag commonly produces.

* **See Also**: A set of links to other tags and pages that are somehow related 
  to your tag.

A template for documenting new RosettaScripts movers can be found [[here|rscript-movers-template]]. Filters and TaskOperations will follow the same basic format.

How to document a new application
---------------------------------
If you are looking for information on how to write an new application, check 
out the page on [[writing an application|writing-an-app]].  Once you've written 
your application, your next step is to document it.  Each application should 
have its own page documenting in detail:

* What problems it solves.
* What options it takes.
* What outputs it produces.
* How those outputs are analyzed.
* What the application does under the hood.
* Any publications relating to the application.
* What version(s) of rosetta it is known to work with.

For example, the following pages all do a good job of documenting different 
applications:

* [[AbInitio|abinitio-relax]]
* [[Backrub|backrub]]
* [[Fold and Dock|fold-and-dock]]
* [[Relax|relax]]
* [[RNA Folding|rna-denovo-setup]]
* [[Docking|docking-protocol]]

Once you have written documentation for your protocol, you have to add it to 
the documentation wiki.  The [[Application Documentation]] page organizes the 
application documentation into categories.  Your first step is to decide which 
category best fits your application. See [[above|how-to-write-documentation#organization and navigation]] 
for descriptions of these categories. 

Each category corresponds to a subdirectory of `application_documentation/` in 
the documentation wiki.  To create a new page in the right directory, navigate 
to a page that is already in right category and click on the `New` button at 
the top of the page.  If you don't see a `New` button, it's because you're on 
the [[static snapshot|https://www.rosettacommons.org/docs/latest]] of the wiki 
and not on the [[wiki itself|https://www.rosettacommons.org/docs/wiki]].  Give 
the page an appropriate name and fill in the documentation you wrote. 

Once your new page is in the wiki, spend a few minutes adding links to it from 
other relevant pages on the wiki.  Also add a "See Also" section to your page 
containing links back to those relevant pages.  Links to demos showcasing your 
application are particularly valuable.  If demos of your application already 
exist, be sure to add links to them.  If they don't exist, then strongly 
consider writing some.  Note that (for technical reasons — Gollum gets really 
slow when there are too many pages in the wiki) the demos wiki is actually a 
whole different website than the documentation wiki.  So you have to use 
external links to link between the two wikis.

If your application is run through a python script, that script should also be briefly described 
in the appropriate section of the [[Tools]] page and linked to the main application page.

Template pages for application documentation can be found [[here|application-docs-template]], [[here|app-name]], and [[here|template-app-documentation-page]].

How to document a new demo
--------------------------
Demos are a really good resource for new users, because they show how the 
diverse diverse components of Rosetta fit together to solve problems.  Every 
demo should include:

1. An introduction to the task at hand.
2. Detailed step-by-step instructions on how to run the demo.
3. All the input data needed to run the demo.
4. Scripts containing the exact commands needed to run the demo.

Once you have written a demo, follow the instructions on [[this 
page|https://www.rosettacommons.org/demos/wiki/How_To_Write_Demos_and_Tutorials]] to see how to 
upload it into the Rosetta source repositories and to link it into the online 
documentation.

I want to emphasize again a point made in the instructions linked above.  Once 
you upload your demo, you have to add links to it from relevant pages in this 
wiki.  This means spending a few minutes browsing the wiki looking for relevant 
pages (especially in the applications section) and adding "See Also" links on 
any relevant pages that you find.  If you skip this step, your demo will be 
hard to find and therefore much less useful.

How to document a new C++ API
-----------------------------
The Rosetta API documentation is generated using doxygen, which is a 
well-established program to read source code and generate nicely formatted 
documentation.  Documentation is written in the source code in comment blocks 
prefixed with special characters:

    // Not recognized by doxygen.

    /// Recognized by doxygen.

    /* Not recognized by doxygen. */

    /** Recognized by doxygen. */

Some other special comments are recognized as well.  Inside these comments you 
can use a lot of different markup commands to control how doxygen formats the 
output.  All of these commands start with `@`:

    /// @brief A function to print a cordial greeting.
    /// @details This function demonstrates both how to write a simple C++ 
    /// program and how to document that function.

    void hello_world() {
        std::cout << "Hello world!" << std::endl;
    }

The `@brief` and `@details` tags demonstrated above are the most important 
formatting tags for use in Rosetta.  The `@brief` tag is used to provide a 
one-sentence description of what a function, class, or namespace does. 
The `@details` tag is used to provide a one-or-more-paragraph overview of what 
a class or non-trivial function does, what inputs it expects, what outputs it 
produces, and how it should be used, and (in broad strokes) how it works.

It's very important to write `@details` tags, because without then it's very 
hard to get a feel for how a class or function fits into the broader context of 
Rosetta.  Writing `@brief` tags is less crucial, but it's a good practice to 
document every single function, class, and namespace you write.  Don't make any 
exceptions for yourself!

Doxygen has many other tags that you might find useful, once you start writing 
your documentation.  You can find a complete list 
[[here|http://www.stack.nl/~dimitri/doxygen/manual/commands.html]].

To view your documentation as you're writing it, you can run doxygen locally. 
To do this, you'll first have to make a doxygen config file:

    $ doxygen -g

This will produce a configuration file called `Doxyfile`.  You can open, peruse, 
and change this file if you want; each option is very well described.  For 
example, I sometimes enable the `RECURSIVE` option to get doxygen to process a 
whole namespace rahter than just the topmost directory.  Either way, with 
`Doxyfile` in hand, you can run doxygen to generate the documentation preview:

    $ doxygen Doxyfile

This command creates a directory called `html`, which contains the generated 
documentation.  Once you are satisfied with your documentation, push it to 
master and it will appear on the live documentation within a few days.

How to view (and edit) the documentation offline
------------------------------------------------
The documentation wiki is a hosted out of a git repository, which makes it easy 
to view and edit offline.  The first step is to clone the relevant repository:

    $ git clone git@github.com:RosettaCommons/documentation.git

If you're happy to browse the documentation using command-lines tools, then 
you're done.  If you want to be able to see a nicely rendered HTML version of 
the documentation, then you need to run a local Gollum server.  [[Gollum]] is 
the software used to serve the public documentation site.  It is wiki software 
written in ruby that uses a git repository as its database.

Follow [[these 
instructions|https://github.com/gollum/gollum/wiki/Installation]] to install 
Gollum.  You may also have to install the GitHub Markdown extension, which 
you can typically do with this command:

    gem install github-markdown

Once Gollum is successfully installed, `cd` into the root of the documentation 
directory and launch a local server using the following command:

    gollum --config rosetta_gollum_config.rb

Then direct your web browser to the following URL:

    http://localhost:4567/

### Editing the documentation offline

While you can technically push your offline changes to the documentation 
repository, doing so is subject to nasty merge conflicts with the live site. 
The problem is that Gollum don't have a way for online users to resolve merge 
conflicts, so instead it just pushes aggressively to master.  Reserve direct 
git access to the repository for changes which cannot be done through the live 
wiki interface, like uploading images or batch processing type edits.

