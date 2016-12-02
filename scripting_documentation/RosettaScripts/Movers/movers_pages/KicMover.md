# KicMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## KicMover

Generate new backbone conformations for the loop being sampled.  Conformations 
are generated using the kinematic closure (KIC) algorithm.  The idea behind KIC 
is that every time a new conformation is generated, all but 6 of the torsions 
can be picked however the user likes, e.g. from Ramachandran space (the most 
common choice), from a fragment library, according to some custom algorithm, 
etc.  The remaining 6 torsions are solved for analytically to ensure that the 
backbone stays closed and that all bond lengths and angles maintain ideal 
values.  KIC is a very general algorithm, good for building loops from 
scratch, modeling big conformational changes, modeling small conformational 
changes, and generating backbone ensembles.

```xml
<KicMover name="(&string)" loop_file="(&string)"/>
```

Right now KicMover is not really customizable at all, but I'm hoping to change 
this in the near-ish future (current date: November 2014).  In particular, I want to 
add a general way to specify different algorithms for perturbing the torsions, 
picking the pivots residues, and filtering the solutions.  In the meantime 
though, this mover is pretty static.

Options:

* loop_file: See LoopModeler.

Subtags:

* Loop: See LoopModeler.

Caveats:

* See LoopModeler.

References:

* Mandell DJ, Coutsias EA, Kortemme T. (2009). Sub-angstrom accuracy in protein 
  loop reconstruction by robotics-inspired conformational sampling. Nature 
  Methods 6(8):551-2.

* Coutsias EA, Seok C, Wester MJ, Dill KA. (2005). Resultants and loop closure. 
  International Journal of Quantum Chemistry . 106(1), 176–189.

##See Also

* [[GeneralizedKICMover]]: Version robust to non-protein backbones
* [[RosettaScriptsLoopModeling]]
* [[Loops file]]: File format for specifying loops for loop modeling
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Structure prediction applications]]: A list of command line applications to be used for structure prediction, including loop modeling
* [[I want to do x]]: Guide to choosing a mover