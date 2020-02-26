This page is geared towards new members of the Rosetta community as a "fast" way to learn about Rosetta, how to use it and how to develop in Rosetta, if needed. The page is organized by increasing difficulty, starting out with basic tools needed, then tutorials for users and later for developers. If you are going through and find that important parts are missing, please add them to the page!

[[_TOC_]]

![gollum](http://s2.quickmeme.com/img/86/86a343e34ab8ca051ce5a455eeba643a94b5f5dda96e558453d19f90cea15d99.jpg)

# 1. Introduction to protein structure and visualization
## Visualization
Most people in the community are using PyMol (download from http://www.pymol.org/). Documentation on how to use it can be found at:
* http://pymol.sourceforge.net/newman/userman.pdf 
* https://pymolwiki.org/index.php/Practical_Pymol_for_Beginners

Some people are using Chimera (http://www.cgl.ucsf.edu/chimera/), which seems to have some additional functionality for density maps if you are working with X-ray electron density maps or Cryo-EM maps. Tutorials can be found at http://www.cgl.ucsf.edu/chimera/docs/UsersGuide/frametut.html.

There is also the Discovery Studio Visualizer for Scientific Linux and Windows systems:
* http://accelrys.com/products/collaborative-science/biovia-discovery-studio/visualization-download.php 

## Basic biochemistry
To work in Rosetta, you need to know some basic biochemistry about amino acids and protein structure. You can learn this by picking up a biochemistry book (such as Voet & Voet: Biochemistry) or look at:
* http://www.rpi.edu/dept/bcbp/molbiochem/MBWeb/mb1/part2/protein.htm
* http://www.ruppweb.org/xray/tutorial/protein_structure.htm

## Foldit (developed by Center for Game Science at UW, Bakerlab, and UMass Dartmouth (Firas Khatib))
Foldit is a videogame created for the general public to solve real-life scientific puzzles involving protein structure and function. It is an excellent starting point to learn about protein structure as it does not require any previous knowledge. Once you download it, it will take you through tutorials where you are learning about all the moves and modifications you can do to a protein structure with a lot of fun along the way. Keep in mind that the terminology that Foldit uses is a bit different than what we are using in Rosetta (even though the code underneath Foldit is Rosetta code), but if you understand the concepts using Foldit, you can easily apply them in Rosetta. Also, the score in Foldit is opposite from Rosetta: in Foldit a higher score is better, in Rosetta, a lower energy is desired.

Download it at http://fold.it/portal/

## Eterna - for RNA (developed by Rhiju Das, Stanford)
A similar tool to FoldIt is available for RNA. It was developed by Rhiju Das' lab at Stanford (http://www.stanford.edu/~rhiju/). You can play and learn about it here: http://eterna.cmu.edu/web/

## Introduction to Linux
To know about how to navigate a terminal in Linux, you need to learn some basic commands. Learning some basic tricks with BASH coding often proves useful in expediting your workflow. There are plenty of resources available on the web: 
* http://www.my-guides.net/en/guides/linux/basic-linux-commands
* http://www.debianhelp.co.uk/commands.htm

# 2. Introduction to Rosetta
Rosetta is a unified software package for protein structure prediction and functional design. It has been used to predict protein structures with and without the aid of sparse experimental data, perform protein-protein and protein-small molecule docking, design novel proteins and redesign existing proteins for altered function. Rosetta allows for rapid tests of hypotheses in biomedical research which would be impossible or exorbitantly expensive to perform via traditional experimental methods. Thereby, Rosetta methods are becoming increasingly important in the interpretation of biological findings, e.g., from genome projects and in the engineering of therapeutics, probe molecules and model systems in biomedical research.

Rosetta concepts:
The following pages describe a handful of very important Rosetta concepts - like FoldTree, AtomType, MoveMap, etc.
* [[Rosetta-overview]]
* [[Rosetta-Basics]]

Some really useful papers about Rosetta:
* Kaufmann, Lemmon, DeLuca, Sheehan, Meiler: "Practically Useful: What the Rosetta Protein Modeling Suite Can Do for You" Biochemistry 2010: http://pubs.acs.org/doi/abs/10.1021/bi902153g
* Rohl, Strauss, Misura, Baker: "Protein Structure Prediction Using Rosetta", Methods in Enzymology, 2004: http://www.sciencedirect.com/science/article/pii/S0076687904830040 - contains the scoring function!!!
* Leaver-Fay et. al: "ROSETTA3: An Object-Oriented Software Suite for the Simulation and Design of Macromolecules" Methods in Enzymology 2011: http://www.sciencedirect.com/science/article/pii/B9780123812704000196


# 3. Documentation
## Glossary: Rosetta and technical
Here are some useful links that will help you understand terminology that is used in Rosetta. 
* [[Rosetta-overview]]
* [[Glossary]]

Some concepts are also explained in the PyRosetta tutorials:
* http://www.pyrosetta.org/tutorials

## Documentation
There is considerable documentation available within this wiki. Additional documentation is available here:  https://www.rosettacommons.org/manuals/archive/rosetta3.4_user_guide/index.html. 

## Tutorials
Excellent in-depth tutorials covering many aspects of Rosetta can be found here:
https://www.rosettacommons.org/demos/latest/Home#tutorials

## FAQ/Forum
The main RosettaCommons page is https://www.rosettacommons.org/. There is a Forum available on this page where you can post questions or look for answers for your specific problem (https://www.rosettacommons.org/forum).


# 4. Course material
There is course material available from several labs who gave lectures about Rosetta. The material can be found on github under teaching resources: https://github.com/RosettaCommons/teaching_resources

Lectures on Rosetta (closely following the PyRosetta book): http://goo.gl/GuUNDK


# 5. Rosetta for users
## Download and compile Rosetta, git version control
If you won't be developing in Rosetta, you can download the release version here : https://www.rosettacommons.org/

Most likely, you will be developing or at least running new code. In this case you have to download and compile the developers version of Rosetta. But before you do that, please follow the instructions here: https://wiki.rosettacommons.org/index.php/NewNewDevelopersPage#Administrative_-_take_care_of_these_IMMEDIATELY, especially:
* signing the developers agreement
* signing up for the mailing list
* creating a github account

After you have done that, follow the instructions on how to download and compile Rosetta here: 
https://wiki.rosettacommons.org/index.php/GithubWorkflow
You might want to look at the test-server (http://rosettatests.graylab.jhu.edu/revs) to figure out the latest revision for which all tests are running and get this revision. If you get the latest revision, it might be that not all tests are running so you might be downloading a 'broken' version. If you don't really understand much about git and github yet, don't worry, you will be going into much more detail later once you are actively developing in Rosetta (see below).

## Meilerlab tutorials (put together by Jens Meiler's lab, Vanderbilt University)
The Meiler lab has hosted one-week workshop in the past (usually some time in the spring) for members of the community, outside people and people from industry. The are an excellent starting point on how to run Rosetta, give plenty of information on how to prepare input files and how to process Rosetta output. The zip folder can be downloaded and unpacked - it contains subfolders for several Rosetta applications, including protein folding, docking, design, ligand docking, and loop modeling. Input files are provided and only minimal previous knowledge is assumed to go through these (like PyMol or Linux). You need to download and compile Rosetta to run these applications!

Download the tutorials from 
* http://structbio.vanderbilt.edu/comp/workshops/rosetta_13/tutorials_2013.tar.gz (download takes a while)

## Demos
Once you downloaded and compiled Rosetta, you can also check out the demos folder at `Rosetta/demos`. This folder contains subfolders with easy-to-follow demonstrations and protocol captures on specific applications. Input files, readme's and commandlines are available in the folders. 

# 6. Rosetta for users/developers
## Python
It is useful to know python when you want to use PyRosetta or to write scripts to prepare input files or analyze data. 
* in-depth tutorial: https://docs.python.org/2.7/tutorial/
* interactive tutorial: http://www.learnpython.org/
	
* cheat sheet: http://www.cogsci.rpi.edu/~destem/gamedev/python.pdf
* another one: http://pythonkit.com/Python-Cheat-Sheet-download-w370.pdf
	
* book: http://www.amazon.com/Python-Dummies-Stef-Maruch/dp/0471778648/ref=sr_1_1?s=books&ie=UTF8&qid=1375469160&sr=1-1&keywords=python+for+dummies

## C++
If you want to develop in Rosetta, you need to learn C++. If you have never scripted before or know nothing about programming, it is recommended that you start with something easier than C++, such as Python (or Perl) to get the basics down. If you have scripting or other programming experience, here are useful references:
	
* short online videos - Bucky's tutorials: http://www.youtube.com/watch?v=tvC1WCdV1XU&list=PLC6E50B89DA30C77A
	
* book: Sam's teach yourself C++ in 21 days: http://www.amazon.com/Sams-Teach-Yourself-Edition-ebook/dp/B0028CK0GW/ref=sr_1_1?ie=UTF8&qid=1375469877&sr=8-1&keywords=c%2B%2B+sams+5th+edition

## ROSIE (set up by Sergey Lyskov, Jeff Gray's lab, Johns Hopkins)
ROSIE is an abbreviation for "Rosetta Online Server that Includes Everyone". It is a server that runs several Rosetta applications without requiring the knowledge of Python, C++ or anything difficult. Perfect to use for the Newbie, however, only few applications are available and some of them are very specialized - more to come in the future. Check it out at http://antibody.graylab.jhu.edu/. Also, if you are a developer and are planning on setting up a server on ROSIE for your own application, contact Sergey Lyskov at sergey.lyskov[at]gmail.com and he will give you instructions on how to do it. It should be pretty quick and easy with about two pages of code or less!

## PyRosetta (developed by Jeff Gray's lab, Johns Hopkins)
If you know Python and you are planning on creating your own protocols, PyRosetta (developed in Jeffrey Gray's lab at Johns Hopkins) is an excellent way of using Rosetta and manipulating protein structures (If you don't know Python, it is much easier if you learn it before diving into PyRosetta). PyRosetta is basically a Python wrapper around the Rosetta C++ code so you can do pretty much everything with Python without knowing C++. For rewriting code, however, it is recomended to do that in C++. The tutorials for PyRosetta can be found at http://www.pyrosetta.org/tutorials with the password here: https://wiki.rosettacommons.org/index.php/PyRosetta

## RosettaScripts and RosettaDiagrams (developed by Sarel Fleishman's lab, Weizmann Institute, Israel)
RosettaScripts is an XML-scriptable interface that allows users to mix and match protocols and carry out customizable tasks for various protocols. Detailed instructions on how to set them up are available at 
https://wiki.rosettacommons.org/index.php/RosettaScripts

An extension of RosettaScripts is available with RosettaDiagrams that should make it even easier to use and write your own protocols. It is basically a drag-and-click web interface where the user/developer can put together protocols from different movers, filters, and task operations. Information can be found at:
* http://www.rosettadiagrams.org/
* https://github.com/LiorZ/RosettaDiagrams
* http://rosettadiagrams.org/app.html

Both RosettaScripts and RosettaDiagrams require a certain knowledge about Rosetta, which movers, filters, and task operations should be used in which order to obtain a certain outcome. 

## CS-Rosetta (developed by Oliver Lange's lab, TU Munich, Germany)
CS-Rosetta is a version of Rosetta that uses NMR chemical shift restraints for ab initio folding or structure prediction. The toolbox of CS-Rosetta also includes automatic assignment of NOE resonances.
* http://www.csrosetta.org/

## Version control
If you are planning to develop in Rosetta and want to put together your own protocols and write code, now is the time to learn more about version control and all that comes with it. Version control is basically a history of the code base (similar to when you hit the 'save' button in a document) which is needed when over 100 developers are working on the code from all over the world at the same time. It makes it much easier to resolve coding conflicts (when multiple people are working on the same code) and much more difficult to "break" Rosetta - even though it is not completely impossible. ;o)

Extended information from the above intro is available here: https://wiki.rosettacommons.org/index.php/Github but it is suggested to become intimately familiar with various git commands. Several online resources are available, among them:
* nicely explained, not too long: http://gitref.org/
* shorter cheat sheet: https://www.kernel.org/pub/software/scm/git/docs/everyday.html
* short videos: http://www.youtube.com/GitHubGuides
	
## IDE:
To write and develop code, it is much easier if you have an IDE (Integrated Development Environment) available. It is basically an editor and compiler, which also links to version control and has tons of nice little features like linking to functions somewhere else in the code, bracket completion, indentation, finding errors, etc. The two IDEs commonly used are 

* Xcode - for Mac: https://wiki.rosettacommons.org/index.php/Tools:XCode
* VsCode - any platform: https://code.visualstudio.com/ C++ code navigation works out of the box.
* Eclipse - any platform: https://wiki.rosettacommons.org/index.php/Tools:Eclipse
* Netbeans - any platform: https://netbeans.org
Talk to your mentor which program he thinks is best so he can also give you advise on how to use it. And don't be discouraged, it takes a while to figure out the details.

## Coding conventions
Now that you know about version control, have set up your IDE and are knowledgeable about C++, you should read through the coding conventions and comply with them - no excuse!!! This will make it much easier in the long run for other people (and yourself) to read, understand and use your code in the way it is intended for. This also applies for Python code:
* https://wiki.rosettacommons.org/index.php/Coding_Convention_and_Examples

## How to find stuff in Rosetta
When you download Rosetta, it will automatically set up three independent github directories in Rosetta: 
* demos
* main
* tools

The executables are located in main/source/bin - they are links from executables somewhere deeper in the code

For Rosetta, people always say "The code is the documentation" - which is nice if you know how to read code, but not so nice, if you don't. Therefore, when you write code: document it in two places: 
* developer documentation: within the code with comments for doxygen to create html documentation
* user documentation: here on the gollum wiki - for the user
	
Write the documentation such that people who are not familiar with every detail of your code will be able to understand it but keep in mind who you are aiming your documentation for: the user or the developer. Please keep the correct documentation style in the correct places. 

## Doxygen/API documentation
User level documentation is a useful resource for learning how protocols in Rosetta work and how to use them. However, as developers it is important to also maintain more detailed documentation of the API (Application Programming Interface) which details how to navigate specific concepts and methods in the Rosetta library. 

We maintain API documentation using Doxygen - a software package that will parse the Rosetta source code and generates html documentation from in-code documentation. This can be done by using specialized tags (i.e. @brief, @details, @author, @note, etc) when commenting code. Details for writing doxygen documentation in-code can be found at: 
* http://graylab.jhu.edu/Rosetta.Developer.Documentation/core+protocols/d3/ddc/doxygen_tips.html
* https://wiki.rosettacommons.org/index.php/Tools:Doxygen

## Useful links
There are plenty of useful links available that are connected with Rosetta, in addition to the ones described above:
* New new developers page: https://wiki.rosettacommons.org/index.php/NewNewDevelopersPage

* Robetta server - online server for several applications: http://robetta.bakerlab.org/
	
* RosettaBackrub server - Kortemme lab, UCSF: https://kortemmeweb.ucsf.edu/backrub/
	
* RosettaDesign server - Kuhlman lab, University of Chapel Hill, NC: http://rosettadesign.med.unc.edu/
	
* Rosetta@cloud - pay-per-use service for the experimental community: http://rosetta.insilicos.com/what/
	
* Rosetta@home - donate computer time to solve scientific problems to RosettaCommons when you are not using your computer: http://boinc.bakerlab.org/rosetta/
	
* source code on github - requires a github account: https://github.com/organizations/RosettaCommons
	
* bugtracker - to keep track of bugs in the code using Mantis Bugtracker (hosted at Vanderbilt): http://bugs.rosettacommons.org/


# 7. More Rosetta for developers

## [[Code Template Generation | code_templates ]] 
How to generate code templates of common Rosetta classes/apps/unit tests to save development time.  Seriously, want to write a mover?  Start here! ```Rosetta/main/source/code_templates```

Here is an example of creating a new mover for carbohydrates:
```
./generate_templates.py --type mover --class_name TestMover --brief "A simple testing Mover" --namespace protocols carbohydrates
```

## Licensing
To get Rosetta as a developer, you signed the developers agreement (http://rosettadesign.med.unc.edu/agreement/agreements.html) which also contained some information about licensing third party software. Please also check out the wiki page here (https://wiki.rosettacommons.org/index.php/Licensing). A good rule of thumb is NOT to use anything under GPL or LGPL license.

For the general public:

Rosetta can be licensed here:   https://els.comotion.uw.edu/express_license_technologies/rosetta

PyRosetta can be licensed here: https://els.comotion.uw.edu/express_license_technologies/pyrosetta

## Bootcamp (put together by Andrew Leaver-Fay and other members of the Commons)
The Rosetta Bootcamp was given in April 2013 for the first time as a one-week workshop for beginning Rosetta developers. It contained both lectures as well as labs where participants applied their just-learned knowledge under the supervision of several Rosetta developers.

Tutorials: https://drive.google.com/folderview?id=0B7YNPpJXYWK8bEEwWnFqSkIzRnc&usp=sharing#grid

The full 24-hour material (split up into lectures/labs up to 90mins videos) can be watched on youtube:
	https://www.youtube.com/watch?v=2qQLdc0tmdg&list=PLaF-DHLR9l7wGTMldDNnZK7nA00eFHEH6
	
It may be better to not follow the schedule that youtube follows but rather the original schedule (https://docs.google.com/spreadsheet/ccc?key=0ArYNPpJXYWK8dHdjZEc4dGxIWnBvYko5OTZ5RFB3cHc#gid=0) since it was taught in this order. 

Below are the contents of the individual lectures/labs:
* Evening Lab 1	Mover in RosettaScripts
* Evening Lab 2	using graphs to identify H-bond networks
* Evening Lab 3	Scoring protein interface
* Evening Lab 4	ResourceManager
* Lab 1: 	Git
* Lab 1 Activity:	Git
* Lab 2: 	Library Structure 1: Write Mover in app
* Lab 2 Activity: 	Library Structure 1: Write app to score pose, write mover, use jd2
* Lab 3: 	GDB
* Lab 3 Activity:	GDB
* Lab 4: 	Unit Tests
* Lab 4 Activity:	Unit Tests
* Lab 5: 	C++ Classes 3: Operators, copying
* Lab 5 Activity: 	C++ Classes 3: Operators, copying, pointers
* Lab 6: 	FoldTree
* Lab 6 Activity: 	FoldTree
* Lab 7: 	Python
* Lab 7 Activity:	Python
* Lab 8: 	Unix Tools
* Lab 8 Activity:	Unix Tools
* Lab 9: 	Constraints
* Lab 9 Activity: 	Constraints
* Lab 10: 	Library Structure 6: Packer, Minimizer
* Lecture 1: 	C++ 1: Classes, encapsulation, polymorphism 
* (Lecture 1: 	C++ 1 (content))
* Lecture 2: 	Memory Allocation, Stack, Heap, Pointers
* Lecture 3: 	C++ 2: const, function signatures, overloading, static functions
* Lecture 4: 	Graphs
* Lecture 5: 	Rosetta Library Structure 2: Theory
* Lecture 6: 	Rosetta Library Structure 3: Applications: Packer, AtomTree, FoldTree, DoF, MoveMap
* Lecture 7: 	Rosetta Protocols 1: JobDistributor, RosettaScripts, ResourceManager
* Lecture 8: 	Rosetta Library Structure 5: Applications: Movers, Filters, Taskoperations, Fragments, Loops
* Lecture 9: 	Computational Thinking
* Lecture 10: 	Databases: SQL

## Running code and git
* make a separate directory outside of Rosetta where you run your exes and create files; this should be separate because your additional output files (as well as data) shouldn't be committed to the code base
* make it a habit to add a new file to git immediately after you create it in source, this will make it much easier once you want to commit

## Where to put your new code
When you are starting a coding project, make a new branch (git personal-tracked-branch mynewbranch) and start coding. **DO NOT PUT YOUR CODE IN /devel/ AS IT WILL BE PHASED OUT!!!** If you don't want your code to be released yet, just keep it in your branch until you are ready to merge your branch to master.

If you are writing a completely new framework, it MIGHT make sense to create a subdirectory in /core/. Also, be sure to consider which other code or libraries you are using in your code because they need to be compiled BEFORE any of your code will be compiled, otherwise you will run into unresolvable errors at compile time. If you are unsure, ask someone. 

## Notes on code design and implementation workflow
* before writing code, write down code design in every single detail, what are the interfaces between all the objects and classes you will create, what are the functions you need (and other people may need)? 
  * Think about it loooooong and hard, because if you implement something half-way thought through, you will spend 10x longer in refactoring it! 
  * Also, writing the actual code should only take you a fraction of the time you took to design it. And proper code design is one of the most important things for writing C++ code in Rosetta, because everything is so complex, even more so when you are a beginning developer!!!
  * while designing, avoid circular design in your code, it's messy and can be hard to compile; use a tree-like code design! 
  1. code design should be a top-down approach, starting with your interface, then design of your smaller classes and functions
  2. code implementation should be a bottom-up approach: implement smallest classes and functions first, then the ones that depend on them
* after you decided on an interface, write your header file with all the functions, input arguments and types and make sure it makes sense!!!
* after you wrote the header, start writing your unit test and think about every single function that you want to test for - the more code coverage, the better since this will tremendously shorten your debugging time:
  * think of every possible corner case and test for your function
  * the function is implemented in the source, not the test
  * in the unit test the function is not implemented, but used
* at the same time implement the functions in the .cc file:
  * give output that warns the user if something doesn't work
  * again: every corner case should be handled
* writing and compiling unit tests while implementing the function goes pretty much hand-in-hand but since the unit tests are there, it should be much easier to debug; also implementing both at the same time lets you think about how to best write functions that are testable; in that order:
  1. first compile source
  2. compile unit test
  3. run unit test
* debug your code
* CLEAN UP YOUR CODE 

## More notes
* choose names for classes and functions that are BOTH user-friendly AND developer-friendly. If your name could be interpreted in another way, choose a different one 
* for refactoring, it is easier to create new files and copy over what you need instead of rewriting old code
* debugging and refactoring is always easier if you put the files in the correct locations first, and then write unit tests for it
* testing for non-existence: can only be done indirectly and not directly, since you are wanting the program to crash, but how do you test for it? One way to deal with this is to write the existing ones in a vector and then ask whether the vector contains your element of interest

## Compiling/running code
* `src` and `test` are (sort-of) mirrored directories. Put your classes in `src` and your unit tests into `test`.
* to compile/run a class in `src`:
  * put `<class>.hh`, `<class>.cpp` into `<library>.src.settings` file
  * for classes, run `scons.py`
* to compile apps:
  * put `<main>.cc` into `pilot_apps.src.settings.all` file
  * for apps, run `scons.py bin mode=release`
  * this creates a binary of your app (and all apps, in fact) in the `bin` directory
* to compile/run unit tests:
  * list your `<name>.cxxtest.hh` file in the appropriate `test/<module>.test.settings` file
  * make sure to add any additional input files (e.g. `tracer.u`, `input.pdb`) in the `testinputfiles` section.
  * compile: `scons.py cat=test`
    * it won't compile if you comment out complete tests
    * avoid a newline between `void` and `test_mytest()`
    * put `<module>_init();` into the `setUp()` method
  * run: `test/run.py -d \<database\> -1 \<class_name, w/o extensions or prefixes\> -c \<compiler\>`
    * might not run if you omit the compiler in the commandline
* it is best to compile the src using `scons.py -j4` and then compile and run the tests
* in `cxxtest.hh`, don't use block comments (`/* */`) to comment out tests: compilation will fail 


## Debugging
Below are some useful techniques for debugging code in Rosetta. Most programmers would be incredibly lucky if their code compiles and runs at the first try. Debugging is trial error and requires some creativity. It is often better to assume your code is wrong (it most likely is) and be surprised when your code compiles and all tests succeed! :o)

Tools/Tricks
 * **Using an IDE:** The IDE will show warnings and possible build errors 
 * **Static Analysis Tools:** Compilers like clang will compile your code and also parse for some potential runtime errors
 * **Debugger:** A debugger will allow you to set breakpoints in your code and step through line-by-line to pinpoint the bug. Some common stand alone debuggers are gdb and lldb. These debuggers are also built into IDEs like XCode and Eclipse. 

When compiling and debugging code, spend your time on the harder bugs and less on the trivial errors. Before compiling, always check: 
* You have included and properly formatted your fwd.hh file. 
* Your class/unit test is listed in the correct src.settings or test.settings file
* Your code respects the library structure, meaning you are not #including anything that is built after your code. For example, you cannot use a pose in conformation code because pose is in core.3 but conformation is in core.2.
* No namespaces are implicitly declared. You should always specify the full namespace of a method you are using either inline or with a 'using namespace' declaration. This could lead to some ambiguity and 'difficult-to-debug' runtime errors. 
* Always initialize all fields in the constructor of a class. 
* For unit tests, add a tracer at the beginning of every unit test acting as a description of that test. This will help you to more easily decipher which test failed

Some useful tips for debugging: 
If compilation fails, some good first things to check:
  1. includes 
  2. namespaces
  3. types (pointers and refs)
  4. scope ("use of undeclared identifier XXX")
  5. implementations in BOTH header and cc file ("is not a member of...") 
  6. possible null pointer dereferences ("Assert p_ != 0 failed...") 

Other tips: 
* **Always unit test from the bottom up:** Test your smallest 'pieces' of code with the least dependencies and then work upwards. This will help you to rule out other untested code as a source of error. 
* **Back Trace:** Because the Rosetta libraries are very deep, you can often get runtime errors that throw from utility classes that have nothing to do with the actual error. A debugger will allow you to back trace - print every call that lead to the error which will help you to pinpoint what actually went wrong.  
* **Print statements are a powerful tool:** Stepping through your code by printing values will help you to understand what your methods are doing and how they can lead to error prone behavior (though, be sure to remove these tracers when you are done!)
* **I don't know what my error message means:** If you still don't know what an error message means, someone has probably run into this error before. Check the developers list, or if it is a generic C++ error Google can be incredibly useful. Also, debugging is largely trial and error - it requires creativity and persistence :)
* **Code and test defensively:** To write good code, pretend your user is a monkey and trying to find a bug in your code. Think about all possible edge cases and make sure you are handling them in your code. 
* **Step through your code using comments:** Comment everything in a function out and run line by line before you figure out the source of error. 

## Debugging segmentation faults
1.  Compile in debug mode.  (`./scons.py -j 8 mode=debug bin`).
2.  Run your protocol with gdb (or lldb on Mac).  These are debuggers which allow you to halt your app as it is executing and inspect the call stack (what function was being run, and what function was calling it, and what function was calling it, etc.) and the values of variables at arbitrary points.
`gdb --args <path_to_Rosetta>/main/source/bin/<your_app>.default.linuxgccdebug @rosetta.flags`
or
`lldb -- <path_to_Rosetta>/main/source/bin/<your_app>.default.macosdebug @rosetta.flags`
3.  Type `catch throw` (gdb) or `break set -E C++` (lldb).
4.  Type `run`.
5.  Wait for the segfault.  When it happens, type `bt` (gdb or lldb) to get a backtrace.  If you want to get debugging help, post the backtrace for other developers.  It shows what was calling what when the segfault happened.
6.  Step through the frames using `f 0`, `f 1`, `f 2`, etc. (gdb or lldb).  You can look at where you are in the code using `list`, print values of variables using `print <variable_name>`, etc.
At this point, it's detective work.  A segfault generally means that memory is being accessed in an invalid way (e.g. accessing element 11 of a 10-element vector).  It's pretty easy to figure out what was being accessed, but you have to figure out why this is happening.

## Some Tricky/Difficult to Debug Errors + Solutions 
Below is a non-comprehensive list of errors that were pretty ambiguous to debug. Feel free to add as you solve: 

Library Code: 
 * Constructors: In C++ it is good to initialize all of your data members in the constructor of a class. The default values for types can be ambiguous and it will prevent numerous runtime bugs. Also always be sure to inherit in your constructor using a base initializer (typically Reference Count). Example below: 

```
Constructor(): 
	utility::pointer::ReferenceCount(),
	bool_field1_(true),
	int_field2_(0),
{
	// code for my constructor
}
```
* Random Numbers: The random number generator in Rosetta generates a random number given some seed n. Always make sure that no seed in any of your code is the same or it will break the random number generator. All of your code will compile, but it will break at runtime and break the unit testing system entirely. 
* Casting: Type check before you cast between classes and subclasses. There is no instanceof keyword like in Java, so this will help ensure better type safety. 
* Exceptions: It is much better to throw exceptions in your code instead of using utility exits. Exceptions make your code more testable because in unit tests you can check TS_ASSERT_THROWS. Also, exceptions provide a more useful path to the original error for your users. 

Unit Testing:
 * Include a semi-colon at the end of your class definition. Your test will compile, but CxxTest will not be able to generate the C++
 * The error “assert p != 0…” means you are dereferencing a null or uninitialized pointer
 * Do not include a line return between your return type and function signature. i.e.
```
void
test_myTest() {} // incorrect
vs. 
void test_myTest() {} // correct! 
```

## Error handling, asserts, and tracers 
* assert: function that evaluates and stops running program when not passed (doesn't crash program: crash is seg fault)
* tracer: message; print statement
* exception: for handling wrong user-input; developer can define exit if error occurs, exit is not always necessary
* error handling: utility exit
* retry_run: retry run if structure didn't fulfill restraints

## The Options System (Options and Flags)
Many protocols in Rosetta can be set up by specifying options and flags through the options system. As you begin to develop code, you will most likely find yourself adding an option or using an existing option. 

To add an option to the options system: 
* In basic/options, open the python script options_rosetta.py and add your option to the script. 
* The options 'groups' are organized by name-spacing. So, for example, an option in the docking group called myoption would be accessed by -docking:myoption on the command line. You can create a new group or add to an existing group. 
* Run the script and it will register your option with Rosetta. 

To include your option in a new application/class, you must #include: 
* basic/options/options.hh
* basic/options/keys/group.OptionKeys.gen.hh

Where 'group' is the name of the option group. 

## The Resource Manager
The options system is very useful for switching on/off parameters in protocols and recognizing some basic settings. However, many inputs into Rosetta are often resources, such as a PDB file that will be loaded into a pose or symmetry information that will be stored in a SymmData object. Because the options system is static, we would have to keep recreating these resources which takes a lot of memory, time, and energy. 

The resource manager is Rosetta's solution to this problem. By defining your resources initially in a resource definition file, Rosetta will load these resources once and provide you access to them whenever needed. 

More info can be found about the Resource manager and how to integrate it into your code can be found here: 
https://www.rosettacommons.org/docs/wiki/development_documentation/tutorials/ResourceManager


## Tests: unit tests, integration tests, scientific tests
### Unit tests
Unit tests are tests of a small piece of code in isolation. Examples are testing a single function or the correct setup of a constructor (= the creation of an object). Code should be written like an onion and most of the code should be unit tested. Actually, ALL of the code should be unit tested, however, there are functions that are impossible to unit test. 
* unit tests are located in <code>test/devel</code>:
    * if compiling/running unit test, add file to <code>main/source/test/devel.test.settings</code>
    * if writing class: add file in <code>main/source/src/devel.src.settings</code>
* every unit test needs a <code>core_init()</code> and a <code>tearDown()</code> method. 
* compile all unit tests (can't compile just a single one, compiles all):
    * from main/source: <code>./scons.py -j<number of processors> cat=test</code>
* run single unit test:
    * from main/source: <code>python test/run.py -d <path_to_rosetta_database> -1 <classname></code>
    * if your environment variable <code>$ROSETTA3_DB</code> is defined (type <code>echo $ROSETTA3_DB</code>), you don't need the flag -d
* More information about unit tests and in particular which types of TS_ASSERT messages exist, see https://wiki.rosettacommons.org/index.php/Tools:Unit_Tests

Note: All unit tests run **every time** modifications are made to the master code base

### Integration tests
Integration tests check how your piece of code "integrates" into the rest of Rosetta. While running an integration test, the output of the code BEFORE the change is compared to the output of the code AFTER the change. Since Rosetta developers cannot understand all 3 million lines of code, integration tests only serve to test whether there is an expected change in output or not. They do NOT test whether the functions do what they are supposed to do (this is what unit tests are for) NOR do they tell you whether the output of a protocol is scientifically valid (this is what scientific tests are for).
* https://www.rosettacommons.org/docs/wiki/development_documentation/test/integration-tests
* https://www.rosettacommons.org/docs/wiki/development_documentation/test/Writing-MPI-Integration-Tests

Note: All integration tests run **every time** modifications are made to the master code base

### Scientific tests
Scientific tests (or benchmarks) are required to test whether the output of a protocol is scientifically sound. If you are refining a protocol, you want to make sure that the results you are getting aren't any worse than from the previous implementation of the protocol. Likewise, when you are implementing a new protocol, you want to see how good or bad your results are and how they compare to other methods.
* https://www.rosettacommons.org/docs/wiki/development_documentation/test/Scientific-Benchmarks

Note: Scientific tests are run every two weeks

## Merging code to master
Once you have branched Rosetta, developed your feature and **fully tested** it, you are ready to contribute it to master - the main Rosetta code base. To do so, you have probably already reviewed the Rosetta Git conventions [Rosetta GitHub Practices]( https://www.rosettacommons.org/docs/wiki/internal_documentation/GithubWorkflow) (if not, do so now!). However, this page links to the **required** detailed process for committing code to Rosetta master: [Rosetta Wiki Page: Committing Code](https://wiki.rosettacommons.org/index.php/Committing_code)