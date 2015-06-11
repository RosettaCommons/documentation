# ExtraRotamersGeneric
## ExtraRotamersGeneric

During packing, extra rotamers can be used to increase sampling. Use this TaskOperation to specify for all residues at once what extra rotamers should be used. Note: The *extrachi\_cutoff* is used to determine how many neighbors a residue must have before the extra rotamers are applied. For example of you want to apply extra rotamers to all residues, set *extrachi\_cutoff=0* . See the Extra Rotamer Commands section on the [[resfiles|resfiles#Extra-Rotamer-Commands:]] page for additional details.

     <ExtraRotamersGeneric name=(&string)
    ex1=(0 &boolean) ex2=(0 &boolean) ex3=(0 &boolean) ex4=(0 &boolean)
    ex1aro=(0 &boolean) ex2aro=(0 &boolean) ex1aro_exposed=(0 &boolean) ex2aro_exposed=(0 &boolean)
    ex1_sample_level=(7 &Size) ex2_sample_level=(7 &Size) ex3_sample_level=(7 &Size) ex4_sample_level=(7 &Size)
    ex1aro_sample_level=(7 &Size) ex2aro_sample_level=(7 &Size) ex1aro_exposed_sample_level=(7 &Size) ex2aro_exposed_sample_level=(7 &Size) 
    exdna_sample_level=(7 &Size)
    extrachi_cutoff=(18 &Size)/> 

