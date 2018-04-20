# TaskAwareScoreType
*Back to [[Filters|Filters-RosettaScripts]] page.*
## TaskAwareScoreType  (Formerly AverageInterfaceEnergy)

Takes task operations to determine the packable residues and then calculates/filters based on the scores of those residues in one of three possible modes:
1) total: the total score of all packable residues
2) average: the average score of all packable residues
3) individual: the scores of individual residues (in individual mode each residue must pass the user-defined threshold in order for the filter to pass).
In each mode, the score type used to assess the score is set by the user (default is total_score).

```xml
<TaskAwareScoreType name="(&string)" task_operations="(&comma-delimited list of taskoperations)" scorefxn="(score12 &string)" score_type="(total_score &string)" threshold="(100000 &Real)" mode="(total &string)", unbound="(0 &bool)", sym_dof_names="(&comma-delimited list of strings)", jump="(0 &Size)", write2pdb="(0 &bool)", bb_bb="(0 &bool)" />
```

-   task\_operations: task operations used to set the repackable residues
-   scorefxn: scorefunction to use during the energy calculations. Defaults to score12
-   score\_type: score term to use for the calculations. Defaults to total_score.
-   threshold: Threshold for the highest permissible value for a passing design.  Note: When using mode="individual" this is the score threshold that each individual residue must pass in order for the filter to pass.  For example, the user could set threshold=3.5, score\_type=fa\_rep, and mode=individual to check if all the packable residues have a fa\_rep score less than 3.5.  The value reported when mode=individual is the number of failing residues.
-   mode: This filter can operate in three modes.  The options are "total", "average", or "individual".  If mode=total, then the total score of the packable residues is returned and the threshold refers to that total value.  If mode=average, then the average score of the packable residues is returned and the threshold refers to that average value.  If mode=individual, then each packable residue is evaluated on an individual basis and the threshold refers to those individual values; in this case, individual residue must pass in order for the filter to pass. For example, the user could set threshold=3.5, score_type=fa\_rep, and mode=individual to check if all the packable residues have a fa_rep score less than 3.5.  The value reported from the filter when mode=individual is the number of failing residues.
-   bb\_bb: See EnergyPerResidueFilter.
-   unbound: Default is false.  Set to true if you want the scores to be assessed in the unbound state.  If unbound is set true, then the user must provide either the sym\_dof\_names or jump along which to separate the pose.
-   sym\_dof\_names: For use with the unbound option.  Which sym\_dofs should be used to separate the pose?
-   jump: For use with the unbound option.  Which jump should be used to separate the pose?  
-   write2pdb: Only for use with mode=individual.  Default is false.  Setting to true will cause the individual scores to be output to the bottom of the pdb.

## See also

* [[Score Types|rosetta_basics/scoring/score-types]]
* [[Design in Rosetta|application_documentation/design/design-applications]]
* [[Task Operations|TaskOperations-RosettaScripts]]
* [[EnergyPerResidueFilter]]
* [[PackRotamersMover]]
* [[ScoreTypeFilter]]
