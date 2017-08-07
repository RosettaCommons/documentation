Some of the classes/functions in Rosetta are near duplicate because of historical reasons or subtle differences in problems they are designed to solve. This page explains the reason why these near duplicate classes exist and what are the suitable problems that these classes/functions are built for.

## Suspects to investigate
* Buried unsat filters (Scott Boyken is best leader here)
* interface detection machineries

## Movers

### Loop modeling

|Mover name | Reason to exist | Suitable problems to solve|
|---|---|---|
|[[LoopmodelWrapper | scripting_documentation/RosettaScripts/xsd/mover_LoopmodelWrapper_type
]] | Wrapper for the legacy loop modeling code for the [[Loop modeling application | loopmodel]] such that it can be used through the RosettaScripts interface| Use this mover when you want to recapitulate the behavior of the [[Loop modeling application | loopmodel]]. Because code under this mover is to be deprecated, using [[LoopModeler|LoopModelerMover]] is recommanded|
|[[LoopModeler|LoopModelerMover]] | A refactored version of the legacy loop modeling code. Should be used through the RosettaScripts interface. | For protein loop modeling problems, use this mover. |
|[[Generalized Kinematic Closure (GeneralizedKIC)|GeneralizedKICMover]] | A generalized protocol for modeling loops on any polymers | Use this mover when working with polymers that have different backbones compared to L-proteins|


## Filters