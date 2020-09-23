# Ddg
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Ddg

[[include:filter_Ddg_type]]



This filter supports the Poisson-Boltzmann energy method by setting the runtime environment to indicate the altering state, either bound or unbound. When used properly in conjunction with SetupPoissonBoltzmannPotential (mover), the energy method (see: core/scoring/methods/PoissonBoltzmannEnergy) is enabled to solve for the PDE only when the conformation in corresponding state has changed sufficiently enough. Because Ddg uses all-atom centroids to determine the separation vector when jump is used, it is highly recommended to use the chain\_num option instead to specify the movable chains, to avoid invalidating the unbound cache when there are slight changes to atom positions.

Example:

The script below shows how to enable PB with ddg filter. I have APBS (Adaptive Poisson-Boltzmann Solver) installed in /home/honda/apbs-1.4/ and "apbs" executable is in the bin/ subdiretory. Chain 1 is charged in this case. You can list more than one chain by comma-delimit (without extra whitespace. e.g. "1,2,3"). I use full scorefxn as the basis and add the PB term.

```xml
    <SCOREFXNS>
        <ScoreFunction name="sc12_w_pb" weights="score12_full" patch="pb_elec"/>  patch PB term
    </SCOREFXNS>
    <MOVERS>
        <SetupPoissonBoltzmannPotential name="setup_pb" scorefxn="sc12_w_pb" charged_chains="1" apbs_path="/home/honda/apbs-1.4/bin/apbs"/>
        ...
    </MOVERS>
    <FILTERS>
        <Ddg name="ddg" scorefxn="sc12_w_pb" chain_num="2"/>
        ...
    </FILTERS>
    <PROTOCOLS>
        <Add mover_name="setup_pb"/>  Initialize PB
        <Add mover_name="..."/>  some mover
        <Add filter_name="ddg"/> use PB-enabled ddg 
        <Add filter_name="..."/>  more filtering
    </PROTOCOLS>
```

## Known issues
**BUG**: Always leave `repack="1"` and control repacking using `repack_bound` and `repack_unbound`. If not ddG may return 0 and debug pdbs are not written.

If a disulfide present across the interface in question the filter silently fails and the ddG column is not added to the score file. A work around (that ignores the energy contribution of the disulfide) is to provide the ddG filter a scorefunction with dslf_fa13 reweighed to zero.

## See also

* [[Docking applications|docking-applications]]
* [[AlaScanFilter]]
* [[ddGMover]]
* [[DdGScanFilter]]
* [[FilterScanFilter]]

