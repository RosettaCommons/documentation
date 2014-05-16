<!-- --- title: Database -->

The Rosetta database contains important data files used by Rosetta during runs (for example, the definitions of what atoms are in alanine, or what the Lennard-Jones radii are).

You have to specify the path to this database directory in the command line to run Rosetta simulations. For example: rosetta.linuxgccrelease -database mypath/rosetta\_database other\_flags.  Rosetta will also automatically check the $ROSETTA3_DB environment variable.  If this is present, the -database option need not be set.
