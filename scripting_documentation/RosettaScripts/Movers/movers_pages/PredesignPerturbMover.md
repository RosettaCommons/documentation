# PredesignPerturbMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PredesignPerturbMover

PredesignPerturbMover randomly perturbs a ligand in a protein active site. The input protein will be transformed to a polyalanine context for residues surrounding the ligand. A number of random rotation+translation moves are made and then accepted/rejected based on the Boltzmann criteria with a modified (no attractive) score function (enzdes\_polyA\_min.wts).

PredesignPerturbMover currently will perturb only the last ligand in the pose (the last jump).

    <PredesignPerturbMover name="(&string)" trans_magnitude="(0.1 &real)" rot_magnitude="(2.0 &real)" dock_trials="(100 &integer)" task_operations="(&string,&string)"/>

-   dock\_trials - the number of Monte Carlo steps to attempt
-   trans\_magnitude - how large (stdev of a gaussian) a random translation step to take in each of x, y, and z (angstrom)
-   rot\_magnitude - how large (stdev of a gaussian) a random rotational step to take in each of the Euler angles (degrees)
-   task\_operations - comma separated list of task operations to specify which residues (specified as designable in the resulting task) are converted to polyAla


