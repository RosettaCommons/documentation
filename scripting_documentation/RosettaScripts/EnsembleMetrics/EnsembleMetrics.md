# EnsembleMetrics
*Back to main [[RosettaScripts|RosettaScripts]] page.*

Page created Wed, 9 February 2022 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## 1. Description

Just as [[SimpleMetrics]] measure some property of a pose, EnsembleMetrics measure some property of a group (or _ensemble_) of poses.  They are designed to be used in two phases.  In the _accumulation_ phase, an EnsembleMetric is applied to each pose in an ensemble in sequence, allowing it to store any relevant measurements from that pose that will later be needed to calculate properties of the ensemble.  In the _reporting_ phase, the EnsembleMetric generates a report about the properties of the ensemble and writes this report to disk or to tracer.  Following reporting, an EnsembleMetric may be _interrogated_ by such modules as the [[EnsembleFilter]], allowing retrieval of any floating-point values computed by the EnsembleMetric for filtering.  Alternatively, the EnsembleMetric may be _reset_ for re-use (meaning that accumulated data, but not configuration settings, are wiped).

##Available EnsembleMetrics

EnsembleMetric | Description | MPI support?
-------------- | ----------- | ------------
**[[CentralTendency]]** | Takes a [[real-valued SimpleMetric|SimpleMetrics]], applies it to each pose in an ensemble, and returns measures of central tendency (mean, median, mode) and other measures of the distribution (standard deviation, standard error, etc.). | YES
**[[PNear|PNearEnsembleMetric]]** | Based on a conformational ensemble, computes the propensity to favour a desired state or the lowest-energy state sampled. | YES

## 2. Usage modes

EnsembleMetrics have three intended usage modes in [[RosettaScripts]]:

Mode | Setup | Accumulation Phase | Reporting Phase | Subsequent Interrogation | Subsequent Resetting
---- | ----- | ------------------ | --------------- | ------------------------ | --------------------
Basic accumulator mode | Added to a protocol at point of accumulation. | The EnsembleMetric is applied to each pose that the RosettaScripts script handles, in sequence. | The EnsembleMetric produces its report at termination of the RosettaScripts application.  This report covers all poses seen during this RosettaScripts run. | None. | None.
Internal generation mode | Provided with a ParsedProtocol for generating the ensemble of poses from the input pose, and a number to generate.  Added to protocol at point where ensemble should be generated from pose at that point. | Accumulates information about each pose in the ensemble it generates.  Poses are then discaded. | The report is provided immediately once the ensemble has been generated.  The script then continues with the input pose. | After reporting. | On next nstruct (repeat) or next job.
Multiple pose mover mode | Set to use input from a mover that produces many outputs (a [[MultiplePoseMover]]).  Placed in script after such a mover. | Collects data from each pose produced by previous mover. | Reports immediately after collecting data on all poses produced by previous mover.  The script then continues on. | After reporting. | On next nstruct (repeat) or next job.

### 2.1 Example of basic usage

In this example, the input is a cyclic peptide (provided with the `-in:file:s` commandline option).  This script perturbs the peptide backbone, relaxes the peptide, and then applies a [[CentralTendency EnsembleMetric|CentralTendency]] that in turn applies a [[TotalEnergyMetric]], measuring total score.  At the end of execution (after repeat execution, a number of times set with the `-nstruct` commandline option), the EnsembleMetric produces a report about the mean, median, mode, etc. of the samples.

```xml
<ROSETTASCRIPTS>
	<!-- Example of the CentralTendency EnsembleMetric used in basic accumulator mode. -->
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
	</SCOREFXNS>
	<MOVERS>
		<!-- The following movers set up, perturb, and relax a cyclic peptide: -->
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
				<AddAtoms res1="4" atom1="CA" res2="4" atom2="C" />
				<AddValue value="5.0"/>
			</AddPerturber>
		</GeneralizedKIC>
		<FastRelax name="frlx" repeats="1" scorefxn="r15" />
	</MOVERS>
	<SIMPLE_METRICS>
		<!-- The SimpleMetric that will be passed to the CentralTendency EnsembleMetric: --> 
		<TotalEnergyMetric name="total_energy" scorefxn="r15" />
	</SIMPLE_METRICS>
	<ENSEMBLE_METRICS>
		<!-- Setting up the EnsembleMetric: -->
		<CentralTendency name="avg_energy" n_threads="0" real_valued_metric="total_energy" />
	</ENSEMBLE_METRICS>
	<PROTOCOLS>
		<!-- Set up and perturb the peptide: -->
		<Add mover="connect_termini" />
		<Add mover="perturb1" />
		<Add mover="perturb2" />
		<Add mover="frlx" />
		<!-- Accumulate data with the EnsembleMetric for every replicate of the
			peturbation protocol: -->
		<Add ensemble_metrics="avg_energy" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
	<!-- The report is written on script termination, after all replicates have been
		performed (as set with the -nstruct flag on the commandline. -->
</ROSETTASCRIPTS>
```

### 2.2 Example of internal generation mode

This example is similar to the example above, only this time, we load one or more cyclic peptides (provided with the `-in:file:s` or `-in:file:l` commandline options), generate a conformational ensemble for each peptide _in memory_, without writing all structures to disk, and perform ensemble analysis on that ensemble, filtering on the results with the [[EnsembleFilter]].

```xml
<ROSETTASCRIPTS>
	<!-- Example of the CentralTendency EnsembleMetric used in internal generation mode. -->
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
	</SCOREFXNS>
	<MOVERS>
		<!-- The movers that set up, perturb, and relax a cyclic peptide are set up just as
			in the previous example.  Only this time, we bundle the perturbation protocol in a
			ParsedProtocol: -->
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
				<AddAtoms res1="4" atom1="CA" res2="4" atom2="C" />
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
		<!-- Setting up the EnsembleMetric, this time with both a SimpleMetric and a
			ParsedProtocol for generating the ensemble from a given pose: -->
		<CentralTendency name="avg_energy" n_threads="0" real_valued_metric="total_energy"
			output_mode="tracer_and_file" output_filename="report.txt"
			ensemble_generating_protocol="ensemble_generating_protocol"
			ensemble_generating_protocol_repeats="20"
		/>
	</ENSEMBLE_METRICS>
	<FILTERS>
		<!-- Set up a filter that can discard those peptides that yield an
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
			writing the structure to disk: -->
		<Add filter="filter_on_avg_energy" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>
```

#### 2.2.1 Multi-threading

When used in internal generation mode, the EnsembleMetric can generate members of the ensemble in [[parallel threads|Multithreading]].  This uses the [[RosettaThreadManager]], assigning work to available threads up to a user-specied maximum number to request.  To set the maximum number of threads to request, use the `n_threads` option (where a setting of zero means to request all available threads).  This functionality is only available in multi-threaded builds of Rosetta (built using `extras=cxx11thread` in the `scons` command), and requires that the total number of Rosetta threads be set at the command line using the `-multithreading:total_threads` commandline option.  Note that an EnsembleMetric may be assigned fewer than the requested number of threads if other modules are using threads; at a minimum, it is guaranteed to be assigned the calling thread.  **Note: this is a _highly_ experimental feature that can fail for many ensemble-generating protocols.  When in doubt, it is safest to set `n_threads` to 1 (the default) for an EnsembleMetric.**

### 2.3 Example of multiple pose mover mode

The following example uses the [[BundleGridSampler]] mover to grid-sample helical bundle conformations parametrically.  For each conformation sampled, the protocol then uses the [[Disulfidize]] mover to generate all possible disulfides joining the helices as an ensemble of poses.  It then computes the median disulfide pair energy, and discards conformations for which this energy is above a cutoff.

```xml
<ROSETTASCRIPTS>
	<!-- Generate a bunch of helical bundles, find all the disulphides that they can form,
	and score the median dslf_fa13 score across all disulphide pairs.  Reject helical bundles with
	disulfide scores above a threshold.-->
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
	</SCOREFXNS>
	<MOVERS>
		<!-- Grid-sample conformations of two-helix bundles: -->
		<BundleGridSampler name="bgs" scorefxn="r15" helix_length="24"
			use_degrees="true" reset="true" nstruct_mode="true"
		>
			<Helix omega0_min="0.0" omega0_max="2.5" omega0_samples="4" r0_min="4.4" r0_max="5.2" r0_samples="4" />
			<Helix pitch_from_helix="1" r0_copies_helix="1" delta_omega0="180" />
		</BundleGridSampler>
		<!-- Add termini: -->
		<DeclareBond name="add_termini" atom1="C" atom2="N" res1="1" res2="2" add_termini="true" />
		<!-- Generate an ensemble of poses, each with a single disulfide bond linking the
		helices.  (Note that the Disulfidize mover is a multiple pose mover.) -->
		<Disulfidize name="disulfidize" min_disulfides="1" max_disulfides="1"
			scorefxn="r15" 
		/>
	</MOVERS>
	<SIMPLE_METRICS>
		<!-- The SimpleMetric that will be used by the CentralTendency EnsembleMetrc, below: -->
		<TotalEnergyMetric name="dslf_energy" scorefxn="r15" scoretype="dslf_fa13" />
	</SIMPLE_METRICS>
	<ENSEMBLE_METRICS>
		<!-- Compute the median disulfide pair energy across the ensemble of disulfide pairings
		for the current backbone conformation:-->
		<CentralTendency name="median_energy" n_threads="0" real_valued_metric="dslf_energy"
			output_mode="tracer_and_file" output_filename="report.txt"
			use_additional_output_from_last_mover="true"
		/>
	</ENSEMBLE_METRICS>
	<FILTERS>
		<!-- Discard backbone conformations for which the median energy is too high: -->
		<EnsembleFilter name="filter_on_median_energy" ensemble_metric="median_energy"
			named_value="median" filter_acceptance_mode="less_than_or_equal"
			threshold="2.5"
		/>
	</FILTERS>
	<PROTOCOLS>
		<Add mover="bgs" />
		<Add mover="add_termini" />
		<Add mover="disulfidize" />
		<Add ensemble_metrics="median_energy" /> <!-- Report generated here! -->
		<Add filter="filter_on_median_energy" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>
```

