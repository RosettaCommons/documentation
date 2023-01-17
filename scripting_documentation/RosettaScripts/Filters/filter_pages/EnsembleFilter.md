# EnsembleFilter
*Back to [[SimpleMetrics]] page.*
*Back to [[Filters | Filters-RosettaScripts]] page.*
## EnsembleFilter

Created by Vikram K. Mulligan (vmulligan@flatironinstitute.org) on 10 February 2022.

[[_TOC_]]

### Description

This filter takes as input an [[EnsembleMetric|EnsembleMetrics]] that has been used to evaluate some set of properties of an ensemble of filters, retrives a named floating-point value from the metric, and filters based on whether that value is greater than, equal to, or less than some threshold.  (Note that [[EnsembleMetrics]] evaluate a property of a collection or _ensemble_ poses, not of a single pose.  This makes this filter unusual: where most discard a trajectory based on the state of a single pose, this can discard a trajectory based on the state of large ensemble of poses -- for example, based on many sampled conformatinos of a single design.)


### Options

[[include:filter_SimpleMetricFilter_type]]

### Example: 

In this example,  we load one or more cyclic peptides (provided with the `-in:file:s` or `-in:file:l` commandline options), generate a conformational ensemble of slightly perturbed conformations for each peptide _in memory_, without writing all structures to disk, and perform ensemble analysis on that ensemble with the [[CentralTendency EnsembleMetric|CentralTendency]], filtering on the results with the EnsembleFilter.  Only those peptides that have low-energy ensembles of perturbed conformations pass the filter.

```xml
<ROSETTASCRIPTS>
	<!-- Example of using the EnsembleFilter to filter based on the properties of an ensemble of poses
	generated from the current pose. -->
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
	</SCOREFXNS>
	<MOVERS>
		<!-- The movers that set up, perturb, and relax a cyclic peptide are set up here.  We
			later bundle the perturbation protocol in a ParsedProtocol: -->
		<DeclareBond name="connect_termini" res1="8" res2="1" atom1="C" atom2="N" add_termini="true" />
		<GeneralizedKIC name="perturb1" selector_scorefunction="r15" closure_attempts="200"
			stop_when_n_solutions_found="1" selector="lowest_rmsd_selector"
		>
			<AddResidue res_index="3"/>
			<AddResidue res_index="4"/>
			<AddResidue res_index="5"/>
			<AddResidue res_index="6"/>
			<AddResidue res_index="7"/>
			<SetPivots res1="3" atom1="CA" res2="5" atom2="CA" res3="7" atom3="CA" />
			<AddPerturber effect="perturb_dihedral" >
				<AddAtoms res1="3" atom1="N" res2="3" atom2="CA" />
				<AddAtoms res1="3" atom1="CA" res2="3" atom2="C" />
				<AddAtoms res1="4" atom1="N" res2="4" atom2="CA" />
				<AddAtoms res1="4" atom1="CA" res2="4" atom2="C" />
				<AddAtoms res1="5" atom1="N" res2="5" atom2="CA" />
				<AddAtoms res1="5" atom1="CA" res2="5" atom2="C" />
				<AddAtoms res1="6" atom1="N" res2="6" atom2="CA" />
				<AddAtoms res1="6" atom1="CA" res2="6" atom2="C" />
				<AddAtoms res1="7" atom1="N" res2="7" atom2="CA" />
				<AddAtoms res1="7" atom1="CA" res2="7" atom2="C" />
				<AddValue value="5.0"/>
			</AddPerturber>
		</GeneralizedKIC>
		<GeneralizedKIC name="perturb2" selector_scorefunction="r15" closure_attempts="200"
			stop_when_n_solutions_found="1" selector="lowest_rmsd_selector"
		>
			<AddResidue res_index="7"/>
			<AddResidue res_index="1"/>
			<AddResidue res_index="2"/>
			<AddResidue res_index="3"/>
			<AddResidue res_index="4"/>
			<SetPivots res1="7" atom1="CA" res2="2" atom2="CA" res3="4" atom3="CA"></SetPivots>
			<AddPerturber effect="perturb_dihedral" >
				<AddAtoms res1="7" atom1="N" res2="7" atom2="CA" />
				<AddAtoms res1="7" atom1="CA" res2="7" atom2="C" />
				<AddAtoms res1="1" atom1="N" res2="1" atom2="CA" />
				<AddAtoms res1="1" atom1="CA" res2="1" atom2="C" />
				<AddAtoms res1="2" atom1="N" res2="2" atom2="CA" />
				<AddAtoms res1="2" atom1="CA" res2="2" atom2="C" />
				<AddAtoms res1="3" atom1="N" res2="3" atom2="CA" />
				<AddAtoms res1="3" atom1="CA" res2="3" atom2="C" />
				<AddAtoms res1="4" atom1="N" res2="4" atom2="CA" />
				<AdmoverdAtoms res1="4" atom1="CA" res2="4" atom2="C" />
				<AddValue value="5.0"/>
			</AddPerturber>
		</GeneralizedKIC>
		<FastRelax name="frlx" repeats="1" scorefxn="r15" />
		<!-- Bundling the perturbation steps together so that they can be passed
			to the CentralTendency EnsembleMetric: -->
		<ParsedProtocol name="ensemble_generating_protocol" >
			<Add mover="perturb1" />
			<Add mover="perturb2" />
			<Add mover="frlx" />
		</ParsedProtocol>
	</MOVERS>
	<SIMPLE_METRICS>
		<!-- The SimpleMetric that will be passed to the CentralTendency EnsembleMetric: --> 
		<TotalEnergyMetric name="total_energy" scorefxn="r15" />
	</SIMPLE_METRICS>
	<ENSEMBLE_METRICS>
		<!-- Setting up the EnsembleMetric with both a SimpleMetric and a
			ParsedProtocol for generating the ensemble from a given pose: -->
		<CentralTendency name="avg_energy" n_threads="0" real_valued_metric="total_energy"
			output_mode="tracer_and_file" output_filename="report.txt"
			ensemble_generating_protocol="ensemble_generating_protocol"
			ensemble_generating_protocol_repeats="20"
		/>
	</ENSEMBLE_METRICS>
	<FILTERS>
		<!-- Set up the filter that can discard those peptides that yield an
			ensemble with energy above a cutoff threshold: -->
		<EnsembleFilter name="filter_on_avg_energy" ensemble_metric="avg_energy"
			named_value="mean" filter_acceptance_mode="less_than_or_equal"
			threshold="4.0"
		/>
	</FILTERS>
	<PROTOCOLS>
		<!-- Set up the peptide, but don't perturb it yet: -->
		<Add mover="connect_termini" />
		<!-- Accumulate data with the EnsembleMetric for every replicate of the
			peturbation protocol (which in this case is run by the EnsembleMetric,
			generating each member of the ensemble internally, in memory, without
			exporting them): -->
		<Add ensemble_metrics="avg_energy" />
		<!-- Abandon the jobs that produce bad ensemble properties prior to
			writing the structure back to disk: -->
		<Add filter="filter_on_avg_energy" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>
```

### See also

* [[EnsembleMetrics]]: Available SimpleMetrics
* [[SimpleMetrics]]: Available SimpleMetrics
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[Movers|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a Rosetta protocol.