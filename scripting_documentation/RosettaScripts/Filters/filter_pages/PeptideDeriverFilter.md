# PeptideDeriver
*Back to [[Filters|Filters-RosettaScripts]] page.*
## PeptideDeriver

Implementation of the Peptiderive protocol. Since all the options are equivalent (both in name and in meaning) to the command-line options of the app, it's best to see the [[PeptiDerive]] application documentation.

```xml
<PeptideDeriver name="(&string)"
    pep_lengths="( 10 &int,...)"
    skip_zero_isc="( true &bool)"
    dump_peptide_pose="( false &bool)"
    dump_cyclic_poses="( false &bool)"
    dump_report_file="( false &bool)"
    dump_prepared_pose="( false &bool)"
    do_minimize="( true &bool)"
    scorefxn_deriver="(&string)"
    optimize_cyclic_threshold="( 0.35 &real)"
    restrict_receptors_to_chains="( "" &string,...)"
    restrict_partners_to_chains="( "" &string,...)"
    />
```

## See also:

* [[PeptiDerive]]