## 3. Interrogating EnsembleMetric floating-point values by name

Each EnsembleMetric can return one or more floating-point values describing different features of the ensemble.  Each of these has a name associated with it.

### 3.1 From C++ or Python code

From C++ (or Python) code, after an EnsembleMetric produces its final report, these values can be interrogated with the `get_metric_by_name()` method.  To see all names offered by a particular EnsembleMetric, call `real_valued_metric_names()`:

```C++
	// C++ pseudo-code:

	// Create an EnsembleMetric:
	CentralTendencyEnsembleMetric my_ensemble_metric;
	// Configure this EnsembleMetric here.  This particular
	// example would require a SimpleMetric to be passed to
	// it, though in general the setup for EnsembleMetrics
	// will vary from EnsembleMetric subclass to subclass.

	for( core::Size i=1; i<=nstruct; ++i ) {
		// Generate a pose here.
		// ...

		// Collect data from it:
		my_ensemble_metric.apply( pose );
	}

	// Produce final report (to tracer or disk,
	// depending on configuration):
	my_ensemble_metric.produce_final_report();

	// Get the names of floating point values
	// that the EnsembleMetric has calculated:
	utility::vector1< std::string > const value_names(
		my_ensemble_metric.real_valued_metric_names()
	);

	// Confirm that "median" is a name of a value
	// returned by this particular metric:
	runtime_assert( value_names.has_value( "median" ) ); //This passes.

	// Get the median value from the ensemble:
	core::Real const median_value(
		my_ensemble_metric.get_metric_by_name( "median" )
	);
```

### 3.2 Using filters

In RosettaScripts (or in PyRosetta or even C++ code), when an EnsembleMetric is used in internal generator mode or multiple pose mover mode (_i.e._ it applies itself to an ensemble of poses that it either generates internally or receives from a previous mover) a subsequent [[EnsembleFilter]] may be used to interrogate a named value computed by the EnsembleMetric, and to cause the protocol to pass or fail depending on that property of the ensemble.

Why would someone want to do this?  One example would be if one wanted to write a script that would design a protein, generate for each design a conformational ensemble, and score the propensity to favour the designed conformation (_e.g._ with the planned [[PNear]] EnsembleMetric), then discard those designs that have poor propensity to favour the designed state based on the ensemble analysis.  This would ensure that one could produce thousands or tens of thousands of designs in memory, analyze them all, and only write to disk the ones worth carrying forward.  Variant patterns include generating initial designs using a low-cost initial design protocol, doing moderate-cost ensemble analysis, discarding poor designs with the EnsembleFilter, and refining those designs that pass the filter using higher-cost refinement protocols.  Other similar usage patterns are possible.

Note that if one simply wants the value produced by the EnsembleMetric to be recorded in the pose, the EnsembleFilter can be used for that purpose as well by setting `confidence="0"` (so that the filter never rejects anything, but only reports).  At some point, a SimpleMetric may be written for that purpose.  For more information, see the page for the [[EnsembleFilter]].

## 4. Note about running in MPI mode

The [[Message Passing Interface (MPI)|MPI]] permits massively parallel execution of a Rosetta protocol.  If an EnsembleMetric is used in basic mode (Section 2.1) using the [[MPI build|Build-Documentation]] of Rosetta, all poses seen _by all processes_ are considered part of the ensemble that is being analysed.  At the end of the protocol, all of the instances of the EnsembleMetric on worker processes will report back to the director process with the measurements needed to allow the director process to perform the analysis on the whole ensemble.  This can be convenient for rapidly analysing very large ensembles generated in memory across a large cluster, without needing to write thousands or millions of structuers to disk.  This functionality is currently only available in the [[JD2]] version of the [[RosettaScripts]] application, and only when the [[MPIWorkPoolJobDistributor|JD2]] (the default MPI JD2 job distributor) or the MPIFileBufJobDistributor (the default MPI JD2 job distributor for use with Rosetta silent files) is used.  Support for [[JD3|RosettaScripts-JD3]] is planned.

Note that EnsembleMetrics that run in different MPI processes, and which generate ensembles internally using either a generating protocol (Section 2.2) or a multiple pose mover (Section 2.3), report immediately on the ensemble seen locally _in that process_. In this case, no information is shared between processes.

As a final note, some EnsembleMetrics may not support MPI job collection.  These should tell you so with a suitable error message at parse time (i.e. before you run an expensive protocol and try to collect in results).  See the table of EnsembleMetrics for MPI support.

## 5. See Also

* [[SimpleMetrics]]: Measure a property of a single pose.
* [[Filters|Filters-RosettaScripts]]: Filter on a measured feature of a pose.
* [[EnsembleFilter]]: Filter on a property of an ensemble of poses.
* [[Movers|Movers-RosettaScripts]]: Modify a pose.
* [[I want to do x]]: Guide to choosing a Rosetta protocol.
