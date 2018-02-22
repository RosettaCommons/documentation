#MultistageRosettaScripts

#Batch Relax Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 21, 2018

```xml
<JobDefinitionFile>
  <Job>
    <Input>
      <PDB listfile="protocols/multistage_rosetta_scripts/pdblist"/>
    </Input>

    (Optional datamap info)
  </Job>

  <Job>
    <Input>
      <PDB filename="protocols/multistage_rosetta_scripts/3U3B_B.pdb"/>
    </Input>

    (Optional datamap info)
  </Job>

  <Common>
     (...)
  </Common>

</JobDefinitionFile>
```