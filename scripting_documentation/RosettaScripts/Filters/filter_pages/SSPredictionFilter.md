# SSPrediction
*Back to [[Filters|Filters-RosettaScripts]] page.*
## SSPrediction

Uses the sequence in the pose to generate secondary structure predictions for each position. Secondary structure predictions are then compared to the desired secondary structure to determine a score. If use\_probability is true, the score returned is a value between 0 and 1, where 0 is complete secondary structure agreement, and 1 is no agreement. The following equation is used to determine the score:
sum(i=1;N;e^(-p[i]/T)), where N is the number of residues, p[i] is the probability of correct secondary structure at position i, and T is a temperature factor set to 0.6 by default.
If use\_probability is false, the filter returns the fraction of residues that match the desired secondary structure as a number between 0 and 1.
If use\_probability is true AND mismatch\_probability is true, the score is the geometric average of the probability of picking the WRONG secondary structure type at all residue positions.  Minimizing this number will maximize the geometric average of the probability of picking the CORRECT secondary structure type at all residue positions.  This option should be the most correct method for comparing two sequences to determine their expected fragment quality based on their predicted secondary structure probabilities at each residue.

```xml
<SSPrediction name="(&string)" threshold="(&real)" use_probability="( false &bool)" mismatch_probability="( false &bool)" cmd="(&string)" blueprint="( '' &string)" use_svm="( true &bool )" />
```

-   threshold - If threshold is set and use_probability is true, the filter returns true only if the calculated value is less than this number. If use_probability is false, the filter returns true if the calculated value is greater than this number.
-   use\_probability - If true, the probability information that psipred calculates will be used to determine the score. IF false, the filter will return the percentage of residues that match.
-   mismatch\_probability - If true AND use\_probability is true, the score is determined as the geometric average of the probability getting a WRONG secondary structure type at each position.  Just as in regular use_probability, you want to minimize this score.
-   cmd - Full path to runpsipred\_single or runpsipred executable. Must be specified if use\_svm=false
-   blueprint - If specified, the filter will take desired secondary structure from a blueprint file, rather from DSSP on the pose.
-   use\_svm - If set, an SVM will be used to make secondary structure predictions instead of psipred. This requires downloading some database files. If false, the psipred executable specified by cmd will be used.
