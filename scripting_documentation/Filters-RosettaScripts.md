#Filters (RosettaScripts)

[[Return to RosettaScripts|RosettaScripts]]

Each filter definition has the following format:

```
<"filter_name" name="&string" ... confidence=(1 &Real)/>
```

where "filter\_name" belongs to a predefined set of possible filters that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the filter needs to be defined.

If confidence is 1.0, then the filter is evaluated as in predicate logic (T/F). If the value is less than 0.999, then the filter is evaluated as fuzzy, so that it will return True in (1.0 - confidence) fraction of times it is probed. This should be useful for cases in which experimental data are ambiguous or uncertain.

[[_TOC_]]

Predefined Filters
------------------

#### TrueFilter

Returns true. Useful for defining a mover without using a filter. Can be explicitly specified with the name "true\_filter".

#### FalseFilter

Always returns false. Can be explicitly specified with the name "false\_filter".

Special Filters
---------------

Filters which are useful for combining, modifying or working with other filters and movers.

#### CompoundStatement filter

This is a special filter that uses previously defined filters to construct a compound logical statement with NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT operations. By making compound statements of compound statements, esssentially all logical statements can be defined.

```
<CompoundStatement name=(&string) invert=(false &bool)>
    <OPERATION filter_name=(true_filter &string)/>
    <....
</CompoundStatement>
```

where OPERATION is any of the operations defined in CAPS above.Note that the operations are performed in the order that they are defined. No precedence rules are enforced, so that any precedence has to be explicitly written by making compound statements of compound statements. Setting invert=true will cause the final boolean value to be inverted. If, for instance multiple AND statements are evaluated and each evaluates to true, then the filter will return false.

Note that the first OPERATION specified in the compound statement treated as a negation if NOT, ANDNOT, or ORNOT is specified.

#### CombinedValue filter

This is a special filter that calculates a weighted sum based on previously defined filters.

```
<CombinedValue name=(&string) threshold=(0.0 &Real)>
    <Add filter_name=(&string) factor=(1.0 &Real) temp=(&Real)/>
    <....
</CombinedValue>
```

By default, the value is a straight sum of the calculated values (not the logical results) of the listed filters. A multiplicative weighting factor for each filter can be specified with the `     factor    ` parameter. (As a convenience, `     temp    ` can be given instead of `     factor    ` , which will divide the filter value, rather than multiply it.)

For truth value contexts, the filter evaluates to true if the weighted sum if less than or equal to the given `     threshold    ` .

#### CalculatorFilter

    <CalculatorFilter name=(&string) equation=(&string) threshold=(&real 0) >
          <VAR name=(&string) filter=(&string) value=(&Real)/>
        ... 
    </CalculatorFilter>

Combine one or more other filters in a semi-arbitrary equation. The equation is a standard mathematical expression using operators +-\*/\^ (caret is exponentiation) with standard operator precedence (when in doubt, use parenthesis).

Case sensitive variables can be defined using subtags, either with a filter, or as a constant. The value of the filter is determined only once, and the same value is used for all instances of the variable in the equation. Variables can also be defined within the equation itself, with the syntax "name = expression ;", with the terminal semicolon. The last entry must be the non-assignment expression to which the filter will evaluate to.

For convenience, several functions are defined as well:

ABS(), EXP(), LN(), LOG()/LOG10(), LOG2(), LOG(a,b), SQRT(), SIN() COS(), TAN(), R2D(), D2R(), MIN(...), MAX(...), MEAN(...), MEDIAN(...)

The function names are case insensitive. LOG(a,b) is the base b logarithm of a, trigonometric functions are in radians, R2D() and D2R() are functions to convert radians to degrees and vice versa, and MIN/MAX/MEAN/MEDIAN can take any number of comma separated values.

In truth contexts the filter will evaluate to true if the resultant value is less than given threshold.

Example:

    <CalculatorFilter name=test threshold=0 equation="t1 = exp(-E1/kT); t2 = exp(-E2/kT); t1/( t1 + t2 )" >
          <VAR name=E1 filter=bound />
          <VAR name=E2 filter=altbind />
          <VAR name=kT value=0.6 />
    </CalculatorFilter>

CAVEAT: The parsing of the equation is a little touchy and black-box at the moment. Diagnostic error messages are poor at best. I'd recommend starting with a simple equation and working your way up (bad equations should be detected at parse-time.)

#### ReplicateFilter

```
<ReplicateFilter name=(&string) filter_name=(&string) replicates=(&integer 1) upper_cut=(&real 0) lower_cut=(&real 0) median=(&bool 0) threshold=(&real 0) />
```

Repeats a given filter the given number of times. It then trims off the highest and lowest values given by upper\_cut and lower\_cut, respectively. If upper/lower cut are less than one, they are interpreted as a fraction to remove, rounded down, and if greater than one as an absolute number of replicates to remove. It then averages the remaining values. By default it uses the mean of the values, although if median is true it will use the median. In truth contexts it will evaluate to true if the resultant value is less than given threshold.

#### Boltzmann

Returns the Boltzmann weighted sum of a set of positive and negative filters. The fitness is actually defined as -F with [-1-0] range (-1 most optimal, 0 least).

```
<Boltzmann name=(&string) fitness_threshold=(0&real) temperature=(0.6 &real) positive_filters=(&comma delimited list) negative_filters=(&comma delimited list) anchors=(&comma delimited list of floats) triage_threshold=(-9999 &int) norm_neg=(false &bool)/>
```

-   fitness\_threshold: below which fitness threshold to allow?
-   temperature: the Boltzmann weighting factor (in fact, kT rather than T).
-   positive\_filters: a list of predefined filters to use as the positive states. The filters' report\_sm methods will be invoked, so there's no need to fret about their thresholds.
-   negative\_filters: as above, only negative.
-   anchors: an anchor per positive state to cap the drift in its energy. Specifying no anchors is fine. A very high value for the anchor means, in practice, no anchor.
-   triage\_threshold: above which threshold (e.g. delta score/delta ddg) a negative state will be counted in the Boltzmann fitness calculation. This prevents the dilution of negative states.
-   norm\_neg: normalize the fitness of the mutation state in relative to the original state. When triage\_threshold is used the number of negative states is changed, therefore norm\_neg is needed in order to compare mutations in the same position.

Useful for balancing counteracting objectives.

#### MoveBeforeFilter

Apply a given mover to the pose before calculating the results from another filter

```
<MoveBeforeFilter name=(&string) mover=(&string) filter=(&string)/>
```

Note that, like all filters, MoveBeforeFilter cannot change the input pose - the results of the submover will only be used for the subfilter calculation and then discarded.

Also note that caution must be exercised when using a computationally expensive mover or a mover/filter pair which yields stochastic results. The result of the mover is not cached, and will be recomputed for each call to apply(), report() or report\_sm().

#### Operator

sum, multiply, find the max or min of a list of filters

```
<Operator name=(&string) filters=(comma-separated list of filters&string) threshold=(0&Real) operation=(one of: SUM/NORMALIZED_SUM/PRODUCT/MIN/MAX/SUBTRACT/ABS/BOOLEAN_OR &string) negate=(0&bool) logarithm=(0&bool)/>
```

Evaluate the list of filters with the operator, and return whether or not they pass the threshold. NORMALIZED\_SUM returns the sum divided by the number of filters. SUBTRACT accepts only two filters, and returns the first - the second. ABS accepts only one filter and returns the absolute value of that filter's report\_sm. BOOLEAN\_OR(x,y) = x + y - x\*y

Operators of operators are allowed, providing a way to generate any statement.

-   filters: list of previously defined filters on which to carry out the operation
-   negate: multiply return value by -1. Useful in optimization
-   logarithm: take the log(x) value of the resulting operator.

#### Sigmoid

Transform a filter's value according to a sigmoid: fx = 1 / ( 1 + exp[ x - offset - baseline ] \* steepness ) )

The midpoint for the filter is at offset and steepness determines how steeply it climbs at the midpoint.

```
<Sigmoid name=(&string) filter=(&string) threshold=(0&Real) steepness=(1.0 &Real) offset=(0.0 &Real) negate=(0 &bool) baseline_checkpoint=(""&string)/>
```

-   threshold: values above this threshold pass as true
-   negate: substitute -x for x in evaluation
-   baseline\_checkpoint: file name to keep track of the baseline value. The baseline is the filter's value when a method called reset\_baseline is called. This allows the user to have a dynamic setting of the offset used in computing the transform.

The function above asymptotically reaches 0 at high x and 1 at low x. The offset can be modified during run time using the reset\_baseline function, but this is only available to Operator filter at this time.

Baseline can only be set within the Rosetta code and is triggered by Operator filter's reset\_baseline. Operator filter's reset\_baseline, in turn, is triggered by GenericMonteCarloMover at the first iteration through the mover. Subsequent calls to Operator (and through it to Sigmoid) are evaluated with this baseline. In this way, the offset can be determined apriori by the user to a threshold above or below the starting value of the filter at the start of GenericMonteCarlo. For instance, say that you're optimizing binding energy, but are not sure what the binding energy will be at the start of GenericMonteCarlo. You set the offset to 2, and if the binding energy is evaluated to -10 at the start of the Monte Carlo simulation, the offset is made as -8.

By setting baseline\_checkpoint to a file name, the baseline will be saved to a file, and will be read from it in case of failure/recovery. This is useful in case a long MC trajectory has been pre-empted and needs to be restarted. Reading the baseline from the checkpointing file is only triggered if the MC trial is greater than 1. If it's 1, the baseline is instead computed and written to the checkpointing file.

#### IfThenFilter

```
<IfThenFilter name=(&string) threshold=(&Real 0) lower_threshold=(&bool False)>
    <IF testfilter=(&string) inverttest=(&bool False) valuefilter=(&string) value=(&Real) weight=(&Real 1)/>
    <IF testfilter=(&string) inverttest=(&bool False) valuefilter=(&string) value=(&Real) weight=(&Real 1)/>
    ....
    <ELSE valuefilter=(&string) value=(&Real 0) weight=(&Real 1)/>
</IfThenFilter>
```

Evaluate to a value contingent on the true/false value of other filters. Each of the IF clauses are evaluated in order. If the testfilter evaluates to true, the real-valued result of the IfThenFilter is the real-valued return value of the valuefilter, multiplied by the corresponding weight. (If inverttest is true, a false testfilter will cause valuefilter evaluation.) Alternatively, you can omit the valuefilter, and give a literal value with the value parameter (which will also be multiplied by the given weight). If none of the IF clauses return true for their testfilters, then the real-valued result of the ELSE clause valuefilter (or the corresponding literal value) multiplied by the weight is used as the value instead.

For truth value testing, the default is to return true if the value is less than or equal to the given threshold. If lower\_threshold is true, then IfThenFilter returns true if the value is greater than or equal to the threshold.

#### ContingentFilter

A special filter that allows movers to set its value (pass/fail). This value can then be used in the protocol together with IfMover to control the flow of execution depending on the success of the mover. Currently, none of the movers uses this filter.

```
<ContingentFilter name=(&string)/>
```

#### PoseComment
Test for the existence or the value of a comment in the pose. This is useful for controlling execution flow: if the pose comments have been modified you do one thing or another.

```
<PoseComment name=(&string) comment_name=(&string, "" ) comment_value=(&string, "") comment_exists=(&bool, false )/>
```
- comment_name: the key value of the comment
- comment_value: the comment's value
- comment_exists: check only whether the comment exists or not, regardless of its content.

If you run with comment_name="" then all the pose comments are checked to find the requested value.


#### Range

This filter returns true if the return value of the given filter is between lower\_bound and upper\_bound.

```
<Range name=(&string) filter=(&string) lower_bound=(&Real) upper_bound=(&Real)/>
```

General Filters
---------------

