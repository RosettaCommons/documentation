# SSMotifFinder
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SSMotifFinder

Filter loops based on the similarity of their stems' backbone geometry to the stems of a template loop. The filter searches for pairs amino acids separated by a certain number of amino acids on the primary sequence that furthermore superimpose the backbone atoms of the template loop stems within some rmsd cutoff. The rmsd calculation are performed on the backbone heavy atoms (N, Cα, C, O) of the stem residues and the preceding and succeeding residues (6 residues in all on each loop). The output is a file containing a list of all the pairs of stems that superimposed the template stems within a specified rmsd cutoff, and the calculated rmsd.

See implementation in: Netzer R, Fleishman SJ _et al_. **Ultrahigh specificity in a network of computationally designed protein-interaction pairs.** _Nature Communications_ (2018).  

```xml
<SSMotifFinder name="(&string)" template_pose="(&string)" template_stem1="(0 &string)" template_stem2="(0 &string)" from_res="(0 &non_negative_integer)" to_res="(0 &non_negative_integer)" rmsd="(0.0 &real)" filename="(&string)" pdbname="(&string)"/>
```

-   template_pose: The pose which contains the loop of interest ("template loop")
-   template_stem1: The N' terminal stem of the template loop (pdb number, e.g. 22A) 
-   template_stem2: The N' terminal stem of the template loop (pdb number, e.g. 36A)
-   from_res: The minimal sequence separation between the stems of the tested loop (which correspond to the loop length)  
-   to_res: The maximal sequence separation between the stems of the tested loop (which correspond to the loop length) 
-   rmsd: The root mean square deviation between the stems of the tested loop and those of the template loop. 
-   filename: The name of the output file containing the list of matching loop conformations
-   pdbname: The name of the pdb in which the matching conformations were found (the input structure for Rosetta in -s)