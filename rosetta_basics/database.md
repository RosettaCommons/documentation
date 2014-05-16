<!-- --- title: Database -->

The Rosetta database contains important data files used by Rosetta during runs (for example, the definitions of what atoms are in alanine, or what the Lennard-Jones radii are).

You have to specify the path to this database directory in the command line to run Rosetta simulations. For example: <code> rosetta.linuxgccrelease -database mypath/rosetta\_database other\_flags </code>.  

Rosetta will also automatically check the $ROSETTA3_DB environment variable.  If this is present, the <code> -database </code> option need not be set. To set it temporarily in your shell session: <code> ROSETTA3_DB=path_to_rosetta_db </code>.  Set the variable in your shell's user settings file, such as <code> $HOME/.bashrc </code> for linux and <code> $HOME/.bash_profile </code> for mac, using the default bash shell