### Basic Filters

#### ResidueCount

Filters structures based on the total number of residues in the structure.

```
<ResidueCount name=(&string) max_residue_count=(Inf &Integer) min_residue_count=(0 &Integer) residue_types=("" &string) count_as_percentage=(0 &Bool) />
```

-   residue\_types: Comma-separated list of which residue type names. (e.g. "CYS,SER,HIS\_D" ). Only residues with type names matching those in the list will be counted.
-   max\_residue\_count: Is the total number of residues less than or equal to the maximum allowable residue count?
-   min\_residue\_count: Is the total number of residues more than or equal to the minimum allowable residue count?
-   count\_as\_percentage: If this is true, count residues as percentage (=100*raw_number_of_specified_residue/total_residue) instead of counting raw number of it, also  max_residue_count/min_residue_count are assumed to be entered as percentage

This is useful when protocols can make very large structures, e.g. with symmetric or modular assembly protocols that may be too big to handle with available computational resources.

#### NetCharge

This filter sums up all of the positively and negatively charged amino acids in your structure and reports a simplistic sequence-based net charge.

```
<NetCharge name=(&string) min=(-100 &Integer) max=(100 &Integer) chain=(0 &Integer) task_operations=("" &string) />
```

-   min: minimum net charge desired (default: -100).
-   max: maximum net charge desired (default: 100).
-   chain: specify which chain you want to calculate the net charge (In the input PDB file, from top to bottom: 1 means first chain, 2 means the second chain, and so forth). Use the value 0 (default) if you want to consider all residues in the input PDB structure.
-   task_operations: all residues that are designable according to the task_operations will be selected for computing the net charge. Residues not set to be designable will not be counted.

This filter assigns basic residues LYS and ARG residues to +1, while acidic residues ASP and GLU are assigned to -1.

### Energy/Score

#### BindingStrain

Computes the energetic strain in a bound monomer. Automatically respects symmetry

```
<BindingStrain name=(&string) threshold=(3.0 &Real) task_operations=(comma-delimited list of operations &string) scorefxn=(score12 &string) relax_mover=(null &string) jump=(1 &Int)/>
```

-   threshold: how much strain to allow.
-   task\_operations: define the repacked region. Whatever you choose, the filter will make sure you don't design and that the packer task is initialized from the commandline.
-   scorefxn: what scorefxn to use for repacking and total-score evaluations.
-   relax\_mover: after repacking in the unbound state, what mover (if at all) to use to further relax the structure (MinMover?)
-   jump: along which jump to dissociate the complex?

Dissociates the complex and takes the unbound energy. Then, repacks and calls the relax mover, and measures the unbound relaxed energy. Reports the strain as unbound - unbound\_relaxed. Potentially useful to relieve strain in binding.

#### Delta

Computes the difference in a filter's value compared to the input structure

```
<Delta name=(&string) upper=(1 &bool) lower=(0 &bool) range=(0 &Real) filter=(&string) unbound=(0 &bool) jump=(see below &Int) relax_mover=(null &string)/>
```

-   upper/lower: the threshold is upper/lower? Use both if the threshold is an exact value.
-   range: how much above/below the baseline to allow?
-   filter: the name of a predefined filter for evaluation.
-   unbound: translates the partners by 10000A before evaluating the baseline and the filters. Allows evaluation of the unbound pose.
-   jump: if unbound is set, this can be used to set the jump along which to translate.
-   relax\_mover: called at parse-time before setting the baseline. Useful to get the energies as low as possible (repack/min?)

The filter is evaluated at parsetime and its internal value (through report\_sm) is saved. At apply time, the filter's report\_sm is called again, and the delta is evaluated.

#### EnergyPerResidue

Tests the energy of a particular residue (e.g. pdb\_num=1), or interface (whole\_interface=1), or whole protein (whole\_protein=1), or a set of residues (e.g. resnums=1,2,3). If whole\_interface is set to 1, it computes all the energies for the interface residues defined by the jump\_number and the interface\_distance\_cutoff. Helpful for post-design analyses. bb\_bb needs to be turn to 1, if one wants to evaluate backbone - backbone hydrogen bonding energies (short and long range). Set whole\_protein=1 to scan the whole protein, or provide resnums to scan a list of residues

```
<EnergyPerResidue name=(energy_per_res_filter &string) scorefxn=(score12 &string) 
score_type=(total_score &string) pdb_num/res_num=(&string) energy_cutoff=(0.0 &float)
whole_interface=(0 &bool) jump_number=(1 &int) interface_distance_cutoff=(8.0 &float) bb_bb=(0, bool) resn resns=("1" &string)/> whole_protein=(0 &int) resnums=(&string)
```

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   resnums, a list of residue numbers (1,2,3 for pose numbering or 1A,2A,3A for pdb numbering) to filter through

#### Residue Interaction Energy

Finds the ineraction energy (IE) for the specified residue over the interface (interface=1) or the entire pose (interface=0). Then applies an interaction penalty if the IE is above the specified cutoff, such that penalty = sum (IE(res)-(cutoff)). e.g. if the residue is a trp with IE -5 and cutoff of -6.5 the penalty is 1.5.

```
<ResidueIE name=(&string) scorefxn=(score12 &string) score_type=(total_score &string) energy_cutoff=(0.0 &float) restype3=(TRP &string; 3 letter code) interface=(0 &bool) whole_pose(0 &bool) jump_number=(1 &float) interface_distance_cutoff=(8.0 &float) max_penalty=(1000.0 &float) penalty_factor=(1.0 & float)/>
```

One way to use this filter is to look at IE over real protein interfaces, see stats below. One would then set the cutoff at mean + SD, e.g. at -6.5 for Trp.

IE statistics have been calculated for aromatics by Alex Ford (ZDOCK, prot/prot set) and Sagar Khare (CSAR, prot/ligand) sets (number of samples in paren):

|Values:    |  mean(CSAR) | SD(CSAR) |  mean(ZDOCK)  |  SD (ZDOCK) |
|-----------|-------------|----------|---------------|-------------|
|W          |  -8.8 (82)  | 2.3      |  -8.6         |   2.0       |
|F          |  -7.3 (128) | 2        |  -7           |   1.9       |
|Y          |  -7.4 (108) | 1.7      |  -6.5         |   2.2       |


#### ScoreType

Computes the energy of a particular score type for the entire pose and if that energy is lower than threshold, returns true.

```
<ScoreType name=(score_type_filter &string) scorefxn=(score12 &string) score_type=(total_score &string) threshold=(&float)/>
```

<!--- BEGIN_INTERNAL -->

#### AverageInterfaceEnergy

(This is a devel Filter and not available in released versions.)

Takes task operations to determine the repackable residues and then calculates/filters based on the average value across these residues for a desired score term or the total energy by default (using functions from the EnergyPerResidue filter). The threshold is set to 100000 by default so that it should function as a report filter unless the threshold is set by the user. Works for both symmetric and asymmetric poses, and poses with symmetric “building blocks”.

```
<AverageInterfaceEnergy name=(&string) task_operations=(&comma-delimited list of taskoperations) scorefxn=(score12 &string) score_type=(total_score &string) cutoff=(100000 &Real) bb_bb=(0 &bool) />
```

-   task\_operations: task operations used to set the repackable residues
-   scorefxn: scorefunction to use during the energy calculations. Defaults to score12
-   score\_type: score term to calculate the average of across the repackable residues. Defaults total.
-   cutoff: Threshold for the highest permissible value for a passing design.
-   bb\_bb: See EnergyPerResidueFilter.

<!--- END_INTERNAL -->

#### ResidueSetChainEnergy

Computes the interaction energy between 2 groups of residues: 1. a set of residues and 2. all residues on a given chain. The groups may overlap. Useful for biasing design to back up a grafted loop or epitope. Group1 is defined with resnums, a list of residue numbers (1,2,3 for pose numbering or 1A,2A,3A for pdb numbering). Group2 is defined with chain, which is the rosetta chain number. If the residue set (Group1) is on the same chain as the user-defined chain (Group2), then the energy does include intra-group1 energies.

```
<ResidueSetChainEnergy name=(residue_set_chain_energy_filter &string) scorefxn=(score12 &string) score_type=(total_score &string) resnums=(&string) chain=(0 &int) threshold=(&float)/>
```

### Distance

#### ResidueDistance

What is the distance between two residues? Based on each residue's neighbor atom (usually Cbeta)

```
<ResidueDistance name=(&string) res1_res_num=(&string) res1_pdb_num=(&string) res2_res_num=(&string) res2_pdb_num=(&string) distance=(8.0 &Real)/>
```

Either \*res\_num or \*pdb\_num may be specified for res1 and res2. See [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]] .

#### AtomicContact

Do two residues have any pair of atoms within a cutoff distance? Somewhat more subtle than ResidueDistance (which works by neighbour atoms). Iterates over all atom types of a residue, according to the user specified restrictions (sidechain, backbone, protons)

```
<AtomicContact name=(&string) residue1=(&integer) residue2=(&integer) sidechain=1 backbone=0 protons=0 distance=(4.0 &integer)/>
```

Some movers (e.g., PlaceSimultaneously) can set a filter's internal residue on-the-fly during protocol operation. To get this behaviour, do not specify residue2.

#### AtomicContactCount

Counts sidechain carbon-carbon contacts among the specified residues under the given distance cutoff.

Iterates across all side-chain atoms of residues specified as packable in the given task operation, defaulting to all residues if no task operation is given, counting carbon-carbon pairs. Optionally restricts count to cross-jump contacts or cross-chain contacts. Optionally normalizes contact count by cross-jump or cross-chain interface sasa.

Operates in three modes:

-   'all' - Counts all side-chain carbon-carbon contacts among residues specified in the task operation.

<!-- -->

       <AtomicContactCount name=(&string) partition=all task_operations=(comma-delimited list of operations &string)  distance=(4.5 &integer)/>

-   'jump' - Counts all side-chain carbon-carbon contacts spanning the specified jump among the specified residues. Normalize-by-sasa calculates sasa score using the specified jump and the sasa filter.

<!-- -->

        <AtomicContactCount name=(&string) partition=jump task_operations=(comma-delimited list of operations &string)  distance=(4.5 &integer) jump=(1 &integer) normalize_by_sasa=(0 &bool)/>

-   'chain' - Counts all side-chain carbon-carbon contacts between residues on different chains among the specified residues. Normalize-by-sasa defaults to all calculating sasa for all chains in the pose, optional 'detect\_by\_task' only calculates interface sasa among chains containing residues specified in the task. May under-calculate sasa if the task operation unexpectedly excludes all residues within a chain.

<!-- -->

       <AtomicContactCount name=(&string) partition=chain task_operations=(comma-delimited list of operations &string)  distance=(4.5 &integer) normalize_by_sasa=(0*|detect_by_task|1 &str)/>

Example:

To count atomic contacts between aromatic and apolar residues, an OperateOnCertainResidues task operation to select aromatic and apolar residues is passed to the AtomicContactCount filter.

       <TASKOPERATIONS>
         <OperateOnCertainResidues name=aromatic_apolar>
           <PreventRepackingRLT/>
           <NoResFilter>
             <ResidueType aromatic=1 apolar=1/>
           </NoResFilter>
         </OperateOnCertainResidues>
       </TASKOPERATIONS>
       ....
       <FILTERS>
         <AtomicContactCount name=cc_jump partition=jump jump=1 normalize_by_sasa=0 task_operations=aromatic_apolar confidence=0/>
         <AtomicContactCount name=cc_jump_norm partition=jump jump=1 normalize_by_sasa=1 task_operations=aromatic_apolar confidence=0/>
       </FILTERS>
       ...
       <PROTOCOLS>
         <Add filter_name=cc_jump/>
         <Add filter_name=cc_jump_norm/>
       </PROTOCOLS>

