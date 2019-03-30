# FastRelax
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FastRelax

**Temporary Note:** The increased repulsive feature presented at Rosettacon2018 can be [[found here|RelaxScript]].

Performs the fast relax protocol.  This finds low-energy backbone and side-chain conformations near a starting conformations by performing many rounds of packing and minimizing, with the repulsive weight in the scoring function gradually increased from a very low value to the normal value from one round to the next.

## Usage

[[include:mover_FastRelax_type]]

The MoveMap (for FastRelax) is initially set to minimize all degrees of freedom. The movemap lines are read in the order in which they are written in the xml file, and can be used to turn on or off dofs. The movemap is parsed only at apply time, so that the foldtree and the kinematic structure of the pose at the time of activation will be respected.

### Relax Scripts

For a list of relax scripts in the database, [[click here|RelaxScript]].

### Relevant command-line options

See the [[relax application|Relax]] page for more information on these options.

- `-relax:constrain_relax_to_start_coords`
- `-relax:constrain_relax_to_native_coords`
- `-relax:ramp_constraints`

### Caveats

- Although the [[relax application|Relax]] can read a movemap from the `-in:file:movemap` option, the RosettaScripts mover ignores it.  Instead you must use the `<MoveMap>` syntax described above.

##See Also
* [[FastDesignMover]]
* [[Relax]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover