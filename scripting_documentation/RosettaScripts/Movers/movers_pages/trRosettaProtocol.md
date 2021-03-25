# trRosettaProtocol mover
*Back to [[Mover|Movers-RosettaScripts]] page.*
Documentation added 25 March 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## trRosettaProtocol mover

The trRosettaProtocol mover provide the same functionality as the [[trRosetta application|trRosetta]], but in the form of a mover that can be used in RosettaScripts or PyRosetta scripts, or in C++ code.  Although most movers take a pose as input, manipulate it, and produce a pose as output, the trRosettaProtocol mover discards the input pose and builds a new one.  The inputs are a sequence or FASTA file and a multiple sequence alignment; the latter is input into the trRosetta neural network to generate inter-residue distance and orientation constraints that guide structure prediction.  Each run of the trRosettaProtocol mover will generate a new predicted structure.  These structures tend to show a small amount of variation, so relatively low levels of sampling are necessary.  On the other hand, this means that this protocol is not ideal for large-scale conformational sampling (e.g. to evaluate whether the energy landscape has alternative minima).

## All options

[[include:mover_trRosettaProtocol_type]]

### Best practices

At the time of this writing, it is recommended to set `mutate_gly_to_ala="false"` and `backbone_randomization_mode="ramachandran"`.  This may become the default at some point.  All other settings may remain default.

## Example script

The following script produces pretty good (~2 A RMSD) predictions of the structure of ubiquitin perhaps four times out of five:

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015" />
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
	</RESIDUE_SELECTORS>
	<PACKER_PALETTES>
	</PACKER_PALETTES>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<MOVE_MAP_FACTORIES>
	</MOVE_MAP_FACTORIES>
	<SIMPLE_METRICS>
	</SIMPLE_METRICS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<trRosettaProtocol name="predict_struct" msa_file="inputs/1r6j_msa.a3m"
			sequence="GAMDPRTITMHKDSTGHVGFIFKNGKITSIVKDSSAARNGLLTEHNICEINGQNVIGLKDSQIADILSTSGTVVTITIMPAF"
			mutate_gly_to_ala="false" backbone_randomization_mode="ramachandran"
		/>
	</MOVERS>
	<PROTOCOLS>
		<Add mover="predict_struct" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>

```

In this example, the input multiple sequence alignment (MSA), which was generated using the HHBlits sever (https://toolkit.tuebingen.mpg.de/tools/hhblits), looks like this:

```
>1718255
GAMDPRTITMHKDSTGHVGFIFKNGKITSIVKDSSAARNGLLTEHNICEINGQNVIGLKDSQIADILSTSGTVVTITIMPAF
>UniRef100_A0A2 Putative syntenin-1 n=1 Tax=Stichopus japonicus TaxID=307972 RepID=A0A2G8KW37_STIJA
---FERTITMHKDSTGHVGFIFKNGKITSIVKDSSAARNGLLTEHNICEINGQNVIGLKDSQIADILSTSGTVVTITIMPKF
>UniRef100_UPI0 Syntenin 1 n=2 Tax=Homo sapiens TaxID=9606 RepID=UPI00001B299E
KNMDQfqRTVTMHKDSSGHVGFVFKKGKIVSIAKDSSAARNGLLTHHCICEVNGQNVIGMKDKQITEVLSGSGNVVTITIMPAF
>UniRef100_A0A0 Uncharacterized protein (Fragment) n=1 Tax=Amblyomma triste TaxID=251400 RepID=A0A023GMK5_AMBTT
---FERTVTMHKDSTGHVGFVFKNGKITSLVKDSSAARNGLLTEHYLCEINGQNVIGLKDKQIKDILSTSGNVITITVMPSF
>UniRef100_A0A0 Syntenin-1 n=1 Tax=Fukomys damarensis TaxID=885580 RepID=A0A091E3S4_FUKDA
---FERTVTMHKDSTGHVGFIFKNGKITSIVKDSSAARNGLLTEHNICEINGQNVIGLKDSQIADILSTSGTVVTITIMPAF
>UniRef100_A0A0 Uncharacterized protein n=1 Tax=Aedes albopictus TaxID=7160 RepID=A0A023ENS9_AEDAL
---FERTITMHKDSTGHVGFIFKNGKITSIVKDSSAARNGLLTDHQICEVNGQNVIGLKDKQIADILSTAGNVVTITIMPSF
...
```

A typical MSA is dozens to hundreds of sequences (though even a single-sequence "alignment" can often produce meaningful predictions).

## References

- The trRosetta neural network is described in Yang _et al_. (2020) _Proc Natl Acad Sci USA_ 117(3):1496-1503 (doi 10.1073/pnas.1914677117).
- The [[trRosettaProtocol]] mover, [[trRosettaConstriantGenerator]], trRosetta application, and other C++ infrastructure were written by Vikram K. Mulligan (vmulligan@flatironinstitute.org), and are currently unpublished.

## See Also

* [[trRosetta application|trRosetta]]: Essentially, this mover in application form, so that you can provide an MSA on the commandline and get a structure out.
* [[trRosettaConstraintGenerator]]:  A constraint generator used by this mover to create the inter-residue constraints that guide structure prediction.
* [[MinMover]]: Used by this composite mover to find conformations compatible with the trRosetta constraints.
* [[FastRelax]]:  Used by tihs composite mover for all-atom refinement.
* [[AbinitioRelax application|abinitio-relax]]:  Classic, fragment-based structure prediction.
