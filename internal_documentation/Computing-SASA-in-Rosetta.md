## Metadata
* Original Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
* Documentation Written/Edited by Rebecca Alford, JKLeman (julia.koehler1982@gmail.com)
* Last Edited: 5/16/14

## Available applications
**per_residue_sc_sasa**

This application takes in a pose (flag `-in:file:s`) and computes absolute and relative sidechain solvent-accessible surface areas. The absolute values are in square Angstrom and the relative values are in percent relative to the sidechain of that amino acid in a GXG tripeptide. The values for the tripeptides are taken from [http://www.proteinsandproteomics.org/content/free/tables_1/table08.pdf]. The output of the application currently goes to standard out, so check your logfile. 

The code for this application is located in `pilot/apps/jkleman/per_residue_sc_sasa` with the underlying functions in `core/scoring/sasa/util`.

**commandline:**

`Rosetta/main/source/bin/per_residue_sc_sasa.macosclangrelease -in:file:s infile.pdb`

## Available in-code methods
**core/scoring/sasa/SasaCalc.hh**

Main class for computing sasa for the whole pose. To compute, use `calculate(pose)` and access methods of the class to retrieve SASA results for total, by atom, by residue, hydrophobic component, etc. Setters are available to control radii and including hydrogens. 

**core/pose/metrics/simple_metrics/SasaCalculator2.cc**

Use of the SaSaCalc as a pose metric 

**protocols/analysis/InterfaceAnalyzerMover.cc**

Example use of the pose metric calculator. Note, to use the pose metric calculator, you have to encapsulate each variable as a 'MetricValue'. This value is then passed by reference to the calculators during pose.metric() method. 

For full control of the SASA calculation (i.e. which atoms/residues get computed) you can use the LeGrandSasa method directly (currently the only method used by rosetta). Pass a subset of atoms and use the calculate method. Currently, the SasaCalc calls LeGrand by passing the whole pose as this "subset of atoms." The default probe radii used is 1.4A but can be changed via the command line. 

## Using SASA Methods

### New
Using the core machinery instead  may be easier in most circumstances.  

```
core::scoring::sasa::SasaCalcOP sasa_calc = core::scoring::sasa::SasaCalcOP( new core::scoring::sasa::SasaCalc() );

core::Real total_sasa = sasa_calc->calculate(this_pose);
utility::vector1< core::Real > residue_sasa  = sasa_calc->get_residue_sasa();
```

### Alternative
An alternative (but a bit more complicated) coding pattern is to use an instantiation of the global pose metric calculator (with Sasa_ being a string - what you will call the metric essentially) The Pose Metric calculators (as used below), are useful as each time you retrieve, it will update if the pose has changed:

```
CalculatorFactory::Instance().register_calculator( Sasa_, new core::pose::metrics::simple_calculators::SasaCalculator2);

```

Below is an example of how to retrieve the data using the PMC method: 

```
//Complex Pose values.
basic::MetricValue< Real > mv_complex_sasa;
	
basic::MetricValue< vector1< core::Real > > mv_complex_res_sasa;
basic::MetricValue< vector1< core::Real > > mv_complex_res_sasa_sc;
basic::MetricValue< vector1< core::Real > > mv_complex_res_hsasa;
basic::MetricValue< vector1< core::Real > > mv_complex_res_hsasa_sc;
basic::MetricValue< vector1< core::Real > > mv_complex_res_rel_hsasa;
	
complexed_pose.metric(Sasa_, "total_sasa", mv_complex_sasa);
complexed_pose.metric(Sasa_, "residue_sasa", mv_complex_res_sasa);
complexed_pose.metric(Sasa_, "residue_sasa_sc", mv_complex_res_sasa_sc);
complexed_pose.metric(Sasa_, "residue_hsasa", mv_complex_res_hsasa);
complexed_pose.metric(Sasa_, "residue_hsasa_sc", mv_complex_res_hsasa_sc);
complexed_pose.metric(Sasa_, "residue_rel_hsasa", mv_complex_res_rel_hsasa);
	
```



## User Options
|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-sasa:method|The method used to calculate sasa.  More will hopefully be added in the future. Default LeGrand Method|String|
|-sasa:include_hydrogens_explicitly|Include hydrogens explicitly in the calculation.  Explicit vs implicit calculations use different radii sets.  These default sets can be controlled via cmd line.  Historically, calculations included hydrogens implicitly.  Some protocols may overwrite this setting to their needs.|Boolean|
|-sasa:probe_radius|'Probe radius used by SasaCalc.  Default is radius of water, 1.4.  1.2 is also commonly used.'|Real|
|-sasa:include_probe_radius_in_atom_radii|This is typically done in calculation of SASA, and in fact is one of the defining features of SASA.  Turn this off to calculate the Surface Area instead.|Boolean|
|-sasa:include_only_C_S_in_hsasa|Include only carbon or sulfer in hsasa calculation.  This is typical.  Only revert to false if excluding polar atoms by charge or everything will be counted as hydrophobic. Note hydrogens are dealt with automatically.|Boolean|
|-sasa:exclude_polar_atoms_by_charge_in_hsasa|Polar carbons and other atoms should not be included in hydrophobic hSASA - though historically they were.  Set this to false to get historic hsasa. default = .4|Boolean|
|-sasa:polar_charge_cutoff|Charge cutoff (abs value) to use on heavy atoms if excluding hydrophobic atoms from hSASA calculation by charge. The default is optimized for protein atom types (which excludes only carbonyl and carboxyl carbons.  By default only carbon and sulfur are excluded.|Real|
|-sasa:implicit_hydrogen_radii_set|The radii set to use when including hydrogens implicitly instead of explicitly. Chothia 1976 radii are used by the program Naccess.  chothia=naccess. legal = [chothia, naccess] |String|
|-sasa:explicit_hydrogen_radii_set|The radii set to use when including hydrogens explicitly. Default is reduce, which was generally agreed upon at Minicon 2014 and come from original data from Bondi (1964) and Gavezzotti (1983) .  LJ are the Rosetta leonard-jones radii, which are not quite exactly from Charmm.  Legacy radii were optimized for a no-longer-in-Rosetta scoreterm (Jerry Tsai et al 2003). legal = [reduce, LJ, legacy] |String|