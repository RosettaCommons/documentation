# FlexPepDock
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FlexPepDock

Flexible peptide docking protocol. This tag encompasses 2 closely related protocols:

-   The **Refinement protocol** is intended for cases where an approximate, coarse-grain model of the interaction is available, as described in Raveh, London et al., Proteins 2010. The protocol iteratively optimizes the peptide backbone and its rigid-body orientation relative to the receptor protein, in addition to on-the-fly side-chain optimization. The pep\_refine option invokes the refinement protocol.
-   The **ab-initio protocol** extends the refinement protocol considerably, and is intended for cases where no information is available about the peptide backbone conformation, as described in Raveh et al., PLoS ONE Rosetta Special Collection, 2011. FlexPepDock ab-initio simultaneously folds and docks the peptide over the receptor surface, starting from any arbitrary (e.g., extended) backbone conformation. It is assumed that the peptide is initially positioned close to the correct binding site, but the protocol is robust to the exact starting orientation. The protocol is invoked by the lowres\_abinitio option, usually in combination with the pep\_refine option, for refinement of the resulting coarse model. It is recommended to also supply the protocol with fragment files of 3-mers, 5-mers (and 9-mers for peptides of length 9 or more).

**Basic options:**

-   min\_only (boolean) - Apply just a minimization step
-   pep\_refine (boolean) - Invoke the refinement protocol
-   lowres\_abinitio (boolean) - Invoke the ab-initio protocol
-   peptide\_chain (string) - Manually specify the peptide chain (default is the 2nd chain)
-   receptor\_chain (string) - Manually specify the receptor (protein) chain. (default is the 1st chain)
-   ppk\_only (boolean) - Just prepacking
-   scorefxn (string) - the score function to use
-   extra\_scoring (boolean) - scoring only mode

Note that only one of the 5 can exist in a tag: extra\_scoring,ppk\_only,pep\_refine,lowres\_abinitio,min\_only.

    <FlexPepDock name="(&string)" min_only="(&boolean)" pep_refine="(&boolean)"
     lowres_abinitio="(&boolean)" peptide_chain="(&string)" receptor_chain="(&string)" 
    ppk_only="(&boolean)" scorefxn="(&string)" extra_scoring="(&boolean)"/>


##See Also

* [[DockingMover]]
* [[DockingProtocolMover]]
* [[DockWithHotspotMover]]
* [[HighResDockerMover]]
* [[Flex Pep Dock]]: The FlexPepDock command line application
* [[I want to do x]]: Choosing a mover