#### AtomicDistance

Are two specified atoms within a cutoff distance? More specific than AtomicContact (which reports if *any* atom is within the cutoff) or ResidueDistance (which works by neighbor atoms only). Residues can be specified either with pose numbering, or with PDB numbering, with the chain designation (e.g. 34B). One of atomname or atomtype (but not both) needs to be specified for each partner. If atomtype is specified for one or both atoms, the closest distance of all relevant combinations is used.

```
<AtomicDistance name=(&string) residue1=(&string) atomname1=(&string) atomtype1=(&string) residue2=(&sring) atomname2=(&string) atomtype2=(&string) distance=(4.0 &integer)/>
```

#### TerminusDistance

True if all residues in the interface are more than \<distance\> residues from the N or C terminus. If fails, reports how far failing residue was from the terminus. If passes, returns "1000"

```
<TerminusDistance name=(&string) jump_number=(1 &integer) distance=(5 &integer)/>
```

-   jump\_number: Which jump to use for calculating the interface?
-   distance: how many residues must each interface residue be from a terminus? (sequence distance)

### Geometry

#### Torsion

```
<Torsion name=(&string) lower=(0&Real) upper=(0&Real) resnum=(0&residue number) torsion=("" &string) task_operations=(&comma-delimited list of taskoperations)/>
```

-   lower: lower cutoff
-   upper: upper cutoff
-   resnum: pdb/rosetta numbering
-   torsion: phi/psi/""
-   task\_operations: The residues to be output can also be defined through a task factory. All residues that are designable according to the taskfactory will be output. resnum and task\_operations are mutually exclusive, so don't set both at the same time.

not setting torsion, will cause the report of both phi and psi. Not specifying resnum will cause a report of all residues. If you want to filter on a given torsion, you have to specify both resnum the torsion and the higher/upper values.

#### HelixPairing

Filter structures based on the geometry of helix pairings. Relating helix pairing geometry, this filter provides three parameters, dist, cross, and align, and the structures of which parameters are "below" thresholds are filtered.

```
<HelixPairing name=(&string) blueprint=(&string) helix_pairings=(&string)  dist=(15.0&Real) cross=(45.0&Real) align=(25.0&Real) bend=(20.0&Real) output_id=(1&Integer) output_type=(dist&string) />
```

-   helix\_pairings: helix pair is described by paired helix indices separated by "-" with orientations (P or A) after dot ".". Ex. 1-2.A means the pairing between the 1st and 2nd helices. The multiple pairings are concatenated with semicolon ";". Ex. 1-2.A;2-3.A;1-3.P
-   dist: distance between mid points of paired helices
-   cross: angle between helix vectors. The helix vector is between the centers of C- and N- terminal helix.
-   align: angle between helix vectors projected onto beta sheet that is defined by the strands immediately followed before the helices. This is calculated only when the strands exists within 6 residues before the helices.
-   bend: check bend of intra helix. This is not pairing related parameter, but for checking the intra helix bending. Basically, you don't need change this parameter.
-   output\_id: the helix pair id to be output in score file. e.g. 1 means 1-2.A in 1-2.A;2-3.P.
-   output\_type: parameter type to be output in score file, dist, cross, or align.
-   blueprint: By giving blueprint file, you can forcibly assign secondary structure. See for [[Blueprint]].

#### SecondaryStructureFilter

```
      <SecondaryStructure name=(&string, required) use_abego=(&int, optional) blueprint=(&string) ss=(&string) abego=(&string) />
```

Filter structures based on the SecondaryStructure, either from a string (EEEEEHHHH) or from a blueprint.

**Usage of dssp mover is required** : You must call the dssp mover prior to applying this filter, as in the example below.

-   ss: secondary structure string, e.g. "HHHHHLLLHHHHH" \<LE\> abego: string of abego values, turn on use\_abego
-   use\_abego: 0 or 1. (optional, requires abego values to match those specified in the blueprint)
-   blueprint: filename string format for a blueprint file (e.g. "../input.blueprint"; standard blueprint file)

**Secondary Structure specification** :

-   E: sheet
-   H: helix
-   h: not helix (so either E or L)
-   L: loop
-   D: wildcard (allows anything)

Example with a blueprint:

```
      <SecondaryStructure name=ss_filter1  use_abego=1 blueprint="input.blueprint" />
```

Examples with top7 derived structures

(Input)

```
<FILTERS>
        <SecondaryStructure name=ss ss=LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL/>
</FILTERS>
<MOVERS>
         <Dssp name=dssp/>
</MOVERS>
<PROTOCOLS>
    <Add mover=dssp/>
        <Add filter=ss/>
</PROTOCOLS>
```

(Output)

```
(when passed) 

protocols.fldsgn.filters.SecondaryStructureFilter: LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL was filtered with 91 residues matching LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLLLEEEEELLEEEEEEEL


(when failed)

protocols.fldsgn.filters.SecondaryStructureFilter: SS filter fail: current/filtered = H/L at position 25
protocols.fldsgn.filters.SecondaryStructureFilter: LEEEEEEEELLLLEEEEEEEELLLLHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLhhEEEEELLEEEEEEEL was filtered with 90 residues matching LEEEEEEEELLLLEEEEEEEELLLHHHHHHHHHHHHHHHHLLLEEEEEEELLLHHHHHHHHHHHHHHHHHLLLLEEEEEEELLEEEEEEEL
```

#### Helix kink

```
<HelixKink name=(&string) bend=(20, &Real) resnums=(&string) helix_start=(1 &int)  helix_end=(1 &int)/>
```

-   bend: cutoff for bend angle
-   resnums: comma separated residues to be evaluated. Any helix contains any residues in this list will be considered, default without specifying will scan whole proteins
-   helix\_start and helix\_end specify a range that needs to be one continuous helix to be evaluated. Default is 1, but you should set a sensible value when you specify.

#### Bond geometry and omga angle

```
<Geometry name=(&string) omega=(165&Real) cart_bonded=(20 &Real) start=(1 &residue number) end=("100000" &residue number) />
```

-   omega: cutoff for omega angle of peptide plane, Cis-proline is also considered. Works for multiple chains
-   cart\_bonded: bond angle and length penalty score
-   start: starting residue number to scan
-   end: ending residue number

#### HSSTriplet

Evaluate the given helix-strand-strand triplets. Calculates distance between strand pair and helix, and the angle between the plane of the sheet and the helix. Returns true if the distance is between min_dist and max_dist, and if the angle is between min_angle and max_angle. Also can report a value based on output_id and output_type.
```
<HSSTriplet name=(&string) hsstriplets=("" &string) blueprint=("" &string) min_dist=(7.5 &Real) max_dist=(13.0 &Real) min_angle=(-12.5 &Real) max_angle=(90.0 &Real) output_id=(1 &bool) output_type=("dist" &string) />
```

-   hsstriplets: a string describing the HSS Triplets. Either hsstriplets or blueprint must be specified, and both cannot be used at the same time. The format of the string is: i-j,k  
     Where i is an integer denoting the strand number of strand1 (from N to C), j is an integer denoting the strand number of strand2, and k is an integer denoting the number of the helix.
-   blueprint: a blueprint file which contains an HSS triplets information in the above format. Cannot be used at the same time as the "hsstriplets" option
-   min_dist: minimum distance for acceptance from the helix to the plane of the sheet
-   max_dist: maximum distance for acceptance from the helix to the plane of the sheet
-   min_angle: minimum angle between the strands and helix
-   max_angle: maximum angle between the strands and helix
-   output_id: Specifies which HSS triplet in the list of input HSS triplets will be reported
-   output_type: Valid values are "dist" and "angle" -- dist returns the distance of the HSS triplet specified by output_id, and angle returns the angle

### Packing/Connectivity

#### CavityVolume

Uses Will Sheffler's packing code to estimate the total volume of intra-protein voids. The value returned is the sum of volumes of the computed cavities in Angstroms <sup>3</sup>. A value of 20 is approximately equal to the volume of a carbon atom. This filter currently has no options or threshold, and currently always returns true, but that is likely to change in the future.

```
<CavityVolume name=(&string) />
```

**Example**

```
<FILTERS>
    <CavityVolume name="cav_vol" />
<FILTERS>
<PROTOCOLS>
    <Add filter_name="cav_vol" />
</PROTOCOLS>
```

#### AverageDegree

What is the average degree connectivity of a subset of residues? Found to be useful for discriminating non-interacting designs from natural complexes. Apparently, many non-interacting designs use surfaces that are poorly embedded in the designed monomer, a feature that can be easily captured by this simple metric. See Fleishman et al. J. Mol. Biol. 414:289

```
<AverageDegree name=(&string) threshold=(0&Real) distance_threshold=(&10.0) task_operations=(comma-delimited list)/>
```

-   threshold: how many residues need to be on average in the sphere of each of the residues under scrutiny.
-   distance\_threshold: Size of sphere around each residue under scrutiny.
-   task\_operations: define residues under scrutiny (all repackable residues).

#### PackStat

Computes packing statistics.

```
<PackStat name=(&string) threshold=(0.58 &Real) chain=(0 &integer) repeats=(1 &integer)/>
```

-   threshold: packstat above which filter passes. Common wisdom says 0.65 is a good number.
-   chain: jump on which to separate the complex before computing packstat. 0 means not to separate the complex.
-   repeats: How many times to repeat the calculation.

#### InterfaceHoles

Looks for voids at protein/protein interfaces using Will Sheffler's packstat. The number reported is the difference in the holes score between bound/unbound conformations. Be sure to set the -holes:dalphaball option!

```
<InterfaceHoles name=(&string) jump=(1 &integer) threshold=(200 &integer)/>
```

-   jump: Which jump to calculate InterfaceHoles across?
-   threshold: return false if above this number

#### NeighborType

Filter for poses that place a neighbour of the types specified around a target residue in the partner protein.

```
<NeighborType name=(neighbor_filter &string) res_num/pdb_num=(&string) distance=(8.0 &Real)>
        <Neighbor type=(&3-letter aa code)/>
</NeighborType>
```

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### ResInInterface

Computes the number of residues in the interface specific by jump\_number and if it is above threshold returns true. o/w false. Useful as a quick and ugly filter after docking for making sure that the partners make contact.

```
<ResInInterface name=(riif &string) residues=(20 &integer) jump_number=(1 &integer)/>
```

#### ShapeComplementarity

Calculates the Lawrence & Coleman shape complementarity using a port of the original Fortran code from CCP4's sc. Symmetry aware. Can be calculated across a jump (default behavior) or the two surfaces can be specified by explicitly providing lists of the residues making up each surface.

Should work with *most* ligands via Lucas Nivon's recent commit.

Set write\_int\_area to add the SC interface area to the scorefile. Use sym\_dof\_name instead of jump for multicomponent symmetries.

```
<ShapeComplementarity name=(&string) min_sc=(0.5 &Real) min_interface=(0 &Real) verbose=(0 &bool) quick=(0 &bool) jump=(1 &int) sym_dof_name=("" &string) residues1=(comma-separated list) residues2=(comma-separated list) write_int_area=(1 &bool) />
```

* min_sc - The filter fails if the calculated sc is less than the given value.
* min_interface - The filter fails is the calculated interface area is less than the given value
* verbose - If true, print extra calculation details to the tracer
* quick - If true, do a quicker, less accurate calculation by reducing the density. 
* jump - For non-symmetric poses, which jump over which to calculate the interface.
* sym_dof_name - For symmetric poses, which dof over which to calculate the interface.
* residues1 & residues2 - Explicitly set which residues are on each side of the interface (both symmetric and non-symmetric poses.)
* write_int_area - If true, write interface area to scorefile.

#### SecondaryStructureShapeComplementarity

