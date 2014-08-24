#Stepwise options classes

StepWiseBasicOptions
 • StepWiseMonteCarloOptions
 • StepWiseBasicModelerOptions
   - StepWiseModelerOptions (also derives from StepWiseProteinModelerOptions, StepWiseRNA_ModelerOptions)*

*(Yes I know about potential issues with multiple inheritance, but I think they're avoided here, and the alternative solutions requires remembering to copy a huge number of options from class to class.)

---
Go back to [[StepWise Overview|stepwise-classes-overview]].
