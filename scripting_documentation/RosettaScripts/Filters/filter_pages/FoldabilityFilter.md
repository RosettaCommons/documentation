# Foldability
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Foldability

Rebuilds a given segment of an input pose a specified number of times using fragment-based assembly. First, the given segment of backbone is removed from the pose. Next, the segment is rebuilt from the N-terminal position of the removed segment by folding from extended chain. No chainbreak constraints are used to prevent biasing the folding. A folding attempt is considered successful if the rebuilt C-terminal end is near the C-terminal end of the original segment, and failed if the C-terminal end is distant from that of the original segment. Secondary structure and torsion bins (i.e. ABEGO) used for fragments are taken from an input pose, or optionally specified in the "motif" option. The score returned is a number between 0 and 1 equal to the ratio of successful folding attempts to total folding attempts.

This filter is designed as a means of quantifying Nobu and Rie's "foldability" metric, in which a structure is refolded several times and compared to the desired structure.

```xml
<Foldability name="(&string)" scorefxn="(&string)" tries="(100 &int)" start_res="(1 &int)" end_res="(1 &int)" motif="('' &string)" distance_threshold="(4.0 &real)" />
```

-   start\_res: The N-terminal residue of the piece of backbone to be rebuilt.
-   end\_res: The C-terminal residue of the piece of backbone to be rebuilt.
-   scorefxn: The score function to be used for fragment insertion.  This should be a centroid-compatible scorefunction. If not specified, the Rosetta default centroid scorefunction is used. 
-   distance_threshold: A folding attempt is considered successful if the end of the refolded region is at most distance_threshold from its original location.
-   motif: The secondary structure + abego to be used for the backbone region to be rebuilt. Taken from input pose if not specified. The format of this string is:

    ```
    <Length><SS><ABEGO>-<Length2><SS2><ABEGO2>-...-<LengthN><SSN><ABEGON>
    ```

    For example, "1LX-5HA-1LB-1LA-1LB-6EB" will build a one residue loop of any abego, followed by a 5-residue helix, followed by a 3-residue loop of ABEGO BAB, followed by a 6-residue strand.

**Example**

The following example runs the foldability filter to rebuild the motif "2LX-5HA-3LX-5EB-2LX" 100 times. The rebuilding will take place starting at residue 30, and the score returned will be the fractions of times (represented as a number between 0 and 1) that folding this piece was successful. The threshold result for success is highly dependent on fold, and can range from 0.05 to 1.0.

```xml
<FILTERS>
    <Foldability name="foldability" tries="100" start_res="30" motif="2LX-5HA-3LX-5EB-2LX" />
</FILTERS>
<PROTOCOLS>
    <Add filter_name="foldability" />
</PROTOCOLS>
```

## See also

* [[AbInitio Modeling|abinitio-relax]]
* [[Loop Modeling|loopmodel]]
