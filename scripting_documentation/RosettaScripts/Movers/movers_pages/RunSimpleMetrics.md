# RunSimpleMetrics
*Back to [[SimpleMetrics]] page.*
*Back to [[Movers | Movers-RosettaScripts]] page.*
## RunSimpleMetrics

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

Run a set of [[SimpleMetrics]] and add the data to the pose for output into the scorefile/scoretable.  Set prefix/suffix to output the set with a particular tag. It is recommended to use JSON scorefile output for easy analysis in python, especially with pandas `-scorefile_format json`

Use the prefix/suffix options to group metrics or to run metrics at different points in a protocol.  Each SimpleMetric also has a `custom_type` option, which can be used to have multiple configurations of a single type of SimpleMetric run during `RunSimpleMetrics`.  Any set prefix, suffix, and custom_type options are added to the data tag in the score file.

See [[Effective Use of SimpleMetrics | SimpleMetrics#effective-use-of-simplemetrics]] for more. 


[[include:mover_RunSimpleMetrics_type]]

##Example: 

Example with comparison to native through `-in:file:native`:

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<CDR name="L1" cdrs="L1"/>
	</RESIDUE_SELECTORS>
	<MOVE_MAP_FACTORIES>
		<MoveMapFactory name="movemap_L1" bb="0" chi="0">
			<Backbone residue_selector="L1" />
			<Chi residue_selector="L1" />
		</MoveMapFactory>
	</MOVE_MAP_FACTORIES>
	<SIMPLE_METRICS>
		<TimingProfileMetric name="timing" />
		<RMSDMetric name="rmsd" rmsd_type="rmsd_protein_bb_heavy" residue_selector="L1" use_native="1"/>
		<SasaMetric name="sasa" residue_selector="L1"/>
		<DihedralDistanceMetric name="dihedral" residue_selector="L1" use_native="1"/>
		<SelectedResiduesMetric name="selection" residue_selector="L1"/>
		<SelectedResiduesMetric name="rosetta_sele" residue_selector="L1" rosetta_numbering="1"/>
		<SelectedResiduesPyMOLMetric name="pymol_selection" residue_selector="L1" />
		<SequenceMetric name="sequence" residue_selector="L1" />
		<SecondaryStructureMetric name="ss" residue_selector="L1" />
		<TotalEnergyMetric name="total_energy" residue_selector="L1" />
		<CompositeEnergyMetric name="composite_energy" residue_selector="L1" use_native="1"/>
	</SIMPLE_METRICS>
	<MOVERS>
		<MinMover name="min_mover" movemap_factory="movemap_L1" tolerance=".1" /> 
		<RunSimpleMetrics name="run_metrics1" metrics="sasa,pymol_selection,sequence,ss,total_energy,rosetta_sele" prefix="m1_" />
		<RunSimpleMetrics name="run_metrics2" metrics="sasa,selection,pymol_selection,sequence,ss,total_energy,rmsd,dihedral,composite_energy" prefix="m2_" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="run_metrics1"/>
		<Add mover_name="min_mover" />
		<Add mover_name="run_metrics2" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

##See Also

* [[SimpleMetrics]]: Available SimpleMetrics
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover