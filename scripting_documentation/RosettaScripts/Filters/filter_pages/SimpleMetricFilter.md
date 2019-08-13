# SimpleMetricFilter
*Back to [[SimpleMetrics]] page.*
*Back to [[Filters | Filters-RosettaScripts]] page.*
## SimpleMetricFilter

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)

Run an arbitrary [[Simple Metric | SimpleMetrics]] and filter based on the value or values calculated. Please use the [[RunSimpleMetrics]] mover to report values into a scorefile.  

##General

Set the `comparison_type` to instruct the filter how to actually filter based on the data. The comparison is done as follows:

```
metric_value comparison_type cutoff/match value
```

For example, if `comparison_type` is set to eq: if metric value is equal to the cutoff/match value we return true.

Acceptable comparison_types are typical equality comparisons:

comparison_type  | Description 
------------ | ------------- 
`eq` | Equal
`ne` | Not Equal
`lt` | Less Than
`gt` | Greater Than,
`lt_or_eq` | Less Than or Equal to
`gt_or_eq` | Greater Than or Equal


##Numeric Metrics

These include RealMetrics, IntegerMetrics, and their composite counterparts. 
The `cutoff` option is required to set a particular cutoff type. 

##String Metrics

These include StringMetrics and its composite counterpart
The `match` option is required to set some arbitrary string to match to. 
Only `eq` and `ne` `comparison_types` can be used. 

##Composite Metrics

Composite Metrics take an additional option, `composite_action` to instruct the filter exactly what to do with the composite metric. 
Acceptable options are: 

composite_action  | Description 
------------ | ------------- 
`any` | Filter on ANY metric in the composite.  For example, if we have lt, and cutoff as 5, than if ANY metric is less than 5, we return True.
`all` | Filter on ALL metrics.  For example, if we use the same example as above with ALL, then ALL metrics in the composite must be less than 5 to pass the filter
`metric_name` | This can be any composite name.  See the individual composite for more.  For the case of the [[CompositeEnergyMetric]] this can be any scoreterm name.  This allows us to filter on any metric name calculated by the composite metric. 


[[include:filter_SimpleMetricFilter_type]]

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
		<RMSDMetric name="rmsd" rmsd_type="rmsd_protein_bb_heavy" residue_selector="L1" use_native="1"/>
		<SasaMetric name="sasa" residue_selector="L1"/>
		<SecondaryStructureMetric name="ss" residue_selector="L1" />
		<TotalEnergyMetric name="total_energy" residue_selector="L1" use_native="0"/>
		<CompositeEnergyMetric name="composite_energy" residue_selector="L1" use_native="0"/>
	</SIMPLE_METRICS>
	<MOVERS>
		<MinMover name="min_mover" tolerance=".1" movemap_factory="movemap_L1"/> 
	</MOVERS>
	<FILTERS>
		<SimpleMetricFilter name="sasa_filter" metric="sasa" cutoff="100" comparison_type="gt"/>
		<SimpleMetricFilter name="delta_energy" metric="total_energy" cutoff="5" comparison_type="lt"/>
		<SimpleMetricFilter name="composite_all" metric="composite_energy" cutoff="100" composite_action="all" comparison_type="lt"/>
		<SimpleMetricFilter name="ss_filter" metric="ss" match="LLLLLLLLLLL"  comparison_type="ne"/>
		<SimpleMetricFilter name="rmsd_filter" metric="rmsd" cutoff="0.5" comparison_type="lt" />

	</FILTERS>
	<PROTOCOLS>
		<Add mover_name="min_mover" />
		<Add filter_name="sasa_filter" />
		<Add filter_name="delta_energy" />
		<Add filter_name="composite_all" />
		<Add filter_name="ss_filter" />
		<Add filter_name="rmsd_filter" />
	</PROTOCOLS>
</ROSETTASCRIPTS>

```

##See Also

* [[SimpleMetrics]]: Available SimpleMetrics
* [[SimpleMetricFilter]]: Filter on an arbitrary SimpleMetric
* [[SimpleMetricFeatures]]: Run [[Features | Features-reporter-overview]] on a set of SimpleMetrics
* [[Mover|Movers-RosettaScripts]]: Available Movers
* [[I want to do x]]: Guide to choosing a mover