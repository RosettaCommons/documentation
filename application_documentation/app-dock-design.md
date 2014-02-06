#Dock Design Parser Applications

Metadata
========

This document was written by Sarel Fleishman and edited by Yi liu

Tutorial
========

The dock\_design\_parser is meant to provide an xml-scriptable interface for conducting all of the tasks that interface design developers produce. With such a scriptable interface, it is hoped, it will be possible for non-programmers to 'mix-and-match' different design strategies and apply them to their own needs. It is also hoped that through a common interface, code-sharing between different people will be smoother. Note that at this point, the only movers and filters that are implemented in this application are the ones described below. More will be made available in future releases.

At the most abstract level, all of the computations that are needed in interface design fall into two categories: Movers and Filters. Movers change the conformation of the complex by acting on it, e.g., docking/design/minimization, and filters decide whether a given conformation should go on to the subsequent dock\_design steps. Filters are meant to reduce the amount of computation that is conducted on conformations that show no promise. Then, a dock\_design protocol is merely a sequence of movers and filters.

The implementation for this behaviour is done by the following components:

-   **DockDesign, DockDesignFilter, and DockDesignMover** DockDesign maintains a vector of pairs of movers and their associated filters. By using the TrueFilter or the NullMover, filters and movers can be essentially decoupled by any protocol. The setup of having pairs of movers and filters is used simply because in most contexts filters will be conceptually associated with a mover and vice versa.
-   **setup\_dockdesign\_mover.cc** This function parses an xml file and populates DockDesignMover with pairs of DockDesignMover's and DockDesignFilter's. All of the movers and filters that are supported should also be defined in this function.
-   **conditional\_jobdist\_mover** This is a flavor of a jobdistributor which means that it is responsible for coupling input structures, movers and output models. The main differences between other jobdist\_movers and this one are:
    1.  Its mover (DockDesign) can decide that a given trajectory is hopeless, and send the job distributor a signal not to save the model to disk.
    2.  For each input structure, the jobdistributor will call a function (dock\_design\_parser) to set up DockDesign through the xml protocol file.
    3.  At the end of a successful run, jobdistributor will call DockDesign-\>report\_all which iterates over all filters and outputs their values for that given pose. This .report file is useful for post-design filtering and ranking.

    This jobdistributor will hopefully be superceeded by a more general purpose jobdistributor in the future.

Options in XML Protocol File
============================

This file lists the Movers, Filters, their defaults, meanings and uses as recognized by dock\_design\_parser. It always has an extention named .protocol. You can find a comprehensive sample in pilot/dock\_design\_parser/dock\_design.protocol

-   **XML Basic** whenever an xml statement is shown, the following convention will be used:

    ```
    <...> to define a branch statement (a statement that has more leaves)
    <.../> a leaf statement.
    "" defines input expected from the user with ampersand (&) defining the type that is expected (string, float, etc.)
    () defines the default value that the parser will use if that is not provided by the protocol.
    ```

PREDEFINITIONS
--------------

The following are defined internally in the parser, and the protocol can use them without defining them explicitly.

-   **Predefined Movers:**
     NullMover: Has an empty apply. Useful for defining a filter without using a mover.
-   **Predefined Filters:**
     TrueFilter: Returns true. Useful for defining a mover without using a filter.
-   **CompoundStatement filter:**
     This is a special filter that uses previously defined filters to construct a compound logical statement with AND, OR, XOR, NAND and NOR operations. By making compound statements of compound statements, esssentially all logical statements can be defined.

    ```
    <CompoundStatement name=(&string)>
        <OPERATION filter_name=(true_filter &string)/>
        <....
    </CompoundStatement>
    ```

    where OPERATION is any of the operations defined in CAPS above.Note that the operations are performed in the order that they are defined. No precedence rules are enforced, so that any precedence has to be explicitly written by making compound statements of compound statements.Also note that the first OPERATION is ignored, and the value of the first filter is simply assigned to the filter's results.

-   **Predefined ScoreFunctions:**

    ```
    score12:            exactly what you think.
    docking_score:      high resolution docking scorefxn (standard+docking_patch)
    docking_score_low:  low resolution docking scorefxn (interchain_cen)
    soft_rep:           soft_rep_design weights.
    ```

SCOREFXNS
---------

This section defines scorefunctions that will be used in Filters and Movers. This can be used to define any of the scores defined in the rosetta\_database using the following statement:

```
<"scorefxn_name" weights=(standard &string) patch="&string">
```

where scorefxn\_name will be used in the Movers and Filters sections to use the scorefunction. The name should therefore be unique and not repeat the predefined score names.