Uses the same code underlying the ShapeComplementarity filter to calculates the Lawrence & Coleman shape complementarity of secondary structure elements of a protein with one another. Essentially, secondary structure elements (e.g. loops, helices) are cut from the protein and their shape complementarity is calculated against the rest of the protein. The protein is then returned to its state when the filter was called and the next secondary structure element is cut and computed. The value calculated is equal to sum( sc\_i\*a\_i )/a\_tot, where sc\_i is the shape complementarity value of secondary structure element i with the rest of the protein, a\_i is the area of interaction of secondary structure element i with the rest of the protein, and a\_tot is the total intraprotein area of all secondary structure elements. Sheets are currently not supported. The secondary structure elements can optionally be specified using a blueprint file. For antibody-antigen interfaces, a value of 0.65-0.67 is typical, while complementarity among intra-protein secondary structure elements is typically higher, on the order of 0.7-0.8. This filter currently always returns true, but that is likely to change in the near future with addition of a threshold option.

```
<SSShapeComplementarity name=(&string) blueprint=("" &string) verbose=(0 &bool) loops=(1 &bool) helices=(1 &bool) />
```

-   blueprint: If specified, the given blueprint file will be used to assign secondary structure. If not specified, DSSP will be used.
-   verbose: If set, verbose output will be generated by the ShapeComplementarity calculator
-   loops: If set, loops will be included in the calculations. Otherwise, they will be skipped.
-   helices: If set, helices will be included in the calculations. Otherwise, they will be skipped.

##### Example

The following example XML will create a SecondaryStructureShapeComplementarity filter which uses the secondary structure definitions in "input.blueprint" and computes the SC of all helices with the rest of the protein.

```
<FILTERS>
    <SSShapeComplementarity name="ss_sc" blueprint="input.blueprint" verbose="1" loops="0" helices="1" />
<FILTERS>
<PROTOCOLS>
    <Add filter_name="ss_sc" />
</PROTOCOLS>
```

#### SpecificResiduesNearInterface

Filter for poses that have a specific set of residues near the interface. For example, this can be useful for designs that depend on say the N-terminus being close to the interface

```
<SpecificResiduesNearInterface name=(&string) task_operation=(&string)/>
```

### Burial

#### TotalSasa

Computes the overall sasa of the pose. If it is \*\*higher\*\* than threshold, it passes. However, it also has the option for an upper\_threshold, where it fails if it is above the upper\_threshold.

```
<TotalSasa name=(sasa_filter &string) threshold=(800 &float) upper_threshold=(1000000000000000 &float) hydrophobic=(0&bool) polar=(0&bool) task_operations=(comma-delimited list of operations &string) />
```

-   upper\_threshold: maximum size allowed
-   hydrophobic: compute hydrophobic-only SASA?
-   polar: compute polar\_only SASA?
-   task\_operations: Only report the SASA for those residues specified as packable for the given taskoperations. If not specified, compute over all residues.
-   report\_per\_residue\_sasa: Add the per-residue SASA to the tracer output.

hydrophobic/polar are computed by discriminating each atom into polar (acceptor/donor or polar hydrogen) or hydrophobic (all else) and summing the SASA over each category.

#### Sasa

Computes the sasa specifically in the interface. If it is \*\*higher\*\* than threshold, it passes. However, it also has the option for an upper\_threshold, where it fails if it is above the upper\_threshold.

```
<Sasa name=(sasa_filter &string) threshold=(800 &float) upper_threshold=(1000000000000000 &float) hydrophobic=(0&bool) polar=(0&bool) jump=(1 &integer) sym_dof_names("" &string)/>
```

-   upper\_threshold: maximum size allowed
-   hydrophobic: compute hydrophobic-only SASA?
-   polar: compute polar\_only SASA?
-   jump: across which jump to compute total SASA?
-   sym\_dof\_names: Use sym\_dof\_names controlling the master jumps to determine across which jump(s) to compute total SASA. For use with multi-component symmetries.

hydrophobic/polar are computed by discriminating each atom into polar (acceptor/donor or polar hydrogen) or hydrophobic (all else) and summing the delta SASA over each category. Notice that at this point only total sasa can be computed across jumps other than 1. Trying to compute hydrophobic or polar sasa across any other jump will cause an exit during parsing.

#### ResidueBurial

How many residues are within an interaction distance of target\_residue across the interface. When used with neighbors=1 this degenerates to just checking whether or not a residue is at the interface.

```
<ResidueBurial name=(&string) res_num/pdb_num=(&string) distance=(8.0 &Real) neighbors=(1 &Integer) task_operations=(&comma-delimited list of taskoperations) residue_fraction_buried=(0.0001 &Real)/>
```

-   task\_operations: the task factory will be used to determine what residues are designable. If any of these residues pass the burial threshold, the filter will return true; o/w false. Allows setting the burial filter dynamically at runtime.
-   residue\_fraction\_buried: what fraction of the total residues defined as designable by the taskfactory should actually be buried in order to return false. The default (0.0001) effectively means that 1 suffices. Set to 1.0 if you want all residues to be buried.
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### ExposedHydrophobics

(This is a devel Filter and not available in released versions.)

Computes the SASA for each hydrophobic residue (A, F, I, M, L, W, V, Y). The score returned reflects both the number of solvent-exposed hydrophobic residues and the degree to which they are exposed. The score is calculated as follows. For each hydrophobic residue, if the SASA is above a certain cutoff value (default=20), then the value of ( SASA - sasa\_cutoff ) is added to the calculated score. The filter passes if the calculated score is less than the user-specified threshold.

```
<ExposedHydrophobics name=(&string) sasa_cutoff=(20 &Real) threshold=(-1 &Real) />
```

-   sasa\_cutoff: If a residue has SASA lower than this value, it is considered buried and does not affect the score returned by the ExposedHydrophobics filter.
-   threshold: If a protein has an ExposedHydrophobics total score below this value, it passes the filter. If a negative threshold is specified, the filter will always pass.

### Comparison

#### RelativePose

Compute a filter's value relative to a different pose's structure. This is useful for cases in which you want to know the effects of a mutation on different poses. An alignment of the pose being read from disk is made to the currently active pose (through the user defined alignment), and applies any sequence changes to the pose read from disk, while repacking a shell around each mutation. It can then apply a relax mover, report a filter's evaluation and dump a scored pose to disk. Works with symmetric poses as well.

```
<RelativePose name=(&string) pdb_name=(&string) filter=(&string) relax_mover=(null &string) dump_pose=("" &string) alignment=(&string; see below) scorefxn=(score12 &string) packing_shell=(8.0 &Real) thread=(1 &bool) baseline=(1 &bool) unbound=(0 &bool) copy_stretch=(1&bool) rtmin=(0 &bool) symmetry_definition=("" &string) copy_comments=("" &comma-delimited list)>
```

