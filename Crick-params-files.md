# Crick params file format
Page created by Vikram K. Mulligan (vmullig@flatironinstitute.org).  Last modified 12 October 2018.
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Crick params files

[[_TOC_]]

### Description of file type

Crick params files are ASCII files with extension `.crick_params`.  They define the minor helical parameters of polymer helices, such as alpha-helices, 3-10 helices, polyproline type I and II helices, _etc_.  Since strands represent a special case of a helix, in which the turn per residue is about 180 degrees, Crick params files can also define minor helical parameters for a strand.  The minor helix parameters are used, along with user-specified major helix parameters, to generate coiled-coil geometry using the Crick equations (first described by Francis Crick in 1953 -- see Crick F. (1953) "The Fourier transform of a coiled-coil".  _Acta Cryst._ 6:685-689).

### File format

Crick params file consist of a series of lines, each specifying either a global property of the helix type or a per-atom parameter value.  The allowed entries are:

| Entry | Description | Allowed values | Example |
| ----- | ----------- | -------------- | ------- |
| Comments | Any line starting with a number sign ("#").  Used to provide information ignored by Rosetta but useful to developers or users. | Any string. | `#Crick params file for a beta-amino acid 14-helix` |