-   **Scorefunction modifiers**
     The apply\_to\_pose section may set up constraints, in which case it becomes necessary to set the weights in all of the scorefunctions that are defined. The default weights for all the scorefunctions are defined globally in the apply\_to\_pose section, but each scorefunction definition may change this weight. The following modifiers are recognized:

    ```
    fnr=(the value set by apply_to_pose for favor_native_residue &float)
    hs_hash=(the value set by apply_to_pose for hotspot_hash &float)
    ```

    For Example:

    ```
    <my_spiffy_score weights="soft_rep_design" patch="dock" fnr=6.0/>
    will multiply the favor_native_residue bonus by 6.0
    ```

APPLY\_TO\_POSE
---------------

This is a section that is used to change the input structure. The most likely use for this is to define constraints to a structure that has been read from disk.

-   **Recognized movers:**

    ```
    <favor_native_residue bonus=(1.5 &bool)/>
    ```

    sets residue\_type\_constraint to the pose and sets the bonus to 1.5.

    ```
    <hashing_constraints scorefxn=(score12 &string)
    stubfile=(stubs.pdb &string)
    redesign_chain=(2 &integer)
    cb_force=(1.0 &float)
    worst_allowed_stub_bonus=(-1.0 &float)
    apply_stub_self_energies=(1 &bool)
    apply_stub_bump_cutoff=(4.0 &float)
    pick_best_energy_constraint=(1 &bool)/>
    ```

MOVERS
------

Each mover definition has the following structure:

```
<"mover_name" name="&string" .../>
```

where "mover\_name" belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

-   **Special movers:**
    1.  DockDesign mover:
         This is a special mover that allows making a single compound mover and filter vector (just like protocols).

        ```
        <DockDesign name=( &string)>
            <Add mover_name=( null &string) filter_name=( true_filter &string)/>
            ...
        </DockDesign>
        ```
    2.  LoopOver mover:
         Allows looping over a mover using either iterations or a filter as a stopping condition (the first turns true). By using DockDesign mover above with loop can be useful, e.g., if making certain moves is expensive and then we want to exhaust other, shorter moves.

        ```
        <LoopOver name=(&string) mover_name=(&string) filter_name=( true_filter &string) iterations=(10 &Integer)/>
        ```

