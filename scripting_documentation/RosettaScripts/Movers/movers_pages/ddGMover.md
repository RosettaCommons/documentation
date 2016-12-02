# ddG
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ddG

This mover is useful for reporting the total or per-residue ddgs in cases where you don't want to use the ddG filter for some reason. (also, the ddg filter can't currently do per-residue ddgs). Ddg scores are reported as string-real pairs in the job. The total ddg score has the tag "ddg" and the each per residue ddg has the tag "residue\_ddg\_n" where n is the residue number.

```
<ddG name="(&string)" jump="(1 &integer)" per_residue_ddg="(0 &bool)" repack_bound="(0 bool&)" repack_unbound="(0 bool&)" relax_bound(0 bool&) scorefxn="('score12' &string)" chain_num="(&int,&int...)" chain_name="(&char,&char)" filter="(&string)"/>
```

chain\_num and chain\_name allow you to specify a list of chain numbers or chain names to use to calculate the ddg, rather than a single jump. You cannot move chain 1, moving all the other chains is the same thing as moving chain 1, so do that instead. If filter is specified, the computed value of the filter will be used for the reported difference in score, rather than the given scorefunction. Use of the filter with per-residue ddG is not supported.

This mover supports the Poisson-Boltzmann energy method by setting the runtime environment to indicate the altering state, either bound or unbound. When used properly in conjunction with SetupPoissonBoltzmannPotential (mover), the energy method (see: core/scoring/methods/PoissonBoltzmannEnergy) is enabled to solve for the PDE only when the conformation in corresponding state has changed sufficiently enough. As ddG uses all-atom centroids to determine the separation vector when the movable chains are specified by jump, it is highly recommended to use chain\_num/chain\_name to specify the movable chains, to avoid invalidating the unbound PB cache due to small changes in atom positioning.

Example:

The script below shows how to enable PB with ddg mover. I have APBS (Adaptive Poisson-Boltzmann Solver) installed in /home/honda/apbs-1.4/ and "apbs" executable is in the bin/ subdiretory. Chain 1 is charged in this case. You can list more than one chain by comma-delimit (without extra whitespace. e.g. "1,2,3"). I use full scorefxn as the basis and add the PB term.

    <SCOREFXNS>
        <ScoreFunction name="sc12_w_pb" weights="score12_full" patch="pb_elec"/>  patch PB term
    </SCOREFXNS>
    <MOVERS>
        <SetupPoissonBoltzmannPotential name="setup_pb" scorefxn="sc12_w_pb" charged_chains="1" apbs_path="/home/honda/apbs-1.4/bin/apbs"/>
        <Ddg name="ddg" scorefxn="sc12_w_pb" chain_num="2"/>
    </MOVERS>
    <FILTERS>
        ...
    </FILTERS>
    <PROTOCOLS>
        <Add mover_name="setup_pb"/>  Initialize PB
        <Add mover_name="..."/>  some mover
        <Add mover_name="ddg"/> use PB-enabled ddg as if filter
        <Add filter_name="..."/>  more filtering
    </PROTOCOLS>


##See Also

* [[SetupPoissonBoltzmannPotentialMover]]
* [[ddg-monomer]]: Application for calculating ddg values for monomeric proteins
* [[I want to do x]]: Guide to choosing a mover