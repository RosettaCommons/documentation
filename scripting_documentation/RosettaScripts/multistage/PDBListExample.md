#MultistageRosettaScripts

#PDBList Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 21, 2018

The first job tag submits several input structures,
one for each filename in the pdblist.
The second job tag just submits one input structure.

```xml
<JobDefinitionFile>
  <Job>
    <Input>
      <PDB listfile="my_pdblist"/>
    </Input>

    (Optional datamap info)
  </Job>

  <Job>
    <Input>
      <PDB filename="some_other_pose.pdb"/>
    </Input>

    (Optional datamap info)
  </Job>

  <Common>
     (...)
  </Common>

</JobDefinitionFile>
```