-   pdb\_name: which is the reference pose to read from disk.
-   filter: which filter to apply.
-   relax\_mover: which relax mover to apply after threading.
-   dump\_pose: optional- should we dump the pose after threading?
-   alignment: what segments to align between the disk-pose and the current pose. defaults to aligning from 1-\>nres. To specify something different use the following format: 3A:1B,4A:2B,5A:6B, meaning align disk pose's 3A-5A to 1B,2B, and 6B on the current pose. Only the aligned segments are searched for mutations between the disk and current pose for threading. All else is ignored. If no residue number is specified, the method aligns chains. For instance: A:D,B:B, means align A with D and B with B. No checks are made to guarantee length compatibility etc.
-   scorefxn: used for packing during threading and for scoring the dumped pose.
-   packing\_shell: radius of shell around each residue to repack after threading. The more use use the longer the simulation.
-   thread: Normally you'd want this to be true. This is not the case only if you're estimating baselines for the disk pose before doing an actual run.
-   baseline: shall we use the pose which is read from disk as a reference? (means that the filter's return value will equal the filter's value at run time minus the reference value.
-   unbound: before threading, should we dissociate the complex?
-   copy\_stretch: rather than threading the residue identities on the pose read from disk, copy the aligned segment from the current pose onto the pose read from disk (residue identities + conformations). No repacking is done, and then goes straight to relax. Obviously the segment should be prealigned for this to make any sense, and should probably only be used on entire chains rather than stretches within chains. Any way, take care in using. No guarantees.
-   rtmin: do rtmin following repack?
-   symmetry\_definition: if symmetric, enter the symmetry definition file here.
-   copy_comments: a comma-delimited list of pose-comment key values to copy from the reference pose (the current pose computed in the trajectory) to the relative pose (from disk). Useful if conformational change needs to be communicated from the reference pose to the relative pose.

#### Rmsd

Calculates the Calpha RMSD over a user-specified set of residues. Superimposition is optional. Selections are additive, so choosing a chain, and individual residue, and span will result in RMSD calculation over all residues selected. If no residues are selected, the filter uses all residues in the pose. 

By default, the RMSD will be calculated to the input pose (pose at parse time). Use -in:file:native \<filename\> or reference_name= to choose an alternate reference pose.

```
<Rmsd name=(&string) chains=("" &string) threshold=(5 &integer) superimpose=(1 &bool) reference_name=(&string) >
    <residue res/pdb_num=(&string) />
    <span begin_(res/pdb_num)=("" &integer) end_(res/pdb_num)=(""&integer)/>
</Rmsd>
```

-   chains: list of chains (eg - "AC") to use for RMSD calculation
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   residue: add a new leaf for each residue to include (can use rosetta index or pdb number)
-   span: contiguous span of residues to include (rosetta index or pdb number)
-   threshold: accept at this rmsd or lower
-   superimpose: perform superimposition before rmsd calculation?
-   reference_name: If given, use the pose saved with the SavePoseMover under the given reference_name as the reference.

#### SidechainRmsd

Calculates the all atom RMSD for a single residue, either with or without the backbone atoms. The RMSD calculated is the automorphic RMSD, so it will compensate for symmetric rearrangments. (For example, Phe ring flips.) No superposition is performed prior to rmsd calculation.

```
<SidechainRmsd name=(&string) res1_(res/pdb)_num=(&string) res2_(res/pdb)_num=(&string) reference_name=(&string) include_backbone=(0 &bool) threshold=(1.0 &real) />
```

-   res1\_(pdb/res)\_num: The residue number for the active pose. see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   res2\_(pdb/res)\_num: The residue number for the reference pose. see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   reference\_name: The name of the reference pose as saved with the [[SavePoseMover|Movers-RosettaScripts#SavePoseMover]] . If not given, will default to the structure passed to -in:file:native if it set, or the input structure, if not.
-   include\_backbone: Whether to include the backbone in the RMSD calculation. (It is recommended to set this to "true" for ligands and other residues which don't have a backbone.)
-   threshold: In a truth value context, what's the maximum RMSD value which is considered to be passing.

#### SequenceRecovery

Calculates the fraction sequence recovery of a pose compared to a reference pose. This is similar to the [[InterfaceRecapitulation|Movers-RosettaScripts#InterfaceRecapitulation]] mover, but does not require a design mover. Instead, the user can provide a list of task operations that describe which residues are designable in the pose. Works with symmetric poses and poses with symmetric "building blocks". Can also filter based on/report to the scorefile the number of mutations rather than the recovery rate if desired by using the report\_mutations and mutation\_threshold options. Will output the specific mutations to the tracer if the option verbose=1. The reference pose against which the recovery rate will be computed can be defined using the -in:file:native command-line flag. If that flag is not defined, the starting pose will be used as a reference.

```
<SequenceRecovery name=(&string) rate_threshold=(0.0 &Real) task_operations=(comma-delimited list of operations &string) mutation_threshold=(100 &Size) report_mutations=(0 &bool) verbose=(0 &bool) />
```

-   rate\_threshold: Lower cutoff for the acceptable recovery rate for a passing design. Will fail if actual rate is below this threshold.
-   task\_operations: Define the designable residues.
-   mutation\_threshold: Upper cutoff for the number of mutations for an acceptable design. Only matters if report\_mutations is set to true.
-   report\_mutations: Defaults to false. If set to true, then will act as a filter for the number of mutations rather than the rate.
-   verbose: Defaults to false. If set to true, then will output the mutated positions and identities to the tracer.

### Bonding

#### HbondsToResidue

This filter checks whether residues defined by res\_num/pdb\_num are hbonded with as many hbonds as defined by partners, where each hbond needs to have at most energy\_cutoff energy. For backbone-backone hydrogen bonds, turn flag on (bb\_bb=1).

```
<HbondsToResidue name=(hbonds_filter &string) partners="how many hbonding partners are expected &integer" energy_cutoff=(-0.5 &float) backbone=(0 &bool) bb_bb=(0 &bool) sidechain=(1 &bool) res_num/pdb_num=(&string)>
```

-   backbone: should we count backbone-backbone hbonds?
-   sidechain: should we count backbone-sidechain and sidechain-sidechain hbonds?
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### HbondsToAtom

This filter checks whether a atom defined by residues through res\_num/pdb\_num and atomname are hbonded with as many hbonds as defined by partners, where each hbond needs to have at most energy\_cutoff energy. For backbone-backone hydrogen bonds, turn flag on (bb\_bb=1).

```
<HbondsToResidue name=(hbonds_filter &string) partners="how many hbonding partners are expected &integer" energy_cutoff=(-0.5 &float) backbone=(0 &bool) bb_bb=(0 &bool) sidechain=(1 &bool) res_num/pdb_num=(&string)>
```

-   backbone: should we count backbone-backbone hbonds?
-   sidechain: should we count backbone-sidechain and sidechain-sidechain hbonds?
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### BuriedUnsatHbonds

Maximum number of buried unsatisfied H-bonds allowed. If a jump number is specified (default=1), then this number is calculated across the interface of that jump. If jump\_num=0, then the filter is calculated for a monomer. Note that \#unsat for monomers is often much higher than 20. Notice that water is not assumed in these calculations. By specifying task\_operations you can decide which residues will be used to compute the statistic. ONly residues that are defined as repackable (or designable) will be used for computing. Others will be ignored. A tricky aspect is that backbone unsatisfied hbonds will also only be counted for residues that are mentioned in the task\_operations, so this is somewhat inconsistent.

```
<BuriedUnsatHbonds name=(&string) scorefxn=(&string) jump_number=(1 &Size) cutoff=(20 &Size) task_operations=(&string)/>
```

<!--- BEGIN_INTERNAL -->
#### BuriedUnsatHbonds2 

Calculate the number of buried unsatisfied H-bonds across a given interface. (Specifically, the difference in the number of buried unsatisfied hydrogen bonds in the bound state versus the bound state. This uses a different algorithm than the BuriedUnsatHbonds filter above. Specifically (*** fill in details from Kevin's presentation ***)

```
<BuriedUnsatHbonds2 name=(&string) scorefxn=(&string) jump_number=(1 &Size) cutoff=(20 &Size) layered_sasa=(1 &bool) generous_hbonds=(1 &bool) sasa_burial_cutoff=(0.01 &Real) AHD_cutoff=(120.0 &Real) dist_cutoff=(3.0 &Real) hxl_dist_cutoff=(3.5 &Real) sulph_dist_cutoff=(3.3 &Real) metal_dist_cutoff=(2.7 &Real) task_operations=(&string) />
```

* scorefxn - The scorefunction to use to evaluate hydrogen bonding energy.
* task_operations - If set, will calculate hydrogen just for residues set to be designable or packable in the task operations.
* jump_number - The jump which describes the interface across which to calculate the number of hydrogen bonds. If jump_number=0, will compute the total number of unburied hbonds for entire structure.
* cutoff - Filter is true if the number of unsatisfied hbonds is less than or equal to cutoff.
* layered_sasa - ??? 
* generous_hbonds - If true, use a generous definition of hydrogen bonds. (Includes more bb-involved hydrogen bonds, and turns off environmental dependent scoring.) 
* sasa_burial_cutoff - ???
* AHD_cutoff - Minimum accpetor-hydrogen-donor angle needed for regular hydrogen bonds.
* dist_cutoff - Distance cutoff for regular hydrogen bonds
* hxl_dist_cutoff - The distance cutoff for hydrogen bonds to hydroxyls.
* sulph_dist_cutoff - The distance cutoff for hydrogen bonds to sulfur.
* metal_dist_cutoff - The distance cutoff for "hydrogen bonds" to metals.

<!--- END_INTERNAL -->

#### DisulfideFilter

Require a disulfide bond between the interfaces to be possible. 'Possible' is taken fairly loosely; a reasonable centroid disulfide score is required (fairly close CB atoms without too much angle strain).

Residues from `     targets    ` are considered when searching for a disulfide bond. As for [[DisulfideMover|Movers-RosettaScripts#DisulfideMover]] , if no residues are specified from one interface partner all residues on that partner will be considered.

```
<DisulfideFilter name="&string" targets=(&string)/>
```

-   targets: A comma-seperated list of residue numbers. These can be either with rosetta numbering (raw integer) or pdb numbering (integer followed by the chain letter, eg '123A'). Targets are required to be located in the interface. Default: All residues in the interface. *Optional*

#### AveragePathLength

Computes the [average shortest path length](http://en.wikipedia.org/wiki/Average_path_length) on the "network" of the single-chain protein topology, considering residues as nodes and peptide and disulfide bonds as edges. Natural proteins with many disulfides tend to select disulfide configurations that minimize average path length, although average path length is a poorer metric for placing disulfides than the more correct disulfide entropy filter (below), so in general there is no longer a reason to use this filter.

Topologies will pass the filter if their average path length is lower than a fixed threshold ( `     max_path_length    ` ) and a chain length-dependent threshold. The chain length-dependent threshold was computed by surveying natural proteins with 3 or greater disulfide bonds and 60 or fewer residues, and is computed as:

threshold = (0.1429 n) + 0.8635 + `     path_tightness    `

where n is the number of residues in the chain and `     path_tightness    ` is user specified. Larger values for path\_tightness lead to a higher (and thus looser) threshold.

```
<AveragePathLength name="&string" path_tightness=(1 &Real) max_path_length=(10000 &Real)/>
```

#### DisulfideEntropy

Computes the change in deltaSconf\_folding caused by formation of the disulfide bonds in a given topology. S\_conf refers to the configurational entropy of the protein chain only.

deltaS\_conf\_folding = S\_conf\_folded - S\_conf\_unfolded

Disulfide formation restricts the conformational freedom of the denatured state, decreasing S\_conf\_unfolded, which increases deltaS\_conf\_folding.

deltaG\_folding = deltaH\_folding - T (deltaS\_conf\_folding + deltaS\_other)

A more positive deltaS\_conf\_folding leads to greater stability of the folded state (a more negative deltaG\_folding).

The change in deltaS\_conf\_folding caused by a particular disulfide configuration is computed based on modeling the denatured state of the protein using random flight configurational statistics according to a Gaussian approximation. For an overview and the equations themselves, see "Analysis and Classification of Disulphide Connectivity in Proteins: The Entropic effect of Cross-Linkage", PM Harrison & MJE Sternberg, [J Mol Biol 1994 244, 448-463](http://www.ncbi.nlm.nih.gov/pubmed/7990133) .

Briefly,

deltaS\_conf\_folding = - ln (Pn)
 P\_n = (deltaV (3/(2\*pi\*(b\^2)))\^(3/2))\^n |A\_n|\^(3/2)

where:

-   n is the number of disulfide bonds
-   P\_n is the probability of all residues that are disulfide-bonded pairs of residues "spontaneously" associating in the denatured state (forming a contact without being constrained by a disulfide bond) deltaV is the spherical shell around a particular residue where, if another residue is present, the two residues are defined as being in contact (29.65 angstroms\^3)
-   b is the distance between monomers in the polymer chain (3.8 angstroms)
-   |A\_n| is the determinant of the n by n matrix A\_n, where the diagonal elements (i,i) are the number of polymer connections within the closed loop formed by each disulfide i (a disulfide connecting residue 3 to residue 12 encloses 9 polymer connections), and the off-diagonal elements (i,j) are the number of polymer connections shared between two different disulfide loops i and j (a 3x12 disulfide and a 7x20 disulfide share 5 polymer connections: 7-8, 8-9, 9-10, 10-11, and 11-12).

Topologies will pass the filter if the change in deltaS\_conf\_folding caused by the disulfide configuration is higher (more positive) than a fixed threshold ( `     lower_bound    ` ), and more positive than a chain length- and number of disulfide-dependent threshold. The chain length- and disulfide-dependent threshold was computed by surveying natural proteins with 3-5 disulfides and 60 or fewer residues, and is computed as:

threshold = (0.1604 \* residues) + (1.7245 \* disulfides) + 5.1477 + `     tightness    `

where `     tightness    ` is user specified. Larger values for tightness lead to a higher (and thus looser) threshold. With a tightness of zero, 61% of natural proteins pass the filter. With a tightness of 1, 82% of natural proteins pass the filter, and with a tightness of -1, only 19% of natural proteins pass the filter.

```
<DisulfideEntropy name="&string" tightness=(0 &Real) lower_bound=(0 &Real)/>
```

Report Filters
--------------

These filters are used primarily for the reports they generate in the log and/or score and silent files, more so than their ability to end a run.

#### DesignableResidues

Filters based on minimum and maximum number of designable residues allowed, but defaults are set to 0 and 1000, respectively so that by default it functions primarily to report to tracers the total number of and which residues are repackable/designable according to use-defined task\_operations. Will also output text to tracers to aid in easy visualization of designable/repackable positions in Pymol. Useful for automatic interface detection (use the ProteinInterfaceDesign task operation for that). The residue number that are reported are pdb numbering. Works with symmetric poses and poses with symmetric "building blocks".

```
<DesignableResidues name=(&string) task_operations=(comma-separated list) designable=(1 &bool) packable=(0 &bool) lower_cutoff=(0 &size) upper_cutoff=(1000 &size)/>
```

-   task\_operations: define what residues are designable or repackable.
-   designable: whether or not to report the number of designable positions
-   repackable: whether or not to report the number of repackable positions
-   lower\_cutoff: minimum number of designable positions
-   upper\_cutoff: maximun number of designable positions

#### Expiry

Has a predetermined number of seconds elapsed since the start of the trajectory? If so, return false (to stop the trajectory), else return true. Yes, I realize now that this is upside down... This is useful on computer systems that want the program to exit gracefully after a predetermined set of time. After defining this filter, sprinkle calls to it throughout your PROTOCOLS section, where you want it to be evaluated.

```
<Expiry name=(&string) seconds=(&integer)/>
```

-   seconds: how many seconds until this triggers failure?

#### FileExist

Does a file exist on disk? Useful to see whether we're recovering from a checkpoint

```
<FileExist name=(&string) filename=(&string) ignore_zero_bytes=(0 &bool)/>
```

-   filename: what filename to test?
-   ignore\_zero\_bytes: if true, files that are merely place holders (contain nothing) are treated as nonexistant (filter returns false).

#### FileRemove

Remove a file from disk. Useful to clean up at the end of a trajectory, if we saved any intermediate files. But you need to know in advance the names of all files you want to delete. It doesn't support wildcards.

```
<FileRemove name=(&string) filenames=(comma delimited list, &string) delete_contents_only=(0 &bool)/>
```

-   filenames: list of file names separated by comma, e.g., 3r2x\_0001.pdb,3r2x\_0002.pdb
-   delete\_contents\_only: if true, only eliminates the contents of the file but leaves a placeholder file of size 0bytes.

#### RelativeSegmentFilter

Reports the numbers of residues that align with a segment on source pose.

```
<RelativeSegment name=(&string) source_pose=(&string) start_res=(&string) stop_res=(&string)/>
```

-   source\_pose: The pose to which to align. The two poses should be superimposed prior to running. This filter will not superimpose.
-   start\_res: start res for alignment. Refers to residues on the source pose. Rosetta numbering only.
-   stop\_res: stop res for alignment. ditto.

Taskoperation RestrictToAlignedSegments supersedes this filter as it allows more than one segment to be defined. Use that taskoperation and feed it to DesignableResidues filter to find aligned residues in the input pose.

#### Report

This filter reports the value of another filter with the current job name. Useful when running long trajectories where one wants to see intermediate values of successful trajectories.

```
<Report name=(&string) filter=("" &string) report_string=(""&string) checkpointing_file=(""&string)/>
```

-   filter: name of a filter on the datamap that report will invoke.
-   report\_string: name of an object on the datamap that stores a value for reporting. This requires another mover/filter to be aware of this object and modify it. Currently no movers/filters use this functionality, but it could come in useful in future.
-   checkpointing\_file: If the protocol is checkpointed (e.g., through GenericMonteCarlo) this will make ReportFilter checkpoint its data. If the checkpointing file exists the value from the checkpointing file will be read into ReportFilter's internal value and will be reported at the end of the run. On apply, the filter's value will be written to the checkpointing file.

23Sep13 report\_string is not really necessary. Report filter simply caches the value of the filter when you call ReportFilter and then returns this saved value at the end of the run. Simple and useful

#### RotamerBoltzmannWeight

Approximates the Boltzmann probability for the occurrence of a rotamer. The method, usage examples, and analysis scripts are published in Fleishman et al. (2011) Protein Sci. 20:753.

Residues to be tested are defined using a task\_factory (set all inert residues to no repack). A first-pass alanine scan looks at which residues contribute substantially to binding affinity. Then, the rotamer set for each of these residues is taken, each rotamer is imposed on the pose, the surrounding shell is repacked and minimized and the energy is summed to produce a Boltzmann probability. Can be computed in both the bound and unbound state.

This is apparently a good discriminator between designs and natives, with many designs showing high probabilities for their highly contributing rotamers in both the bound and unbound states.

The filter also reports a modified value for the complex ddG. It computes the starting ddG and then reduces from this energy a fraction of the interaction energy of each residue the rotamer probability of which is below a certain threshold. The interaction energy is computed only for the residue under study and its contacts with residues on another chain.

For real-valued contexts, the value of the filter by default is the modified ddG value. If the no\_modified\_ddG option is set true, then the value of the filter is equal to the negative of the average rotamer probablility across the evaluated residues.

Works with symmetric poses and poses with symmetric "building blocks".

```
<RotamerBoltzmannWeight name=(&string) task_operations=(comma-delimited list) radius=(6.0 &Real) jump=(1 &Integer) sym_dof_names=("" &string) unbound=(1 &bool) ddG_threshold=(1.5 &Real) scorefxn=(score12 &string) temperature=(0.8 &Real) energy_reduction_factor=(0.5 &Real) repack=(1&bool) skip_ala_scan=(0 &bool) no_modified_ddG=(0 &bool)>
   <??? threshold_probability=(&Real)/>
   .
   .
   .
</RotamerBoltzmannWeight>
```

-   task\_operations: define what residues to work on. Set all residues not to be tested to no repack.
-   radius: repacking radius around the rotamer under consideration. These residues will be repacked and minimized for each rotamer tested
-   jump: what jump to look at
-   sym\_dof\_names: what jumps to look at: Look up jumps corresponding to sym\_dofs and separate the pose along these jumps. Can separate along multiple at once.
-   unbound: test the bound or unbound state?
-   ddG\_threshold: a further filter on which designs to test. Only residues that contribute more than the stated amount to binding will be tested.
-   temperature: the scaling factor for the Boltzmann calculations. This is actually kT rather than just T.
-   energy\_reduction\_factor: by what factor of the interaction energy to reduce the ddG.
-   repack: repack in the bound and unbound states before reporting binding energy values (ddG). If false, don't repack (dG).
-   skip\_ala\_scan: do not conduct first-pass ala scan. Instead compute only for residues that are allowed to repack in the task factory.
-   no\_modified\_ddG: Skip the ddG calculation.
-   ??? any of the three-letter codes for residues (TRP, PHE, etc.)

#### StemFinder
Compare a set of homologous but structurally heterogeneous PDBs to a template PDB and find structurally highly conserved sites that can serve as stems for splicing segments.
```
<StemFinder name=(&string) from_res=(1&int) to_res=(pose.total_residue()&int) rmsd=(0.7&float) stems_on_sse=(false&bool) stems_are_neighbors=(true&bool) neighbor_distance=(4.0&float) neighbor_separation=(10&int) filenames=(&comma-separated list of pdb file names)/>
```
- from_res, to_res: template positions (in rosetta numbering) in which to search for stems. (positions out of range will be ignored).
- rmsd: cutoff for the average rmsd between a given position in the template and all of the closest positions in the homologues.
- stems_on_sse: demand that in each of the homologues the candidate stems are on 2ary structural elements. This isn't a good idea, b/c DSSP is a bit noisy
- stems_are_neighbors: should we eliminate stems that are farther than neighbor_distance from one another?
- neighbor_distance: minimal atomic distance between any pair of atoms on each of the residues.
- neighbor_separation: minimal aa separation between candidate stem sites
- filenames: PDB structures that are well aligned to the template. Use align or cealign.


#### AlaScan

Substitutes Ala for each interface position separately and measures the difference in ddg compared to the starting structure. The filter always returns true. The output is only placed in the REPORT channel of the tracer output. Repeats causes multiple ddg calculations to be averaged, giving better converged values.

```
<AlaScan name=(&string) scorefxn=(score12 &string) jump=(1 &Integer) interface_distance_cutoff=(8.0 &Real) partner1=(0 &bool) partner2=(1 &bool) repeats=(1 &Integer) repack=(1 &bool)/>
```

-   scorefxn: scorefxn to use for ddg calculations
-   jump: which jump to use for ddg calculations. If jump=0 the complex is not taken apart and only the dG of the mutation is computed.
-   interface\_distance\_cutoff: how far apart counts as an interface (in angstroms)
-   partner1: report ddGs for everything upstream of the jump
-   partner2: report ddGs for everything downstream of the jump
-   repack: repack in the bound and unbound states before reporting the energy (ddG). When false, don't repack (dG).

<!--- BEGIN_INTERNAL -->

#### TaskAwareAlaScan

(This is a devel Filter and not available in released versions.)

Takes a set of task operations from the user in order to more precisely specify a set of residues to analyze via alanine scanning (see above). Individually mutates each of the residues to alanine and calculates the change in binding energy (ddG).

```
<TaskAwareAlaScan name=(& string) task_operations=(comma-delimited list of task operations) jump=(1 &Size) repeats=(1 &Size) scorefxn=(&scorefxn) repack=(1 &bool) report_diffs=(1 &bool) exempt_identities=(comma-delimited list of amino acid identities) write2pdb=(0 &bool) />
```

-   task\_operations - The task operations to use to identify which residues to scan. Designable or packable residues are scanned.
-   jump - Which jump to use for ddg calculations.
-   repeats - How many times to repeat the ddg calculations; the average of all the repeats is returned.
-   scorefxn - The score function used for the calculations.
-   repack - Whether to repack in the bound and unbound states before reporting the energy.
-   report\_diffs - Whether to report the changes in binding energy upon mutation (pass true), or the total binding energy for the mutated structure (pass false).
-   exempt\_identities - The user can exempt certain amino acid identities (for instance, glycine) from being mutated to alanine during scanning by specifying them here (e.g., "GLY,PRO").
-   write2pdb - Whether to write the residue-specific ddG information to the output .pdb file.

<!--- END_INTERNAL --> 

#### FilterScan

Described in Whitehead et al., Nat Biotechnol. 30:543

Scan all mutations allowed by `     task_operations    ` and test against a filter. Produces a report on the filter's values for each mutation as well as a resfile that says which mutations are allowed. The filter can work with symmetry poses; simply use SetupForSymmetry and run. It will figure out that it needs to do symmetric packing for itself.

```
<FilterScan name=(&string) scorefxn=(score12 &string) task_operations=(comma separated list) triage_filter=(true_filter &string) dump_pdb=(0 &bool) filter=(&string) report_all=(0 &bool) relax_mover=(null &string) resfile_name=(<PDB>.resfile &string) resfile_general_property=("nataa" &string) delta=(0 &bool) unbound=(0 &bool) jump=(1 &int) rtmin=(0&bool) delta_filters=(comma delimited list of filters) score_log_file=("" &string)/>
```

-   triage\_filter: If this filter evaluates to false, don't include the mutation in the resulting resfile
-   dump\_pdb: dump models for each of the single mutants that pass triage filter. The pdb is scored and dumped after running the relax mover. The naming is: \<input file name\>RESxxxRES where the suffix for the Ala278-\>Arg mutant will look like ALA278ARG.
-   filter: Used only for reporting the value for the pose in the tracer report
-   report\_all: By default, only attempted mutations which pass `      triage_filter     ` will be evaluated by `      filter     ` and reported in the tracer report. If `      report_all     ` is true, report the value of `      filter     ` for all evaluated mutations. (Note this will increase the number of calls to `      filter     ` /the computational cost.)
-   relax\_mover: After mutation, what mover to use for relax (minimization may be a good idea) This mover is in addition to repacking done as part of the mutation. (Repacking is done according to `      task_operations     ` , but is limited to an 8 Angstrom shell around each mutated residue.)
-   scorefxn: The scorefunction to use with the mutation repacking
-   resfile\_name: the output resfile name. Defaults to what's the -s on the commandline +".resfile"
-   resfile\_general\_property: What to do with all other residues in the resfile
-   delta: Test the filter against a baseline which is the filter's value at the start of the run?
-   unbound: Test the filter in the unbound state?
-   jump: If unbound, which jump?
-   rtmin: carry out an rtmin repack step before the relax steps? Improves the fit of the mutated residue but can lead to noisy energies.
-   delta\_filters: a list of filters of type DeltaFilter. See below for baseline evaluation.
-   score\_log\_file: filename to put the score values (per residue filter output).

To compute a baseline, the entire pose is first repacked (with include current, no design, initialized from the comandline, but ignoring the taskoperations), and relax\_mover is called. This can be useful to get the pose's energy down. If delta\_filters are specified then before introducing mutations to any given position, the mutation to self is made (say Arg25-\>Arg), repacked/rtmin,relaxed as usual and each filter's value is evaluated. Then, these values are set as the baselines for each DeltaFilter.

Filter and triage\_filter are potentially confusing. You can use the same filter for both. Triage\_filter can be more involved, including compound filter statements, whereas the filter option is reserved to filters that have meaningful report\_sm methods (ddG, energy...).

The reported values from filter will appear in a Tracer called ResidueScan, so -mute all -unmute ResidueScan will only output the necessary information

Use the unbound option only on a Prepacked structure with jump\_number=1, o/w the reference energy (baseline) won't make any sense.

#### Time

Simple filter for reporting the time a sequence of movers/filters takes.

```
<Time name=(&string)/>
```

Within the protocol, you need to call time at least twice, once, when you want to start the timer, and then, when you want to stop. The reported time is that between the first and last calls.

#### PoseInfo

Primarily intended for debugging purposes. When invoked, it will print basic information about the pose (e.g. PDB numbering and FoldTree layout) to the standard/tracer output.

This filter \*always\* returns true, therefore it's not recommended to use it with the standard "confidence" option, as that may result in the filter not being applied when you want it to be (and consequently not getting the tracer output).

```
<PoseInfo name=(&string)/>
```

<!--- BEGIN_INTERNAL -->

#### SaveResfileToDisk

(This is a devel Filter and not available in released versions.)

Saves a resfile to the output directory that specifies the amino acid present at each position defined by a set of input task operations. Outputs "PIKAA X", where X is the current amino acid in the pose at that position.

```
<SaveResfileToDisk name=(&string) task_operations=(comma-delimited list of task operations) designable_only=(0 &bool) resfile_prefix=(&string) resfile_suffix=(&string) resfile_name=(&string) resfile_general_property=(NATAA &string) selected_resis_property=(&string) renumber_pdb=(0 &bool) />
```

-   task\_operations - Used to define which residues are output to the resfile.
-   designable\_only - If true, only designable positions are output, otherwise all repackable positions are output.
-   resfile\_prefix - A prefix that will be appended to each output resfile.
-   resfile\_suffix - A suffix that will be appended to each output resfile.
-   resfile\_name - A name for the output resfile, that will go between the prefix and suffix, if specified. If resfile\_name is not specified, will get the current job name from the job distributor and use that.
-   resfile\_general\_property - What general property should go at the top of the output resfile.
-   selected\_resis\_property - What property to use for the selected residues (defaults to "PIKAA X", where X is the current amino acid in the pose.
-   renumber\_pdb - If true, use the numbering of residues corresponding to what would be output with the flag -out:file:renumber\_pdb. Otherwise use the current PDB numbering. (If you've already renumbered the residues, there should be no difference.)

<!--- END_INTERNAL --> 

#### SSPrediction

(This is a devel Filter and not available in released versions.)

Uses the sequence in the pose to generate secondary structure predictions for each position. Secondary structure predictions are then compared to the desired secondary structure to determine a score. If use\_probability is true, the score returned is a value between 0 and 1, where 0 is complete secondary structure agreement, and 1 is no agreement. The following equation is used to determine the score:
sum(i=1;N;e^(-p[i]/T)), where N is the number of residues, p[i] is the probability of correct secondary structure at position i, and T is a temperature factor set to 0.6 by default.
If use\_probability is false, the filter returns the fraction of residues that match the desired secondary structure as a number between 0 and 1.
If use\_probability is true AND mismatch\_probability is true, the score is the geometric average of the probability of picking the WRONG secondary structure type at all residue positions.  Minimizing this number will maximize the geometric average of the probability of picking the CORRECT secondary structure type at all residue positions.  This option should be the most correct method for comparing two sequences to determine their expected fragment quality based on their predicted secondary structure probabilities at each residue.

```
<SSPrediction name=(&string) threshold=(&real) use_probability=( true &bool) mismatch_probability=( true &bool) cmd=(&string) blueprint=( "" &string) use_svm=( true &bool ) />
```

-   threshold - If threshold is set and use_probability is true, the filter returns true only if the calculated value is less than this number. If use_probability is false, the filter returns true if the calculated value is greater than this number.
-   use\_probability - If true, the probability information that psipred calculates will be used to determine the score. IF false, the filter will return the percentage of residues that match.
-   mismatch\_probability - If true AND use\_probability is true, the score is determined as the geometric average of the probability getting a WRONG secondary structure type at each position.  Just as in regular use_probability, you want to minimize this score.
-   cmd - Full path to runpsipred\_single or runpsipred executable. Must be specified if use\_svm=false
-   blueprint - If specified, the filter will take desired secondary structure from a blueprint file, rather from DSSP on the pose.
-   use\_svm - If set, an SVM will be used to make secondary structure predictions instead of psipred. This requires downloading some database files. If false, the psipred executable specified by cmd will be used.

Special Application Filters
---------------------------

### Binding

#### Ddg

Computes the binding energy for the complex and if it is below the threshold returns true. o/w false. Useful for identifying complexes that have poor binding energy and killing their trajectory.

```
<Ddg name=(ddg &string) scorefxn=(score12 &string) threshold=(-15 &float) jump=(1 &Integer) chain_num=(&int,&int...) repeats=(1 &Integer) repack=(true &bool) relax_mover=(&string) repack_bound=(true &bool) relax_bound=(false &bool) filter=(&string) extreme_value_removal=(false &bool)/>
```

-   jump specifies which chains to separate. Jump=1 would separate the chains interacting across the first chain termination, jump=2, second etc.
-   repeats: averages the calculation over the number of repeats. Note that ddg calculations show noise of about 1-1.5 energy units, so averaging over 3-5 repeats is recommended for many applications.
-   repack: Should the complex be repacked in the bound and unbound states prior to taking the energy difference? If false, the filter turns to a dG evaluator. If repack=false repeats should be turned to 1, b/c the energy evaluations converge very well with repack=false
-   repack\_bound: Should the complex be repacked in the bound state? Note: If repack=true, then the complex will be repacked in the bound and unbound state by default. However, if the complex has already been repacked in the bound state prior to calling the DdgFilter then setting repack\_bound=false allows one to avoid unnecessary repetition.
-   relax\_mover: optionally define a mover which will be applied prior to computing the system energy in the unbound state.
-   relax\_bound: Should the relax mover (if specified) be applied to the bound as well as the unbound state? Note: the bound state is not relaxed by default.
-   chain\_num: allows you to specify a list of chain numbers to use to calculate the ddg, rather than a single jump. You cannot move chain 1, moving all the other chains is the same thing as moving chain 1, so do that instead. Use independently of jump.
-   translate\_by: How far to translate the unbound pose. Note: Default is now 100 Angstroms rather than 1000.
-   filter: If specified, the given filter will be calculated in the bound and unbound state for the score, rather than the given scorefunction. Repacking, if any, will be done with the provided scorefunction.
-   extreme_value_removal: compute ddg value <repeat> times, sort and remove the top and bottom evaluation. This should reduce the noise levels in trajectories involving 1000s of evaluations. If set to true, repeats must be set to at least 3.

This filter supports the Poisson-Boltzmann energy method by setting the runtime environment to indicate the altering state, either bound or unbound. When used properly in conjunction with SetupPoissonBoltzmannPotential (mover), the energy method (see: core/scoring/methods/PoissonBoltzmannEnergy) is enabled to solve for the PDE only when the conformation in corresponding state has changed sufficiently enough. Because Ddg uses all-atom centroids to determine the separation vector when jump is used, it is highly recommended to use the chain\_num option instead to specify the movable chains, to avoid invalidating the unbound cache when there are slight changes to atom positions.

Example:

The script below shows how to enable PB with ddg filter. I have APBS (Adaptive Poisson-Boltzmann Solver) installed in /home/honda/apbs-1.4/ and "apbs" executable is in the bin/ subdiretory. Chain 1 is charged in this case. You can list more than one chain by comma-delimit (without extra whitespace. e.g. "1,2,3"). I use full scorefxn as the basis and add the PB term.

    <SCOREFXNS>
        <sc12_w_pb weights=score12_full patch=pb_elec/>  patch PB term
    </SCOREFXNS>
    <MOVERS>
        <SetupPoissonBoltzmannPotential name=setup_pb scorefxn=sc12_w_pb charged_chains=1 apbs_path="/home/honda/apbs-1.4/bin/apbs"/>
        ...
    </MOVERS>
    <FILTERS>
        <Ddg name=ddg scorefxn=sc12_w_pb chain_num=2/>
        ...
    </FILTERS>
    <PROTOCOLS>
        <Add mover_name=setup_pb/>  Initialize PB
        <Add mover_name= .../>  some mover
        <Add filter_name=ddg/> use PB-enabled ddg 
        <Add filter_name=.../>  more filtering
    </PROTOCOLS>

#### InterfaceBindingEnergyDensityFilter

Takes two other filters: Ddg and Sasa. Computes Ddg/Sasa and returns the value. Fails if the value is not below some threshold.

```
<InterfaceBindingEnergyDensityFilter name=(&string) sasa_filter=(&string)  ddG_filter=(&string) threshold=(-0.015 &float)/>
```

-   sasa\_filter is the name of a previously defined Sasa filter
-   ddG\_filter is the name of a previously defined Ddg filter
-   threshold sets the fail condition for the filter, this filter fails if Ddg/Sasa is not below the threshold.

### Ligand docking and enzyme design

#### DSasa

*(Formerly known as LigDSasa)*

Computes the fractional interface delta\_sasa for a ligand on a ligand-protein interface and checks to see if it is \*between\* the lower and upper threshold. A DSasa of 1 means ligand is totally buried (loses all it's accessible surface area), 0 means totally accessible (loses none upon interface formation).

```
<DSasa name=(&string) lower_threshold=(0.0 &float) upper_threshold=(1.0 &float)/>
```

#### DiffAtomBurial

-   As of 12-3-12: I'd be careful of using this one. After checking many of these filtered results by hand, I'm not convinced that it works properly / the way one would expect.

Compares the DSasa of two specified atoms and checks to see if one is greater or less than other. This is useful for figuring out whether a ligand is oritented in the correct way (i.e. whether in the designed interface one atom is more/less exposed than another)

```
<DiffAtomBurial name=(&string)  res1_res_num/res1_pdb_num=(0, see res_num/pdb_num convention) res2_res_num/res2_pdb_num=(0, see convention) atomname1=(&string) atomname2=(&string) sample_type=(&string)/>
```

pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

-   res1\_res\_num/res2\_res\_num: conventional pose numbering of rosetta, res\_num=0 will mean ligand (Assuming there is only one ligand)
-   res1\_pdb\_num/res2\_pdb\_num: conventional pdb\_numbering such as 100A (residue 100 chain A), 1X (residue 1 chain X e.g. of ligand)
-   atomname1/atomname2: atomnames of the respective atoms
-   sample\_type: "more" or "less". "more" means Dsasa1\>Dsasa2 (atom1 is more buried than atom2); "less" means Dsasa1\<Dsasa2 (atom1 is less buried than atom2)

#### LigInterfaceEnergy

Calculates interface energy across a ligand-protein interface taking into account (or not) enzdes style cst\_energy.

```
<LigInterfaceEnergy name=(&string)  scorefxn=(&string) include_cstE=(0 &bool) jump_number=(last_jump &integer) energy_cutoff=(0.0 &float)/>
```

include\_cstE=1 will \*not\* subtract out the cst energy from interface energy. jump\_number defaults to last jump in the pose (assumed to be associated with ligand). energy should be less than energy\_cutoff to pass.

#### EnzScore

Calculates scores of a pose e.g. a ligand-protein interface taking into account (or not) enzdes style cst\_energy. Residues can be accessed by res\_num/pdb\_num or their constraint id. One and only one of res/pdb\_num, cstid, and whole\_pose tags can be specified. energy should be less than cutoff to pass.

```
<EnzScore name=(&string)  scorefxn=(&string, score12) whole_pose= (&bool,0) score_type = (&string) res_num/pdb_num = (see convention) cstid =  (&string) energy_cutoff=(0.0 &float)/>
```

-   cstid: string corresponding to cst\_number+template (A or B, as in remarks and cstfile blocks). each enzdes cst is between two residues; A or B allows access to the corresponding residue in a given constraint e.g. cstid=1A means cst \#1 template A (i.e. for the 1st constraint, the residue corresponding to the block that is described first in the cstfile and its corresponding REMARK line in header), cstid=4B (for the 4th constraint, the residue that is described second in the cstfile block and its REMARK line in header).
-   score\_type: usual rosetta score\_types; cstE will calculate enzdes style constraint energy
-   whole\_pose: calculate total scores for whole pose
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### RepackWithoutLigand

Calculates delta\_energy or RMSD of protein residues in a protein-ligand interface when the ligand is removed and the interface repacked. RMSD of a subset of these repacked residues (such as catalytic residues) can be accessed by setting the appropriate tags.

```
<RepackWithoutLigand name=(&string)  scorefxn=(&string, score12) target_res = (&string) target_cstids =  (&string) energy_threshold=(0.0 &float) rms_threshold=(0.5 &float)/>
```

-   target\_cstids: comma-separated list corresponding to cstids (see EnzScore for cstid format)
-   target\_res: comma-separated list corresponding to res\_nums/pdb\_nums (following usual convention: [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]] ) OR "all\_repacked" which will include all repacked neighbors of the ligand (the repack shell).
-   rms\_threshold: maximum allowed RMS of repacked region; (i.e. RMSD\<rms\_threshold filter passes, else fails)
-   energy\_threshold: delta\_Energy allowed (i.e. if E(with\_ligand)-E(no\_ligand) \< threshold, filter passes else fails)

### Ligand design

#### HeavyAtom

```
<HeavyAtom name="&string" chain="&string" heavy_atom_limit=(&int)/>
```

Stop growing this designed ligand once we reach this heavy atom limit

#### CompleteConnections

```
<CompleteConnections name="&string" chain="&string"/>
```

Are there any connections left to fulfill? If not, stop growing ligand

### Hotspot Design

#### StubScore

See [[Movers (RosettaScripts)#StubScore|Movers-RosettaScripts#StubScore]]

<!--- BEGIN_INTERNAL -->

### MatDes

#### OligomericAverageDegree

(This is a devel Filter and not available in released versions.)

A version of the AverageDegree filter (see above) that is compatible with oligomeric building blocks. Includes other subunits within the same building block in the neighbor count. Also works for monomeric building blocks.

```
<OligomericAverageDegree name=(&string) jump=(1 &Size) sym_dof_names=("" &string) threshold=(0 &Size) distance_threshold=(10.0 &Real) multicomp=(0 &bool) write2pdb=(0 &bool) task_operations=(comma-delimited list of task operations) />
```

-   jump - Which jump separates the building block from others?
-   sym\_dof\_names - Which sym\_dofs separate the building blocks from the others (must also set multicomp=1 if it is a multicomponent symmetric system)?
-   threshold - How many residues need to be on average in the sphere of each of the residues under scrutiny in order for the filter to return true.
-   distance\_threshold - Size of sphere around each residue under scrutiny.
-   write2pdb - Whether to write the residue-level AverageDegree values to the output .pdb file.
-   multicomp - Set to true if the systems has multiple components.
-   task\_operations - Define residues under scrutiny (all repackable residues).

#### SymUnsatHbonds

(This is a devel Filter and not available in released versions.)

Maximum number of buried unsatisfied H-bonds allowed across an interface. Works with both symmetric and asymmetric poses, as well as with poses with symmetric “building blocks”. Takes the current pose, uses the jump number or sym\_dof\_names and core::pose::symmetry::get\_sym\_aware\_jump\_num(pose,jump) to get the correct vector for translation into the unbound state, uses the RigidBodyTransMover to translate the pose into its unbound state, goes through every heavy atom in the asymmetric unit and finds cases where a polar is considered buried in the bound state, but not in the unbound state. If passes, will output the number of unsatisfied hydrogen bonds to the scorefile and tracer. Also outputs to the tracer the specific residues and atoms that are unsatisfied and a formatted string for easy selection in pymol.

```
<SymUnsatHbonds name=(&string) jump=(1 &size) sym_dof_names=("" &string) cutoff=(20 &size)/>
```

-   jump: What jump to look at.
-   sym\_dof\_names: What jump(s) to look at. For multicomponent systems, one can simply pass the names of the sym\_dofs that control the master jumps. For one component systems, jump can still be used.
-   cutoff: Maximum number of buried unsatisfied H-bonds allowed.

#### ClashCheck

(This is a devel Filter and not available in released versions.)

Calculate the number of heavy atoms clashing between building blocks.

    <ClashCheck name=(&string) sym_dof_names=(&string) clash_dist=(3.5 &Real) nsub_bblock=(1 &Size) cutoff=(0 &Size) verbose=(0 &bool) write2pdb=(0 &bool)/>

-   clash\_dist - Distance between heavy atoms below which they are considered to be clashing. Note: A hard-coded cutoff of 2.6 is set for contacts between backbone carbonyl oxygens and nitrogens for bb-bb hbonds.
-   sym\_dof\_names - Only use with multicomponent systems. Name(s) of the sym\_dof(s) corresponding to the building block(s) between which to check for clashes.
-   nsub\_bblock - The number of subunits in the symmetric building block. Does not need to be set for multicomponent systems.
-   cutoff - Maximum number of allowable clashes.
-   verbose - If set to true, then will output a pymol selection string to the logfile with the clashing positions/atoms.
-   write2pdb - If set to true, then will output a pymol selection string to the output pdb with the clashing positions/atoms.

#### InterfacePacking

(This is a devel Filter and not available in released versions.)

Calculates Will Sheffler's holes score for atoms at inter-building block interfaces.. Works with symmetric assemblies with one or more building blocks. Be sure to set the -holes:dalphaball option!

    <InterfacePacking name=(&string) sym_dof_names=("" &string) contact_dist=(10.0 &Real) distance_cutoff=(9.0 &Real) lower_cutoff=(-5 &lower_cutoff) upper_cutoff=(5 &upper_cutoff)/>

-   sym\_dof\_names - Must be provided. Name(s) of the sym\_dof(s) corresponding to the building block(s) for which to calculate the holes score(s).
-   contact\_dist - Maximum distance between CA or CB atoms of the primary subunit(s) and the other subunits to be included in the subpose used for the holes calculations. (Should this be change to heavy atoms and set to be the same value as distance\_cutoff?)
-   distance\_cutoff - Maximum distance between heavy atoms of the primary subunit(s) and neighboring subunits in order for the holes score to be included in the calculation.
-   lower\_cutoff - Minimum passing holes score.
-   upper\_cutoff - Maximum passing holes score.

#### MutationsFiler

(This is a devel Filter and not available in released versions.)

Determines mutated residues in current pose as compared to a reference pose. Can be used to stop trajectories if desired by setting a mutation\_threshold or rate\_threshold. The residues considered are restricted by task operations. By default, only designable residues are considered, but packable residues can also be considered if the option packable=true (useful for instance if a resfile is used to mutate some positions during the protocol, but only one AA was allowed to be considered during repack. Such a position is only considered packable). Outputs the number of mutations or the mutation rate (number of mutations divided by the number of designable (or packable) positions. Works with symmetric poses and symmetric "building blocks". The reference pose against which the recovery rate will be computed can be defined using the -in:file:native command-line flag.

```
<MutationsFilter name=(&string) rate_threshold=(0.0 &Real) task_operations=(comma-delimited list of operations &string) mutation_threshold=(100 &Size) report_mutations=(0 &bool) packable=(0 &bool) verbose=(0 &bool) write2pdb=(0 &bool) />
```

-   rate\_threshold: Lower cutoff for the acceptable recovery rate for a passing design. Will fail if actual rate is below this threshold.
-   task\_operations: Define the designable residues or packable residues.
-   mutation\_threshold: Upper cutoff for the number of mutations for an acceptable design. Only matters if report\_mutations is set to true.
-   report\_mutations: Defaults to false. If set to true, then will act as a filter for the number of mutations rather than the rate.
-   verbose: Defaults to false. If set to true, then will output the mutated positions and identities to the tracer.
-   write2pdb: Defaults to false. If set to true, then will output the mutated positions and identities to the output pdb.
-   packable: Defaults to false. If set to true, then will also consider mutations at packable positions in addition to designable positions.

#### GetRBDOFValues

(This is a devel Filter and not available in released versions.)

Calculates either the current translation or rotation across a user specified jump (referenced by jump\_id or sym\_dof\_name).

```
<GetRBDOFValues name=(&string)  jump=(1 &int) sym_dof_name=("" &string) verbose= (0 &bool) axis=('x' &char) get_disp=(0 &bool) get_angle=(0 &bool) init_disp=(0 &Real) init_angle=(0 &Real) get_init_value(0 &bool)/>
```

-   jump: Jump number of movable jump for which to calculate the translation or rotation
-   sym\_dof\_name: Sym\_dof\_name for movable jump for which to calculate the translation or rotation
-   verbose: Output jump and corresponding displacement or angle to tracer
-   axis: Axis in local coordinate frame about which to calculate the translation or rotation (not currently set up to handle off axis values)
-   get\_disp: If set to true (and get\_disp is false), then will calculate the displacement across the specified jump
-   get\_angle: If set to true (and get\_angle is false), then will calculate the angle of rotation about the specified jump
-   init\_disp: Initial displacement value to add to each calculated value
-   init\_angle: Initial angle value to add to each calculated value
-   get\_init\_value: Get the initial displacement or angle for the specified jump from the SymDofMoverSampler

<!--- END_INTERNAL --> 

### Backbone Design

#### Foldability

Rebuilds a given segment of an input pose a specified number of times using fragment-based assembly. First, the given segment of backbone is removed from the pose. Next, the segment is rebuilt from the N-terminal position of the removed segment by folding from extended chain. No chainbreak constraints are used to prevent biasing the folding. A folding attempt is considered successful if the rebuilt C-terminal end is near the C-terminal end of the original segment, and failed if the C-terminal end is distant from that of the original segment. Secondary structure and torsion bins (i.e. ABEGO) used for fragments are taken from in input pose, or optionally specified in the "motif" option. The score returned is a number between 0 and 1 equal to the ratio of successful folding attempts to total folding attempts.

This filter is designed as a means of quantifying Nobu and Rie's "foldability" metric, in which a structure is refolded several times and compared to the desired structure.

```
<Foldability name=(&string) tries=(100 &int) start_res=(1 &int) end_res=(1 &int) motif=("" &string) />
```

-   start\_res: The N-terminal residue of the piece of backbone to be rebuilt.
-   end\_res: The C-terminal residue of the piece of backbone to be rebuilt.
-   motif: The secondary structure + abego to be used for the backbone region to be rebuilt. Taken from input pose if not specified. The format of this string is:

    ```
    <Length><SS><ABEGO>-<Length2><SS2><ABEGO2>-...-<LengthN><SSN><ABEGON>
    ```

    For example, "1LX-5HA-1LB-1LA-1LB-6EB" will build a one residue loop of any abego, followed by a 5-residue helix, followed by a 3-residue loop of ABEGO BAB, followed by a 6-residue strand.

**Example**

The following example runs the foldability filter to rebuild the motif "2LX-5HA-3LX-5EB-2LX" 100 times. The rebuilding will take place starting at residue 30, and the score returned will be the fractions of times (represented as a number between 0 and 1) that folding this piece was successful. The threshold result for success is highly dependent on fold, and can range from 0.05 to 1.0.

```
<FILTERS>
    <Foldability name="foldability" tries="100" start_res="30" motif="2LX-5HA-3LX-5EB-2LX" />
</FILTERS>
<PROTOCOLS>
    <Add filter_name="foldability" />
</PROTOCOLS>
```

Currently Undocumented
----------------------

The following Filters are available through RosettaScripts, but are not currently documented. See the code (particularly the respective parse\_my\_tag() and apply() functions) for details. (Some may be undocumented as they are experimental/not fully functional.)

AtomCount, ChainExists, ConservedPosMutationFilter, CoreDunbrack, EnzdesScorefileFilter, FragQual, HBondAcceptor, HBondDonor, HSSTriplet, Holes, I\_sc, InterlockingAroma, LigBurial, MolarMass, MolecularMass, NMerPSSMEnergy, Ncontacts, NonSequentialNeighbors, ParallelBetaPairingPreference, ScoreCutoffFilter, SheetTopology, Stochastic, StubScoreLoops, SymmetricMotif, TaskAwareSASA