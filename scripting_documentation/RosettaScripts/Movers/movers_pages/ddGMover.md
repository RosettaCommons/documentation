# ddG
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ddG

Ddg (or delta-delta-G) is an estimate of the binding energy of a complex.  It is computed by taking the difference of the energy of the complex and of the separated components.  Repacking or relaxation can be done on the bound and/or unbound state, in which case averaging over several attempts is recommended.

This mover is useful for reporting the total or per-residue ddgs in cases where you don't want to use the [[Ddg filter|DdgFilter]] for some reason. (The Ddg filter can't currently do per-residue ddgs, for example). Ddg scores are reported as string-real pairs in the job. The total ddg score has the tag "ddg" and the each per residue ddg has the tag "residue\_ddg\_n" where n is the residue number.

```xml
<ddG name="(&string)" jump="(1 &integer)" per_residue_ddg="(0 &bool)" repack_bound="(true bool&)" repack_unbound="(true bool&)" relax_bound=(false bool&) relax_unbound=(true bool&) relax_mover=(&string) scorefxn="('score12' &string)" chain_num="(&int,&int...)" chain_name="(&char,&char)" filter="(&string)"/>
```

The `repack_bound` and `repack_unbound` control whether global repacking is applied to the bound and unbound states, respectively.  Both are true by default, though this can be expensive for large structures (and can result in irrelevant noise caused by different configurations of residues far from the binding interface).  The `relax_bound` and `relax_unbound` options provide an alternative, if a configured relaxation mover is provided with the `relax_mover` option.  This allows the user to specify, for example, a FastRelaxMover that only repacks and minimizes side-chains in the binding interface.

chain\_num and chain\_name allow you to specify a list of chain numbers or chain names to use to calculate the ddg, rather than a single jump. You cannot move chain 1, moving all the other chains is the same thing as moving chain 1, so do that instead. If filter is specified, the computed value of the filter will be used for the reported difference in score, rather than the given scorefunction. Use of the filter with per-residue ddG is not supported.



This mover supports the Poisson-Boltzmann energy method by setting the runtime environment to indicate the altering state, either bound or unbound. When used properly in conjunction with SetupPoissonBoltzmannPotential (mover), the energy method (see: core/scoring/methods/PoissonBoltzmannEnergy) is enabled to solve for the PDE only when the conformation in corresponding state has changed sufficiently enough. As ddG uses all-atom centroids to determine the separation vector when the movable chains are specified by jump, it is highly recommended to use chain\_num/chain\_name to specify the movable chains, to avoid invalidating the unbound PB cache due to small changes in atom positioning.

Example:

The script below shows how to enable PB with ddg mover. I have APBS (Adaptive Poisson-Boltzmann Solver) installed in /home/honda/apbs-1.4/ and "apbs" executable is in the bin/ subdiretory. Chain 1 is charged in this case. You can list more than one chain by comma-delimit (without extra whitespace. e.g. "1,2,3"). I use full scorefxn as the basis and add the PB term.

    <SCOREFXNS>
        <ScoreFunction name="sc12_w_pb" weights="score12_full" patch="pb_elec"/>  patch PB term
    </SCOREFXNS>
    <MOVERS>
        <SetupPoissonBoltzmannPotential name="setup_pb" scorefxn="sc12_w_pb" charged_chains="1" apbs_path="/home/honda/apbs-1.4/bin/apbs"/>
        <ddG name="ddg" scorefxn="sc12_w_pb" chain_num="2"/>
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
* [[Ddg filter|DdgFilter]]: A filter for discarding complexes with too low a Ddg value.
* [[ddg-monomer]]: Application for calculating ddg values for monomeric proteins
* [[I want to do x]]: Guide to choosing a mover
