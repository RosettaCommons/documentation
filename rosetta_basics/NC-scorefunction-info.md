#Scorefunctions that work well with protein and non-protein residues and molecules

With the addition of the [[talaris2013 scorefunction | score-types]] as the default Rosetta scorefunction, most non-protein residues and molecules can be scored, however other scorefunctions exist that work well with protein and non-protein residues and molecules.

[[_TOC_]]

## MM Standard Scorefunction
Creator Names:
* P. Douglas Renfrew (doug.renfrew@gmail.com)
* Bonneau Lab

Description:
* Developed to score non-canonical alpha-amino acid side chains, and used in the generation of rotamer libraries for NCAA
* Currently being used to score peptoids, and oligo-oxypiperizines (OOPs), and hydogen-bond surrogets (HBSs)
* Removes knowledge-based terms that are evaluated based on residue type identity

* *  *fa_dun*, *rama*, *pair*, *ref*
* Adds a MM torsion and MM Lennard-Jones terms that are evaluated **intra**-residue

* *  *mm_intra_lj_rep*, *mm_intra_lj_atr*, *mm_twist*
* Adds an explicit unfolded state energy term based on pdb fragments

* *  *unfolded*

Preliminary Results:
* Testing done in [Renfrew et. al., PLOS ONE 2012](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0032637)

* * rotamer libraries produced are comparable to dun02
* * rotamer recovery is comparable to score12
* * sequence recovery not as good as score12
* * 5 peptides were designed to target the calpain/calpastatin interface that had disassociation constants (Kd) less than or equal to the wild type peptide fragment
* Testing done in [Drew et. al., PLOS ONE 2013](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0067051)
* * Designed ROSIE servers to work with non-canonical backbones (NCBBs)
* Used to design 9 OOPs against he P53/MDM2 interface (Kevin Drew, to be published soon)
* * 4 OOPs had nM Kd and 4 had uM Kd and 1 did not bind

Caveats:
* Has not received as much testing as score12
* No long-range electrostatics
* Formulation of unfolded energy under-estimates the attractive component of energy function which lead to the over incorporation of large side chains

How to use:
* Flags (assuming protocol respects command-line options)
<pre>
 -score::weights mm_std
</pre>
* Weight set
 <code>mm_std.wts</code>

##Partial Covalent Interactions Energy Function (Orbitals)
Creator Names:
* Steven Combs (steven.combs1@gmail.com)
* Meiler Lab

Description:
* Developed to score salt bridges, cation-pi, pi-pi, and hbonds more accurately
* Not typed on residue types, but on orbital types associated with atoms. Allows for extensibility to ligands and non-canonical amino acids

Preliminary Results:
* Performs as well as talaris2013 in design.
* Improves geometry of saltbridges, cation-pi, pi-pi, and hbond interactions at the acceptor/donor interface
* Works for all residuetypes (ligands, DNA, RNA) because it is typed on orbitals
* Recapitulates average number of hbonds, salt bridges, cation-pi, pi-pi interactions better than talaris2013

Caveats: 
* Slightly slower than talaris2013
* Just changed the names of all the scoreterms so that they match those in the soon to be published paper
* Adjustment of individual terms (cation_pi, pi_pi, hbond, salt_bridge) is now easier by directly manipulating the respective term (pci_cation_pi, pci_pi_pi, pci_hbond, pci_salt_bridge)
* Still uses the hbond backbone-backbone scfxn to score backbone-backbone interactions

How to Use:
* Flags (assuming protocol respects command-line options)
<pre>
 -score::weights orbitals_talaris2013
 -add_orbitals
 -output_orbitals (optional. Outputs the orbitals in the pdb file)
</pre>
* Weight Set

 <code>orbitals.wts </code>(for pre-talaris2013 defaults), <code>orbitals_talaris2013.wts</code>, <code>orbitals_talaris2013_softrep.wts</code> (analogous to soft_rep/soft_rep_design scorefunction but not rigorously tested)
  