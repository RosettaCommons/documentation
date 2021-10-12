#SimpleThreadingMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SimpleThreadingMover

[[include:mover_SimpleThreadingMover_type]]

### Details
It does the threading by allowing the task to only enable these residues and then does a repacking. Optionally repack neighbors so we save one more step.

A sequence can be provided in one of several formats, with the input format specified with the `sequence_mode` option.  The table below gives the available sequence modes, and shows how to specify the tetrapeptide sequence L-aspartate, L-phenylalanine, D-tryptophan, D-alanine.

| Sequence mode | Input sequence description | Example |
|----------|--------------------------------------------------------------------------------|----------|
| oneletter | A string of amino acid one-letter codes.  Additional '-' characters indicate that a position is to be skipped in the thread.  An 'X', followed by a full basename in square brackets (_e.g._ `X[ORN]`) can be used to specify non-canonical building-blocks. | DFX[DTRP]X[DALA] |
| threeletter | A string of amino acid three-letter codes, separated by commas.  No whitespace should be included.  Additional '-' characters indicate that a position is to be skipped in the thread.  A '-' indicates a position to be skipped. | ASP,PHE,DTR,DAL |
| basename | A string of amino acid base names, separated by commas.  No whitespace should be included.  Additional '-' characters indicate that a position is to be skipped in the thread.  A '-' indicates a position to be skipped. | ASP,PHE,DTRP,DALA |
| fullname | A string of full amino acid names, including any variant types.  Additional '-' characters indicate that a position is to be skipped in the thread. | ASP:NtermProteinFull,PHE,DTRP,DALA:CtermProteinFull |

The default is 5 rounds of packing.  If the sequence would be threaded past the C-terminus, the returned pose will have the sequence threaded up to the end of the pose - additional residues will not be added or modeled.

SimpleThreadingMover supports symmetric poses.

### Overview

In order to run this protocol, you just need to specify the place to start - in rosetta or PDB numbering - and the sequence.  
We will parse the PDB numbering on apply time in case there are any pose-length changes until then. 
Pass the option to repack neighbors for packing.  

```xml
     <SimpleThreadingMover name="threader" start_position="24L" thread_sequence="TGTGT--GTGT" pack_neighbors="1" neighbor_dis="6"  pack_rounds="5"/>
```

##See Also

* [[RosettaCM]]: Full Rosetta Comparative Modeling protocol
* [[HybridizeMover]]: More Complex mover for Comparative Modeling
* [[FastRelaxMover]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover