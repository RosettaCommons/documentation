#MultiplePoseMover (RosettaScripts)
*Back to [[Mover|Movers-RosettaScripts]] page.*
##MultiplePoseMover (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

[[Return To RosettaScripts Movers|Movers-RosettaScripts]]

[[_TOC_]]

The MultiplePoseMover allows a multi-step "distribute and collect" protocol to be implemented in a single RosettaScript.
Examples of such protocols include ab initio followed by clustering and docking followed by design, which are described in more detail below.

## Overview

First, the MultiplePoseMover collects all poses from the previous mover of the protocol (as listed in the PROTOCOLS section of the RosettaScript).
Next, poses are selected from the complete set using Pose Selectors defined in the SELECT tag.
The sub-protocol specified in the ROSETTASCRIPT tag is then run on all selected poses.
Poses for which the protocol succeeds are output to another mover for further processing, or to the Job Distributor for output to persistant storage.

Both the SELECT and ROSETTASCRIPTS tags are optional.
Thus, this mover can also be used to "branch out" without any selection criteria (i.e. generate many derived poses from one or more input poses) or purely as a selector to trim down the set of poses based on some criteria.

Several MultiplePoseMovers can be connected back to back for several distribute and collect steps. The sub-protocol can also contain one or more MultiplePoseMovers.

Noteworthy points:

-   The previous mover needs to be able to generate more than one pose, or no branching out will be possible.
    Movers that do not have this ability can be wrapped with the MultipleOutputWrapper, which repeatedly calls the contained mover to generate additional poses.

-   Currently this mover works single-threaded, keeps all poses in memory, and does not have any checkpointing support for resuming. It is therefore not designed to operate on 100,000 poses. You have been warned.

## General XML syntax

The MultiplePoseMover understands two child tags.
Pose selection criteria are defined inside the SELECT tag, while a regular RosettaScript protocol lives inside the ROSETTASCRIPTS tag.
Both tags are optional but at least one should be present, otherwise this becomes a caching null mover and a warning will be genrated.

```xml
<MultiplePoseMover name="(&string)" max_input_poses="(&integer)">
    <SELECT>
    ...
    </SELECT>
    <ROSETTASCRIPTS>
    	<IMPORT movers="(&string)" filter="(&string)"/>
    ...
    </ROSETTASCRIPTS>
</MultiplePoseMover>
```

-   max\_input\_poses: Maximum number of poses this mover will accept from the previous mover. The default it to accept all poses the previous mover will output.

## SELECT tag

Poses are selected from the entire set of collected poses using a single selector, which is defined inside the SELECT tag.
Logical selectors can be used to build compound statements to, for example, select poses that have property (X and Y) or Z.

### Pose Selectors

- AndSelector: Logical AND selector; a pose is selected if ALL defined child selectors choose it.
- OrSelector: Logical OR selector; a pose is selected if ANY defined child selectors choose it.
- TopNByProperty: Select best n poses from the set by some property. This selector is used with a PosePropertyReporter.
- ClusterPoseSelector: Cluster poses by some property (i.e. RMSD) and select poses from the cluster centers. This selector is used with a PosePropertyReporter.

See below for details.

### Pose Property Reporters

- EnergyReporter: Reports any score term or the total score for the pose.
- FilterReporter: Use the value from any RosettaScripts filter (i.e. shape complementarity, SASA, ...).
- RMSDReporter: Reports the RMSD of two poses.

## IMPORT tag

To avoid redundant declarations of filters and movers, the IMPORT tag can be used to import previously defined filters and movers by their name.
The declaration to be imported must be somewhere higher in the script hierarchy (any parent but not sibling).

Example:

```xml
<IMPORT movers="repack" filters="filter1,filter2"/>
```

## Pose Selectors

### AndSelector and OrSelector

These selectors are used to build compound logical statements.
One or more sub-selectors are defined in child tags and will be evaluated in order listed.
A pose is selected if all (AndSelector) or any (OrSelector) defined selectors choose it.

```xml
<AndSelector>
  <SomeOtherSelector>
    ...
  </SomeOtherSelector>
  <SomeOtherSelector>
    ...
  </SomeOtherSelector>
  ...
</AndSelector>
```

### TopNByProperty

This selector is used to select best n poses by some property, without expicitly specifying any threshold cutoff values.
It uses the defined PosePropertyReporter to rank all collected poses in the set, and then chooses the n best ones.

```xml
<TopNByProperty n="(&integer)" order="(&string)">
  # A PosePropertyReporter (for example, EnergyReporter) must be defined here.
</TopNByProperty>
```

-   n: Number of "best" poses to select.
-   order: sort order, ascending (default) or descending.

### ClusterPoseSelector

This selector clusters all collected poses by some property, such as RMSD.
It uses the defined pose property reporter to evaluate the similarity of two poses.
Similar poses are placed in the same cluster.
Phil Bradley's cluster algorithm is used for the clustering. See the cluster application for more details.

```xml
<ClusterPoseSelector radius="(&Real)" structures_per_cluster="(&integer)" remove_singletons="(&boolean)" initial_cluster_set_size="(&integer)" max_cluster_size="(&integer)"  max_clusters="(&integer)"  max_structures="(&integer)">
  # A PosePropertyReporter (for example, EnergyReporter) must be defined here.
</ClusterPoseSelector>
```

- radius: Cutoff radius for the pose similarity. Unit depends on reporter used. For the RMSDReporter the radius is in Angstroms. This parameter is required. No default.
- remove\_singletons: Remove clusters that only contain one structure. Default: false.
- structures\_per\_cluster: Number of structures to select from each cluster, starting with the cluster center. Default: 1.
- initial\_cluster\_set\_size: Maximum number of structures to use for the initial clustering step. Additional structures are assigned to clusters later. Default: 400.
- max\_cluster\_size: Maximum number of poses to place in a cluster. Default: no limit.
- max\_clusters: Maximum number of clusters to generate. Default: no limit.
- max\_structures: Maximum number of structures to select. Default: no limit.

## Pose Property Reporters

PosePropertyReporters report a single Real value for a given pose property or similarity between two poses.

### EnergyReporter

This reporter scores the pose and returns either the total pose score or a specific term.

```xml
<EnergyReporter scorefunction="(&string)" term="(&string)"/>
```

- scorefunction: The scoring function to use.  Note that this is the name of a weights file, NOT a scoring function defined previously in the script.  (This will likely change in the future).
- term: The score term to report or total_score. Default: total_score.

### FilterReporter

This reporter uses any RosettaScripts filter capable of expressing the property it measures as a real number.
The filter must be defined in the FITLERS section and use referenced here by the name given in the definition.

```xml
<FilterReporter filter="(&string)"/>
```

- filter: name of filter to use.

### RMSDReporter

This reporter is used by the ClusterPoseSelector to compute the similarity of two poses in terms of RMSD.

```xml
<RMSDReporter mode="(&string)" residues="(&string)"/>
```

- mode: CA or all_atom (required).
- residues: List of residues to include in format: 1-20,40-100. Default: all residues.



## Full Examples

### Classic ab initio with clustering

In this example, the classic ab initio protocol generates a desired number of ab initio models (step 1).
Those models are then clustered by RMSD (step 2) and one model from each cluster center is output.

The first instance of the MultiplePoseMover with name "abinito_protocol" is used to branch out, while the second instance of the mover with name "cluster" is used purely for pose selection/filtering.
Should the selected poses be processed further, either a ROSETTASCRIPT block could be added to the "cluster" MultiplePoseMover, or a third MultiplePoseMover mover could be added to the main PROTOCOLS section.

The ab initio protocol in step 1 (ROSETTASCRIPTS block in the MultiplePoseMover with name abinito_protocol) is a near literal cut and paste from the classic ab initio protocol in the demos.

For demonstration purposes a rather large cluster radius is used to keep the run-time reasonable (~2 minutes total).

```
Example command line:
rosetta_scripts.linuxgccrelease -fasta 1a19a.fasta -parser:protocol abinito_cluster.xml -database ../database/

Step 1: Classic Abinitio

A ClassicAbinitio-like protocol that operates in 5 stages. The MoveMap parameter
to SingleFragmentMover (SFM) can be used to control backbone torsion flexibility.
SFMs policy parameter specifies the strategy used to select from the numerous
fragments at a given insertion position. "uniform" selects uniformly among the
possibilities. "smooth" chooses the fragment that, when inserted, minimizes
distortion to the pose.

Overview:
Stage 1 : 9mers, score0.wts_patch, 2000 cycles, uniform policy
Stage 2 : 9mers, score1.wts_patch, 2000 cycles, uniform policy
Stage 3a: 9mers, score2.wts_patch, 2000 cycles, uniform policy
Stage 3b: 9mers, score5.wts_patch, 2000 cycles, uniform policy
Stage 4 : 3mers, score3.wts_patch, 4000 cycles, smooth policy

Step 2: Clustering

Cluster all generated structures (100) by RMSD, pick the model at the cluster center for diversity.

<ROSETTASCRIPTS>

  <MOVERS>
		
		Step 1: 10 classic ab initio runs, i.e. the classic abitio rosetta scripts protocol from the demos
		This is wrapper with the AdditionalOutputMover to generate 100 poses
		
		<MultipleOutputWrapper name=abinito max_output_poses=100>

			Cut and paste from Classic Abinitio demo XML
			
			<ROSETTASCRIPTS>
				<SCOREFXNS>
					<score0 weights="score0"/>
					<score1 weights="score1"/>
					<score2 weights="score2"/>
					<score3 weights="score3"/>
					<score5 weights="score5"/>
				</SCOREFXNS>
				<FILTERS>
				</FILTERS>
				<MOVERS>
					Defines the base mover for small fragments (typically 3-mers)
					<SingleFragmentMover name="sfm_small" fragments="aa1a19a03_05.200_v1_3" policy="smooth">
						<MoveMap>
							<Span begin=1 end=89 chi=1 bb=1/>
						</MoveMap>
					</SingleFragmentMover>

					Defines the base mover for large fragments (typically 9-mers)
					<SingleFragmentMover name="sfm_large" fragments="aa1a19a09_05.200_v1_3" policy="uniform">
						<MoveMap>
							<Span begin=1 end=89 chi=1 bb=1/>
						</MoveMap>
					</SingleFragmentMover>

					Wrap the base movers in GenericMonteCarlo objects for scoring
					<GenericMonteCarlo name="stage1"  scorefxn_name="score0" mover_name="sfm_large" temperature=2.0 trials=2000/>
					<GenericMonteCarlo name="stage2"  scorefxn_name="score1" mover_name="sfm_large" temperature=2.0 trials=2000/>
					<GenericMonteCarlo name="stage3a" scorefxn_name="score2" mover_name="sfm_large" temperature=2.0 trials=2000/>
					<GenericMonteCarlo name="stage3b" scorefxn_name="score5" mover_name="sfm_large" temperature=2.0 trials=2000/>
					<GenericMonteCarlo name="stage4"  scorefxn_name="score3" mover_name="sfm_small" temperature=2.0 trials=4000/>

					Converts the centroid-level pose to fullatom for scoring
					<SwitchResidueTypeSetMover name=fullatom set=fa_standard/>
				</MOVERS>
				<APPLY_TO_POSE>
				</APPLY_TO_POSE>
				<PROTOCOLS>
					<Add mover=stage1/>
					<Add mover=stage2/>
					<Add mover=stage3a/>
					<Add mover=stage3b/>
					<Add mover=stage4/>
					<Add mover=fullatom/>
				</PROTOCOLS>
			</ROSETTASCRIPTS>

		</MultipleOutputWrapper>

		Step 2: Cluster poses and pick center structure from each cluster
		Large cluster radius is used here only for demo purposes since there are only 100 total structures
		
		<MultiplePoseMover name=cluster>
			<SELECT>
				<ClusterPoseSelector structures_per_cluster=1 radius=10 remove_singletons=true>
					<RMSDReporter mode=CA/>
				</ClusterPoseSelector>
			</SELECT>
		</MultiplePoseMover>
		
  </MOVERS>
  
  <PROTOCOLS>
    <Add mover_name=abinito/>
    <Add mover_name=cluster/>
  </PROTOCOLS>
  
</ROSETTASCRIPTS>
```

##See Also

* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[JD2]]: The job distributor
* [[ResourceManager]]
