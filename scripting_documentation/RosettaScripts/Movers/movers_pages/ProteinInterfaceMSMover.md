# ProteinInterfaceMS
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ProteinInterfaceMS

Multistate design of a protein interface. The target state is the bound (input) complex and the two competitor states are the unbound partners and the unbound, unfolded partners. Uses genetic algorithms to select, mutate and recombine among a population of starting designed sequences. See Havranek & Harbury NSMB 10, 45 for details.

```xml
<ProteinInterfaceMS name="&string" generations="(20 &integer)" pop_size="(100 &integer)" num_packs="(1 &integer)" pop_from_ss="(0 &integer)" numresults="(1 &integer)" fraction_by_recombination="(0.5 &real)" mutate_rate="(0.5 &real)" boltz_temp="(0.6 &real)" anchor_offset="(5.0 &real)" checkpoint_prefix="('' &string)" gz="(0 &bool)" checkpoint_rename="(0 &bool)" scorefxn="(score12 &string)" unbound="(1 &bool)" unfolded="(1&bool)" input_is_positive="(1&bool)" task_operations="(&comma-delimited list)" unbound_for_sequence_profile="(unbound &bool)" profile_bump_threshold="(1.0 &Real)" compare_to_ground_state="(see below & bool)" output_fname_prefix="('' &string)">
   <Positive pdb="(&string)" unbound="(0&bool)" unfolded="(0&bool)"/>
   <Negative pdb="(&string)" unbound="(0&bool)" unfolded="(0&bool)"/>
   .
   .
   .
</ProteinInterfaceMS>
```

The input file (-s or -l) is considered as either a positive or negative state (depending on option, input\_is\_positive). If unbound and unfolded is true in the main option line, then the unbound and the unfolded states are added as competitors. Any number of additional positive and negative states can be added. Unbound and unfolded takes a different meaning for these states: if unbound is checked, the complex will be broken apart and the unbound state will be added. If unfolded is checked, then the unbound and unfolded protein will be added.

unbound\_for\_sequence\_profile: use the unbound structure to generate an ala pose and prune out residues that are not allowed would clash in the monomeric structure. Defaults to true, if unbound is used as a competitor state. profile\_bump\_threshold: what bump threshold to use above. The difference between the computed bump and the bump in the ala pose is compared to this threshold.

compare\_to\_ground\_state: by default, if you add states to the list using the Positive/Negative tags, then the energies of all additional states are zeroed at their 'best-score' values. This allows the user to override this behaviour. See code for details.

output\_fname\_prefix: All of the positive/negative states that are defined by the user will be output at the end of the run using this prefix. Each state will have its sequence changed according to the end sequence and then a repacking and scoring of all states will take place according to the input taskfactory.

Rules of thumb for parameter choice. The Fitness F is defined as:

    F = Sum_+( exp(E/T) ) / ( Sum_+( exp(E/T) ) + Sum_-( exp(E/T) ) + Sum_+((E+anchor)/T) )

where Sum\_-, and Sum\_+ is the sum over the negative and positive states, respectively.

the values for F range from 1 (perfect bias towards +state) to 0 (perfect bias towards -state). The return value from the PartitionAggregateFunction::evaluate method is -F, with values ranging from -1 to 0, correspondingly. You can follow the progress of MSD by looking at the reported fitnesses for variants within a population at each generation. If all of the parameters are set properly (temperature etc.) expect to see a wide range of values in generation 1 (-0.99 - 0), which is gradually replaced by higher-fitness variants. At the end of the simulation, the population will have shifted to -1.0 - -0.5 or so.

For rules of thumb, it's useful to consider a two-state, +/- problem, ignoring the anchor (see below, that's tantamount to setting anchor very high) In this case FITNESS simplifies to:

    F = 1/(exp( (dE)/T ) + 1 )

and the derivative is:

    F' = 1/(T*(exp(-dE/T) + exp(dE/T) + 2)

where dE=E\_+ - E\_-

A good value for T would then be such where F' is sizable (let's say more than 0.05) at the dE values that you want to achieve between the positive and negative state. Since solving F' for T is not straightforward, you can plot F and F' at different temperatures to identify a reasonable value for T, where F'(dE, T) is above a certain threshold. If you're lazy like me, set T=dE/3. So, if you want to achieve differences of at least 4.5 e.u between positive and negative states, use T=1.5.

To make a plot of these functions use MatLab or some webserver, e.g., [http://www.walterzorn.com/grapher/grapher\_e.htm](http://www.walterzorn.com/grapher/grapher_e.htm) .

The anchor\_offset value is used to set a competitor (negative) state at a certain energy above the best energy of the positive state. This is a computationally cheap assurance that as the specificity changes in favour of the positive state, the stability of the system is not overly compromised. Set anchor\_offset to a value that corresponds to the amount of energy that you're willing to forgo in favour of specificity.


##See Also

* [[Multistate design application|mpi-msd]]
* [[DnaInterfacePackerMover]]
* [[InterfaceAnalyzerMover]]
* [[InterfaceRecapitulationMover]]
* [[InterfaceScoreCalculatorMover]]
* [[I want to do x]]: Guide to choosing a mover
