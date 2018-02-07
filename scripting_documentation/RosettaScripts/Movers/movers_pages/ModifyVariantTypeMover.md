# ModifyVariantType
Last updated 6 April 2017 by Vikram K. Mulligan (vmullig@uw.edu).<br/>
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ModifyVariantType

Add or remove variant types on specified residues.

```xml
<ModifyVariantType name="[name]" add_type="[type[,type]...]" remove_type="[type[,type...]]" residue_selector="(&string)" update_polymer_bond_dependent_atoms="(&bool,false)" />
```

Adds (if missing) or removes (if currently added) [[variant types|Glossary#variant-types]] to the residues specified in the given task operations. Use a [[ResidueSelector|ResidueSelectors]] to select specific residues.  Optionally, the positions of atoms that are dependent on polymeric connections (_e.g._ the amide proton, the carbonyl oxygen, the N-methyl group in N-methylated amino acids, _etc._) may be updated after modifying the variant type (`update_polymer_bond_dependent_atoms="true"`).

## Example

The following script adds the C-terminal amidation variant type to an 18-residue peptide imported from a PDB file.  (It would have to be run with the ```-in:file:s``` commandline option to specify the PDB file.)

```xml
<ROSETTASCRIPTS>
	<RESIDUE_SELECTORS>
		<Index name="select_cterm" resnums="18" />
	</RESIDUE_SELECTORS>	
	<MOVERS>
		<ModifyVariantType name="vartype" add_type="CTERM_AMIDATION" residue_selector="select_cterm" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover="vartype" />
	</PROTOCOLS>
</ROSETTASCRIPTS>

```

##See Also

* [[I want to do x]]: Guide to choosing a mover

