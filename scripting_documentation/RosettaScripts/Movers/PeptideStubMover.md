# PeptideStubMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PeptideStubMover

PeptideStubMover is a convenient method for modifying a pose or building a new pose from scratch. One can append, prepend, or insert residues to a pose.

<b>Usage cases</b>

`PeptideStubMover` is useful for following scenarios:

-	Given a structure, one wants to covalently connect new residues before or after a certain residue (anchor residue) in the pose. The connection mode can be a common peptide bond or other types of covalent linkages accepted by the anchor residue).
-	Given a structure, one wants to insert new residues after a certain residue (anchor residue).
-	One wants to generate a peptide with known length with a desired amino acid sequence from scratch.

PeptideStubMover is usually used as a starting point in the grand scheme of a larger problem, particularly for incorporating select modifications into a pose or designing peptides from scratch.

<b>Inputs and Outputs</b>

Depending on the specific usage, `PeptideStubMover` can take a pose as an input or a dummy file (make sure that the dummy file is not completely blank). It will generate as output a new pose with new residues added in the places requested. The residue numbering will be modified during the process.

<b>Detailed workflow<b>

The PeptideStubMover has a general setting as follows:

```
<PeptideStubMover name="&string" reset="(false &bool)">
        <Prepend resname="(&string)" anchor_rsd="residuenumber"  repeat="(1 &number")/>
	<Append resname="(&string)" repeat=(&number) jump="(false &bool)"  anchor_rsd=”residuenumber” connecting_atom=”atom type” />
	<Insert resname="(&string)" repeat="(1 &number)"/>
 </PeptideStubMover>
```

name—what is the name you want to call the mover with. 
Reset—whether to discard the pose information or not. Default is set false. If reset is set to true, all the information about the pose is cleared as well as the pose. 

The PeptideStubMover has three modes, which will be described in more details later: Append, prepend, insert. At least one mode should be set during the process.

<i>Append options</i>:

Append=add residue AFTER an anchor residue.

Resname—what type of residue you want to add. Any residue that is defined in the fa_standard can be used. Should be defined by the user.

Jump—it is by default set to false. If set to true, the new residue is added by a jump and not a covalent bond. Notice that if there is no residue in the pose (i.e. when you make a pose from scratch), the first residue is always added with a jump. Note that if repeat is mentioned with the jump, only the first residue is added by a jump and the residues after that are added by normal covalent bonds. Jump can only work in the append mode.

Anchor_rsd—can define which residue to use as an anchor to add the new residue to. In terms of a new peptide bond, this will the residue at the C-terminal residue. If not mentioned, it adds by default to the C-terminal residue in the pose.

Connecting_atom—which atom to use for the connection. If not mentioned, the default is to use the LOWR_CONNECT atom specified in the “.params” file of the anchor residue.

Repeat—by default is set to 1. If more than one is mentioned, keeps adding the same residue to the anchor residue. For example, the command line below will add 3 D-Ser to the C-terminal of the peptide with a common peptide bond.

```
<Append resname="DSER" repeat="3"/>
```

*  If you’re building a pose from scratch, append is the only mode that will work for the first residue. And by default the first residue of the pose is always added as a jump (nothing to bond it to!).

<i>Prepend options</i>:

Prepend= Add residue BEFORE an anchor residue

Resname—what type of residue you want to add. Any residue that is defined in the fa_standard can be used. Should be defined by the user.

Anchor_rsd—can define which residue to use as an anchor to add the new residue to. If not mentioned, it adds by default to the C-terminal residue in the pose.

Connecting_atom—which atom to use for the connection. If not mentioned, the default is to use the UPPER_CONNECT atom specified in the “.params” file of the anchor residue.

Repeat—by default is set to 1. If more than one is mentioned, keeps adding the same residue to the anchor residue. For example, the command line below will add 2 L-Trp to the N-terminal of the peptide with a common peptide bond.

```
<Prepend resname="TRP" repeat="2"/>
```

<i>Insert options</i>:

Insert=insert a residue after an anchor residue in a pose.

Resname—what type of residue you want to add. Any residue that is defined in the fa_standard can be used. Should be defined by the user.

Anchor_rsd—can define which residue to use as an anchor to add the new residue to. In terms of a new peptide bond, this will the residue at the C-terminal residue. If not mentioned, it adds by default to the C-terminal residue in the pose.

Connecting_atom—which atom to use for the connection. If not mentioned, the default is to use the LOWR_CONNECT atom specified in the “.params” file of the anchor residue.

Repeat—by default is set to 1. If more than one is mentioned, keeps adding the same residue to the anchor residue. Only works for insert if the position is not set.

Position—where we want the new residue index to be. if not mentioned, insert works similar as append.
