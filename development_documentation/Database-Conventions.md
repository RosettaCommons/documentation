#Database Conventions

[[_TOC_]]

##Adding Files/Data to the Rosetta Database
Updates to files in the database and additions of new files should have information regarding the data added with it.  This can either be in the form of a comment in the file, or an accompanying notes.txt file.  The metadata should address the following:

* How the file was generated.
* Where the data originated.
* What the file is for.
* What format the file has (columns/rows/etc).

##Adding ScoreFunction Weights and Patches to the Rosetta Database
New weights and patches should include comments of the following format.  All information should include # at the beginning of the line.  If you come across one that does not have this information, and you know it, please add it!  For a more detailed description, see the page on adding a [[new energy method]]

* #@reference: List any references associated with or describing the scorefunction.

* #@author:  List your contact information.

* #@purpose: Give a general purpose of the scorefunction/patch.  Generally answer the question, 'Why is it here?'.  
When will it be beneficial to use it? For patches, which scorefunctions should it patch?

* #@applications: If it is not a general scorefunction, list any applications the scorefunction was designed for.

* #@limitations: Describe where/when the scorefunction is not recommended and why. 
Describe any molecular systems (DNA/polymers/ligands) it will not work or work well for. 
State if it is experimental and not for general use. 
State if it is for centroid-only poses if not given in filename.

* #@tips: Include any tips that would be useful to a developer or user. 
Examples: Does the scorefunction require a specific option (-add_orbitals)?  Does it require an external dependency? Should an EnergyMethodOption be used with it? 

###Extra Information:
Here is some extra information that may be useful to include.
* #@optimization: Has the scorefunction been optimized?  How?

* #@updates: Has the scorefunction and/or weights been updated?  Why?

##See Also

* [[Database]]: The Rosetta database
* [[Development tutorials|devel-tutorials]]
* [[Database IO]]: Using Rosetta with SQL databases (not the Rosetta database)
* [[Development documentation]]
