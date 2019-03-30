# Ddg
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Ddg

Computes the binding energy for the complex and if it is below the threshold returns true. o/w false. Useful for identifying complexes that have poor binding energy and killing their trajectory.

```xml
<Ddg name="(ddg &string)" scorefxn="(score12 &string)" threshold="(-15 &float)" jump="(1 &Integer)" chain_num="(&int,&int...)" repeats="(1 &Integer)" repack="(true &bool)" relax_mover="(&string)" repack_bound="(true &bool)" repack_unbound="(true &bool)" relax_bound="(false &bool)" relax_unbound=("true &bool) filter="(&string)" extreme_value_removal="(false &bool)"/>
```

-   jump specifies which chains to separate. Jump=1 would separate the chains interacting across the first chain termination, jump=2, second etc.
-   repeats: averages the calculation over the number of repeats. Note that ddg calculations show noise of about 1-1.5 energy units, so averaging over 3-5 repeats is recommended for many applications.
-   repack: Should the complex be repacked in the bound and unbound states prior to taking the energy difference? If false, the filter turns to a dG evaluator. If repack=false repeats should be turned to 1, b/c the energy evaluations converge very well with repack=false
-   repack\_bound: Should the complex be repacked in the bound state? Note: If repack=true, then the complex will be repacked in the bound and unbound state by default. However, if the complex has already been repacked in the bound state prior to calling the DdgFilter, or if an alternative packing or relaxation mover is provided with the relax\_mover option, then setting repack\_bound=false allows one to avoid unnecessary repetition.
-   repack\_unbound: Should the complex be repacked in the unbound state? Note: If repack=true, then the complex will be repacked in the bound and unbound state by default. However, if the complex has already been repacked in the unbound state prior to calling the DdgFilter, or if an alternative packing or relaxation mover is provided with the relax\_mover option, then setting repack\_unbound=false allows one to avoid unnecessary repetition.
-   relax\_mover: optionally define a mover which will be applied prior to computing the system energy in the unbound state.
-   relax\_bound: Should the relax mover (if specified) be applied to the bound state? Note: the bound state is **not** relaxed by default.
-   relax\_unbound: Should the relax mover (if specified) be applied to the unbound state? Note: the unbound state **is** relaxed by default.
-   chain\_num: allows you to specify a list of chain numbers to use to calculate the ddg, rather than a single jump. You cannot move chain 1, moving all the other chains is the same thing as moving chain 1, so do that instead. Use independently of jump.
-   translate\_by: How far to translate the unbound pose. Note: Default is now 100 Angstroms rather than 1000.
-   filter: If specified, the given filter will be calculated in the bound and unbound state for the score, rather than the given scorefunction. Repacking, if any, will be done with the provided scorefunction.
-   extreme_value_removal: compute ddg value <repeat> times, sort and remove the top and bottom evaluation. This should reduce the noise levels in trajectories involving 1000s of evaluations. If set to true, repeats must be set to at least 3.

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
If a disulfide present across the interface in question the filter silently fails and the ddG column is not added to the score file. A work around (that ignores the energy contribution of the disulfide) is to provide the ddG filter a scorefunction with dslf_fa13 reweighed to zero.

## See also

* [[Docking applications|docking-applications]]
* [[AlaScanFilter]]
* [[ddGMover]]
* [[DdGScanFilter]]
* [[FilterScanFilter]]

