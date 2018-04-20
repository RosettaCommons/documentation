<!-- --- title: Pyrosetta Toolkit -->Language: Python/Tkinter

Contact:
--------

Jared Adolf-Bryfogle
 jadolfbr@gmail.com

Intentions
----------

Interactive Modelling, multiprocessing protocols, file export, Rosetta setup, exploration, useful Rosetta functions and analysis. Please feel free to add whatever you feel is useful to users and developers alike. For more information, please refer to the doxygen documentation and paper from the RosettaCon2012 Collection.

Current Code
------------

The PyRosetta Toolkit has not been ported to PyRosetta-4 unfortunately and is only distributed and comparable with PyRosetta-3. 

Use / Tutorial
--------------

**Install PyRosetta.**

Copy the code from pyrosetta/SetPyRosettaEnvironment.sh to your .bashrc (linux) or .bash\_profile (mac). Give the full path where it says PYROSETTA= Source this. Useful to add a shortcut to pyrosetta/ipython.py in your profile.

**Setup PyMOL.**

There is an awesome file you can put in your $HOME directory called .pymolrc . There is a file: [PyMOLPyRosettaServer.py](http://www.pyrosetta.org/pymol_mover-tutorial) . Add this command to your .pymolrc 'run path\_to\_pyrosetta/PyMOLPyRosettaServer.py' This enables the connection to run every time you open PyMOL, and the GUI is heavily integrated to use this awesome PyRosetta feature.

**Run the GUI.**

The GUI code exists both in the rosetta source code at <code>main/source/src/python/bindings/app/pyrosetta_toolkit</code> and in the PyRosetta binary distributions in <code> app/pyrosetta_toolkit</code> If you have sourced SetPyRosettaEnvironment.sh, an alias is created to launch the GUI using the <code>pyrosetta_toolkit</code> command.  

If you have not compiled the PyRosetta bindings from the rosetta source code, please download and use the PyRosetta binaries (recommended if not a Rosetta developer).  Ignore the GUI in the rosetta source as it requires a full PyRosetta compilation.  

If sqlite3 has a problem loading, reinstall python with sqlite3. To do this, usually all you have to do is install sqlite3 and reinstall python. It may be more complex sometimes, so google it, and you'll find a ton of information.

**Load a PDB.**

There are two things you can load right off the bat. A PDB or a PDBLIST. Lets cover the PDB first. Use the file menu to load or fetch a PDB from the RCSB. A PDB setup window will launch. If it's your PDB that you have loaded into Rosetta before, just select the load button. The Clean/Analyze button will attempt to clean your PDB given the options selected and determine if any residues would be unrecognized by Rosetta.

Once the PDB is loaded into PyRosetta, you have a few choices. The output directory is auto set to the directory you loaded the PDB from, and the output name is the name of the PDB. These can be changed using the upper right corner of the main window. Using file-\>export-\>save session you can save this information as well as the PDB loaded for later.

*CODE: toolkit/window\_main/IO/GUIInput.py*

**Check out PYMOL.**

So, lets take a look at the protein first. Open PyMol if you havn't already. Read the main documentation for instructions on how to setup PyMOL to listen for information from PyRosetta. Use the visualization menu to show the pose in pymol. This sends coordinates to PyMOL. If you want to watch different protocols each time the protein is scored, use the PyMOL Observer checkbox. Note that each time the protein is scored, it will create another frame in pymol. This can be used as a snapshot to save anything you model, or any designs you make. The visualization has options to change the behavior of the PyMOL Observer, as well as to color regions as they are added.

*CODE: toolkit/window\_modules/PyMOL*

**REALLY check out PyMOL.**

Click the PyMOL Visualization Window button in the vis menu. Here are a few cool, hopefully useful things. Double click the 'view residue energy' to send energy colors to pymol. Now, explore your protein with the energy components on the right. More options on the left should work as well such as observing all hydrogen bonds.

*CODE: toolkit/window\_modules/PyMOL*

**Set your Options.**

The Options menu allows you to configure a variety of Rosetta specific options through the 'Configure Options System' button, including command-line options such as dun10. There are a few common ones, but use the entry box to add your own, and click add option to change the options for this current session. Click save defaults to have it loaded the next time you load the toolkit.

*CODE: toolkit/window\_modules/options\_system*

**Set your ScoreFunction.**

Once again, in the Options tab, click the ScoreFxn Control button. Here you can change the scorefunction, and also edit individual score terms using the bottom half. Double clicking either the score function or patch sets it for this current session. Double Clicking on a term on the bottom left allows you to change the weight on it, double clicking on a term in the bottom right allows you to change the weight from zero to anything.

Note that this window has it's own menu. You can do a few things, including saving a new scorefunction, or setting a particular score:patch combo as the default. More scorefunctions can be shown by clicking the 'Show ALL scorefunctions' button in the options menu of the scorefunction window. Note that many of these scorefunctions are either undocumented or not used, which is why they are not listed by default. This is currently a project within the Rosetta dev community. The scorefunction you have set will be used by any protocol which uses a scorefunction. talaris2013 is set as the default for now.

*CODE: toolkit/window\_modules/scorefunction*

**Use some Simple Analysis.**

Back to the main window, we have some simple analysis for quickly looking at your pose. On the left, we have some basic analysis options, while on the right are the full suite of RMSD tools. Yay rms\_util!!!

Take a look, score your pose. At loading the pose, the native pose is set. This is NATIVE RMSD. Lets do some loop min.

*CODE: toolkit/window\_main/frames/SimpleAnalysisFrame.py* *CODE: toolkit/modules/tools/analysis.py*

 Note some analysis movers (Interface, PackStat, VIP, Loop) are now available in the advanced tab.

**Set some regions.**

On the left bottom, you can select a region. You have start, end, and chain. All of that pose.pdb\_info().pdb2pose(start, end, chain) happens in the background, so the GUI is made to work specifically with PDB numbering. You can specify a loop, a residue, a chain, and/or a termini. To add - use the add region button. This will go into the listbox on the left. To remove a region, click the remove region button. Region colors can be sent to PyMOL through the Visualization menu tab.

Ok, so how do we specify more then a loop?

Termini - Specify only the end and chain for Nter floppy tail and and beginning and chain for Cter.
 Chain - Specify only the chain.
 Individual Residue - Give the same value for start and end.

*CODE: toolkit/window\_main/frames/InputFrame.py* *CODE: toolkit/modules/Region.py*

**Protocols**

On the bottom right we have some quick protocols. These are meant mostly for modeling, as we all know we need as many processors as possible to do most of our hardcore work. Currently, these are broken down into full protocols and regional protocols. Click the right button to relax the loop. If you want to save the PDB afterward, in the upper right there is a write after protocol button. Clicking this will use the job distributor to write the PDB after the protocol. Now we can use the RMSD analysis to get back info on each loop, total, and an average of all loops.

Note that the chainbreak score is set to 100 for minimization.

 Additionally is the protocols tab in the menu. Here you can specify the number of processors you wish to use, as well as run a few other protocols, and open up a web browser to many different webservers from the Rosetta community.

*CODE: toolkit/window\_main/Frames/QuickProtocolsFrame.py*
 *CODE: toolkit/modules/protocols* *CODE: toolkit/modules/protocols/ProtocolBaseClass.py* *CODE: toolkit/modules/protocols/MinimizationProtocols.py*

**SCWRL**

Since I am in Roland Dunbrack's lab, I integrated SCWRL into the GUI. If you want the MOST accurate packing of sidechains shown in the literature, that's where you would use SCWRL. To get it working in the GUI, cd into the SCWRL directory, go [ [http://dunbrack.fccc.edu/scwrl4/](http://dunbrack.fccc.edu/scwrl4/) here ] to download the specific OS version you need, and install it in the given directory. Now you can use the pack (SCWRL) option to pack your chain, loop, residue, etc. just like you did before. Or, you could output a SCWRL sequence file from the export menu. This is a file with the full sequence of the protein and the residues to be repacked in CAPS.

*CODE: toolkit/SCWRL/*
 *CODE: toolkit/modules/tools/output.py* *CODE: toolkit/modules/protocols/MinimizationProtocols.py*

**Design Window**

Clicking the protein design menu option and then the design file toolbox opens an interactive way to make Resfiles. I find it's much easier to use this then by hand. Specify a residue, and you are given some biochemical values. These are old, but remain heavily used. If you don't know what they are, read about them through the help menu. Once you choose a residue, the first listbox on the left changes. It has info on the conserved residues to make specifying these easier. Exploring the listbox populates the second listbox. Three types are available - individual residues, ALL, and ALL+Self. Double clicking these will populate the last listbox. These are the current residues you have set for design for each residue. Double clicking any residue in the final listbox will remove it from your design. You can click next residue to then modify the next one. Finally, instead of one residue you can specify a region like this 23:42 and then add a residue to the design. All of these will be set. Chains and termini are not currently implemented. You can then save a resfile, clear it, or clear everything for a specific residue. Loading a new pose resets the dictionary of designs.

Adding NCAA's to this window is in the works.

*CODE: toolbox/modules/definitions/restype\_definitions.py*
 *CODE: toolbox/window\_modules/design\_window/resfile\_design.py*

**Full Control Window**

Sometimes, you just want to design single residues, pack single residues, or even modify the dihedral angles of specific residues to make a model, or get something (like a termini) ready for Rosetta. You also may be interested in rotamer probabilities and energies of a particular residue. Here is where this window comes into play. It is located in the Advanced tab of the menu. After specifying a residue, you can first change the dihedrals using the entry box or the slider. No changes are made until you click the delta button. Double clicking a residue type in the middle listbox will mutate that particular residue using one of the PyRosetta convenience functions. On the right, you can then repack the residue, or relax it, or relax that residue and it's neighbors. Note that in this situation, the backrub move would be pretty awesome, and I will be implementing it in the future. You can also observe individual energies terms of the residue by clicking one of the terms in the bottom listbox. This grabs the terms using the ScoreFxn object as before, and IS weighted! This can be useful if your looking for a design that lowers a specific energy term. I know, very specific, but sometimes, just what you need! Clicking the next residue or previous residue will update all energies and probabilities in this window including the energy term set.

You can also add variants to your pose here. Yay phosphorylations!

*CODE: toolbox/window\_modules/full\_control/FullControl.py*
 *CODE: toolbox/window\_module/scorefunction/ScoreFxnControl.py*

**PDBLIST Functions**

Last of the major functions I have had the time to implement are the PDBLIST functions. I do all of my work with PDBLIST of full paths. Makes things easier, and having the full paths means I can work with them in multiple places and multiple scripts. Some users and modelers on the other hand, might not have the knowledge to really work with these or even make one. This is for them, and when I'm feeling a bit lazy, honestly. You can specify a PDBLIST in the input part of the main window. You can also create one in the menu. It will create a file called PDBLIST.txt in the directory specified and set the filenmane as this. Few things you can do now. In the ScoreFxn window, you can rescore all the files and output a file with PATH : SCORE. Next I want to integrate the score filters for users. In the menu, you can output a FASTA file for each PDB, or even for the region specified, which is kinda nice for sequence Logos, etc. You will be able to use calibur in a few weeks, and right now, you can convert all of the PDB's to an SQLITE3 DB. This is basically a way to store a large number of PDB's for analysis, etc. Note that it is not the Rosetta DB structure, it is my own. Will have the option to convert them the Rosetta way in the future. Not sure how to do the conversion in PyRosetta yet.

*CODE: toolbox/modules/tools*
 *CODE: toolbox/modules/calibur.py*
 *CODE: toolbox/modules/PDB.py*

**Rosetta Tools Window**

In the Rosetta Tools window is the GUI that I built, independent of this program and PyRosetta. It has a if \_\_name\_\_=\_\_main\_\_ function, so you can run it by itself if you feel inclined. It's intent was to be an interactive way to create Rosetta options files, since I can't remember names, and I kept forgetting options for the many Rosetta apps that I use. In addition, I wanted a GUI for modellers in my lab to use Rosetta, since for some reason they are a bit scared of the command line. Next, I wanted it to be run on the cluster, so I could quickly set up a Rosetta run at 3 am.
 *Current Implementation:* If you open the window and click the repopulate menu item, there are 4 options. Default option is to load option information and descriptions from doxygen. The second option is a manually curated list of options, descriptions, and documentation. Next option is ALL. This stands for ALL options of each program found in the app directory specified. It runs the -help function of each app, writes a file, and parses that file as neatly as I could. So much information, but sometimes, you want it all. You can return the info for just the specific app selected in the help menu. After repopulating, or even when you open the window, you can choose an app, and the options are listed. Clicking the add\_option, will add that the textbox at the bottom. You can edit this. Clicking showpath builder will allow you to look for files, add names, etc. This options file can be saved/loaded/and run. On the right is the documentation of each app, since I am constantly on rosettacommons re-reading the documentation every time I start using new apps.
 Next, we have the cluster part. This is supposed to be used for all apps, as the ones that don't use JD2 can be frustrating to set up for the cluster. It generally uses Qsub to run on the cluster. If you have MPI, use that instead.

**Help Menu**

Here are a few things and links useful to users and you guys. The license, about functions, etc. If something in the GUI is less then explanatory, please let me know and we can add it to the help menu.

*CODE: toolbox/modules/help.py*

Code Information
----------------

=== Organization: ===

-   */toolkit/pyrosetta\_toolkit.py*
    -   This is the main class responsible for building the window and holding global variables. It adds /toolkit to the python PATH variable. It also sets and shows each piece of the main window. It holds 4 main objects. The pymol\_class, score\_class, input\_class, and output\_class. It also holds access to the fullcontrol\_class, which is the full control window. It also holds a the current pose, but references of this pose are passed around freely.

-   */toolkit/window\_main/*
    -   Currently, all classes in window\_main accept an instance of the toolkit class itself. If this were C++, they would be accepting an access pointer to it!
    -   */toolkit/window\_main/frames* The main window is now made up of 4 Frames. These custom frames inherit from Tkinter 'Frame' class. If you would like to add to the main window, follow the code here.
    -   There are 4 frames: InputFrame (which handles region selection), OutputFrame, SimpleAnalysisFrame and the QuickProtocolsFrame. Each frame deals with building each part of the window. They are not container classes, and should not hold any important variables that the rest of the GUI may hold.
    -   */toolkit/window\_main/IO* There are two classes that reside here: GUIInput and GUIOutput. These classes are almost the lifeblood of the GUI. Instances of these are named input\_class and output\_class respectively and reside in the main toolkit class as mentioned above. They hold variables, classes, and any callback functions. They can also have some functions that require access to many of the GUIs classes or the toolkit itself. These two classes are passed all around the GUI. Functions such as loading a pose, fetching from the RCSB, or loading a Loop file into the region selection InputFrame reside here. These are functions that cannot be placed in toolkit/modules/tools.
    -   */toolkit/window\_main/menu.py* : Here is the main menu for the program. It has some of it's own functions at the bottom.
    -   */toolkit/window\_main/global\_variables.py* : The global variable current\_directory is held here. Any module that imports this file can access and set global\_variables.current\_directory. It's a nice python trick.

-   *toolkit/SCWRL/*
    -   For those of you who use SCWRL, install a copy here to use it during modeling.

-   *toolkit/window\_modules/*
    -   'Here are all the windows that get launched. All are objects with an \_\_init\_\_ function, and a setTk and shoTk function. The setTk functions to create the Tk objects, while the shoTk grids them onto the screen. Keeping these separate keeps code maintenance easier. If you want a new window, put it in here. If it has any other dependencies, help the user set them up, and use try: while importing

-   *toolkit/modules*
    -   Here are classes that are useful to the GUI. T If you have a kick ass class, put it here!
    -   *toolkit/modules/protocols* : Here are the protocols that I have used in the toolkit. Each protocol class inherits from ProtocolBaseClass. To run your protocol, setup the mover and use self.run\_protocol(my\_mover). This will setup the multiprocessing run, read output options from output\_class, and generally run your protocol. New protocols should go here.
    -   *toolkit/modules/tools* : These are mostly functions due to Tk's incessant need for functions instead of TCL/TK where you could write a few lines of code right in the command:lambda function. We'll get to that later. Needless to say, if you want to use Tk, everything needs to be a function. Tools are basically collections of functions used by various classes around the GUI.
    -   *toolkit/modules/definitions* : Here is where you should put any large pieces of information you need to access. I have one file in there for design that defines resfile types as well as all the biochemical info for design.

=== Global Variables ===

-   **How window\_main modules work**
    -   window\_main/IO holds most of the relevant variables. Pass input\_class or output\_class, or specific variables from those around.

-   **Toolkit Variables**
    -   *toolkit.pose* : Here is the pose that is loaded. A reference is passed throughout the GUI.
    -   *toolkit.native\_pose* : This is set upon loading the pose, and is mainly used for RMSD, but can be used for other protocols and analysis as well.
    -   *toolkit.current\_directory* : Here is the directory that is set when loading a pose. Other functions may set it, as it controls the initial directory in a tKFileDialog window.
    -   toolkit.score\_class.score : Here is the current score function that is set. I have a feeling you may need it...
    -   toolkit.pymol\_class : Here is where the lovely PyMOL Observer and PyMOL Mover objects are held as pymol\_class.pyobserver and pymol\_class.pymover respectively. A callback is set to the observe pymol checkbox to add and remove an observer as need be. If you want to control it, pass your class/function this object.

-   **GUIInput Variables**
    -   *input\_class.filename* : Filename of the PDB loaded. Passed to PyMOL and the output main window.
    -   *input\_class.loops\_as\_strings* : This is an array of regions specified in the input part [ 24:42:L, ::A, ] etc.
    -   *input\_class.regions* : This is an instance of the Regions class. This replaces loops as strings for controlling and accessing region-specific information such as movemaps, sequences, taskfactories, etc.

-   -   *input\_class.options\_manager* : This is the options window that pops up. Besides that, it holds currently set options so that they can be re initialised when a protocol is run on multiple processors. If you want to enable a variable permanently, use input\_class.options\_manager.add\_option(option\_string\_with\_-). Otherwise, use rosetta.basic.options.set\_sometype\_option('option', value)

-   **GUIOutput Variables**
    -   *output\_class.outdir* : Directory specified in output section of the GUI. Default is whereever the pose was loaded from.
    -   *output\_class.outname* : Name of Output. JD2 uses this for outputting after a protocol. Variable is actually set in the output part of the main window.
    -   *output\_class.terminal\_output* : Here is the IntVar variable set with a callback that controls the terminal window redirect. 0 for textbox, 1 for terminal.

Tkinter Resources/Overview
--------------------------

=== Resources ===

[Description](http://wiki.python.org/moin/TkInter)

[Start Here](http://www.pythonware.com/library/tkinter/introduction/)

[Nice Tutorial](http://sebsauvage.net/python/gui/)

[Advanced](http://infohost.nmt.edu/tcc/help/pubs/tkinter/)

[Complex. Book. Complete Tkinter guide.](http://www.amazon.com/Python-Tkinter-Programming-Grayson-Ph-D/dp/1884777813)

=== Basic Program ===

=== Useful Functions ===

`      import tkFileDialog     `

`      import tkSimpleDialog     `

`      import tkMessageBox     `

`      filename = tkFileDialog.askopenfilename(title="", message="", initialdir=global_variables.current_directory)     `

`      filename = tkFileDialog.asksaveasfilename()     `

`      my_float = tkSimpleDialog.askfloat(title="float", prompt="Please enter...", initialvalue=10.0)     `

`      my_integer = tkSimpleDialog.askinteger     `

`      my_string =  tkSimpleDialog.askstring     `

`      result = tkMessageBox.askyesno(prompt = "proceed?")     `

=== Tips ===

-   -   Use command:lambda self.my\_func when using buttons or menu items.

-   -   Check if a user hit cancel (Makes result NoneType) after a prompt: `      if not result:return     `

-   -   Set the current\_directory after a user has chosen to save or load something `      global_variables.current_directory=os.path.dirname(just_opened_path)     `

-   -   If using any sort of multiprocessing where random numbers are used, use `      input_class.options_manager.re_init()     ` on each processor to generate a new seed for that particular instance.

Adding to the code
------------------

=== Main Window ===

-   */toolkit/pyrosetta\_toolkit.py*
-   */toolkit/window\_main*
    -   If you want to add another section to the main window, put the file in /window\_main. It should have three main functions, and inherit from the Tkinter Frame class.
        -   **def \_\_init\_\_(self, main, toolkit, \*\*options):**
            -   The default constructor should take a main tk, an instance of the toolkit itself, and \*\*options, which denotes the ability to pass Frame options to the object.
            -   Within the constructor, this needs to be defined: Frame.\_\_init\_\_(self, main, \*\*options)

        -   **create\_GUI\_objects(self):**
            -   Here, you want to initialize your Tk objects. optionMenu's, Buttons, etc. Set any callbacks in the \_\_init\_\_ function. You should pass self instead of self.main in construction of each GUI object

        -   **grid\_GUI\_objects(self)::**
            -   This should grid the window. Note that this grid is independant of the grid in pyrosetta\_toolkit.py This allows you and developers to move the subcomponents of the main\_window around, without changing your design, or doing it manually.

        -   **toolkit.sho\_gui**
            -   Here, you want to call your main window. You can initialize it in any of the \_x functions or add your own. Your create and grid functions should be placed here.

=== Menu Items ===

-   */toolkit/window\_main/menu.py*
    -   Here, we add commands or draw new windows. Surprisingly, this is pretty simple syntax. First, find the menu item you want to add to.
    -   *Adding Commands* : menu.add\_command(label = "Cool function", command = lambda: func) Thats it!

=== Windows ===

-   *Adding Windows* :
    -   *The File:* Add the file(s) to window\_modules. Follow the guide in window\_main, as you should have both a setTk and a shoTk window, but you don't necessarily have to for this one. If you read the book, windows can get pretty complicated, so do whatever you need! window\_modules/rosetta\_tools/RosettaSetup.py has an example of a dialog window if you need it, but the possibilities really are quite awesome.
    -   *The code:* This is a little more complicated. You need to add a function to menu.py which initializes your window (if you havn't in the main toolkit class), and then call your setTk and shoTk functions if you have them. the main should use this syntax: x = Toplevel(self.main). This draws a new window. Set your command, and voila - your new window! Tk can be a pain in the ass, but it is as simple as it gets.

=== Existing Code ===

-   By now, you should have an idea of where to put what, and how to add the majority of things. If you have questions, email me and I can help.

##See Also

* [[PyRosetta]]: The main PyRosetta wiki page
* [[PyRosetta Toolkit GUI]]: Information on the PyRosetta Toolkit user interface
* [[PyMOL]]: More information on PyMOL
* [[Extending the PyMol Viewer]]: How to add new functionality to Rosetta's PyMOL Mover
* [[PyRosetta website (external)|http://www.pyrosetta.org]]
* [[Graphics and GUIs]]: Home page for graphical interfaces with Rosetta