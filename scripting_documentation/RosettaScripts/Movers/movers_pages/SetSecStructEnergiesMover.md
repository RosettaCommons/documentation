# SetSecStructEnergies
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetSecStructEnergies

Give a bonus to the secondary structures specified by the user. For example a sheet topology of "1-4.A.99" would specify an antiparallel relationship between strand 1 and strand 4; when this is present a bonus (negative) score is applied to the pose.


```xml
<SetSecStructEnergies name="(&string)"
    scorefxn="(&string, required)"
    secstruct="(&string, '')"
    use_dssp="(&bool, true)"
    hh_pair="(&string, '')"
    ss_pair="(&string, '')"
    hss_triplets="(&string, '')"
    blueprint="(&string '')"
    ss_from_blueprint="(&string, true)"
    natbias_ss="(&float)"
/> 
```

-   **blueprint** - If specified, a blueprint file will be used to find ss_pair, hh_pair and hss_triplets.  If use_blueprint_ss is also true, the blueprint will be used to specify the pose secondary structure.
-   **use_blueprint_ss** - Has no effect if a blueprint file is not specified. If true, and a blueprint file is specified, the blueprint secondary structure will be used to define secondary structure elements. 
-   **secstruct** - The given secondary structure will be used to determine strands and helices within the pose.  If unspecified, the value of use_dssp will control how the secondary structure is obtained.
-   **use_dssp** - If true, DSSP will be used to compute the secondary structure of the input pose. If false, the secondary structure stored in the pose by a mover such as DsspMover will be used.
-   **ss_pairs** - Strand pairs are indicated by number (1-4 is strand 1 / strand 4) followed by a ".", followed by A of P (Antiparallel/Parallel), followed by a ".", followed by the desired register shift where "99" indicates any register shift, e.g. "1-6.A.99;2-5.A.99;" Indicates an antiparallel pair between strand 1 and strand 6 with any register; and an antiparallel pair between strand 2 and strand 5 with any register.  In the order of secondary structure specification, pairs start from the lowest strand number. So a strand 1 / strand 2 pair would be 1-2.A, not 2-1.A, etc.
-   **hh_pairs** - Helix-helix pairs are indicated by H1-H2.D, where H1 is the helix number in primary sequence space, H2 is the paired helix number in primary sequence space, and D is the direction of pairing (P for parallel and A for antiparallel).  For example, "1-3.A;2-3.P" indicates that helices 1 and 3 are paired in an antiparallel configuration, and helices 2 and 3 are paired in a parallel configuration.
-   **hss_triplets** - Helix-strand-strand triplets are defined by a string [H,S1-S2;]*, where H is the helix number, S1 is the strand number for the first strand, and S2 is the strand number for the second strand. For example, "1,2-3;2,1-3" indicates that helix 1 is paired to strands 2 and 3, and helix 2 is paired to strands 1 and 3.
-   natbias\_ss = score bonus for a correct pair.


##See Also

* [[BluePrintBDRMover]]: Commonly used with SetSecStructEnergies
* [[DsspMover]]
* [[RemodelMover]]
* [[SetTemperatureFactorMover]]
* [[SetTorsionMover]]
* [[I want to do x]]: Guide to choosing a mover
