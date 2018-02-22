#MultistageRosettaScripts

#PDBList Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 21, 2018

I mentioned in the [[Batch Relax exmaple|BatchRelaxExample]] that I generated
a job definition file with 30,000 `<Job/>` tags.
This was a byproduct of the script converter, which is not smart enough to
differentiate between poses provided using `-l` and `-s` so it just loads
all of the files individually.
If you were to write the script by hand, you could save time by using the `listfile`
option as shown in the first `<Job>` tag below.

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