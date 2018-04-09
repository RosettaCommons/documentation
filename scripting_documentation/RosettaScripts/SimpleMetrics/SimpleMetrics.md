# SimpleMetrics
*Back to main [[RosettaScripts|RosettaScripts]] page.*
## SimpleMetrics


SimpleMetrics are a new way to do analysis in Rosetta, and will eventually replace the Filter system and most filters.  They are declared in the new `<SIMPLE_METRICS>` block of RosettaScripts and are available in weekly releases after April 10th, 2018.  All data calculated by a SimpleMetric can be output to a score file with the metric name and any set prefix and/or suffix. These sets of SimpleMetrics can be also be run at different points in a protocol See [[RunSimpleMetrics]] for more on the syntax of how to Run SimpleMetrics in your protocol.  Filters were never meant to do analysis in the way they are being used currently.  The SimpleMetric framework aims to correct this. The SimpleMetrics on this page are broken into what kind of data they calculate.  

All SimpleMetrics can also be used as Filters, using the [[SimpleMetricFilter]].

Finally, all SimpleMetrics can also be used to within the [[FeaturesReporter | Features-reporter-overview]] framework, to allow robust analysis into relational databases.  Please see [[SimpleMetricFeatures]] for more. 

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

[[_TOC_]]

##RealMetrics

These metrics calculate a single real number (ie NOT an integer). 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[DihedralDistanceMetric]]** | Calculates the normalized dihedral angle distance in degrees from directional statistics on a set of dihedrals/residues of two poses or two regions of a pose.  | Yes
**[[RMSDMetric]]** | Calculates the RMSD between two poses or on a subset of residues.  Many options for RMSD including bb, heavy, all, etc. | Yes 
**[[SasaMetric]]** | Calculates the Solvent Accessible Surface Area (sasa). | Yes
**[[TotalEnergyMetric]] | Calculates the Total Energy of a pose using a Scorefunction OR the delta total energy between two poses. | Yes
** [[TimingMetric]] | Calculates the time passed in minutes or hours from from construction to apply (ie from when declared in the RS block to when it is run).  Useful for obtaining timing information of protocols. | No


##IntegerMetrics

These metrics calculate a single integer. 


##StringMetrics

These metrics calculate a string, such as sequence and seecondary structure. 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[SecondaryStructureMetric]]** | Returns the DSSP secondary structure of the pose or set of selected residues. | Yes
**[[SelectedResiduesMetric]]** | Returns the a comma-separated list of selected residues in PDB or Rosetta numbering. | Yes - _Required_
**[[SelectedResiduesPyMOLMetric]]** | Returns a PyMOL selection of a set of selected residues. | Yes - _Required_
**[[SequenceMetric]]** | Returns the one or three-letter sequence of the pose or set of selected residues.  | Yes


##CompositeRealMetrics

These metrics calculate a set of named real numbers. All metric values in the composite are output and available for filtering. 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[CompositeEnergyMetric]]** | Calculates each individual scoreterm of a scorefunction or the DELTA of each scoreterm between two poses.  Each named value is the scoreterm | Yes


##CompositeIntegerMetrics

These metrics calcuate a set of integers. All metric values in the composite are output and available for filtering. 


##CompositeStringMetrics

These metrics calculate a set of named strings. All metric values in the composite are output and available for filtering. 

##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover