# [[ PoseFromSequenceMover ]]
*Back to [[Mover|Movers-RosettaScripts]] page.*
## [[ PoseFromSequenceMover ]]

[[include:mover_PoseFromSequenceMover_type]]


The goal of this mover is to allow you to build a pose of your chosen sequence without
requiring `-s` or `-in:file:fasta`

If this is the first stage in your rosetta script, you should supply In general, you should add the commandline flag `-input_empty_pose true` so that rosetta starts with the pose made by this mover, instead of creating one from the pdb or fasta supplied.

One of the nice things about this mover is that you can create multi-chain Poses easily by supplying a fasta file that has multiple sequences ie:

```
>Thiswillbechain1
SEGVENCE
>Thiswillbechain2
POTBELLG
```

will yield a pose with two chains: `SEGVENCE` and `POTBELLG`

This is particularly useful with long complicated Poses supplied to the Hybridize mover, where it is useful to know the identities of the chains of the pose when generating inputs.