#HybridizeMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## HybridizeMover

Performs comparative modeling as described in detail in:  
[High-resolution comparative modeling with RosettaCM](http://www.sciencedirect.com/science/article/pii/S0969212613002979).  
Song Y, DiMaio F, Wang RY, Kim D, Miles C, Brunette T, Thompson J, Baker D.,
Structure. 2013 Oct 8;21(10):1735-42. doi:10.1016/j.str.2013.08.005. Epub 2013 Sep 12.

    <Hybridize name="&string" stage1_scorefxn="&sring" stage2_scorefxn="&string" fa_scorefxn="&string" batch=(1 &bool) linmin_only=(1 &bool)>
            <Template pdb="&string" cst_file="AUTO" weight=1.000 />
            <Template pdb="&string" cst_file="AUTO" weight=1.000 />
            ...
     </Hybridize>

The weight of each individual template can be adjusted, e.g to accommodate different degrees of sequence similarity.

Further options:  
* stage1_increase_cycles:     Increase sampling in stage 1
* stage2_increase_cycles:     Increase sampling in stage 2

For a more detailed description of it's use for comparative modeling, see [[RosettaCM]]