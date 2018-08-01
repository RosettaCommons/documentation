# InterfaceHydrophobicResidueContacts

Documentation last updated on 1 August 2018 by Brian Coventry (bcov@uw.edu).

*Back to [[Filters|Filters-RosettaScripts]] page.*
## InterfaceHydrophobicResidueContacts

Filters structures based on the number of hydrophobic residues on the target that have at least a certain hydrophobic ddG.

```xml
<InterfaceHydrophobicResidueContacts name="(&string)" target_selector="(&string)" binder_selector="(&string)" scorefxn="(&string)" threshold="(5 &int)" score_cut="(-0.5 &Real)" apolar_res="(ALA,CYS,CYD,PHE,ILE,LEU,MET,PRO,THR,VAL,TRP,TYR &string)" />
```

-   target\_selector: Required. Which residues should be counted as hydrophobic target residues?
-   binder\_selector: Required. Which residues are part of the binder so that the interface can be defined?
-   scorefxn: Required. Which scorefunction do you want to use? Only fa_rep, fa_sol, and fa_atr will be kept. (Soft score functions like ref2015_soft often work well too)
-   threshold: How many hydrophobic residues should have at least the score cutoff?
-   score\_cut: What score cut should be used to determine whether a hydrophobic residue is contacted? (A note here. This is the energy from the pose.energies() object; therefore the actual ddG of the residue may be twice as big as what is typed here because pose.energies() only contains half of the interaction energy.)
-   apolar\_res: What residues should count as hydrophobic residues (comma separated name3 list)?

This mover looks for designs that make the most use of the target, with the hypothesis being that binders that use more of the hydrophobic residues on the target are better binders. Be careful with your target selector though! If you select extraneous hydrophobic residues, designs with the highest InterfaceHydrophobicResidueContacts will all contact those residues!

