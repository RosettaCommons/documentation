# Using RosettaScripts with VSCode

Documentation added 12 December 2020 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).
Back to [[RosettaScripts]].

## Using RosettaScripts with VSCode

The [[Visual Studio Code]](https://code.visualstudio.com/) editor can be a convenient tool for editing RosettaScripts XML.  This document shows how to enable auto-completion and mouse-over help in VSCode.

[[_TOC_]]

## Setup

Follow the following four steps:

1.  Install [[VSCode]](https://code.visualstudio.com/).
2.  Open VSCode, and from the **View** menu, select **Extensions**.  Type "XSD" in the search dialogue, and select **Xml Complete**.  Click **Install**.
3.  Export a RosettaScripts XSD file (a file defining all the allowed commands and syntax in RosettaScripts) from RosettaScripts.  To do this, from the commandline run `<path to Rosetta>/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease -output_schema rosettascripts.xsd`.  Replace `<path to Rosetta>` with your Rostta path, and `.default.linuxgccrelease` with your build, operating system, compiler, and mode (_e.g._ `cxx11thread.maxcosclangrelease` for the threaded build on MacOS).  This command will run the RosettaScripts application, which will write out an XSD file and then exit.  Place this XSD file someplace convenient.  (Note that Rosetta [[must be compiled first|Build-Documentation]].)
4.  Open a RosettaScripts XML file in VSCode.  (You can create a new, empty RosettaScripts XML file by running the RosettaScripts application with no options and cutting-and-pasting from the output into VSCode.)  Add the following lines to the top of your XML file:

```xml
<root
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:noNamespaceSchemaLocation="<path to file>/rosettascripts.xsd"
/>
```

In the above, replace `<path to file>` with the path to the file relative to the RosettaScripts xml file.

And that's it!  Steps 1 and 2 only need be done once.  Step 3 need only be done when you compile a new version of Rosetta.  Step 4 needs to be done for each XML file that you work with, and unfortunately, the added `<root ... />` lines need to be commented out (flanked with `<!--` and `-->`) before running the script.  This will likely be addressed in the near future so that Rosetta just disregards these extra lines.  In the mean time, one can comment and uncomment these lines easily in VSCode by selecting them and pressing `Ctrl + /` on a PC, or `Command + /` on a Mac.

# See also
*  [[RosettaScripts]]
*  [[Compiling Rosetta|Build-Documentation]].