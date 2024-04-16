# [[extract_pdbs]]

[[_TOC_]]

## Algorithm Description

This app extracts poses from a silent file and exports them as a PDB file, based on the tag(s). The tag is written under the 'description' column (24th column) in the silent file, and has a format of 'result_xxxx'.

    ROSETTA='path/to/rosetta'
    silent_file_path='out.silent'
    tags='result_0001 result_0002'

    $ROSETTA/main/source/bin/extract_pdbs.linuxgccrelease -in:file:silent $silent_file_path -in:file:tags $tags

## Options

**General options**

|**Flag**|**Short Flag**|**Description**|**Type**|
|:-------|:-------|:--------------|:-------|
|-in:file:silent||Input silent file|String|
|-in:file:tags||Tags of desired poses|String|