-  Recognized Movers:
    1.  score\_low is the scorefxn to be used for centroid-level docking; score\_high is the scorefxn to be used for full atom docking; rb\_jump controls the jump number over which tocarry out rb motions.

        ```
        <Docking name="&string" score_low=(docking_score_low &string) score_high=(docking_score &string) fullatom=(0 &bool) local_refine=(0 &bool) view=(0 &bool) rb_jump=(1 &Integer)/>
        ```
    2.  RepackMinimize does the design/repack and minimization steps using different score function as defined by the protocol. repack\_partner1 (and 2) defines which of the partners to design. If no particular residues are defined, the interface is repacked/designs. If specific residues are defined, then a shell of residues around those target residues are repacked/designed and minimized. repack\_non\_ala decides whether or not to change positions that are not ala. Useful for designing an ala\_pose so that positions that have been changed in previous steps are not redesigned. min\_rigid\_body minimize rigid body orientation. (as in docking)

        ```
        <RepackMinimize name="&string" scorefxn_repack=(score12 &string) scorefxn_minimize=(score12 &string) repack_partner1=(0 &bool) repack_partner2=(1 &bool) design=(1 &bool) interface_cutoff_distance=(8.0 &Real) repack_non_ala=(1 &bool) min_rigid_body=(1 &bool)>
          <residue pdb_num/res_num, see below/>
        </RepackMinimize>
        ```
    3.  Same as for DesignMinimize with the addition that a list of target residues to be hbonded can be defined. Within a sphere of 'interface\_cutoff\_distance' of the target residues,the residues will be set to be designed.The residues that are allowed for design are restricted to hbonding residues according to whether donors (STRKWYQN) or acceptors (EDQNSTY) or both are defined. If residues have been designed that do not, after design, form hbonds to the target residues with energies lower than the hbond\_energy, then those are turned to Ala.

        ```
        <DesignMinimizeHbonds name=(design_minimize_hbonds &string) hbond_weight=(3.0 &float) scorefxn_design=(score12 &string) scorefxn_minimize=score12) donors="design donors? &bool" acceptors="design acceptors? &bool" bb_hbond=(0 &bool) sc_hbond=(1 &bool) hbond_energy=(-0.5 &float) interface_cutoff_distance=(8.0 &float) design_partner1=(0 &bool) design_partner2=(1 &bool) repack_non_ala=(1 &bool) min_rigid_body=(1 &bool)>
            <residue pdb_num="pdb residue and chain, e.g., 31B &string"/>
            <residue res_num="serially defined residue number, e.g., 212 &integer"/>
        </DesignMinimizeHbonds>
        hbond_weight:            sets the increase (in folds) of the hbonding terms in each of the scorefunctions that are defined.
        bb_hbond:                do backbone-backbone hbonds count?
        sc_hbond:                do backbone-sidechain and sidechain-sidechain hbonds count?
        hbond_energy:            what is the energy threshold below which an hbond is counted as such.
        repack_non_ala:          see RepackMinimize
        ```
    4.  Turns either or both sides of an interface to Alanines (except for prolines and glycines that are left as in input) in a sphere of 'interface\_distance\_cutoff' around the interface. Useful as a step before design steps that try to optimize a particular part of the interface. The alanines are less likely to 'get in the way' of really good rotamers.

        ```
        <build_Ala_pose name=(ala_pose &string) partner1=(0 &bool) partner2=(1 &bool) interface_distance_cutoff=(8.0 &float)/>
        ```
    5.  To be used after an ala pose was built (and the design moves are done) to retrieve the sidechains from the input pose that were set to Ala by build\_Ala\_pose. Sidechains that are different than Ala will not be changed.

        ```
        <SaveAndRetrieveSidechains name=(save_and_retrieve_sidechains &string)/>
        ```
    6.  With the values defined above, backrub will only happen on residues 31B, serial 212, and the serial span 10-20. If no residues and spans are defined then all of the interface residues on the defined partner will be backrubbed by default.

        ```
        <Backrub name=(backrub &string) partner1=(0 &bool) partner2=(1 &bool) interface_distance_cutoff=(8.0 &Real) moves=(1000 &integer) sc_move_probability=(0.25 &float) scorefxn=(score12 &string)>
            <residue pdb_num="pdb residue and chain, e.g., 31B &string"/>
            <residue res_num="serially defined residue number, e.g., 212 &integer"/>
            <span begin="serially defined residue number, e.g., 10 &integer" end="serially defined residue number, e.g., 20 &integer"/>
        </Backrub>
        ```
    7.  Places a stub on the scaffold. The stub is chosen using MC sampling using the score\_threshold and temp. parameters.repack\_non\_ala: see RepackMinimize

        ```
        <PlaceStub name=(&string) chain_to_design=(2 &integer) score_threshold=(-2.0 &Real) temperature=(0.8 &Real) repack_non_ala=(1 &bool) self_energy_trials=(2000 &Integer) two_sided_trials=(200 &Integer) stubfile=(&string) final_filter=(true_filter &string)/>
        self_energy_trials:              how many times should we try to place a stub and test its self energy (this is a fast step, so high is probably good).
        two_sided_trials:                how many two-sided trials to test (this is slow, so recommended is just slightly more than the number of stubs in the library).
        stubfile:                        using a stub file other than the one used to make constraints. This is useful for placing stubs one after the other.
        final_filter:                    one of the default DockDesignFilters or the ones defined by the user. This will be applied at the final stage of stub placement as the last
                                         test. Useful, e.g., if we want a stub to form an hbond to a particular target residue.
        ```
    8.  Places the scaffold on a stub. The stub is chosen using MC sampling using the score\_threshold and temp. parameters.

        ```
        <PlaceScaffold name=(&string) chain_to_design=(2 &integer) score_threshold=(-2.0 &Real) temperature=(0.8 &Real) repack_non_ala=(1 &bool) distance=(2.0 &Real) self_energy_trials=(2000 &Integer) two_sided_trials=(2000 &Integer) stubfile=(&string) final_filter=(true_filter &string)/>
        repack_non_ala:                  see RepackMinimize
        distance:                        max distance from scaffold CA to stub CA
        self_energy_trials:              how many times should we try to place a stub and test its self energy (this is a fast step, so high is probably good).
        two_sided_trials:                how many two-sided trials to test (this is slow, so recommended is just slightly more than the number of stubs in the library).
        stubfile:                        using a stub file other than the one used to make constraints. This is useful for placing stubs one after the other.
        final_filter:                    one of the default DockDesignFilters or the ones defined by the user. This will be applied at the final stage of stub placement as
                                         the last test. Useful, e.g., if we want a stub to form an hbond to a particular target residue.
        ```
    9.  Dumps a pdb. Recommended ONLY for debuggging as you can't change the name of the file during a run.

        ```
        <DumpPdb name=(&string) fname=(dump.pdb &string)/>
        ```
    10. Performs something approximating r++ prepacking by doing sc minimization and repacking. Separates chains based on jump\_num, does prepacking, then reforms the complex.If jump\_num=0, then it will NOT separate chains at all.

        ```
        <Prepack name=(&string) scorefxn=(score_docking &string) jump_number=(1 &integer)/>
        ```
    11. Do domain-assembly sampling by fragment insertion in a linker region. frag3 and frag9 specify the fragment-file names for 9-mer and 3-mer fragments.

        ```
        <DomainAssembly name=(&string) linker_start_(pdb_num/res_num, see above) linker_end_(pdb_num/res_num, see above) frag3=(&string) frag9=(&string)/>
        ```
    12. Finds nstubs potential hotspot amino acids.Target\_resnum/distance are option, and specify an amino acid on the target to focus hotspot-finding. Attempting to use a core amino acid here will cause problems. Existing hashes can be read with "in=". Note that if the output file file ("out=") already exists, it will also be read in! This helps recover from job restarts on the clusters.The hotspot residues to find can be any name rosetta recognizes (note that mini uses all caps!). "ALL" is a special name that includes all amino acids except G and C. Threshold= specifies a special contact score that all found stubs must be better than or equal to.

        ```
        <HotspotHasher name=(&string) nstubs=(1000 &integer) target_resnum_(pdb_num/res_num, see above) target_distance=(15 &Real) in=(&string) out=(hash.stubs &string) threshold=(-1.0 &Real)>
            <residue type=(&string)/>
        </HotspotHasher>
        ```

