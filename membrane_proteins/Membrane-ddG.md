## Metadata
Questions and comments to: 

 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 3/25/15

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tiley D, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS Computational Biology (under review)

## Code and Demo
The membrane ddG application is packaged with PyRosetta. The released version cab be found in: 
`PyRosetta/app/membrane/predict_ddG.py.`

The developmental version can be found in the Rosetta source code in `source/src/python/bindings/app/membrane/predict_ddG.py`

A demo for this application can be found in `Rosetta/demos/protocol_capture/2015/MPddG`

## Background
Measuring free energy changes upon mutation can inform our understanding of membrane protein stability and variation and is a step toward design. In this application, we predict ddGs by measuring the difference in Rosetta energy for the native and mutated conformation. This application uses a modified version of the all atom energy function for membrane proteins, which includes the fa_elec term and pH energy (see below). The Membrane ddG application is part of the RosettaMP Framework. 

## Algorithm Description
The Membrane ddG application predicts the ddG by taking the difference in Rosetta energy between the native and mutated conformations. Several variations of this protocol are available: 
* **Default:** Predict the ddG, repacking only at the mutated position
* **Include Repacking:** Predict the ddG, repacking residues within a given radius of the mutated position (recommended radius is 8Å by Kellogg et al. 2011)
* **Include pH Calculations:** Use a modified version of the Rosetta energy function that corrects for system pH and electrostatics. This option will load in an additional set of rotamers The default pH is 7.0. Additional information on pH calculations can be found in Kilambi et al. 2013 (ref below). 

## Options
The following options can be used to adjust settings for ∆∆G predictions

**General options**

|**Flag**|**Short Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|--in_pdb|-p|Input PDB file|String|
|--in_span|-s|Input spanfile (transmembrane spanning regions of the protein)|String|
|--out|-o|Output filename for ddG data. ddG predictions referenced by pose numbering. Default: ddG.out|String|
|--res|-r|Pose residue number to mutate|Int|
|--mut|-m|One-letter code of residue identity of the mutant. Example: A181F would be 'F'|Char|
|--output_breakdown|-b|Output ddG score breakdown by weighted energy term into a scorefile. Default: score.sc|String|

**Repacking**

|**Flag**|**Short Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|--repack_radius|-a|Repack the residues within this radius (in Å). Default value is 0Å|Real|

**pH Options**

|**Flag**|**Short Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|--include_pH|-t|Include pH energy terms: e_pH and fa_elec. Default value is false.|Bool|
|--pH_value|-v|pH Value at which to predict ddGs. Default value is pH 7. Must pass -include_pH first|Real|

## Sample Command Lines
Below is a sample commandline using inputs provided in the 2015 MPddG protocol Capture. In this command, all residues are repacked within 8.0Å of the mutated position and calculations are performed at pH 4: 

```
./compute_ddG.py --in_pdb inputs/1qd6_tr.pdb --in_span inputs/1qd6_tr_C.pdb --in_span inputs/1qd6_tr_C.span --res 181 --repack_radius 8.0 --include_pH true --pH_value 4.0 
```

## References
1. Chaudhury S, Lyskov S, Gray JJ (2010) PyRosetta: a script-based interface for implementing molecular modeling algorithms using Rosetta.

2.  Moon CP, Fleming KG (2011) Side-chain hydrophobicity scale derived from transmembrane protein folding into lipid bilayers. Proc Natl Acad Sci. 

3. Kellogg, Elizabeth H., Leaver-Fay A, and Baker D. “Role of Conformational Sampling in Computing Mutation-Induced Changes in Protein Structure and Stability.” Proteins 79, no. 3 (March 2011): 830–38. doi:10.1002/prot.22921.

4. Kilambi, KP, and Gray JJ. “Rapid Calculation of Protein pKa Values Using Rosetta.” Biophysical Journal 103, no. 3 (August 8, 2012): 587–95. doi:10.1016/j.bpj.2012.06.044.

