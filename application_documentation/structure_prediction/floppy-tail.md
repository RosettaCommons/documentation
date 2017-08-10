#FloppyTail application

Metadata
========

Author: Steven Lewis (smlewi - at - gmail.com)

Code by Steven Lewis. Corresponding PI Brian Kuhlman (bkuhlman - at - email.unc.edu).

Code and Demo
=============

The code is at `       rosetta/main/source/src/apps/public/scenarios/FloppyTail/      ` ; there's an integration test+demo at `       rosetta/main/tests/integration/tests/FloppyTail/      ` . Note that the integration test is vastly under-cycled relative to getting it to do anything useful: the number of cycles it demonstrates should be sufficient to show some remodeling but not enough to get anywhere useful. To run that demo, go to that directory and run `[path to executeable] -database [path to database] (at-symbol)options`

References
==========

-   [Kleiger G, Saha A, Lewis S, Kuhlman B, Deshaies RJ. Rapid E2-E3 assembly and disassembly enable processive ubiquitylation of cullin-RING ubiquitin ligase substrates. Cell. 2009 Nov 25;139(5):957-68. PubMed PMID: 19945379.](http://www.ncbi.nlm.nih.gov/pubmed/19945379) (pubmed link)

You may want to look at the online supplemental info for that paper for a different presentation of how the code works.

-   [Crawley SW, Gharaei MS, Ye Q, Yang Y, Raveh B, London N, Schueler-Furman O, Jia Z, Côté GP. Autophosphorylation activates Dictyostelium myosin II heavy chain kinase A by providing a ligand for an allosteric binding site in the alpha-kinase domain. J Biol Chem. 2011 Jan 28;286(4):2607-16. Epub 2010 Nov 11.](http://www.ncbi.nlm.nih.gov/pubmed/21071445) (pubmed link)

This paper uses FloppyTail but is not related to development.  Key idea: the paper authors were able to productively use FloppyTail without significant assistance from the code's author.

-  [Zhang J, Lewis SM, Kuhlman B, Lee AL. Supertertiary structure of the MAGUK core from PSD-95. Structure. 2013 Mar 5;21(3):402-13.] (http://www.ncbi.nlm.nih.gov/pubmed/23395180) (pubmed link)

This paper uses FloppyTail to generate models consistent with NMR and SAXS data for interpretation of a structure of biological interest.

-  [Santiago-Frangos A, Jeliazkov JR, Gray JJ, Woodson SA. Acidic C-terminal domains autoregulate the RNA chaperone Hfq. eLIFE. 2017 Aug 9;](https://elifesciences.org/articles/27049)

This paper uses an ensemble of FloppyTail-generated models to assess probability/energy of disordered tail to ordered core interactions and predictions are experimentally validated.

Application purpose
===========================================

This code was written for a relatively singular application. The system in question was a protein with a long (dozens of residues) flexible tail, which was not seen in crystal structures. Biochemical evidence suggested a particular binding site for the tail on a known binding partner (the two binding partners also had a known binding interface separate from this tail). The code was intended to model the reach of the long flexible tail and determine whether the hypothesized binding site was plausible.

The protocol is more useful for testing hypotheses about possible conformations, and exploring accessible conformation space, than for finding "the one true binding mode". If your tail is truly that flexible it might not have a "one true binding mode."

The Philosophy of FloppyTail – how to use it on hard problems
=============================================================

(Note that this section may duplicate some of the above, or the demo – it was written to stand alone and included here for posterity)

FloppyTail is aimed at “constrained docking”.  It can be used when you have one or more relatively rigid domains, with flexible linkers connecting them / at their ends.  For some cases, like the original flexible tail, the question is “where might this tail be able to dock onto the rigid protein?”  For some cases, like two domains with a linker between them, it might be “how should these two proteins dock, given that some conformations are impossible because the linker can’t stretch that far?”

Broadly speaking, FloppyTail comes into play for FLEXIBLE linkers.  There are two problems with this.  First, the Rosetta energy function is parameterized on and for well folded crystalline protein.  It will only do so well with flexible linkers, because its view of physics doesn’t allow for unstructured soluble protein.  Second, flexible linkers are flexible in time, but a static structure has no time domain, so looking at the top model by score is not very informative about the state of the linker region.  So, using FloppyTail and interpreting its results requires some careful consideration of the value of the results.  

If your goal is “I have two proteins that are connected and I want to know what it’s going to look like” – that’s an expensive problem and the success rate is marginal.  (It’s equally expensive, with an equally marginal success rate, to just do global docking and then try to solve the loop, which is a valid alternative).

If you have NO experimental data about your problem, you can use FloppyTail to generate hypotheses.  Look at your result ensemble and see what interactions recur frequently in the better models, then think about ways to test experimentally if those interactions are real (via crosslinking or mutagenesis, perhaps).  

Perhaps you have an idea of a conformation that might exist and you want to check computationally before trying the experiment.  In this case, try using constraints to force the conformation you’re interested in to see if the system can accommodate it.  If you get out models that still don’t have the interaction you wanted, or can only achieve it with tortured geometries, that constitutes a negative result from FloppyTail.

If you have experimental data – great!  Constraints are the way to go.  Run the code with constraints, and you’ll get much higher model quality to feed into further hypotheses.  Alternatively, use the constraints to filter unconstrained results, or just use them to judge if the model population is realistic.  This lets you generate an “envelope” of the things the system might be doing consistent with your constraints, which can be used for further cycles of experiment as necessary.  

Algorithm
=========

The algorithm is fairly simple: small/shear/fragment moves in centroid mode to collapse the tail into some sort of folded conformation from an initially straight-out-into-space extended conformation, and small/shear moves with repacking to refine its position. This is conceptually similar to how abinitio folding works, although it is not refined for that purpose (and does not contain temperature scheduling, etc).

The code is compatible with constraints during the centroid phase (passed in via commandline). Early modeling proceeded using constraints and some small hacks to help guide models to the hypothesized tail-binding site. Ultimately this was not necessary for the original system, but the code retains the ability to use constraints, etc. Your mileage may vary. UPDATE: The code is compatible with constraints in both phases.

Limitations
===========

This code is NOT intended to do "half-abinitio" where you know half a structure and want to fold the other half. Although it is modeled on abinitio, it is only tested on a truly floppy, disordered tail, and I have no idea if it is able to fold compact structures. It is resolutely not supported for that purpose.

If you want to perform standard ab initio folding of a terminal sequence, you can use the [[Topology Broker|BrokeredEnvironment]]'s [[RigidChunk|ClientMovers]] environment. This can be used in RosettaScripts or using the minirosetta application. 


Input Files
===========

See tests/integration/tests/FloppyTail/ for example usage. Basically all you need is an input structure.

-   The code does not tolerate imperfections in the input PDB. Get rid of your heteroatoms, 0-occupancy regions, multiply-defined atoms, and waters beforehand.
-   The code does not add your extension for you. You need to add starting coordinates (however meaningless) for the flexible tail. I had it pointing straight out into space (as it is in the demo). Alternatively, there are PyRosetta scripts in scripts/pyrosetta/public/floppy_tail_utility/ that can update input conformations (disordered residues present) to be extended or append/prepend tails (adds the disordered residues for you).
-   See the [[fragment file]] input format for an explanation of how to make fragments.
-   See the [[constraint file]] input format for an explanation of constraint files.

Tips
====

This code was intended for a single purpose, but it may work if you have a similarly flexible tail. It can also model internal flexible regions between domains.

-   You are likely to need a large number of trajectories if you have a long tail. The protocol gets trapped in bad conformations fairly easily even with the Metropolis criterion. Production runs for publication completed slightly less than 30000 trajectories in 1000 processor-days on 2.3 gigahertz processors. I'm sure this can be enormously optimized if you wanted to. (Additionally, an error in the code has been corrected since publication that decreases runtime by 10-25%)
-   Constraints are a GREAT way to bias your modeling to test if a hypothesized conformation is possible.
-   Do not use the -publication flag unless you are doing the demo or repeating the publication. It activates an extra function for system-specific analysis (essentially, postprocessing scripts are embedded inside the executeable). These will crash if run against inputs other than the expected E2/E3/UBQ system.
-   This code is compatible with silent-file input, but you have to work around the PDB-numbering based inputs assuming numbering from 1 and chain-lettering from A. (Just use a PDB!)
-   When modeling a terminal flexible region (a tail), in the refinement phase, the protocol can be directed to model a shorter portion of the tail for part of refinement mode with the short\_tail\_xxx options. The reasoning is that the tail may be too close to a binding partner in the structure fresh from centroid mode, even with repacking (centroids tend to be a bit too small for this sort of docking). By only remodeling the tip of the tail in the first part of refinement, you can relax clashes without swinging the tail back out into space.
-   The short\_tail\_xxx, constraint, and pair\_off options were not used for production runs with this code. They were used for early experiments, controls, debugging, etc. They still work.
-   Fragments are supported, but were not found to be necessary. You should probably be running this on a sequence which has little secondary structure anyway, so the fragments won't be too useful. In the publication case, use of fragments resulted in scattered short helices in the results (clearly raw fragments) without affecting any of the important metrics.
-   Do a secondary structure and disorder prediction on your flexible tail ahead of time. If it has no SS preferences, use FloppyTail. If it has a few predicted helices, use FloppyTail with fragments. If it has a lot of secondary structure, use abinitio.
-   If you have a single chain (one protein), if the flexible region is closer to the N-terminus than the C-terminus, use the C\_root option to make computation faster. It reroots the fold tree on the C terminus, obviating a lot of useless recalculation of coordinates for the rigid part of the protein (if the N part is moving).
-   You must use the C\_root option (or pass a flexible\_start\_resnum of zero) when using an N-terminal tail. Otherwise, the first residue of the tail will have no motion in phi (undefined at an N-terminus), and the residue will remain fixed in space in a probably undesired fashion.
-   If you are modeling a complex, ensure that the flexible region has either the highest or lowest residue numbers possible: if it is a N-terminus, put its subcomponent first in the PDB file, or vice-versa if it is C-terminal. Use the C\_root option if your flexible region is a lower residue number, and do not if it is higher. If you have more than two components in your complex, and are modeling a linker between them, then the linker's chain must come between the groups of internally rigid parts in the input PDB file.
-   force\_linear\_fold\_tree combines with C\_root in the quest for perfect control over the kinematics of the system. Use force\_linear\_fold\_tree when you need folding to proceed C to N between chains, instead of jumping around.
-   FloppyTail now fully supports modeling internal linker regions (to do domain assembly). It detects interfaces between the internally rigid portions and packs accordingly.

Options
=======

####FloppyTail options

-   -flexible\_start\_resnum - integer - this is the start of the flexible tail in PDB numbering. (See below that you have an option for passing a MoveMap file instead).  If you do use this option, you are required to also use -flexible_chain.
-   -flexible\_stop\_resnum - integer - this is the end of the flexible region, in PDB numbering. Not using this option means the entire chain after flexible\_start\_resnum. (See below that you have an option for passing a MoveMap file instead).  If you do use this option, you are required to also use -flexible_chain.
-   -flexible\_chain - string - the first character of this string is interpreted as the PDB chain for the flexible region; any other characters are ignored.
-   -shear\_on - real - In centroid mode, shear moves are completely nonproductive early on when the tail is still largely extended. This value gives the fraction of centroid cycles when shear moves will be allowed (introduced into the moveset of the RandomMover choosing perturbation moves). For example, passing 0.333 means that for the first third of centroid mode, shear moves will be disallowed.
-   -short\_tail::short\_tail\_fraction - real - Fraction of the tail used in the short tail fraction of refinement mode. 0.1 would mean the last tenth of the tail is flexible. Not compatible with non-terminal flexible regions.
-   -short\_tail::short\_tail\_off - real - Fraction of refinement cycles dedicated to refining only the short part of the tail. 0.33 means the first third of refinement cycles will be with the shorter flexible region.
-   -pair\_off - boolean - If true, disable the electrostatic Epair (pair and fa\_pair) terms. Used for a control experiment, not for general use.
-   -publication - boolean - If true, output system-specific results used in the demo and publication. Use FALSE for any other purpose; this boolean activates code including hardcoded references to particular residues and will cause either a crash or silly behavior on systems other than the demo/publication.
-   -FloppyTail::cen\_weights - string - Use a custom centroid scorefunction for the centroid stage modeling.

####Kinematics Control options

-   -C\_root - boolean - If true, reroot the fold tree on the C-terminus. Use if you have an N-Terminal tail.
-   -force\_linear\_fold\_tree - boolean - Force a linear fold tree. Use C\_root and reordering the chains in your input PDB as described above to ensure correct kinematics.

####Monte Carlo sampling control options

-   -FloppyTail::perturb\_temp - real - Monte Carlo temperature for perturb phase (0.8 used for production)
-   -FloppyTail::perturb\_cycles - unsigned integer - number of perturb phase cycles (5000 used for production)
-   -FloppyTail::perturb\_show - boolean - if true, outputs centroid poses after perturbation
-   -FloppyTail::debug - debug - if true, outputs poses for each monte carlo cycle
-   -FloppyTail::refine\_temp - real - Monte Carlo temperature for refine phase (0.8 used for production)
-   -FloppyTail::refine\_cycles - unsigned integer - number of refine phase cycles (3000 used for production)
-   -FloppyTail::refine\_repack\_cycles - unsigned integer - Perform a repack/minimize every N cycles of refine mode (30 used for production)

####General options: 

All packing namespace options loaded by the PackerTask are respected. jd2 namespace options are respected. Anything very low-level, like the database paths, is respected.

-   -packing::resfile - string - [[Resfile|resfiles]] if you want one
-   -packing::repack\_only - boolean - Tells the code not to perform design. Design is performed by default because PackerTasks behave that way.
-   -in::file::frag3 - string - [[Fragment file]] if you've got it
-   -run::min\_type - string - [[Minimizer|minimization-overview]] type. dfpmin\_armijo\_nonmonotone used for production.
-   -nstruct - integer - number of structures to generate
-   -constraints::cst\_file - string - [[Constraint file]] - for constraints (the centroid phase)
-   -constraints::cst\_weight - real - constraints weight (centroid phase)
-   -constraints::cst\_fa\_file - string - [[Constraint file]] - for constraints (the fullatom phase)
-   -constraints::cst\_fa\_weight - real - constraints weight (fullatom phase)

Multiple flexible linkers mode
==============================

For release 3.4, FloppyTail supports multiple flexible linkers. To use these, you have to write your own [[MoveMap file]] to tell FloppyTail what is flexible, and pass it in via the flag in:file:movemap. The formatting is described in the header to the function core::kinematics::MoveMap::init\_from\_file (probably at core/kinematics/MoveMap.hh). Briefly, do this:

```
RESIDUE 20 30 BBCHI
RESIDUE 54 67 BBCHI
```

to define flexible regions running from residues 20 to 30 and 54 to 67. This is in internal Rosetta residue numbering (from 1), not PDB numbering.

To use this feature you must also NOT use the following flags, because the movemap handles these data, so the program is set up to ignore inputs from these flags if passing a movemap.

-   flexible\_chain
-   flexible\_stop\_resnum
-   flexible\_chain
-   short\_tail\_fraction
-   short\_tail\_off

Post Processing
===============

You'll be using this application to model mostly unstructured regions. You should not put a lot of stock in any individual model. This is not the sort of application where you'll run it 10 times and then take the best-scoring result as an accurate guess for the actual protein structure.

In general you should pick some metric predicted by the model (if you read the paper, you'll see that it was a distance between two residues later found to be chemically crosslinkable). You can then mine the model population to see what this metric looks like in the top-scoring fraction of models. The extra\_analysis functionality will facilitate this. I suggest histograms.

Changes since last release
==========================

For 3.2, there was a major under-the-hood change which decreases runtime, scaling favorably for very long tails. For the publication case it decreases runtime 10-25%.

For 3.3, the publication flag was added for simplicity. The C\_root flag was added to speed computation on non-c-terminal tails. Constraints work in fullatom mode. Full support for domain assembly (internal linkers) was added.

For 3.4, I added the ability to specify a custom MoveMap, which also allows for multiple rigid and flexible regions.

For 3.5, FloppyTail was refactored into a proper Mover in the protocols library; this should be invisible to end users.

##See Also

* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* Loop modeling applications
  -  [[Loop modeling overview|loopmodel]]
  -  [[CCD loop modeling|loopmodel-ccd]]: Sample loop conformations using fragments and the CCD closure algorithm.
  -  [[Kinematic loop modeling|loopmodel-kinematic]]: Sample loop conformations using the kinematic closure algorithm.
  -  [[Next-generation KIC]]: A newer version of loop modeling with kinematic closure.
  -  [[KIC with fragments|KIC_with_fragments]]: The latest version of loop modeling, combining kinematic closure with sampling of coupled degrees of freedom from fragments.
  -  [[Loop closing]]: Closing chainbreaks introduced during modeling.
  -  [[Stepwise assembly of protein loops|swa-protein-main]]: Generate three-dimensional de novo models of protein segments    :  [[Stepwise assembly of long loops|swa-protein-long-loop]]: For loops greater than 4-5 residues. See also  [[Stepwise monte carlo|stepwise]].
  -  [[Stepwise monte carlo|stepwise]]: Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 

* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[Abinitio relax]]: Application for predicting protein structures from sequences
    * [[Abinitio]]: More details on this application
  * [[NonlocalAbinitio]]: Application for predicting protein structure given some prior structural information
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
