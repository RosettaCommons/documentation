# [[extract_pdbs]]

[[_TOC_]]

## Code and Demo
The [[extract_pdbs]] can be found in `<path/to/rosetta>/main/source/bin/extract_pdbs.linuxgccrelease`

## Background

## Algorithm Description

This app extracts poses from a silent file as a PDB file, based on the tag(s). Tag is written under the 'description' column (24th column) in silent file, and has a format of 'reault_xxxx'.

    silent_file_path='out.silent'
    tags='result_0001 result_0002'
    <path/to/rosetta>/main/source/bin/extract_pdbs.linuxgccrelease -in:file:silent $silent_file_path -in:file:tags $tags

## Options

**General options**

|**Flag**|**Short Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|-in:file:silent||Input silent file|String|
|-in:file:tags||Tags of desired poses|String|

## Sample Command Lines

## Citation

## Contact

## References

## See Also
