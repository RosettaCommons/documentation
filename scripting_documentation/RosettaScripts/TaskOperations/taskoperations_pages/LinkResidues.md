# LinkResidues
## LinkResidues

Specify groups of residues that should be mutated together.  For example, if one residue in the group is mutated to Cys, all the residues in that group will be mutated to Cys.  This task operation is meant for situations where you want to design a homo-multimer, but you don't want to use symmetry mode (perhaps because your monomers aren't geometrically symmetrical).  

### Usage:

```xml
<LinkResidues name="(&string)">
      <LinkGroup group="(&string)"/>
      ...
</LinkResidues>
```

### Options:

* name: A short string that you can use later in the script to refer to this task operation.

### Subtags:

* LinkGroup: A group of residues should keep the same amino acid identity.  Use the ``group=(&string)`` option to specify a comma-separated list of residue numbers (in rosetta numbering) which residues make up the group.  For example, `group="1,2"` ensures that the first and second residues will keep the same identity.  You can make as many groups as you like by specifying multiple LinkGroup subtags.

### Example:

This script designs a protein according to the a particular resfile, while ensuring that residues 1 and 2 (in rosetta numbering) mutate together.

```xml
<ROSETTASCRIPTS>
  <TASKOPERATIONS>
    <ReadResfile name="resfile" filename="my_resfile.res"/>
    <LinkResidues name="linkres">
      <LinkGroup group="1,2"/>
    </LinkResidues>
  </TASKOPERATIONS>
  <MOVERS>
      <PackRotamersMover name="packer" task_operations="resfile,linkres"/>
  </MOVERS>
  <PROTOCOLS>
    <Add mover_name="packer"/>
  </PROTOCOLS>
</ROSETTASCRIPTS>
```

### Known Bugs:

* This task operation will print "singular unlinked position" warnings and eventually cause a Segmentation Fault if positions in the protein are allowed to design but are not specified in a LinkGroup.  Every position you want to design must be specificed in a LinkGroup.  If a position shouldn't be linked to anything, make a LinkGroup specifying only that position; this will "link the position to itself", which is what you want. 

* All of the positions specified in LinkGroups must be allowed to design (i.e. ALLAA in your resfile or something), otherwise you'll get a SegmentationFault.