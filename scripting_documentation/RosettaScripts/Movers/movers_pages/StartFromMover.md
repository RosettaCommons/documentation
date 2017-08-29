# StartFrom
*Back to [[Mover|Movers-RosettaScripts]] page.*
## StartFrom

```
<StartFrom name="(&string)" chain="(&string)" use_nbr="(0 &bool)" >
   <Coordinates x="(&float)" y="(&float)" z="(&float)" pdb_tag="('' &string)"/>
   <File filename="(&string)" />
   <PDB filename="(&string)" atom_name="('' &string)" pdb_tag="('' &string)" />
</StartFrom>
```

The StartFrom mover moves a chain (normally a ligand) to a specified coordinate. This is used to place the docked ligand at a position different from the input PDB. If multiple coordinates are specified, the starting coordinate is chosen at random. By default the centroid of the specified chain (the average position of all atoms/residues) is centered on the given coordinate. If the "use_nbr" flag is set, then it is the neighbor atom (the atom which is superimposed during conformer repacking) which is placed at the given location. Setting use_nbr implies that the given chain consists of a single residue.

Coordinates can be specified by one or more subtags. Multiple subtags of different types can be specified simultaneously - the set of possible coordinates is a combination of the coordinates from all the subtags. 

Each subtag has the ability to take an optional structure specifier (pdb_tag, file_name, or hash). If a structure matches a given structure specifier, then only coordinates for that structure specifier are considered. If a structure does not match any of the provided structure specifiers, then the default coordinates (those specified without a structure specifier) are used instead. 

*Coordinates subtag*

Each tag contains an XYZ coordinate position which will be added to the set of valid coordinates.

*File subtag*

Provide a JSON formatted file containing starting positions. This is useful if you are docking ligands into a large number of protein structures. <!--- BEGIN_INTERNAL --> The application generate\_ligand\_start\_position\_file will generate these JSON files.<!--- END_INTERNAL --> The file is of the format:

        [
            {
                "file_name" : "infile.pdb",
                "x" : 0.0020,
                "y" : -0.004,
                "z" : 0.0020,
                "hash" : 14518543732039167129
            }
        ]

Both "file_name" and "hash" are optional. If both are present, the "file_name" entry is ignored.

"hash" is a hashed representation of the without-ligand structure. At present, Boost hashing of floats is extremely build and platform dependent. You should not consider these hash values to be at all portable. This will be addressed in the future.

*PDB subtag*

The starting coordinates are provided as the heavy atom positions in a PDB file. By default all heavy atom positions are used. If atom_name is given, then only the positions of atoms matching that atom name are used. Note that the standard Rosetta PDB loading mechanism is bypassed, so you do not need params files, etc. for all the residues/atoms in the provided file. (Although all residue numbers/atom name combinations should be unique.)

One easy way to generate this file is graphically. If you load up your starting structure into PyMol along with a PDB containing waters (which could be the same structure), you can use the "3-Button Editing" or "2-Button Editing" Mouse modes. While holding the Ctrl key (command on Mac), you can Left Click/Drag to move individual water oxygens around to the starting positions you're interested in. Switch back to Viewing mode, select the individual atoms you moved, and then File->Save Molecule and save that selection (just the individual water molecules) as a new PDB file. -- Other structure viewing programs likely have similar capabilities. Consult the manual for details. 

Note: The PDB should only contain the atoms which describe the starting points. It should *not* contain any context residues (e.g. any of the receptor protein residues, or ligand atoms which aren't defining the putative center of the binding pocket.)


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[AddChainMover]]
* [[AddChainBreakMover]]
* [[AlignChainMover]]
* [[BridgeChainsMover]]
* [[SwitchChainOrderMover]]
