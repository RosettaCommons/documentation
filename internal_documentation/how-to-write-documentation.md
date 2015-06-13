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
so make sure you're familiar with it's syntax (for most things it's pretty 
intuitive).  You can also preview your pages to make sure they show up how you 
want.

There are two ways to write documentation that will only be visible to 
developers and not to users who download weekly releases of Rosetta.  The first 
is to put that documentation in the `internal_documents/` folder and the second 
is to put that documentation inside the following comment tags:

    <!--- BEGIN_INTERNAL -->
    ...
    <!--- END_INTERNAL -->

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
|Filters-RosettaScripts]], a [[TaskOperation|TaskOpertions-RosettaScripts]], 
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

How to document a new application
---------------------------------
If you are looking for information on how to write an new application, check 
out the page on [[writing an application|writing-an-app].  Once you've written 
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
application documentation into categories.  Your first step is to read that 
page and decide which category best fits your application.

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
page|https://www.rosettacommons.org/demos/latest/Home.html]] to see how to 
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

    /// @brief A function to print a coridal greeting.
    /// @details This function demonstrates both the way to write a simple C++ 
    /// program and to document that function.

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
