# IsoelectricPointMetric
*Back to [[SimpleMetrics]] page.*
## IsoelectricPointMetric

Author: Sharon Guffy (sharonguffy@gmail.com)

The IsoelectricPointMetric is used to predict the isoelectric point of a protein based on its sequence using one of several available algorithms. Note that this metric is not currently compatible with noncanonical amino acids or non-protein molecules.
Available algorithms:

* IPC_protein
  * Citation: Lukasz P. Kozlowski. IPC – Isoelectric Point Calculator. Biol Direct. 2016; 11: 55.
  * Website: [[http://isoelectric.org]]
  * Notes: Optimized for proteins. Benchmarks indicate that it outperforms most other algorithms including those available via IsoelectricPointMetric.
* IPC_peptide
  * Citation: Lukasz P. Kozlowski. IPC – Isoelectric Point Calculator. Biol Direct. 2016; 11: 55.
  * Website: [[http://isoelectric.org]]
  * Notes: Optimized for small peptides.
* Nozaki_Tanford
  * Citation: Nozaki Y, Tanford C. The solubility of amino acids and two glycine peptides in aqueous ethanol and dioxane solutions: establishment of a hydrophobicity scale. J Biol Chem. 1971;246(7):2211–2217.
  * Notes: pKa values based on pKa of side chain groups in model compounds similar to the amino acids
* Patrickios
  * Citation: Patrickios CS, Yamasaki EN. Polypeptide amino acid composition and isoelectric point. II. Comparison between experiment and theory. Anal Biochem. 1995;231(1):82–91. doi: 10.1006/abio.1995.1506.
  * Notes: Highly simplified model computed on small peptides. Not generally recommended for use on proteins.
* Bjellqvist
  * Citation: B. Bjellqvist, G. J. Hughes, C. Pasquali, N. Paquet, F. Ravier, J. C. Sanchez, S. Frutiger, D. Hochstrasser, Electrophoresis 14 (1993) 1023–1031.
  * Website: https://web.expasy.org/compute_pi/, among others
  * Notes: One of the most commonly used set of pKa values for pI calculations.
* EMBOSS
  * Author: Alan Bleasby (European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridge CB10 1SD, UK). 
  * Website: [[http://www.bioinformatics.nl/cgi-bin/emboss/iep]]
  * Notes: Algorithm used by the EMBOSS program. 
* ProMoST
  * Citation: Halligan BD1, Ruotti V, Jin W, Laffoon S, Twigger SN, Dratz EA. Nucleic Acids Res. 2004 Jul 1;32(Web Server issue):W638-44.
  * Website: [[http://proteomics.mcw.edu/promost.html]]
  * Notes: Uses a more complex algorithm that takes into account the identities of terminal residues for both terminus and side chain pKa values. Developed to determine effects of posttranslational modifications on pI--note that these modifications are not currently recognized by IsoelectricPointMetric.


[[include:simple_metric_IsoelectricPointMetric_complex_type]]

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[DihedralDistanceMetric]]: Calculate the dihedral angle distance from directional statistics
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover