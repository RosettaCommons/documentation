# About the Project

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))

### Metadata
Corresponding PI: Jeffrey Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 09/20/2013

### About
The membrane protein framework in Rosetta is designed to be flexible and support various protocols. As a result, there is a generic system for inputs that will enable greatest flexibility, extensibility, and reuse. Below is instructions for setting up a job using membrane proteins. 

# Required Inputs
The membrane protein framework views a membrane protein as either spanning the membrane or embedded at a given depth in the membrane. For each pdb, you will need a (1) OCTOPUS span file (if spanning), (2) Lipophobicity Data file and (3) an Embedding Definition file.

### OCTOPUS File
To generate a spanfile, go to [OCTOPUS](http://octopus.cbr.su.se/) and generate a topology file from the FASTA sequence. Below is an example format of the resulting file:
 `
#####################################################################
OC```TOPUS result file
Generated from http://octopus.cbr.su.se/ at 2008-09-18 21:06:32
Total request time: 6.69 seconds.
#####################################################################

Sequence name: BRD4
Sequence length: 123 aa.
Sequence:
PIYWARYADWLFTTPLLLLDLALLVDADQGTILALVGADGIMIGTGLVGALTKVYSYRFV
WWAISTAAMLYILYVLFFGFTSKAESMRPEVASTFKVLRNVTVVLWSAYPVVWLIGSEGA
GIV

OCTOPUS predicted topology:
oooooMMMMMMMMMMMMMMMMMMMMMiiiiMMMMMMMMMMMMMMMMMMMMMooooooMMM
MMMMMMMMMMMMMMMMMMiiiiiiiiiiiiiiiiiiiiiMMMMMMMMMMMMMMMMMMMMM
ooo

After this file is generated, convert the file to a .span file using the script octopus2span.pl in src/apps/public/membrane Example usage of this script is below:

`./octopus2span.pl BRD4.oct > BRD4.span`

### Lipophobicity Data
To generate a lipid accessibility, use the run_lips.pl script provided in src/apps/public/membrane. This script requires the NCBI blast toolkit which includes the blastpgp executable, the nr database, and a spanfile generated as described above, as well as the alignblast.pl script which is also located in src/apps/public/membrane.
Below is example usage of the script:

`./run_lips.pl <myfasta.txt> <mytopo.span> /path/to/blastpgp /path/to/nr alignblast.pl`


# Setting Up a Job