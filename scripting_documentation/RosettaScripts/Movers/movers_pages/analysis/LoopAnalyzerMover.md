# LoopAnalyzerMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopAnalyzerMover

This Mover computes a bunch of loop-specific metrics.  It was created as an analysis tool for [[AnchoredDesign|anchored-design]] but is not specific to that protocol.

```xml
<LoopAnalyzerMover name="&string" use_tracer="(&bool)" loops_file="(&string)" >
    <Loop start="(&int)" stop="(&int)" cut="(&int)" skip_rate="(0.0 &real)" rebuild="(no &bool)"/>
</LoopAnalyzerMover>
```

- loop: You can pass the loop(s) in as a subtag(s).
- loops_file: You can pass the loops in as a loop file.
- use_tracer: if false, store results in the PoseExtraScores / DataCache for output at the end of the run.  If true, print results to a [[Tracer|Glossary#tracer]] object.

##What does it do?

You use the LoopAnalyzerMover output to filter for bad loop closures (which Rosetta's scorefunction detects insufficiently).  The particular problems are:

* omega is isoenergetic between trans and cis, so you need to manually check for cis omegas
* The chainbreak term doesn't do a good job of ensuring good omega bond geometry after CCD unless its weight is really high; if the weight is high it causes problems during minimization by screwing up the rest of the loop.
** These geometries are ignored by the scorefunction, as are most bond lengths and angles (the scorefunction assumes they are ideal)
* The Ramachandran energy rama used to be (I think this is fixed in Talaris13+) capped at 20 energy units, so once a torsion got into garbage space, it could stay there because minimization had a zero derivative and couldn't fix it.

So, LoopAnalyzerMover generates a bunch of metrics aimed at these problems.  

##Sample output and interpretation

Here is LoopAnalyzerMover's output at the end of an output PDB. The second line is long column titles, and the third is short versions to make visualization easier. Each row represents one residue. Totals for all loops for some terms are collected at the bottom.

```
LoopAnalyzerMover: unweighted bonded terms and angles (in degrees)
position phi_angle psi_angle omega_angle peptide_bond_C-N_distance rama_score omega_score dunbrack_score peptide_bond_score chainbreak_score
 pos phi_ang psi_ang omega_ang pbnd_dst    rama  omega_sc dbrack pbnd_sc   cbreak
  17  -106.8   175.8     178.2    1.322   0.998    0.0342   7.01   -2.68   0.0182
  18  -82.33   64.67    -178.5    1.329   0.211    0.0217   3.11   -3.42   0.0203
  19  -83.63   149.4     177.2    1.329   -1.07    0.0795      0   -3.43    0.584
  20  -75.25   171.1    -178.7    1.329  -0.264    0.0161  0.348   -3.43   0.0151
  21  -58.53  -42.95     174.6    1.329   -0.58     0.294      0   -3.43      2.7
  22  -76.02   159.9    -179.8    1.326  -0.811  0.000404   0.97   -3.45   0.0424
  23  -72.63   130.1     179.4    1.325   -1.29   0.00372   0.24   -3.46   0.0281
  24  -94.91   116.5     179.8    1.323   -1.21   0.00028  0.721   -3.45   0.0694
  25  -65.42   150.7     179.4    1.335   -1.58     0.004      0   -3.32     1.38
  26  -64.68   147.9     179.1    1.323   -1.45    0.0079   1.61   -3.32    0.211
  27  -56.44  -66.68      -180    1.329    1.34  8.08e-30   7.87   -3.43 2.37e-05
  28  -124.4  -56.48     177.6    1.329    2.08    0.0568  0.608   -3.43   0.0533
  29  -124.1   28.78    -177.7    1.264   0.341    0.0542   2.39    2.65     2.07
  30   81.57  -134.3    -176.4    1.329      20     0.126   5.06    2.65    0.128
  31  -112.9   147.2     172.7    1.318  -0.744     0.538  0.534   -3.35     1.38
total_rama 15.9674
total_omega 1.23676
total_peptide_bond -38.3223
total_chainbreak 8.70689
total rama+omega+peptide bond+chainbreak -12.4113

LAM_total -12.4113
```

In this particular example, position 29 is clearly problematic: the peptide bond distance is too short, as reported by the pbnd_dst, pbnd_sc, and cbreak columns. You can also see that position 30 has an awful ramachandran score. Good structures will have no fields out of range of the lower scores in this example.


##See Also
* [[I want to do x]]: Guide to choosing a mover
* [[RosettaScriptsLoopModeling]]
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[AnchoredDesign|anchored-design]]: The protocol for which this was written

<!-- SEO

loop analyzer
loop analyzer
loop analyzer
-->
