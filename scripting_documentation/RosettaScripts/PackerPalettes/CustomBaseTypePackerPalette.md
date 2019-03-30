#CustomBaseTypePackerPalette

##Page history

`CustomBaseTypePackerPalette` documentation created by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 20 February 2019.

###Description

A `PackerPalette` permitting design with the canonical 20 amino acids plus a user-specified list of other base types.

##RosettaScripts Details
[[include:packer_palette_CustomBaseTypePackerPalette_type]]

##Example

The following example creates a palette that allows both L- and D-amino acids (and GLY), then uses the [[Phi ResidueSelector|PhiSelector]] to restrict design to L-amino acids at positions in the negative-phi region of Ramachandran space, and to D-amino acids at positions in the positive-phi region of Ramachandran space:

```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="r15" weights="ref2015.wts"/>
    </SCOREFXNS>
    <PACKER_PALETTES>
        <CustomBaseTypePackerPalette name="palette" additional_residue_types="DALA,DCYS,DASP,DGLU,DPHE,DHIS,DILE,DLYS,DLEU,DMET,DASN,DPRO,DGLN,DARG,DSER,DTHR,DVAL,DTRP,DTYR" />
    </PACKER_PALETTES>
    <RESIDUE_SELECTORS>
        <Phi name="posPhi" select_positive_phi="true" ignore_unconnected_upper="false" />
        <Not name="negPhi" selector="select_positive_phi" />
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
          <ReadResfile name="l_res" filename="inputs/l_res.txt" selector="negPhi"/>
          <ReadResfile name="d_res" filename="inputs/d_res.txt" selector="posPhi"/>
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="packer" scorefxn="r15" task_operations="l_res,d_res" packer_palette="palette" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover="terminal_bond1"/>
        <Add mover="terminal_bond2"/>
        <Add mover="packer"/>
    </PROTOCOLS>
    <OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>
```

The resfile `l_res.txt` would look like this:

```
PIKAA ACDEFHIKLMNPQRSTVWY
start
```

And the resfile `d_res.txt` would look like this:

```
PIKAA X[DALA]X[DCYS]X[DASP]X[DGLU]X[DPHE]X[DHIS]X[DILE]X[DLYS]X[DLEU]X[DMET]X[DASN]X[DPRO]X[DGLN]X[DARG]X[DSER]X[DTHR]X[DVAL]X[DTRP]X[DTYR]
```

##See also

* [[PackerPalettes|PackerPalette]]
* [[DefaultPackerPalette]]
* [[NoDesignPackerPalette]]
