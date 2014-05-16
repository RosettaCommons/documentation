#The Rosetta Database

The Rosetta database contains important data files used by Rosetta during runs (for example, the definitions of what atoms are in alanine, or what the Lennard-Jones radii are).

#Set for a single Rosetta run:



You have to specify the path to this database directory in the command line to run Rosetta simulations. For example: 
* <code>rosetta.linuxgccrelease -database mypath/rosetta\_database other\_flags</code>


#Set for multiple Rosetta runs:

Rosetta will also automatically check the <code>$ROSETTA3_DB</code> environment variable.  If this is present, the <code>-database</code> option need not be set. To set it temporarily in your shell session: 

* <code>ROSETTA3_DB=path_to_rosetta_db</code>

Set the variable in your shell's user settings file, such as for the default shell bash: <code>$HOME/.bashrc</code> for linux and <code>$HOME/.bash_profile</code> for mac.
