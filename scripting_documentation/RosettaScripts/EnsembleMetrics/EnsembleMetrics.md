# EnsembleMetrics
*Back to main [[RosettaScripts|RosettaScripts]] page.*

Page created Wed, 9 February 2022 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

[[_TOC_]]

## Description

Just as [[SimpleMetrics]] measure some property of a pose, EnsembleMetrics measure some property of a group (or _ensemble_) of poses.  They are designed to be used in two phases.  In the _accumulation_ phase, an EnsembleMetric is applied to each pose in an ensemble in sequence, allowing it to store any relevant measurements from that pose that will later be needed to calculate properties of the ensemble.  In the _reporting_ phase, the EnsembleMetric generates a report about the properties of the ensemble and writes this report to disk or to tracer.  Following reporting, an EnsembleMetric may be _interrogated_ by such modules as the [[EnsembleFilter]], allowing retrieval of any floating-point values computed by the EnsembleMetric for filtering.  Alternatively, the EnsembleMetric may be _reset_ for re-use (meaning that accumulated data, but not configuration settings, are wiped).

##Available EnsembleMetrics

EnsembleMetric  | Description
------------ | -------------
**[[CentralTendency]]** | Takes a [[real-valued SimpleMetric|SimpleMetrics]], applies it to each pose in an ensemble, and returns measures of central tendency (mean, median, mode) and other measures of the distribution (standard deviation, standard error, etc.).

## Usage modes

EnsembleMetrics have three intended usage modes in [[RosettaScripts]]:

Mode | Setup | Accumulation Phase | Reporting Phase | Subsequent Interrogation | Subsequent Resetting
---- | ----- | ------------------ | --------------- | ------------------------ | --------------------
Basic accumulator mode | Added to a protocol at point of accumulation. | The EnsembleMetric is applied to each pose that the RosettaScripts script handles, in sequence. | The EnsembleMetric produces its report at termination of the RosettaScripts application.  This report covers all poses seen during this RosettaScripts run. | None. | None.
Internal generation mode | Provided with a ParsedProtocol for generating the ensemble of poses from the input pose, and a number to generate.  Added to protocol at point where ensemble should be generated from pose at that point. | Accumulates information about each pose in the ensemble it generates.  Poses are then discaded. | The report is provided immediately once the ensemble has been generated.  The script then continues with the input pose. | After reporting. | On next nstruct (repeat) or next job.
Multiple pose mover mode | Set to use input from a mover that produces many outputs (a [[MultiplePoseMover]]).  Placed in script after such a mover. | Collects data from each pose produced by previous mover. | Reports immediately after collecting data on all poses produced by previous mover.  The script then continues on. | After reporting. | On next nstruct (repeat) or next job.

### Example of basic usage

In this example, the input is a cyclic peptide.  This script perturbs the peptide backbone, relaxes the peptide, and then applies a [[CentralTendency EnsembleMetric|CentralTendency]] that in turn applies a [[TotalEnergyMetric]], measuring total score.  At the end of execution (after repeat execution, a number of times set with the `-nstruct` flag), the EnsembleMetric produces a report about the mean, median, mode, etc. of the samples.

```xml
<ROSETTASCRIPTS>
	<!-- Example of the CentralTendency EnsembleMetric used in basic accumulator mode. -->
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" />
	</SCOREFXNS>
	<MOVERS>
		<!-- The following movers set up, perturb, and relax a cyclic peptide: -->
		<DeclareBond name="connect_termini" res1="8" res2="1" atom1="C" atom2="N" add_termini="true" />
		<GeneralizedKIC name="perturb1" selector_scorefunction="r15" closure_attempts="200" stop_when_n_solutions_found="1" selector="lowest_rmsd_selector" >
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
		<GeneralizedKIC name="perturb2" selector_scorefunction="r15" closure_attempts="200" stop_when_n_solutions_found="1" selector="lowest_rmsd_selector" >
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
		<!-- Accumulate data with the EnsembleMetric for every replicate of the peturbation protocol: -->
		<Add ensemble_metrics="avg_energy" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
	<!-- The report is written on script termination, after all replicates have been performed (as set with the -nstruct flag on the commandline. -->
</ROSETTASCRIPTS>
```

### Example of internal generation mode

TODO

### Example of multiple pose mover mode

TODO

## Interrogating EnsembleMetric floating-point values by name

Each EnsembleMetric can return one or more floating-point values describing different features of the ensemble.  Each of these has a name associated with it.

### From C++ or Python code

From C++ (or Python) code, after an EnsembleMetric produces its final report, these values can be interrogated with the `get_metric_by_name()` method.  To see all names offered by a particular EnsembleMetric, call `real_valued_metric_names()`:

```C++
	// Create an EnsembleMetric:
	CentralTendency my_ensemble_metric;
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

### Using filters

In RosettaScripts (or in PyRosetta or even C++ code), when an EnsembleMetric is used in internal generator mode or multiple pose mover mode (_i.e._ it applies itself to an ensemble of poses that it either generates internally or receives from a previous mover) a subsequent [[EnsembleFilter]] may be used to interrogate a named value computed by the EnsembleMetric, and to cause the protocol to pass or fail depending on that property of the ensemble.

Why would someone want to do this?  One example would be if one wanted to write a script that would design a protein, generate for each design a conformational ensemble, and score the propensity to favour the designed conformation (_e.g._ with the planned [[PNear]] EnsembleMetric), then discard those designs that have poor propensity to favour the designed state based on the ensemble analysis.  This would ensure that one could produce thousands or tens of thousands of designs in memory, analyze them all, and only write to disk the ones worth carrying forward.  Variant patterns include generating initial designs using a low-cost initial design protocol, doing moderate-cost ensemble analysis, discarding poor designs with the EnsembleFilter, and refining those designs that pass the filter using higher-cost refinement protocols.  Other similar usage patterns are possible.

For more information, see the page for the [[EnsembleFilter]].

## Note about running in MPI mode

TODO

##See Also

* [[SimpleMetrics]]: Measure a property of a single pose.
* [[Filters|Filters-RosettaScripts]]: Filter on a measured feature of a pose.
* [[EnsembleFilter]]: Filter on a property of an ensemble of poses.
* [[Movers|Movers-RosettaScripts]]: Modify a pose.
* [[I want to do x]]: Guide to choosing a Rosetta protocol.