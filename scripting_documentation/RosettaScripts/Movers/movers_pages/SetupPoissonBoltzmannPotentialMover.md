# SetupPoissonBoltzmannPotential
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetupPoissonBoltzmannPotential

Initialize the runtime environment for Poisson-Boltzmann solver. It allows keeping track of protein mutations to minimize the number of PB evaluations.

Currently the feature is only supported by the **ddG** mover and filter.

**[ Prerequisites ]**

-   Build the customized version of [APBS](http://www.poissonboltzmann.org/apbs) and [iAPBS](http://mccammon.ucsd.edu/iapbs) , according to the instructions found in /path/to/rosetta/rosetta\_source/external/apbs/apbs-1.4-rosetta/README.

<!-- -->

       APBS:
        Baker NA, Sept D, Joseph S, Holst MJ, McCammon JA. Electrostatics of 
        nanosystems: application to microtubules and the ribosome. Proc. Natl. 
        Acad. Sci. USA 98, 10037-10041 2001. (Link)

       iAPBS:
        Robert Konecny, Nathan A. Baker and J. Andrew McCammon, 
        iAPBS: a programming interface to Adaptive Poisson-Boltzmann Solver 
        (APBS), Computational Science & Discovery, 2012, 5, 015005 (preprint).

        The iAPBS development is supported by grants from the National Center for 
        Research Resources (5P41RR008605-19) and the National Institute of General 
        Medical Sciences (8P41GM103426-19) from the National Institutes of Health. 

-   Build Rosetta with **extras=apbs** argument. This will cause linking your app against the APBS/iAPBS libraries.

-   Set the LD\_LIBRARY\_PATH environment variable to

<!-- -->

    export LD_LIBRARY_PATH=/path/to/rosetta/Rosetta/main/source/external/apbs/apbs-1.4-rosetta/lib:${LD_LIBRARY_PATH}

-   In your rosetta script, call **SetupPoissonBoltzmannPotential** before any PB-enabled scorefxn (i.e. scorefxn with **pb\_elec** ) is evaluated.

**[ Usage ]**

    <SetupPoissonBoltzmannPotential name="pb_setup" scorefxn="sc12_pb" charged_chains="1" epsilon="2.0" sidechain_only="true" revamp_near_chain="2" potential_cap="20.0" apbs_debug="2" calcenergy="false"/>

-   name: Arbitary name used to refer to the mover
-   charged\_chains: Comma delimited list of charged chainnumbers (\>=1). e.g. charged\_chains=1,2,3 for chains 1, 2 and 3. No extra whitespace is permitted.
-   epsilon (optional): mutation tolerance in Angstrom. Potential is re-computed only when | Ca1 - Ca2 | \> epsilon, for all Ca1 in Alpha-carbon in previous pose and all Ca2 in the current pose. The default is 2.0 A.
-   sidechain\_only (optional): Set "true" to limit calculation of interactions to sidechain. Defaul to "false"
-   revamp\_near\_chain (optional): Comma delimited list of chain numbers. Scale down PB interactions if near the given chain(s). Default to none.
-   potential\_cap (optinal) : Upper limit for PB potential input. Default to 20.0.
-   apbs\_debug (optional): APBS debug level [0-6]. Default to 2.
-   calcenergy (optional): Set "true" to calculate energy. Not yet implemented. Default to false.

Warning: Pay attention to those movers or filters that prescore when their XML definitions appear & are parsed withint your script file. Use SavePoseMover to defer their prescoring timing. One filter that is known to-day is DeltaDdg filter. It evalutates the scorefxn when the definiton appears in the XML script. Here's how you have it defer and make PB works.

**[ Example ]**

    <SCOREFXNS>
        <ScoreFunction name="sc12_pb" weights="score12_full" patch="pb_elec"/>
    </SCOREFXNS>
    <MOVERS>
       <SetupPoissonBoltzmannPotential name="pb_setup" charged_chains="1" scorefxn="sc12_pb" />
       <SavePoseMover name="save_after_pb_setup" reference_name="pose_after_setup"/> 
    </MOVERS>
    <FILTERS>
       <Ddg name="ddg" scorefxn="sc12_pb" confidence="0" repeats="1"/>
       <Delta name="delta_ddg" filter="ddg"  reference_name="pose_after_setup" lower="0" upper="1" range="-0.5"/> # defers scoring till the ref pose is saved
    </FILTERS>
    <PROTOCOLS>
       <Add mover_name="pb_setup"/>  # init PB
       <Add mover_name="save_after_pb_setup"/>  # save the reference pose
       ...
       <Add filter_name="delta_ddg"/>
    </PROTOCOLS>

Protein mutation is monitored for both bounded or unbounded states, and a pose is cached for each state, across all scoring functions by default. If you need to cache different poses depending upon scorefxn, you need to customize the tags associated with cached poses using \<Set\> for scorefxns.

    <SCOREFXNS>
       <ScoreFunction name="sc12_pb" weights="score12_full" patch="pb_elec">
          <Set pb_bound_tag="MyBound"/>       # cache pose as "MyBound"
          <Set pb_unbound_tag="MyUnbound"/>   # cache pose as "MyUnbound"
       </ScoreFunction>
    </SCOREFXNS>

The default values are "bound" and "unbound", respectively.

##See Also

* [[ddGMover]]: Supports the Poisson-Boltzmann energy method
* [[I want to do x]]: Guide to choosing a mover