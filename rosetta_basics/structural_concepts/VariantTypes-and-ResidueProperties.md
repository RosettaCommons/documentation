#Grouping ResidueTypes based on chemically meaningful traits

There are two classes in Rosetta used to categorize [[ResidueTypes|ResidueType]] based on similar chemical properties.
In each case, the goal is essentially the same: it is important to treat all ResidueTypes with a particular trait the same way, and it is immensely more important to determine whether that ResidueType has the trait by looking up that factual matter in the params file rather than to compute it on the fly.
For example, what ResidueTypes are aliphatic?
You could count sidechain atoms and ensure that every one is sp<sup>3</sup> hybridized and a carbon atom, which would be a sufficient condition.
But instead, particularly for general cases, it is much more efficient to simply keep a vector of ResidueProperties in the params file: thus, serine is POLAR and PROTEIN and ALPHA_AA and can thereby be distinguished from leucine and beta-serine and glucose.

Thus, ResidueProperties describe what is intrinsically true about a residue; it is rarely alterable.
(Occasional patches remove or add a property.)
In contrast, VariantTypes essentially encode the relationship that a patched residue has to its parent residue. For example, a CYS:disulfide has the DISULFIDE variant type because it, unlike CYS, is deprotonated and forms a disulfide bond.
Generally, if you are manually mutating a residue, you will want to maintain the variant types from the original residue where possible.

## The words of a wise Rosetta scholar, first of his name, Anonymous, (also known as Labonte): 

Properties:
-	A property should be used for the following purposes:
	- To designate whether the residue in question is an actual polymeric residueor a ligand, e.g., POLYMER, LIGAND
	- To designate to which chemical classification/family the residue belongs, e.g., PROTEIN, RNA
	- To designate a global chemical property of the molecule/residue, e.g., POLAR, CHARGED
	- To designate that a residue has been modified at a particular position, (but NOT what that modification is,) e.g., OG_MODIFIED, C1_MODIFIED
-	Do not combine properties that are distinct:  CHARGED and PROTEIN are preferred properties; CHARGED_PROTEIN would not be.
-       DO combine properties if they ARE intrinsically related:  L_AA is preferred over L_STEREOCHEMISTRY and AMINO_ACID, because L-stereochemistry is only defined as a convention in the context of amino acids (as opposed to the R/S nomenclature that can be more universally applied, but which results in cysteine being classified differently from the other amino acids).
-	Properties should be named as nouns if a family designation or adjectives if a chemical property, e.g., PEPTOID vs. AROMATIC.

Variants:
-	 A variant should be used to designate a specific variation/modification of a base residue, specifying the location if necessary, e.g., LOWER_TERMINUS, OG_PHOSPHORYLATED, C1_PHOSPHORYLATED
-	 Variants are NOT directly synonymous with patches:
	- It is possible for several patch files to be of the same variant. For example, the way to make a LOWER_TERMINUS variant of an AA residue is very different from how one makes a LOWER_TERMINUS of an NA residue.
	- It should NOT be possible for a single base residue to have more than one patch file specifying the same variant type!

