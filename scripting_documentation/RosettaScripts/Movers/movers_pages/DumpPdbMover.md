# DumpPdb
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DumpPdb

Dumps a pdb. Recommended ONLY for debugging as you can't change the name of the file during a run, although if tag\_time is true a timestamp with second resolution will be added to the filename, allowing for a limited amount of multi-dumping. If scorefxn is specified, a scored pdb will be dumped.

    <DumpPdb name="(&string)" fname="(dump.pdb &string)" scorefxn="(&string)" tag_time="(&bool 0)"/>


##See Also

* [[LoadPDBMover]]
* [[SavePoseMover]]
* [[I want to do x]]: Guide to choosing a mover