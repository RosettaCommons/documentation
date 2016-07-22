Metadata
========

- Authors: Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com), Dr. Sebastian Raemisch(raemisch@gmail.com), and Dr. Jason W. Labonte (JWLabonte@jhu.edu)
- PIs: Dr. Jeff Gray and Dr. William Schief



Description
===========

Selects parts of all glycan trees.  Combine a OrResidueSelector or a NotResidueSelector with the [[GlycanTreeSelector]] to work with specific glycan trees.  Currently in development.
Use the [[GlycanInfo]] app to get more information on the 'glycan position' of specific residues of interest.

<!--- BEGIN_INTERNAL -->


Details:
```
/// @brief A Residue Selector for selecting specific parts of arbitrary glycans.
///
/// @details.
///
///  Background
///
///    Lets assume that the ASN that a particular N-linked Glycan is attached to, starts from Residue 0.
///    The residues off this continue with 1 being the next residue, 2, and so on.  Each branch corresponds to a number.
///    The GlycanResidueSelector takes multiple settings giving real residues corresponding to this 'Glycan Position'
///
///    This allows you to choose parts of the glycan, without knowing the actual glycan residue numbers.  For example, maybe you want to
///    select the outer leaflet of all glycans (from_position).
///
///  Tips For use
///
///		This Selector works on all glycans of the pose individually.
///
///     Settings are:
///
///       range
///       positions
///       from_position (All glycan foliage from this and including this residue.)
///       to_position (All glycan foliage up to and including this residue.)
///
///     Use the glycan_info application to determine the glycan position numbers.
///     Combine with the GlycanTreeSelector to get unions of specific glycans
///      (such as the leaf of all Man5 residues or the stem of the glycan that starts at ASN85.)
///
```

Usage
=====

``` 
    <GlycanResidueSelector name=(&string) from_position=3/>
```

```
position &string
positions &string,&string&string
  desc = Set a specific set of glycan positions to select on. 

to_position &Size
  desc = Set a glycan position to select up to (including this position)
  
from_position &Size
  desc = Set a glycan position to select from (including this position)
  
range &string
ranges &string,&string,&strng
  desc = Set a range or list of ranges for which to select glycan positions. Range is specified with a '-', like: 2-5
  
```


<!--- END_INTERNAL -->

## See Also
* [[WorkingWithGlycans]]

 - ### RosettaScript Components
* [[GlycanRelaxMover]] - Glycosylate poses with glycan trees.  
* [[GlycanTreeSelector]] - Select specific residues of each glycan tree of interest.

 - ### Apps
* [[GlycanRelax]] - Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
* [[GlycanInfo]] - Get information on all glycan trees within a pose
* [[GlcyanClashCheck]] - Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

 - ### Other
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files