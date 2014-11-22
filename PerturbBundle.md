## PerturbBundle

This mover operates on a pose generated with the MakeBundle mover.  It perturbs (<i>i.e.</i> adds a small, random value to) one or more Crick parameters, then alters the backbone conformation to reflect the altered Crick parameters.  This is useful for iterative Monte Carlo searches of Crick parameter space.

```
<PerturbBundle name=(&string) default_perturbation_type=(&string)
     r0_perturbation=(&real) r0_perturbation_type=(&string)
     omega0_perturbation=(&real) omega0_perturbation_type=(&string)
     delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string)
     delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string)
     delta_t_perturbation=(&real) delta_t_perturbation_type=(&string) >
          <Helix
               r0_perturbation=(&real) r0_perturbation_type=(&string) r0_copies_helix=(&int)
               omega0_perturbation=(&real) omega0_perturbation_type=(&string) omega0_copies_helix=(&int)
               delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string) delta_omega0_copies_helix=(&int)
               delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string) delta_omega1_copies_helix=(&int)
               delta_t_perturbation=(&real) delta_t_perturbation_type=(&string) delta_t_copies_helix=(&int) />
</PerturbBundle>
```