FILTERS
-------

Each filter definition has the following format:

```
<"filter_name" name="&string" ... confidence=(1 &Real)/>
```

where "filter\_name" belongs to a predefined set of possible filters that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the filter needs to be defined. If confidence is 1.0, then the filter is evaluated as in predicate logic (T/F). If the value is less than 0.999, then the filter is evaluated as fuzzy, so that it will return True in (1.0 - confidence) fraction of times it is probed. This should be useful for cases in which experimental data are ambiguous or uncertain.

-   **Recognized Filters:**
    1.  Computes the binding energy for the complex and if it is below the threshold returns true. o/w false. Useful for identifying complexes that have poor binding energy and killing their trajectory.

        ```
        <Ddg name=(ddg &string) scorefxn=(score12 &string) threshold=(-15 &float)/>
        ```
    2.  Computes the number of residues in the interface specific by jump\_number and if it is above threshold returns true. o/w false. Useful as a quick and ugly filter after docking for making sure that the partners make contact.

        ```
        <ResInInterface name=(riif &string) residues=(20 &integer) jump_number=(1 &integer)/>
        ```
    3.  This filter checks whether residues defined by res\_num/pdb\_num are hbonded with as many hbonds as defined by partners, where each hbond needs to have at most energy\_cutoff energy.

        ```
        backbone: should we count backbone-backbone hbonds?
        sidechain: should we count backbone-sidechain and sidechain-sidechain hbonds?
        <HbondsToResidue name=(hbonds_filter &string) partners="how many hbonding partners are expected &integer" energy_cutoff=(-0.5 &float) backbone=(0 &bool) sidechain=(1 &bool) "res_num/pdb_num see above">
        ```
    4.  Computes the interface sasa and if it's **higher** than threshold passes.

        ```
        <Sasa name=(sasa_filter &string) threshold=(800 &float)/>
        ```
    5.  Filters for poses that place a neighbour of the types specified around a target residue in the partner protein.

        ```
        <NeighborType name=(neighbor_filter &string) "res_num/pdb_num see above" distance=(8.0 &Real)>
            <Neighbor type=(&3-letter aa code)/>
        </NeighborType>
        ```
    6.  How many residues are within an interaction distance of target\_residue across the interface. When used with neighbors=1 this degenerates to just checking whether or not a residue is at the interface.

        ```
        <ResidueBurial name=(&string) "res_num/pdb_num see above" distance=(8.0 &Real) neighbors=(1 &Integer)/>
        ```
    7.  Maximum number of buried unsatisfied H-bonds allowed. If a jump number is specified (default=1), then this number is calculated across the interface of that jump. If jump\_num=0, then the filter is calculated for a monomer. Note that \#unsat for monomers is often much higher than 20.

        ```
        <BuriedUnsatHbonds name=(&string) jump_number=(1 &Size) cutoff=(20 &Size)/>
        ```
    8.  What is the distance between two residues?

        ```
        <ResidueDistance name=(&string) res1_"res_num/pdb_num see above" res2_"resnum/pdb_num" distance=(8.0 &Real)/>
        ```
    9.  Tests the energy of a particular residue.

        ```
        <EnergyPerResidue name=(energy_per_res_filter &string) scorefxn=(score12 &string) score_type=(total_score &string) pdb_num/res_num(see above) energy_cutoff=(0.0 &float)/>
        ```
    10. Computes the energy of a particular score type for the entire pose and if that energy is lower than threshold, returns true.

        ```
        ScoreType name=(score_type_filter &string) scorefxn=(score12 &string) score_type=(&string) threshold=(&float)/>
        ```
        Don't use these energy filters directly after centroid level moves, because the energies are likely to be extremely high.


