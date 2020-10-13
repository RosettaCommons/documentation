# SimpleMetrics
*Back to main [[RosettaScripts|RosettaScripts]] page.*

SimpleMetrics are a new way to do analysis and data reporting in RosettaScripts, and have replaced the old Filter system for that purpose. SimpleMetrics can be run at different points in a protocol, such as before and after a particular mover or set of movers. They are declared in the `<SIMPLE_METRICS>` block of RosettaScripts and are available in Rosetta versions after April 10th, 2018. 

There are two ways of outputting the data calculated by SimpleMetrics to a scorefile. The first and most flexible is with the [[RunSimpleMetrics]] mover. See the documentation page for [[RunSimpleMetrics]] for more on the syntax of how to include it in your protocol.

The other (available after Oct 15th, 2010) is to use the `metrics` option in the [[PROTOCOLS|RosettaScripts#rosettascript-sections_protocols]] section. This option takes a comma-separated list of metric names (previously defined in the SIMPLE_METRICS section) to apply at that point of the protocol and to report to the scorefile. By default, this approach uses the name of the metric as the output label, rather than the metric-specified custom types. You can specify a different output label using the `labels` option of the PROTOCOLS section (which also takes a comma-separated list). The label `-` is special-cased to give you the name of the metric you would otherwise get with RunSimpleMetrics. 

All SimpleMetrics can also be used as Filters, using the [[SimpleMetricFilter]].
 
Finally, all SimpleMetrics can also be used within the [[FeaturesReporter | Features-reporter-overview]] framework, to allow robust analysis into relational databases.  Please see [[SimpleMetricFeatures]] for more. 

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
		<SelectedResiduesPyMOLMetric name="pymol_selection" residue_selector="L1" />
		<TotalEnergyMetric name="total_energy" residue_selector="L1" />
	</SIMPLE_METRICS>
	<MOVERS>
		<MinMover name="min_mover" movemap_factory="movemap_L1" tolerance=".1" /> 
		<RunSimpleMetrics name="run_metrics1" metrics="pymol_selection,total_energy" prefix="m1_" />
		<RunSimpleMetrics name="run_metrics2" metrics="pymol_selection,total_energy" prefix="m2_" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="run_metrics1"/>
		<Add mover_name="min_mover" />
		<Add mover_name="run_metrics2" />
		<Add metrics="timing,rmsd" labels="run_time,bb_rmsd_to_native"/>
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

Framework Author: 
   Jared Adolf-Bryfogle (jadolfbr@gmail.com)

[[_TOC_]]



##Effective use of SimpleMetrics

### Summarizing/Calculating metrics

The [[ResidueSummaryMetric]] takes a [[PerResidueRealMetric | SimpleMetrics#PerResidueRealMetric]] and summarizes the data in various ways, such as the mean, sum, or the number of residues above, below, or equal to a certain value. This Metric is itself a [[RealMetric | SimpleMetrics#RealMetric]] and can be used as such in filters, features reporters, etc.

The [[CalculatorMetric]] is a RealMetric which can combine other RealMetrics with an arbitrary mathematical formula.

### Custom Types

Each SimpleMetric has a `custom_type` option.  This option gives an additional name to the data term when using [[RunSimpleMetrics]] or [[SimpleMetricFeatures]] (ex: output scoreterm becomes L1_total_energy and L2_total_energy in the example below). The benefit to this is that you can have multiple SimpleMetrics, all configured differently and using the `custom_type` option allows you to run them all in a single RunSimpleMetrics or SimpleMetricFeatures application.  

Ex:

```xml

	<TotalEnergyMetric name="E_L1" residue_selector="L1" custom_type="L1" />
	<TotalEnergyMetric name="E_L2" residue_selector="L2" custom_type="L2" />
	<TotalEnergyMetric name="E_CDRs" residue_selector="ALL" custom_type="cdrs"/>

  	. . .

	<RunSimpleMetrics name="cdr_metrics" metrics="E_L1,E_L2,E_CDRs" />

```

### Prefix/Suffix

[[RunSimpleMetrics]] and [[SimpleMetricFeatures]] have additional options for prefix and suffix.  Use this to run a set of SimpleMetrics at different points in your protocol, or begin to group sets of metrics into similar tags.  For example, before a mover you can set `prefix="pre_min"` and then you can have the same set of SimpleMetrics run afterward as `prefix="post_min"`.  

Ex:

```xml


<RunSimpleMetrics name="cdr_metrics_pre" metrics="E_L1,E_L2,E_CDRs" prefix="pre_min_"/>
<RunSimpleMetrics name="cdr_metrics_post" metrics="E_L1,E_L2,E_CDRs" prefix="post_min_"/>
	
 . . . 
  
<PROTOCOLS>
	<Add mover_name="cdr_metrics_pre"/>
	<Add mover_name="min_mover" />
	<Add mover_name="cdr_metrics_post" />
</PROTOCOLS>

```

###Metric Cacheing

Some calculations are expensive, such as the `DensityFitMetric`.  In order to reduce run time during a complex protocol, [[SimpleMetricFilter]],  [[SimpleMetricFeatures]], and the [[ResidueSummaryMetric]] can use cached data.  During the `RunSimpleMetrics` application, ALL data is stored within the pose and this can be used for filters and features using the `use_cached_data` option.  If a prefix/suffix was used during `RunSimpleMetrics`, this is needed here as well as the options `cache_prefix` and `cache_suffix`. Any pose-length changes are accounted for automatically using Vikram Mulligan's excellent reference pose functionality.  

Ex: 

```xml
<SimpleMetricFilter name="ss_filter" use_cached_data="1" cache_prefix="cached_"  metric="ss" match="LLLLLLLLLLL"  comparison_type="ne"/>
<SimpleMetricFilter name="rmsd_filter" use_cached_data="1" cache_prefix="cached_"  metric="rmsd" cutoff="0.5" comparison_type="lt" />
```

###SavePoseMover

One thing to be aware of is that the data calculated during [[RunSimpleMetrics]] is stored in the pose.  This means that if you calculate a bunch of data and switch to a different pose in the protocol while using the [[SavePoseMover]], the data will not be output.  A mover to copy this data into a new pose is in the works, but please be aware of this.


##RealMetrics

These metrics calculate a single real number (or integer). 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[CalculatorMetric]]** | Combine multiple RealMetrics with a mathematical expression. | No
**[[DihedralDistanceMetric]]** | Calculates the normalized dihedral angle distance in degrees from directional statistics on a set of dihedrals/residues of two poses or two regions of a pose.  | Yes
**[[InteractionEnergyMetric]]** | Calculates the (long range and short range) interaction energy between a selection and all other residues or another selection. Can be set to only calculate short or long or only use certain score terms such as fa_rep. | Yes
**[[MouseTotalEnergy]]** | Evaluate your interface using Mouse. | Yes
**[[ResidueSummaryMetric]]** | A metric that takes a _PerResidueRealMetric_ and summarizes the data in different ways, such as the sum, mean, or the number of residues that match a certain criteria. Can use cached data. | Yes
**[[RMSDMetric]]** | Calculates the RMSD between two poses or on a subset of residues.  Many options for RMSD including bb, heavy, all, etc. | Yes 
**[[SasaMetric]]** | Calculates the Solvent Accessible Surface Area (sasa). | Yes
**[[SelectedResidueCountMetric]]** | Count the number of residues in a selection (or whole pose). | Yes
**[[SequenceRecoveryMetric]]** | Compare the sequence of the structure to that of a reference structure of PSSM | Yes
**[[SequenceSimilarityMetric]]** | Averages the BLOSUM62 score for selected residues. | Yes
**[[TotalEnergyMetric]]** | Calculates the Total Energy of a pose using a Scorefunction OR the delta total energy between two poses. | Yes
**[[TimingProfileMetric | TimingMetric]]** | Calculates the time passed in minutes or hours from from construction to apply (ie from when declared in the RS block to when it is run).  Useful for obtaining timing information of protocols. | No



##StringMetrics

These metrics calculate a string, such as sequence and seecondary structure. 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[InteractionGraphSummaryMetric]]** | Given a pose and a set of task operations, calculates an interaction graph and writes out a summary of it.  Intended for use with external annealers and with the [[ExternalPackerResultLoader mover|ExternalPackerResultLoader]] to reconstruct the pose with the external solution. | Yes (indirectly -- since task operations may take residue selectors)
**[[PolarGroupBurialPyMolStringMetric]]** | Returns PyMol commands to colour polar groups in a pose based on burial, in a manner compatible with the [[buried_unsatisfied_penalty|BuriedUnsatPenalty]] scoreterm. | No (not applicable)
**[[SecondaryStructureMetric]]** | Returns the DSSP secondary structure of the pose or set of selected residues. | Yes
**[[SelectedResiduesMetric]]** | Returns the a comma-separated list of selected residues in PDB or Rosetta numbering. | Yes - _Required_
**[[SelectedResiduesPyMOLMetric]]** | Returns a PyMOL selection of a set of selected residues. | Yes - _Required_
**[[SequenceMetric]]** | Returns the one or three-letter sequence of the pose or set of selected residues.  | Yes

##PerResidueRealMetrics
These metrics calculate a single real number (or integer) for every Residue selected by a residue selector.
Default is to calculate on ALL residues.  
**All accept ResidueSelectors.**  Output can be in Rosetta or PDB Numbering.  You can use the [[ResidueSummaryMetric]] to calculate the sum, mean, etc. from a PerResidueMetric.  

SimpleMetric  | Description 
------------ | -------------
**[[HbondMetric]]** | Calculate number of hydrogen bonds between residues in a selector or between two selectors
**[[PeptideInternalHbondsMetric]]** | Calculate the number of hydrogen bonds in a single selection or pose, excluding bonds between residues within a threshold distance of each other in terms of covalent connectivity.
**[[MousePerResidueEnergy]]** | Evaluate your interface using Mouse. 
**[[PerResidueDensityFitMetric]]** | Calculate the Fit of a  model to the loaded density either by Correlation or a Zscore.
**[[PerResidueClashMetric]]** | Calculates the number of atomic clashes per residue using two residue selectors. Clashes are calculated through the leonard jones radius of each atom type.
**[[PerResidueEnergyMetric]]** | Calculate any energy term for each residue.  Total energy is default.  If a native or repose is given, can calculate the energy delta for each residue.
**[[PerResidueRMSDMetric]]** | Calculate the RMSD for each residue between the input and either the native or a reference pose.
**[[PerResidueSasaMetric]]** | Calculate the Solvent Accessible Surface Area (SASA) of each residue.
**[[WaterMediatedHbondMetric]]** | A metric to measure hydrogen bonds between a set of residues that are water-mediated (bridged).  Can calculate different depths to traverse complex hbond networks.

##PerResidueStringMetrics
These metrics output a single string for each residue of a residue selector. 

##CompositeRealMetrics

These metrics calculate a set of named real numbers. All metric values in the composite are output and available for filtering. 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[CompositeEnergyMetric]]** | Calculates each individual scoreterm of a scorefunction or the DELTA of each scoreterm between two poses.  Each named value is the scoreterm | Yes
**[[ElectrostaticComplementarityMetric | simple_metric_ElectrostaticComplementarityMetric_type ]]** | Calculates the McCoy, Chandana, Colman Electrostatic complementarity using APBS. | Yes

##CompositeStringMetrics

These metrics calculate a set of named strings. All metric values in the composite are output and available for filtering. 

SimpleMetric  | Description | ResidueSelector Compatability?
------------ | ------------- | -------------
**[[ProtocolSettingsMetric]]** | Outputs currently set user options (cmd-line,xml, or both).  Allows one to only output specific metrics or set a tag for the particular experiment.  Useful for benchmarking/plotting or historical preservation of options tied to a pose  | No


##See Also

* [[RunSimpleMetrics]]: Run a set of SimpleMetrics and output data to the scorefile
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover