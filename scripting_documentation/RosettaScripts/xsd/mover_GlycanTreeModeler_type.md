<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
Brief: A protocol for optimizing glycan trees using the GlycanSampler by  computationally growing glycans from the roots out to the trees.

It is recommended to use this modeling algorithm in conjunction with the -beta scorefunction,  as this was shown to work best for modeling glycans.
QUECHING

By default, we model all glycans simultaneously.  First, all glycan roots (the start of the tree), and slowly unvirtualize 
all glycan residues, while only modeling each layer. 
Alternatively, we can choose a particular glycan tree, run the algorithm,  and then choose another glycan tree randomly until all 
glycan trees have been optimized. 
Here, we call this quenching. 

GLYCAN LAYERS 

Draw a tree on a paper.  We start with the beginning N residues, and work our way out towards the leaves. 
Layers are defined by the glycan residue distance to the rooot.   This enables branching residues to be considered the same 
layer conceptually and computationally, and allows them to be modeled together. 

--Residue Selection-- 

 You do not need a ResidueSelector passed in.  It will select all glycan residues automatically.
 However, if you do, you must only pass in glycan residues.   See the GlycanResidueSelector and the GlycanLayerSelector  for a very easy way to select specific glycan trees and residues. 

References and author information for the GlycanTreeModeler mover:

GlycanTreeModeler Mover's author(s):
Jared Adolf-Bryfogle, Institute for Protein Innovation (IPI), Boston, MA [jadolfbr@gmail.com]

```xml
<GlycanTreeModeler name="(&string;)" refine="(false &bool;)"
        glycan_sampler_rounds="(100 &non_negative_integer;)"
        quench_mode="(false &bool;)" layer_size="(&non_negative_integer;)"
        window_size="(&non_negative_integer;)" rounds="(&non_negative_integer;)"
        use_conformer_probs="(false &bool;)"
        use_gaussian_sampling="(true &bool;)"
        force_virts_for_refinement="(false &bool;)" idealize="(false &bool;)"
        final_min_pack_min="(true &bool;)" min_rings="(false &bool;)"
        cartmin="(false &bool;)" hybrid_protocol="(true &bool;)"
        shear="(true &bool;)" match_window_one="(true &bool;)"
        root_populations_only="(false &bool;)" kt="(&real;)"
        residue_selector="(&string;)" scorefxn="(&string;)" />
```

-   **refine**: Do a refinement instead of a denovo model. This means NO randomization at the start of the protocol and modeling is done  in the context of the full glycan tree instead of using virtual (non-scored) residues during tree growth
-   **glycan_sampler_rounds**: Round Number for the internal the GlycanSampler.   Default is the default of the GlycanSampler.
-   **quench_mode**: Do quench mode for each glycan tree? Quench means model each individual glycan tree instead of all at once.
-   **layer_size**: Brief: Set the layer size we will be using.  A layer is a set of glycan residues that we will be optimizing.
  Current benchmarked protocol is set to 1.  Only change this for benchmarking.
-   **window_size**: Brief: Set the window size.  This is the overlap of the layers during modeling. 
 Current benchmarked protocol is set to 0.  Only change this for benchmarking.
-   **rounds**: Current protocol is set to 1.  Rounds currently are directional, with every even round going backward.  Only change this for benchmarking.
-   **use_conformer_probs**: Use conformer probabilities instead of doing uniform sampling
-   **use_gaussian_sampling**: Set whether to build conformer torsions using a gaussian of the angle or through uniform sampling up to 1 SD (default)
-   **force_virts_for_refinement**: Refinement now models layersin the context of the full glycan tree.
 Turn this option on to use non-scored residues (virtuals) at the ends of the tree that are not being modeled.
  This is how the de-novo protocol works.
-   **idealize**: Attempt to idealize the bond lengths/angles of glycan residues being modeled
-   **final_min_pack_min**: Do a final set of cycles of min/pack
-   **min_rings**: Minimize Carbohydrate Rings during minimization.
-   **cartmin**: Use Cartesian Minimization instead of Dihedral Minimization during packing steps.
-   **hybrid_protocol**: Set to use a protocol where we build out the glycans, but re-model the full tree during the building process
-   **shear**: Use the Shear Mover that is now compatible with glycans at an a probability of 10 percent
-   **match_window_one**: Matches the number of rounds per layer with that of using a window of 1.  This is how all protocols were benchmarked.  Leave this on.
-   **root_populations_only**: Use population-based sampling for only the linkage between the amino acid and glycan residue. Sounds nice, benchmarking showed this is only good for common glycans
-   **kt**: Override the GlycanSampler kT (which defaults to 2.0)
-   **residue_selector**: Residue Selector containing only glycan residues.  This is not needed, as this class will automatically select ALL glycan residues in the pose to model.   See the GlycanResidueSelector and the GlycanLayerSelector for control glycan selection.   Note that the ASN is not technically a glycan.  Since dihedral angles are defined for a sugar from the upper to lower residue, the dihedral angles between the first glycan and the ASN are defined by the first glycan. . The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **scorefxn**: Name of score function to use

---
