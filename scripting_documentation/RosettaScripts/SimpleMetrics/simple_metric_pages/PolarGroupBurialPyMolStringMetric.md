#PolarGroupBurialPyMolStringMetric

*Back to [[SimpleMetrics]] page.*

## PolarGroupBurialPyMolStringMetric

Author: Vikram K. Mulligan (vmullig@uw.edu)

Documentation created 24 April 2018.

[[_TOC_]]

## Purpose and Description

The PolarGroupBurialPyMolStringMetric [[SimpleMetric|SimpleMetrics]] was created to complement the [[buried_unsatisfied_penalty|BuriedUnsatPenalty]] scoreterm.  It generates a string of PyMol commands to colour the polar groups in a pose based on burial.  The pose is coloured grey, with surface-exposed polar groups in cyan and buried groups in orange.  The generated commands are written out with output PDB files.

The PolarGroupBurialPyMolStringMetric takes a scorefunction as input, and matches its definition of "burial" to that used by the [[buried_unsatisfied_penalty|BuriedUnsatPenalty]] scoreterm.  See the documentation for that scoreterm for the scorefunction options that can be altered to change the definition of burial.

## Usage

```xml
<PolarGroupBurialPyMolStringMetric name="(&string)" verbose="(false &bool)" scorefxn="(&string)" />
```

* **verbose:** If true, PyMol commands are also written to the tracer.  False by default.
* **scorefxn:** A previously-defined scorefunction, used to set the definition of "burial".  See the documentation for the [[buried_unsatisfied_penalty|BuriedUnsatPenalty]] scoreterm for settings that can be altered in the scorefunction to change the definition of burial.  Required input.

##See Also

* The [[buried_unsatisfied_penalty|BuriedUnsatPenalty]] scoreterm
* [[Design-centric guidance terms|design-guidance-terms]]
* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover