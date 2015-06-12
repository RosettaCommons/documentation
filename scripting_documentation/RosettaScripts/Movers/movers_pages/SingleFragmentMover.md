# SingleFragmentMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SingleFragmentMover

Performs a single fragment insertion move on the pose. Respects the restrictions imposed by the user-supplied *MoveMap* and underlying kinematics of the pose (i.e. *FoldTree* ). By default, all backbone torsions are movable. The *MoveMap* parameter is used to specify residues that should remain fixed during the simulation. Insertion positions are chosen in a biased manner in order to have roughly equivalent probability of acceptance at each allowable insertion position. This has traditionally been referred to as "end-biasing." Once an insertion position has been chosen, a *Policy* object is responsible for choosing from among the possible fragments contained in the fragment file. Currently, two policies are supported-- "uniform" and "smooth." The former chooses uniformly amongst the set of possibilities. The latter chooses the fragment that, if applied, causes minimal distortion to the pose.

In order to be useful, *SingleFragmentMover* should be paired with a Monte Carlo-based mover. If you're folding from the extended chain, "GenericMonteCarloMover" is a common choice. When folding from a reasonable starting model, "GenericMonteCarloMover" is \*not\* recommended-- it unilaterally accepts the first move. A simplified version of the *ClassicAbinitio* protocol is recapitulated in demo/rosetta\_scripts/classic\_abinitio.xml.

Input is \*not\* restricted to monomers. Oligomers work fine.

```

<SingleFragmentMover name=(&string) fragments=(&string) policy=(uniform &string)>
  <MoveMap>
    <Span begin=(&int) end=(&int) chi=(&int) bb=(&int)/>
  </MoveMap>
</SingleFragmentMover>
```


##See Also

* [[Fragment file]]: Fragment file format
* [[I want to do x]]: Guide to choosing a mover
