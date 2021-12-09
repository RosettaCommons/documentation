# Sap Constraint (sap_constraint) 

[[_TOC_]]

Author: Brian Coventry (2020)

## Short description

The SAP score is a property of proteins that determines how aggregation prone they are. This was originally developed for antibodies, but it has tons of uses for proteins. It comes from this paper.

Developability Index: A Rapid In Silico Tool for the Screening of Antibody Aggregation Propensity


Brian added various ways to calculate this as well as design with it to Rosetta. See below for the various options.


At the time of writing, this isn't published, so there's nothing to cite. I figure we keep it that way until it's important enough to someone's work that they need to describe it in the methods. At which point that'll be the publication to cite.


## Ways to use it

Someday, this documentation will be better.

### Simple Metrics

Use these and you'll get values.

[[SapScoreMetric|scripting_documentation/RosettaScripts/xsd/simple_metric_SapScoreMetric_type]]

[[PerResidueSapScoreMetric|scripting_documentation/RosettaScripts/xsd/simple_metric_PerResidueSapScoreMetric_type]]

### Movers

For these to work. You must enable the sap_constraint scoreterm. Ideally with weight = 1.

[[AddSapConstraintMover|scripting_documentation/RosettaScripts/xsd/mover_AddSapConstraintMover_type]]

[[AddSapMathConstraintMover|scripting_documentation/RosettaScripts/xsd/mover_AddSapMathConstraintMover_type]]


### Code

You can get whole-pose, per-residue, and per-atom sap scores with these functions.

```
core.pack.guidance_scoreterms.sap.calculate_sap()
core.pack.guidance_scoreterms.sap.calculate_per_res_sap()
core.pack.guidance_scoreterms.sap.calculate_per_atom_sap()
```
