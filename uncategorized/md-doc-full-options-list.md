<!-- --- title: Md Doc Full-Options-List -->List of Rosetta command line options.

\_(This is automatically generated file, do not edit!)\_

*Note that some application specific options may not be present in this list.*

[[ *TOC* ]]

-   -in
    ---

 **-in** \<Boolean\>   
Input option group

 **-Ntermini** \<String\>   
Put full N termini on pose
 Default: "ALL"

 **-Ctermini** \<String\>   
Put full C termini on pose
 Default: "ALL"

 **-use\_truncated\_termini** \<Boolean\>   
Will not add extra OXT/Hs at termini if not in input structure
 Default: false

 **-ignore\_unrecognized\_res** \<Boolean\>   
Do not abort if unknown residues are found in PDB file; instead, ignore them. Note this implies -in:ignore\_waters
 Default: false

 **-ignore\_waters** \<Boolean\>   
Do not abort if HOH water residues are found in PDB file; instead, ignore them.
 Default: false

 **-add\_orbitals** \<Boolean\>   
Will add orbitals to residues only. Does not include orbitals to ligands. Done through params file reading.
 Default: false

 **-show\_all\_fixes** \<Boolean\>   
Show all residue & atom name fixes
 Default: false

 **-include\_sugars** \<Boolean\>   
Sets whether or not carbohydrate residues will beloaded into Rosetta. The default value is false.
 Default: false

 **-include\_surfaces** \<Boolean\>   
Sets whether or not mineral surface residues will beloaded into Rosetta. The default value is false.
 Default: false

 **-enable\_branching** \<Boolean\>   
Sets whether or not polymer branching is allowed. The default value is false.
 Default: false

 **-remember\_unrecognized\_res** \<Boolean\>   
Ignore unrecognized residues, but remember them in PDBInfo.
 Default: false

 **-remember\_unrecognized\_water** \<Boolean\>   
Remember waters along with other unrecognized residues.
 Default: false

 **-preserve\_crystinfo** \<Boolean\>   
Preserve information important for crystal refinement (B factors +CRYST1 line)
 Default: false

 **-detect\_oops** \<Boolean\>   
Detect oligooxopiperazines (oops) and add required constraints
 Default: false

 **-detect\_disulf** \<Boolean\>   
Forcably enable or disable disulfide detection. When unspecified, rosetta conservatively detects disulfides in full atom input based on SG distance, but will not form centroid disulfides. Setting '-detect\_disulf true' will force aggressive disulfide detection in centroid poses based on CB distance. Setting '-detect\_disulf false' disables all detection, even in full atom poses. Note that disabling disulfides causes severe clashes for native disulfides.

 **-detect\_disulf\_tolerance** \<Real\>   
disulf tolerance
 Default: 0.5

 **-fix\_disulf** \<File\>   
Specify disulfide connectivity via a file. Disulfides are specified as two whitespace-seperated residue indices per line. This option replaces the old '-run:fix\_disulf' option.

 **-missing\_density\_to\_jump** \<Boolean\>   
If missing density is found in input pdbs, replace with a jump
 Default: false

 **-target\_residues** \<IntegerVector\>   
which residue numbers to pass for getDistConstraints

 **-replonly\_residues** \<IntegerVector\>   
residue numbers regarded as repulsive-only residues

 **-replonly\_loops** \<Boolean\>   
all loops will be regarded as repulsive-only
 Default: false

 **-use\_database** \<Boolean\>   
Read in structures from database. Specify database via -inout:dbms:database\_name and wanted structures with -in: <file:tags> or select\_structures\_from\_database

-   ### -in:dbms

 **-dbms** \<Boolean\>   
dbms option group

 **-struct\_ids** \<StringVector\>   
List of struct\_ids (hex representation) to be used by the database job inputter

-   -in
    ---

 **-database\_protocol** \<Integer\>   
Database to use when reading in structures
 Default: 1

 **-select\_structures\_from\_database** \<StringVector\>   
specify an SQL query to determine which structures get read in from a database specified with -inout:dbms:database\_name. SELECT query must return structures.tag

-   ### -in:path

 **-path** \<PathVector\>   
Paths to search for input files (checked after type-specific paths)
 Default: "."

 **-fragments** \<PathVector\>   
Fragment file input search paths

 **-pdb** \<PathVector\>   
PDB file input search paths

 **-database** \<PathVector\>   
Database file input search paths. If the database is not found the ROSETTA3\_DB environment variable is tried.

-   ### -in:file

 **-file** \<Boolean\>   
Input file option group

 **-s** \<FileVector\>   
Name(s) of single PDB file(s) to process
 Default: []

 **-l** \<FileVector\>   
File(s) containing list(s) of PDB files to process

 **-list** \<FileVector\>   
File(s) containing list(s) of PDB files. PDBs on the same line become one pose

 **-screening\_list** \<FileVector\>   
Files containing lists of PDB files. all permutations of the files in the list become poses

 **-screening\_job\_file** \<File\>   
A JSON file containing groups of ligands and proteins to screen

 **-shuffle\_screening\_jobs** \<Boolean\>   
Randomize the order of jbos input through -in: <file:screening_job_file>
 Default: false

 **-native** \<File\>   
Native PDB filename

 **-torsion\_bin\_probs** \<File\>   
File describing probabilities over torsion bins A,B,E,G,O
 Default: "empty"

 **-PCS\_frag\_cst** \<File\>   
File that containts PCS constraints for use in fragment picking

 **-talos\_phi\_psi** \<File\>   
File that provides Phi-Psi angles in Talos+ format

 **-talos\_cs** \<File\>   
File that provides chemical shifts in Talos format

 **-ambig\_talos\_cs\_A** \<File\>   
File that provides 1st set of ambigious chemical shift options in Talos format

 **-ambig\_talos\_cs\_B** \<File\>   
File that provides 2nd set of ambigious chemical shift options in Talos format

 **-native\_exclude\_res** \<IntegerVector\>   
Residue numbers to be excluded from RMS calculation

 **-tags** \<StringVector\>   
Tag(s) of structures to be used from silent-file

 **-user\_tags** \<StringVector\>   
user\_tag(s) of structures to be used from silent-file

 **-tagfile** \<File\>   
file with list of tags to be resampled from file given with in:resample:silent
 Default: "TAGS"

 **-frag\_files** \<FileVector\>   
Fragment input file names

 **-frag\_sizes** \<IntegerVector\>   
Fragment file sizes

 **-extra\_res** \<FileVector\>   
.params file(s) for new residue types (e.g. ligands)

 **-extra\_res\_fa** \<FileVector\>   
.params file(s) for new fullatom residue types (e.g. ligands)

 **-extra\_res\_mol** \<FileVector\>   
.mol file(s) for new fullatom residue types (e.g. ligands)

 **-extra\_res\_database** \<String\>   
the name of a database containing fullatom residue types (e.g. ligands)

 **-extra\_res\_pq\_schema** \<String\>   
the name of a postgreSQL schema in the database containing fullatom residue types (e.g. ligands)
 Default: ""

 **-extra\_res\_database\_mode** \<String\>   
The type of database driver to use for -in: <file:extra_res_database> .
 Default: "sqlite3"

 **-extra\_res\_database\_resname\_list** \<File\>   
Path to a list of residue names to be read in from the residue database. The list should have one residue name per line

 **-extra\_res\_cen** \<FileVector\>   
.params file(s) for new centroid residue types (e.g. ligands)

 **-extra\_res\_path** \<PathVector\>   
directories with .params files. Only files containing 'param' will be chosen

 **-extra\_res\_batch\_path** \<PathVector\>   
directories generated by src/python/apps/public/batch\_molfile\_to\_params.py. Only files containing 'param' will be chosen

 **-extra\_patch\_fa** \<FileVector\>   
patch files for full atom variants not specified in the database

 **-extra\_patch\_cen** \<FileVector\>   
patch files for centroid atom variants not specified in the database

 **-frag3** \<String\>   
No description

 **-frag9** \<String\>   
No description

 **-fragA** \<String\>   
No description

 **-fragB** \<String\>   
No description

 **-surface\_vectors** \<String\>   
Input file containing three sets of xyz coordinates which define the plane and periodicity of the solid surface

 **-xyz** \<String\>   
Input coordinates in a raw XYZ format (three columns)

 **-fragA\_size** \<Integer\>   
No description
 Default: 9

 **-keep\_input\_scores** \<Boolean\>   
Keep/Don't keep scores from input file in Pose.
 Default: true

 **-lazy\_silent** \<Boolean\>   
Activate LazySilentFileJobInputter
 Default: false

 **-silent** \<FileVector\>   
silent input filename(s)

 **-atom\_tree\_diff** \<FileVector\>   
atom\_tree\_diff input filename(s)

 **-zip** \<String\>   
zipped input file, used for BOINC database

 **-boinc\_wu\_zip** \<FileVector\>   
zipped input file with files for a specific BOINC workunit

 **-fullatom** \<Boolean\>   
Enable full-atom input of PDB or centroid structures
 Default: false

 **-centroid\_input** \<Boolean\>   
why input in the name twice ? in:file:centroid\_input Enable centroid inputs of PDBs
 Default: false

 **-centroid** \<Boolean\>   
Enable centroid inputs of PDBs
 Default: false

 **-treat\_residues\_in\_these\_chains\_as\_separate\_chemical\_entities** \<String\>   
Create a chemical jump for each residue in these chains (String of 1-letter chain IDs)
 Default: " "

 **-residue\_type\_set** \<String\>   
ResidueTypeSet for input files
 Default: "fa\_standard"

 **-pca** \<File\>   
compute PCA projections
 Default: ""

 **-silent\_energy\_cut** \<Real\>   
energy cut for silent-files
 Default: 1.0

 **-silent\_list** \<FileVector\>   
Silent input filename list(s) - like -l is to -s

 **-silent\_renumber** \<Boolean\>   
renumber decoys in not\_universal\_main or not
 Default: false

 **-silent\_optH** \<Boolean\>   
Call optH when reading a silent file

 **-silent\_struct\_type** \<String\>   
Type of SilentStruct object to use in silent-file input
 Default: "protein"

 **-silent\_read\_through\_errors** \<Boolean\>   
will ignore decoys with errors and continue reading
 Default: false

 **-silent\_score\_prefix** \<String\>   
Prefix that is appended to all scores read in from a silent-file
 Default: ""

 **-silent\_select\_random** \<Integer\>   
Select a random subset of this number of decoys from every silent-file read
 Default: 0

 **-silent\_select\_range\_start** \<Integer\>   
Select a ranged subset of decoys from every silent-file read. Start at this decoy.
 Default: -1

 **-silent\_select\_range\_mul** \<Integer\>   
Select a blocksize multiplier. This param pasically multiplies -silent\_select\_range\_start. E.g. when set to, say, 5, -silent\_select\_range\_start 0,1,2,3,4 will result in decoys being read starting from 0,5,10,15,20
 Default: 1

 **-silent\_select\_range\_len** \<Integer\>   
Select a ranged subset of decoys from every silent-file read. Start at this decoy.
 Default: 1

 **-skip\_failed\_simulations** \<Boolean\>   
Ignore failed simulations (prefixed by W\_) during silent file input. Existing behavior is preserved by default.
 Default: false

 **-silent\_scores\_wanted** \<StringVector\>   
Only put these silent-scores into the Pose.

 **-fasta** \<FileVector\>   
Fasta-formatted sequence file

 **-pssm** \<FileVector\>   
NCBI BLAST formatted position-specific scoring matrix

 **-seq** \<StringVector\>   
List of input files for constructing sequences

 **-checkpoint** \<File\>   
Sequence profile (binary file format) prepared by NCBI BLAST

 **-alignment** \<FileVector\>   
Input file for sequence alignment

 **-alignment2** \<FileVector\>   
Input file for second sequence alignment

 **-rama2b\_map** \<File\>   
Ramachandran file used by rama2b
 Default: "scoring/score\_functions/rama/Rama08.dat"

 **-psipred\_ss2** \<File\>   
psipred\_ss2 secondary structure definition file
 Default: "tt"

 **-dssp** \<File\>   
dssp secondary structure definition file
 Default: "tt"

 **-fail\_on\_bad\_hbond** \<Boolean\>   
exit if a hydrogen bonding error is detected
 Default: true

 **-movemap** \<File\>   
No description
 Default: "default.movemap"

 **-repair\_sidechains** \<Boolean\>   
Attempt a repack/minmize to repair sidechain problems, such as proline geometry and His tautomerization
 Default: false

 **-no\_binary\_dunlib** \<Boolean\>   
Do not attempt to read from or write to a binary file for the Dunbrack library

 **-extended\_pose** \<Integer\>   
number of extended poses to process in not\_universal\_main
 Default: 1

 **-template\_pdb** \<FileVector\>   
Name of input template PDB files for comparative modeling

 **-template\_silent** \<File\>   
input templates for comparative modeling – tag needs to fit alignment id

 **-rdc** \<FileVector\>   
Experimental NMR Residual Dipolar Coupling File — one file per alignment medium

 **-csa** \<FileVector\>   
Experimental NMR Chemical Shift Anisotropy File

 **-dc** \<FileVector\>   
Experimental NMR Dipolar Coupling File

 **-burial** \<FileVector\>   
WESA-formatted burial prediction

 **-vall** \<FileVector\>   
Fragment database file, e.g vall.dat.2006-05-05
 Default: "/sampling/filtered.vall.dat.2006-05-05"

 **-rescore** \<Boolean\>   
Governs whether input poses are rescored or not in not\_universal\_main, defaults to false.
 Default: false

 **-spanfile** \<String\>   
Membrane spanning file

 **-lipofile** \<String\>   
Membrane exposure file

 **-HDX** \<String\>   
HDX (Hydrogen exchange data file

 **-d2h\_sa\_reweight** \<Real\>   
d2h\_sa reweight
 Default: 1.00

 **-sucker\_params** \<File\>   
Parameter file containing SplineEnergy parameters
 Default: "scoring/spline\_energy\_functions/sucker.params"

 **-fold\_tree** \<File\>   
User defined fold tree to be imposed on the pose after reading from disk

 **-obey\_ENDMDL** \<Boolean\>   
Stop reading a PDB after ENDMDL card; effectively read only first model in multimodel NMR PDBs
 Default: false

 **-new\_chain\_order** \<Boolean\>   
ensures chain from different MODEL records have differnet mini chains
 Default: false

 **-ddg\_predictions\_file** \<File\>   
File that contains mutational ddG information. Used by ddG task operation/filter.
 Default: ""

 **-input\_res** \<IntegerVector\>   
Residues already present in starting file
 Default: []

 **-minimize\_res** \<IntegerVector\>   
Residues to minimize
 Default: []

 **-md\_schfile** \<String\>   
File name containing MD schedule

 **-read\_pdb\_link\_records** \<Boolean\>   
Sets whether or not the LINK records in PDB files are read. The default value is false.
 Default: false

 **-native\_contacts** \<File\>   
native contacts pair list for fnat/fnon-nat calculation in Docking

-   ### -in:rdf

 **-rdf** \<Boolean\>   
rdf option group

 **-sep\_bb\_ss** \<Boolean\>   
separate RDFs by SS for backbone atypes
 Default: true

-   -inout
    ------

 **-inout** \<Boolean\>   
Ouput option group

 **-fold\_tree\_io** \<Boolean\>   
Ignore 'CHECKPOINT' file and the overwrite the PDB file(s)

 **-dump\_connect\_info** \<Boolean\>   
Output CONECT info between bonded atoms that are beyond 3.0 A apart; useful for coarse-grained representations.
 Default: false

-   ### -inout:dbms

 **-dbms** \<Boolean\>   
database option group

 **-mode** \<String\>   
Which backend to use by default for database access. Note, usage of 'mysql' requires building with 'extras=mysql' and usage of 'postgres' requires building with 'extras=postgres'
 Default: "sqlite3"

 **-database\_name** \<String\>   
name of the database. For sqlite3 databases this is a path in the file system usually with the '.db3' extension.

 **-pq\_schema** \<String\>   
For posgres databases, specify the default schema with the database. For PostgreSQL database, schemas are like namespaces.
 Default: ""

 **-host** \<String\>   
default hostname of database server

 **-user** \<String\>   
default username for database server access

 **-password** \<String\>   
default password for database server access

 **-port** \<Integer\>   
default port for database server access

 **-readonly** \<Boolean\>   
open sqlite3 database in read-only mode by default
 Default: false

 **-separate\_db\_per\_mpi\_process** \<Boolean\>   
In MPI mode, open a separate sqlite3 database for each process with extension \_\<mpi\_rank\> and write partitioned schema to that database.
 Default: false

 **-database\_partition** \<Integer\>   
Open a sepearte sqlite3 database with the extension \_\<partition\> and write a partitioned schema to that database.
 Default: -1

 **-use\_compact\_residue\_schema** \<Boolean\>   
Store all the atoms for a residue in a binary silent file style blob. Sacrifices analyzability for scalability. If you don't know if you want this you probably don't.
 Default: false

-   -out
    ----

 **-out** \<Boolean\>   
Ouput option group

 **-overwrite** \<Boolean\>   
Ignore 'CHECKPOINT' file and the overwrite the PDB file(s)

 **-nstruct** \<Integer\>   
Number of times to process each input PDB
 Default: 1

 **-shuffle\_nstruct** \<Integer\>   
total number of decoys to produce
 Default: 1

 **-prefix** \<String\>   
Prefix for output structure names, like old -series code
 Default: ""

 **-suffix** \<String\>   
Suffix for output structure names
 Default: ""

 **-force\_output\_name** \<String\>   
Force output name to be this. Needed for some cluster environments.

 **-no\_nstruct\_label** \<Boolean\>   
Do not tag the first output structure with *0001
 Default: false
*

 **-pdb\_gz** \<Boolean\>   
*Compress (gzip) output pdbs
 Default: false
*

 **-pdb** \<Boolean\>   
*Output PDBs
 Default: false
*

 **-silent\_gz** \<Boolean\>   
*Use gzipped compressed output (silent run level)
 Default: false
*

 **-use\_database** \<Boolean\>   
*Write out structures to database. Specify database via -inout:dbms:database\_name and wanted structures with -in: <file:tags>
*

 **-database\_protocol\_id** \<Integer\>   
*Manually specify a protocol ID for database output. MPI-distributed jobs are the only time when you will want to use this. It is a temporary workaround to a limitation of the MPI distributor
*

 **-database\_filter** \<StringVector\>   
*Filter to use with database output. Arguments for filter follow filter name
*

 **-resume\_batch** \<IntegerVector\>   
*Specify 1 or more batch ids to finish an incomplete protocol. Only works with the DatabaseJobOutputter. The new jobs will be generated under a new protocol and batch ID
*

 **-nooutput** \<Boolean\>   
*Surpress outputfiles
 Default: false
*

 **-output** \<Boolean\>   
*Force outputfiles
 Default: false
*

 **-scorecut** \<Real\>   
*Only output lowest energy fraction of structures - default 1.0, i.e. output all
 Default: 1.0
*

 **-show\_accessed\_options** \<Boolean\>   
*In the end of the run show options that has been accessed.
 Default: false
*

 **-sf** \<File\>   
*filename for score output
 Default: "score.fsc"
*

 **-mute** \<StringVector\>   
*Mute specified Tracer channels; specify 'all' to mute all channels.
*

 **-unmute** \<StringVector\>   
*UnMute specified Tracer channels; specify 'all' to unmute all channels.
*

 **-level** \<Integer\>   
*Level of Tracer output, any level above will be muted. Availible levels: 0 - fatal, 100 - error, 200 - warning, 300 - info, 400 - debug, 500 - trace. For additional info please see: src/basic/Tracer.hh and doc page 'Tracer, tool for debug IO'. Default output level is 'info': 300
 Default: 300
*

 **-levels** \<StringVector\>   
*Specified hierarchical mute levels for individual channels in following format: -levels all:300 core.pose:500. Numeric values could be substituted with mute level names like: debug, info, error etc. Please note that all:\<num\> is synonymous to -level:\<num\>
*

 **-std\_IO\_exit\_error\_code** \<Integer\>   
*Specify error code that will be used to exit if std::IO error detected. This is useful if you want to detect situations like: Rosetta output was redirected to a file but the disk got full, etc. Default value is 0 which means that error detection code is turned off.
 Default: 0
*

 **-chname** \<Boolean\>   
*Add Tracer chanel names to output
 Default: true
*

 **-chtimestamp** \<Boolean\>   
*Add timestamp to tracer channel name
 Default: false
*

 **-dry\_run** \<Boolean\>   
*If set ComparingTracer will not generate any asserts, and save all Tracer output to a file
 Default: false
*

 **-mpi\_tracer\_to\_file** \<String\>   
*MPI ONLY: Redirect all tracer output to this file with '* \<mpi\_rank\>' appened as a suffix
 Default: "tracer.out"

 **-user\_tag** \<String\>   
add this tag to structure tags: e.g., a process id
 Default: ""

 **-output\_tag** \<String\>   
Prefix output files with this tag, if code checks for it
 Default: ""

-   ### -out:file

 **-file** \<Boolean\>   
Output file option group

 **-o** \<String\>   
Name of output file

 **-design\_contrast** \<File\>   
output list comparing design sequence to native sequence
 Default: "redesign"

 **-residue\_type\_set** \<String\>   
ResidueTypeSet for output files
 Default: "fa\_standard"

 **-atom\_tree\_diff** \<String\>   
Use atom\_tree\_diff file output, use filename after this flag
 Default: "default.out"

 **-atom\_tree\_diff\_bb** \<Integer\>   
For atom\_tree\_diff output, how many digits of precision to use for backbone dihedrals
 Default: 6

 **-atom\_tree\_diff\_sc** \<Integer\>   
For atom\_tree\_diff output, how many digits of precision to use for sidechain dihedrals
 Default: 4

 **-atom\_tree\_diff\_bl** \<Integer\>   
For atom\_tree\_diff output, how many digits of precision to use for bond lengths
 Default: 2

 **-alignment** \<String\>   
Output file for sequence alignment
 Default: "out.align"

 **-score\_only** \<String\>   
Only output scores, no silent files or pdb files
 Default: "default.sc"

 **-scorefile** \<String\>   
Write a scorefile to the provided filename
 Default: "default.sc"

 **-silent** \<String\>   
Use silent file output, use filename after this flag
 Default: "default.out"

 **-silent\_struct\_type** \<String\>   
Type of SilentStruct object to use in silent-file output
 Default: "protein"

 **-silent\_print\_all\_score\_headers** \<Boolean\>   
Print a SCORE header for every SilentStruct in a silent-file
 Default: false

 **-silent\_decoytime** \<Boolean\>   
Add time since last silent structure was written to score line
 Default: false

 **-silent\_comment\_bound** \<Integer\>   
String data longer than this ends up as remark rather than in score line
 Default: 15

 **-raw** \<Boolean\>   
Use silent-type file output
 Default: false

 **-weight\_silent\_scores** \<Boolean\>   
Weight scores in silent-file output.
 Default: true

 **-silent\_preserve\_H** \<Boolean\>   
Preserve hydrogrens in PDB silent-file format.
 Default: false

 **-fullatom** \<Boolean\>   
Enable full-atom output of PDB or centroid structures
 Default: false

 **-suppress\_zero\_occ\_pdb\_output** \<Boolean\>   
Suppress output of atoms with zero (or negative) occupancy
 Default: false

 **-output\_virtual** \<Boolean\>   
Output virtual atoms in output of PDB
 Default: false

 **-no\_output\_cen** \<Boolean\>   
Omit outputting centroids
 Default: false

 **-output\_orbitals** \<Boolean\>   
Output all orbitals into PDB.
 Default: false

 **-renumber\_pdb** \<Boolean\>   
Use Rosetta residue numbering and arbitrary chain labels in pdb output.
 Default: false

 **-pdb\_parents** \<Boolean\>   
If the pose contains a comment named template, print this as a REMARK in the pdb file
 Default: false

 **-per\_chain\_renumbering** \<Boolean\>   
When used in conjunction with renumber\_pdb, restarts residue numbering at each chain.
 Default: false

 **-output\_torsions** \<Boolean\>   
Output phi, psi, and omega torsions in the PDB output if the pose is ideal.
 Default: false

 **-pdb\_comments** \<Boolean\>   
If the pose contains any comment print it as a COMMENT in the pdb file.
 Default: false

 **-force\_nonideal\_structure** \<Boolean\>   
Force ResidueConformationFeatures to treat the structure as nonideal. If you know all your structures are non-ideal this decreases pose output time
 Default: true

 **-write\_pdb\_link\_records** \<Boolean\>   
Sets whether or not the LINK records in PDB files are written. The default value is false.
 Default: false

 **-dont\_rewrite\_dunbrack\_database** \<Boolean\>   
Disables the default behavior of rewriting the Dunrack library in binary format if a binary version is not found

 **-frag\_prefix** \<String\>   
Prefix for fragment output
 Default: "default.frags"

-   ### -out:path

 **-all** \<Path\>   
Default file output path
 Default: "."

 **-path** \<Path\>   
Default file output path
 Default: "."

 **-pdb** \<Path\>   
PDB file output path

 **-score** \<Path\>   
Score file output path

 **-movie** \<Path\>   
Movie file output path

 **-scratch** \<Path\>   
use this path as scratch drive
 Default: ['"/scratch/USERS/"']

 **-mpi\_rank\_dir** \<Boolean\>   
Put silent-output files in individual directory as determined by mpi-rank
 Default: false

-   -rigid
    ------

 **-rigid** \<Boolean\>   
rigid option group

 **-chainbreak\_bias** \<Real\>   
Strength of bias applied to the translation component of rigid body moves to close chainbreak
 Default: 0.00

 **-close\_loops** \<Boolean\>   
Perform loop closure at the end of medal
 Default: true

 **-fragment\_cycles** \<Integer\>   
Number of fragment insertion/rigid body cycles
 Default: 10000

 **-log\_accepted\_moves** \<Boolean\>   
Write accepted moves to silent file output
 Default: false

 **-max\_ca\_ca\_dist** \<Real\>   
Maximum distance between consecutive CA atoms before chunk partitioning occurs
 Default: 5.0

 **-medium\_range\_seqsep** \<Integer\>   
Constraints with sequence separation less than x are scored
 Default: 30

 **-patch** \<File\>   
Patch file containing energy terms and their respective weights

 **-residues\_backbone\_move** \<Integer\>   
Number of residues perturbed by a backbone move
 Default: 5

 **-rotation** \<Real\>   
Rotation magnitude
 Default: 2.5

 **-sampling\_prob** \<File\>   
Normalized, per-residue sampling probabilities

 **-score** \<String\>   
Centroid-level score function
 Default: "score3"

 **-sequence\_separation** \<Integer\>   
Maximum sequence separation for scoring chainbreaks
 Default: 20

 **-short\_range\_seqsep** \<Integer\>   
Constraints with sequence separation less than x are scored
 Default: 15

 **-small\_cycles** \<Integer\>   
Number of small/shear cycles
 Default: 8000

 **-stages** \<Integer\>   
Number of stages over which to interpolate ramped values
 Default: 4

 **-temperature** \<Real\>   
Monte Carlo temperature
 Default: 2.0

 **-translation** \<Real\>   
Translation magnitude
 Default: 0.5

-   -MM
    ---

 **-MM** \<Boolean\>   
MM option group

 **-ignore\_missing\_bondangle\_params** \<Boolean\>   
ignore failed lookups for missing bond angle parameters
 Default: false

-   -qsar
    -----

 **-qsar** \<Boolean\>   
qsar option group

 **-weights** \<String\>   
select qsar weight set to use
 Default: "talaris2013"

 **-grid\_dir** \<String\>   
Directory to store grids in

 **-max\_grid\_cache\_size** \<Integer\>   
delete old grids if grid cache exceeds specified size

-   -residues
    ---------

 **-residues** \<Boolean\>   
residues option group

 **-patch\_selectors** \<StringVector\>   
allow patch files that have CMDLINE\_SELECTOR tags can be switched on with this option

-   -PCS
    ----

 **-PCS** \<Boolean\>   
PCS option group

 **-write\_extra** \<File\>   
Write into the File PCS calc, PCS exp, PCS dev, tensor informations, AT EACH ENERGY EVALUATION. More suited for rescoring

 **-normalization\_id** \<Integer\>   
Normalize individual data set. The integer identify the normalization method to be used

-   -pocket\_grid
    -------------

 **-pocket\_grid** \<Boolean\>   
pocket\_grid option group

 **-pocket\_grid\_size** \<Real\>   
grid spacing in Angstroms
 Default: 0

 **-pocket\_grid\_size\_x** \<Real\>   
grid spacing in Angstroms
 Default: 10

 **-pocket\_grid\_size\_y** \<Real\>   
grid spacing in Angstroms
 Default: 10

 **-pocket\_grid\_size\_z** \<Real\>   
grid spacing in Angstroms
 Default: 10

 **-pocket\_grid\_spacing** \<Real\>   
grid spacing in Angstroms
 Default: 0.5

 **-pocket\_max\_spacing** \<Real\>   
Maximum residue-residue distance to be considered a pocket
 Default: 8

 **-pocket\_min\_size** \<Real\>   
Minimum pocket size to score, in cubic Angstroms
 Default: 10

 **-pocket\_max\_size** \<Real\>   
Maximum pocket size to report, in cubic Angstroms, 0 for no limit
 Default: 0

 **-pocket\_probe\_radius** \<Real\>   
radius of surface probe molecule
 Default: 1.0

 **-central\_relax\_pdb\_num** \<String\>   
Residue number:(optional)Chain around which to do Pocket Constraint
 Default: "-1"

 **-pocket\_ntrials** \<Integer\>   
Number of trials to use for backrub
 Default: 100000

 **-pocket\_num\_angles** \<Integer\>   
Number of different pose angles to measure pocket score at
 Default: 1

 **-pocket\_side** \<Boolean\>   
Include only side chain residues for target surface
 Default: false

 **-pocket\_dump\_pdbs** \<Boolean\>   
Generate PDB files
 Default: false

 **-pocket\_dump\_exemplars** \<Boolean\>   
Generate exemplar PDB files
 Default: false

 **-pocket\_filter\_by\_exemplar** \<Boolean\>   
Restrict the pocket to the exemplars
 Default: false

 **-pocket\_dump\_rama** \<Boolean\>   
Generate Ramachandran maps for each pocket cluster
 Default: false

 **-pocket\_restrict\_size** \<Boolean\>   
Pockets that are too large return score of 0
 Default: false

 **-pocket\_ignore\_buried** \<Boolean\>   
Ignore pockets that are not solvent exposed
 Default: true

 **-pocket\_only\_buried** \<Boolean\>   
Identify only pockets buried in the protein core (automatically sets -pocket\_ignored\_buried false)
 Default: false

 **-pocket\_psp** \<Boolean\>   
Mark Pocket-Solvent-Pocket events as well
 Default: true

 **-pocket\_sps** \<Boolean\>   
Unmark Solvent-Pocket-Solvent events
 Default: false

 **-pocket\_search13** \<Boolean\>   
Search in 13 directions (all faces and edges of a cube) versus faces and diagonal
 Default: false

 **-pocket\_surface\_score** \<Real\>   
Score given to pocket surface
 Default: 0

 **-pocket\_surface\_dist** \<Real\>   
Distance to consider pocket surface
 Default: 2.5

 **-pocket\_buried\_score** \<Real\>   
Score given to deeply buried pocket points
 Default: 5.0

 **-pocket\_buried\_dist** \<Real\>   
Distance to consider pocket buried
 Default: 2.0

 **-pocket\_exemplar\_vdw\_pen** \<Real\>   
Temporary max penalty for vdW class in exemplar discovery
 Default: 300.0

 **-pocket\_debug\_output** \<Boolean\>   
Print any and all debuggind output related to pockets
 Default: false

 **-print\_grid** \<Boolean\>   
print the grid points into a PDB file
 Default: false

 **-extend\_eggshell** \<Boolean\>   
Extend the eggshell points
 Default: false

 **-extend\_eggshell\_dist** \<Real\>   
Distance to extend eggshell
 Default: 1

 **-extra\_eggshell\_dist** \<Real\>   
Distance to extend extra eggshell points
 Default: 4

 **-eggshell\_dist** \<Real\>   
Distance to extend eggshell points from ligand atoms
 Default: 4

 **-reduce\_rays** \<Boolean\>   
reduce no. of rays by rounding and removing duplicate xyz coordinates
 Default: true

 **-pocket\_static\_grid** \<Boolean\>   
No autoexpanding grid
 Default: false

-   -fingerprint
    ------------

 **-fingerprint** \<Boolean\>   
fingerprint option group

 **-print\_eggshell** \<Boolean\>   
print the eggshell points into a PDB file
 Default: false

 **-atom\_radius\_scale** \<Real\>   
Scale to shrink the radius of atom
 Default: 0.9

 **-atom\_radius\_buffer** \<Real\>   
Value to subtract from all atomic radii, to match PocketGrid buffer thickness
 Default: 1.0

 **-packing\_weight** \<Real\>   
Add weight to rho large deviation
 Default: 1

 **-dist\_cut\_off** \<Real\>   
set cut\_off distance to add packing weight
 Default: 5

 **-include\_hydrogens** \<Boolean\>   
include hydrogen atoms for fingerprint
 Default: false

 **-use\_DARC\_gpu** \<Boolean\>   
use GPU when computing DARC score
 Default: false

 **-square\_score** \<Boolean\>   
square the terms in DARC scoring function
 Default: false

 **-set\_origin** \<Integer\>   
option to set orgin: 0 to choose origin based on R(rugedness) value, 1 for protein\_center, 2 for eggshell\_bottom, 3 for vector form eggshell\_plane closest to protein\_center, 4 for vector form eggshell\_plane distant to protein\_center
 Default: 0

 **-origin\_res\_num** \<Integer\>   
residue to be used as origin
 Default: 0

-   -contactMap
    -----------

 **-contactMap** \<Boolean\>   
contactMap option group

 **-prefix** \<String\>   
Prefix of contactMap filename
 Default: "contact\_map\_"

 **-distance\_cutoff** \<Real\>   
Cutoff Backbone distance for two atoms to be considered interacting
 Default: 10.0

 **-energy\_cutoff** \<Real\>   
Energy\_Cutoff (percentage value - only affecting silent file input)
 Range: 0.0-1.0
 Default: 1.0

 **-region\_def** \<String\>   
Region definition for comparison eg: 1-10:20-30,40-50,A:ligand=X
 Default: ""

 **-row\_format** \<Boolean\>   
Flag whether to output in row instead of matrix format
 Default: false

 **-distance\_matrix** \<Boolean\>   
Output a distance matrix instead of a contact map
 Default: false

-   -docking
    --------

 **-kick\_relax** \<Boolean\>   
Add relax step at the end of symmetric docking
 Default: false

 **-docking** \<Boolean\>   
Docking option group

 **-view** \<Boolean\>   
Decide whether to use the viewer (graphical) or not
 Default: false

 **-no\_filters** \<Boolean\>   
Toggle the use of filters
 Default: false

 **-design\_chains** \<StringVector\>   
Pass in the one-letter chain identifiers, separated by space, for each chain to design: -design\_chains A B

 **-recover\_sidechains** \<File\>   
usually side-chains are taken from the input structure if it is fullatom - this overrides this behavior and takes sidechains from the pdb-file

 **-partners** \<String\>   
defines docking partners by ChainID, example: docking chains L+H with A is -partners LH\_A
 Default: "\_"

 **-docking\_local\_refine** \<Boolean\>   
Do a local refinement of the docking position (high resolution)
 Default: false

 **-low\_res\_protocol\_only** \<Boolean\>   
Run only low resolution docking, skip high resolution docking
 Default: false

 **-randomize1** \<Boolean\>   
Randomize the first docking partner.
 Default: false

 **-randomize2** \<Boolean\>   
Randomize the second docking partner.
 Default: false

 **-use\_ellipsoidal\_randomization** \<Boolean\>   
Modify docking randomization to use ellipsoidal rather than spherical method.
 Default: false

 **-spin** \<Boolean\>   
Spin a second docking partner around axes from center of mass of partner1 to partner2
 Default: false

 **-dock\_pert** \<RealVector\>   
Do a small perturbation with partner two: -dock\_pert ANGSTROMS DEGREES. Good values for protein docking are 3 A and 8 deg.

 **-uniform\_trans** \<Real\>   
No description

 **-center\_at\_interface** \<Boolean\>   
Perform all initial perturbations with the center of rotation at the interface between partners instead of at the center of mass of the oppposite partner.
 Default: false

 **-dock\_mcm\_first\_cycles** \<Integer\>   
Perfrom 4 cycles to let the filter decide to continue.
 Default: 4

 **-dock\_mcm\_second\_cycles** \<Integer\>   
If the first cycle pass the fliter, continue 45 cycles.
 Default: 45

 **-docking\_centroid\_outer\_cycles** \<Integer\>   
Outer cycles during cking rigid body adaptive moves.
 Default: 10

 **-docking\_centroid\_inner\_cycles** \<Integer\>   
Inner cycles during docking rigid body adaptive moves.
 Default: 50

 **-dock\_min** \<Boolean\>   
Minimize the final fullatom structure.
 Default: false

 **-flexible\_bb\_docking** \<String\>   
How to do flexible backbone docking, if at all. Choices include fixedbb, ccd, alc, and backrub.
 Default: "fixedbb"

 **-flexible\_bb\_docking\_interface\_dist** \<Real\>   
Distance between chains required to define a residue as having flexible backbone (ie. loop).
 Default: 10.0

 **-ensemble1** \<String\>   
turns on ensemble mode for partner 1. String is multi-model pdb file
 Default: ""

 **-ensemble2** \<String\>   
turns on ensemble mode for partner 2. String is multi-model pdb file
 Default: ""

 **-dock\_mcm\_trans\_magnitude** \<Real\>   
The magnitude of the translational perturbation during mcm in docking.
 Default: 0.1

 **-dock\_mcm\_rot\_magnitude** \<Real\>   
The magnitude of the rotational perturbation during mcm in docking.
 Default: 5.0

 **-minimization\_threshold** \<Real\>   
Threhold for Rosetta to decide whether to minimize jump after a rigid\_pert
 Default: 15

 **-temperature** \<Real\>   
Temperature setting for the mc object during rigid-body docking
 Default: 0.8

 **-repack\_period** \<Integer\>   
full repack period during dockingMCM
 Default: 8

 **-extra\_rottrial** \<Boolean\>   
extra rotamer trial after minimization
 Default: false

 **-dock\_rtmin** \<Boolean\>   
does rotamer trials with minimization, RTMIN
 Default: false

 **-sc\_min** \<Boolean\>   
does sidechain minimization of interface residues
 Default: false

 **-norepack1** \<Boolean\>   
Do not repack the side-chains of partner 1.
 Default: false

 **-norepack2** \<Boolean\>   
Do not repack the side-chains of partner 2.
 Default: false

 **-bb\_min\_res** \<IntegerVector\>   
Minimize backbone at these positions.

 **-sc\_min\_res** \<IntegerVector\>   
Minimize backbone at these positions.

 **-dock\_ppk** \<Boolean\>   
docking prepack mode
 Default: false

 **-max\_repeats** \<Integer\>   
If a decoy does not pass the low- and high-resolution filters, how many attempts to make before failur
 Default: 1000

 **-dock\_lowres\_filter** \<RealVector\>   
manually sets the lowres docking filter: -dock\_lowres\_filter \<INTERCHAIN\_CONTACT cutoff\>=""\> \<INTERCHAIN\_VDW cutoff\>=""\> \<RESTRAINT cutoff\>=""\>. Default values for protein docking are 10.0 and 1.0

 **-multibody** \<IntegerVector\>   
List of jumps allowed to move during docking

 **-ignore\_default\_docking\_task** \<Boolean\>   
Allows the user to define another task to give to Docking and will ignore the default DockingTask. Task will default to designing everything if no other TaskFactory is given to docking.
 Default: false

 **-low\_patch** \<String\>   
Name of weights patch file (without extension .wts) to use during rigid body

 **-high\_patch** \<String\>   
Name of weights patch file (without extension .wts) to use during docking

 **-high\_min\_patch** \<String\>   
Name of weights patch file (without extension .wts) to use during

 **-pack\_patch** \<String\>   
Name of weights patch file (without extension .wts) to use during packing

 **-use\_legacy\_protocol** \<Boolean\>   
Use the legacy high resolution docking algorithm for output compatibility.
 Default: false

 **-docklowres\_trans\_magnitude** \<Real\>   
The magnitude of the translational perturbation during lowres in docking.
 Default: 0.7

 **-docklowres\_rot\_magnitude** \<Real\>   
The magnitude of the rotational perturbation during lowres in docking.
 Default: 5.0

-   ### -docking:ligand

 **-ligand** \<Boolean\>   
docking:ligand option group

 **-protocol** \<String\>   
Which protocol to run?
 Default: "abbreviated"

 **-soft\_rep** \<Boolean\>   
Use soft repulsive potential?
 Default: false

 **-tweak\_sxfn** \<Boolean\>   
Apply default modifications to the score function?
 Default: true

 **-old\_estat** \<Boolean\>   
Emulate Rosetta++ electrostatics? (higher weight, ignore protein-protein)
 Default: false

 **-random\_conformer** \<Boolean\>   
Start from a random ligand rotamer chosen from the library
 Default: false

 **-improve\_orientation** \<Integer\>   
Do N cycles of randomization to minimize clashes with backbone

 **-mutate\_same\_name3** \<Boolean\>   
Allow ligand to 'design' to residue types with same name3? Typically used for protonation states / tautomers.
 Default: false

 **-subset\_to\_keep** \<Real\>   
When selecting a subset of ligand poses, what fraction (number if \> 1.0) to keep?
 Default: 0.05

 **-min\_rms** \<Real\>   
When selecting a subset of ligand poses, all must differ by at least this amount.
 Default: 0.8

 **-max\_poses** \<Integer\>   
When selecting a subset of ligand poses, select as most this many.
 Default: 50

 **-minimize\_ligand** \<Boolean\>   
Allow ligand torsions to minimize?
 Default: false

 **-harmonic\_torsions** \<Real\>   
Minimize with harmonic restraints with specified stddev (in degrees)
 Default: 10.0

 **-use\_ambig\_constraints** \<Boolean\>   
Use ambiguous constraints to restrain torsions instead of adding and removing constraints
 Default: false

 **-shear\_moves** \<Integer\>   
Do N pseudo-shear moves on ligand torsions per MCM cycle
 Default: 0

 **-minimize\_backbone** \<Boolean\>   
Allow protein backbone to minimize? Restrained except near ligand.
 Default: false

 **-harmonic\_Calphas** \<Real\>   
Minimize with harmonic restraints with specified stddev (in Angstroms)
 Default: 0.2

 **-tether\_ligand** \<Real\>   
Restrain ligand to starting point with specified stddev (in Angstroms)

 **-start\_from** \<RealVector\>   
One or more XYZ locations to choose for the ligand: -start\_from X1 Y1 Z1 -start\_from X2 Y2 Z2 ...

 **-option\_file** \<String\>   
Name of Ligand Option File for use with multi\_ligand\_dock application

 **-rescore** \<Boolean\>   
No docking (debug/benchmark mode)
 Default: false

-   #### -docking:ligand:grid

 **-grid** \<Boolean\>   
docking:ligand:grid option group

 **-grid\_kin** \<File\>   
Write kinemage version of generated grid to named file

 **-grid\_map** \<File\>   
Write grid to named file as electron density in BRIX (aka \`O'-map) format

-   ### -docking:symmetry

 **-symmetry** \<Boolean\>   
symmetry option group

 **-minimize\_backbone** \<Boolean\>   
Allow protein backbone to minimize?
 Default: false

 **-minimize\_sidechains** \<Boolean\>   
Allow protein sidechains to minimize?
 Default: false

-   -pH
    ---

 **-pH** \<Boolean\>   
pH option group

 **-pH\_mode** \<Boolean\>   
Allow protonated/deprotonated versions of the residues based on pH
 Default: false

 **-keep\_input\_protonation\_state** \<Boolean\>   
Read in residue protonation states from input pdb?
 Default: false

 **-value\_pH** \<Real\>   
pH value input for the pHEnergy score
 Default: 7.0

-   ### -pH:calc\_pka

 **-calc\_pka** \<Boolean\>   
calc\_pka option group

 **-pka\_all** \<Boolean\>   
Calculate pKa values for all protonatable protein residues in the PDB?
 Default: false

 **-pka\_for\_resnos** \<RealVector\>   
Residue no whose pKa value is to be determined
 Default: 0

 **-pka\_for\_chainno** \<String\>   
Chain no of the residue whose pKa is to be determined
 Default: "A"

 **-pH\_neighbor\_pack** \<Boolean\>   
Pack the neighbors while calculating pKa?
 Default: false

 **-pka\_rad** \<Real\>   
Radius of repack
 Default: 5.0

 **-pH\_prepack** \<Boolean\>   
Prepack structure before calculating pKa values?
 Default: false

 **-pH\_relax** \<Boolean\>   
Relax structure before calculating pKa values?
 Default: false

 **-rotamer\_prot\_stats** \<Boolean\>   
Get rotamer protonation statistics when titrating?
 Default: false

-   -pH
    ---

 **-pH\_unbound** \<FileVector\>   
Name(s) of unbound receptor and ligand PDB file(s)

 **-output\_raw\_scores** \<Boolean\>   
Return raw scores contributing to interface score?

 **-pre\_process** \<Boolean\>   
Refine rigid body orientation?

 **-cognate\_partners** \<String\>   
Chain IDs for the cognate complex
 Default: "\_"

 **-cognate\_pdb** \<File\>   
File containing the cognate Antigen-Antibody complex

-   -run
    ----

 **-run** \<Boolean\>   
Run option group

 **-batches** \<FileVector\>   
batch\_flag\_files
 Default: ""

 **-no\_prof\_info\_in\_silentout** \<Boolean\>   
no time-columns appears in score/silent - files
 Default: false

 **-archive** \<Boolean\>   
run MPIArchiveJobDistributor
 Default: false

 **-n\_replica** \<Integer\>   
run MPIMultiCommJobDistributor with n\_replica processes per job
 Default: 1

 **-shuffle** \<Boolean\>   
Shuffle job order
 Default: false

 **-n\_cycles** \<Integer\>   
Option to control miscellaneous cycles within protocols. This has no core meaning - it is meant to reduce option-bloat by having every protocol define separate cycles options. Check your protocol's documentation to see if it is used.
 Range: 1-
 Default: 1

 **-repeat** \<Integer\>   
Repeat mover N times
 Range: 0-
 Default: 1

 **-max\_min\_iter** \<Integer\>   
Maximum number of iterations of dfpmin
 Default: 200

 **-maxruntime** \<Integer\>   
Maximum runtime in seconds. JobDistributor will signal end if time is exceeded no matter how many jobs were finished.
 Default: -1

 **-write\_failures** \<Boolean\>   
write failed structures to output
 Default: false

 **-clean** \<Boolean\>   
clean input pdb befere processing them
 Default: false

 **-benchmark** \<Boolean\>   
Run in benchmark mode

 **-test\_cycles** \<Boolean\>   
When running tests, use reduced cycles. Cycles must be defined in the code itself
 Default: false

 **-memory\_test\_cycles** \<Boolean\>   
use together with test\_cycles to keep number of copies of anything as high as in production mode
 Default: false

 **-dry\_run** \<Boolean\>   
Run through structures/tasks/etc skipping the actual calculation step for testing of I/O and/or setup
 Default: false

 **-debug** \<Boolean\>   
Run in debug mode

 **-profile** \<Boolean\>   
Run in profile mode
 Default: false

 **-max\_retry\_job** \<Integer\>   
If a job fails with FAIL\_RETRY retry this many times at most
 Default: 10

 **-verbosity** \<Integer\>   
Logging verbosity level
 Range: 0-9
 Default: 0

 **-version** \<Boolean\>   
write out SVN version info, if it was available at compile time
 Default: true

 **-nodelay** \<Boolean\>   
Do not delay launch of minirosetta

 **-delay** \<Integer\>   
Wait N seconds before doing anything at all. Useful for cluster job staggering.
 Default: 0

 **-random\_delay** \<Integer\>   
Wait a random amount of 0..N seconds before doing anything at all. Useful for cluster job staggering.
 Default: 0

 **-timer** \<Boolean\>   
write out time per decoy in minutes in scorefile

 **-series** \<String\>   
alternate way to specify the code name chain
 Default: "ss"

 **-protein** \<String\>   
protein \<pdbcode\> these options override the first three args
 Default: "----"

 **-chain** \<String\>   
-chain \<chain\_id\>
 Default: "-"

 **-score\_only** \<Boolean\>   
calculate the score only and exit
 Default: false

 **-silent\_input** \<Boolean\>   
read start structures from compressed format requires -refold -s \<.out file\> -l \<label/index list file\> or use -all in place of -l

use all files

 **-decoystats** \<Boolean\>   
calculate values of a series of additional structural properties, including counting unsatisfied buried Hbond donors and acceptors, SASApack, etc. Additional output associated with this flag is written both to stdout and to output PDB files

 **-output\_hbond\_info** \<Boolean\>   
print hydrogen bond info in the stats section of written out PDB files

 **-wide\_nblist\_extension** \<Real\>   
Amount to extend the wide neighbor list
 Default: 2.0

 **-status** \<Boolean\>   
Generate a status file

 **-constant\_seed** \<Boolean\>   
Use a constant seed (1111111 unless specified)

 **-jran** \<Integer\>   
Specify seed (requires -constant\_seed)
 Default: 1111111

 **-use\_time\_as\_seed** \<Boolean\>   
Use time as random number seed instead of default rng seed device.

 **-rng\_seed\_device** \<String\>   
Obtain random number seed from specified device.
 Default: "/dev/urandom"

 **-seed\_offset** \<Integer\>   
This value will be added to the random number seed. Useful when using time as seed and submitting many jobs to clusters. Using the condor job id will force jobs that are started in the same second to still have different initial seeds
 Default: 0

 **-rng** \<String\>   
Random number generation algorithm: Currently only mt19937 is a accepted here
 Default: "mt19937"

 **-run\_level** \<Integer\>   
Specify runlevel by integer
 Default: 0

 **-verbose** \<String\>   
Keyword runlevels (decreasing verbosity): gush yap chat inform quiet silent

 **-silent** \<Boolean\>   
use compressed output (also a runlevel)

 **-regions** \<Boolean\>   
Specify regions of the protein allowed to move

 **-find\_disulf** \<Boolean\>   
Each time the pose is scored, attempt to find new disulfide bonds.
 Default: false

 **-rebuild\_disulf** \<Boolean\>   
Attempt to build correct disulfide geometry when converting from a centroid pose to a full atom pose. Disulfides must be previously annotated, either by enabling -detect\_disulf or by specifying a file to -fix\_disulf.
 Default: false

 **-movie** \<Boolean\>   
Update \_movie.pdb file for rasmol\_rt

 **-trajectory** \<Boolean\>   
Write a pdb file of each accepted structure

 **-IUPAC** \<Boolean\>   
Use IUPAC hydrogen conventions in place of PDB conventions

 **-preserve\_header** \<Boolean\>   
Maintain header info from input PDB when writing output PDBs

 **-evolution** \<Boolean\>   
evolutionary algorithm applied to fullatom refinement of structure models

 **-suppress\_checkpoints** \<Boolean\>   
Override & switch off checkpoints.

 **-checkpoint** \<Boolean\>   
Turn checkpointing on

 **-delete\_checkpoints** \<Boolean\>   
delete the checkpoints after use
 Default: true

 **-checkpoint\_interval** \<Integer\>   
Checkpoint time interval in seconds
 Range: 10-
 Default: 600

 **-protocol** \<String\>   
Which protocol to run, for Rosetta wrapper
 Default: "abrelax"

 **-remove\_ss\_length\_screen** \<Boolean\>   
Sets the use\_ss\_length\_screen flag in the Fragment Mover to false

 **-min\_type** \<String\>   
type of minimizer to use
 Default: "dfpmin"

 **-min\_tolerance** \<Real\>   
minimizer tolerance
 Default: 0.000001

 **-nblist\_autoupdate** \<Boolean\>   
Turn on neighborlist auto-updates for all minimizations
 Default: false

 **-nblist\_autoupdate\_narrow** \<Real\>   
With nblist autoupdate: the reach in Angstroms for the narrow neighbor list
 Default: 0.5

 **-nblist\_autoupdate\_wide** \<Real\>   
With nblist autoupdate: the reach in Angstroms for the wide neighbor list
 Default: 2.0

 **-skip\_set\_reasonable\_fold\_tree** \<Boolean\>   
Do not run set\_reasonable\_fold\_tree when creating a pose from a pdb. Useful for unreasonable PDBs where the user sets a fold tree explicitly.
 Default: false

 **-randomize\_missing\_coords** \<Boolean\>   
Insert random coordinates for missing density atoms ( occupancy is zero ) and for any atoms with negative occupancy, randomizing coords is done by default
 Default: false

 **-ignore\_zero\_occupancy** \<Boolean\>   
discard coords information for missing density atoms ( occupancy is zero ) defined in input structures. Default is to keep those coordinates because this is a consistent problem for end users
 Default: true

 **-cycles\_outer** \<Integer\>   
number of outer cycles
 Range: 1-
 Default: 1

 **-cycles\_inner** \<Integer\>   
number of inner cycles
 Range: 1-
 Default: 1

 **-repack\_rate** \<Integer\>   
repack after every [value] cycles during certain protocols
 Range: 1-
 Default: 10

 **-reinitialize\_mover\_for\_each\_job** \<Boolean\>   
job distributor will generate fresh copy of its mover before each apply (once per job)
 Default: false

 **-reinitialize\_mover\_for\_new\_input** \<Boolean\>   
job distributor will generate fresh copy of its mover whenever the pose being passed to the mover is going to change (e.g., next PDB in -l)
 Default: false

 **-multiple\_processes\_writing\_to\_one\_directory** \<Boolean\>   
activates .in\_progress files used to communicate between independent processes that a job is underway. UNSAFE but may be convenient.
 Default: false

 **-jobdist\_miscfile\_ext** \<String\>   
extension for JobOutputter file() function (miscellaneous file output).
 Default: ".data"

 **-no\_scorefile** \<Boolean\>   
do not output scorefiles
 Default: false

 **-other\_pose\_to\_scorefile** \<Boolean\>   
write other\_pose (JobOutputter) to a scorefile; path by other\_pose\_scorefile; be warned you can get garbage if scorefunctions for poses do not match. Overridden by no\_scorefile
 Default: false

 **-other\_pose\_scorefile** \<File\>   
Path to other\_pose (JobOutputter) scorefiles. Default is same scorefile as regular result poses. The default will cause problems if your output poses were scored on different scorefunctions.
 Default: ""

 **-intermediate\_scorefiles** \<Boolean\>   
write intermediate evaluations to disk (depends on your protocol if and how often this happens
 Default: false

 **-intermediate\_structures** \<Boolean\>   
write structures together with intermediate evaluations
 Default: false

 **-idealize\_before\_protocol** \<Boolean\>   
run idealize first, before running whatever.

 **-interactive** \<Boolean\>   
Signal Rosetta is to be run as a library in an interactive application. In particular, favor throwing exceptions on bad inputs rather than exiting.
 Default: false

 **-condor** \<Boolean\>   
if condor say yes – proc\_id counting starts at 0
 Default: false

 **-nproc** \<Integer\>   
number of process... needed if proc\_id is specified
 Default: 0

 **-proc\_id** \<Integer\>   
give process number... Jobdistributor will only work on proc\_id mod nproc part of work
 Default: 0

 **-exit\_if\_missing\_heavy\_atoms** \<Boolean\>   
quit if heavy atoms missing in pdb
 Default: false

 **-show\_simulation\_in\_pymol** \<Real\>   
Attach PyMOL observer to pose at the beginning of the simulation. Refreshes pose every [argument] seconds, default 5. Don't forget to run the PyMOLPyRosettaServer.py script within PyMOL!
 Default: 5.0

 **-keep\_pymol\_simulation\_history** \<Boolean\>   
Keep history when using show\_simulation\_in\_pymol flag?
 Default: false

-   -jd2
    ----

 **-jd2** \<Boolean\>   
jd2 option group

 **-pose\_input\_stream** \<Boolean\>   
Use PoseInputStream classes for Pose input
 Default: false

 **-lazy\_silent\_file\_reader** \<Boolean\>   
use lazy silent file reader in job distributor, read in a structure only when you need to
 Default: false

 **-mpi\_nowait\_for\_remaining\_jobs** \<Boolean\>   
exit immediately (not graceful – not complete) if the last job has been sent out
 Default: false

 **-mpi\_timeout\_factor** \<Real\>   
timeout is X times average job-completion time - set to 0 to switch off
 Default: 3

 **-mpi\_work\_partition\_job\_distributor** \<Boolean\>   
determine if we should use the WorkPartition job distributor
 Default: false

 **-mpi\_file\_buf\_job\_distributor** \<Boolean\>   
determine if we should use the MPIFileBufJobDistributor (warning: silent output only)
 Default: true

 **-mpi\_filebuf\_jobdistributor** \<Boolean\>   
same as mpi\_file\_buf\_job\_distributor but with more intuitive spacing... determine if we should use the MPIFileBufJobDistributor (warning: silent output only)
 Default: true

 **-mpi\_fast\_nonblocking\_output** \<Boolean\>   
By default the master node blocks while a slave node outputs to avoid two slaves writing to a score file or silent file at the same time setting this to true disables that feature
 Default: false

 **-dd\_parser** \<Boolean\>   
determine whether to use the dock\_design\_parser
 Default: false

 **-ntrials** \<Integer\>   
number of attempts at creating an output file for each nstruct. e.g., ntrials 3 and nstruct 10 would mean that each of 10 trajectories would attempt to write an output file 3 times and if unsuccessful would fail.

 **-generic\_job\_name** \<String\>   
job name when using GenericJobInputter (i.e. abinitio)
 Default: "S"

 **-no\_output** \<Boolean\>   
use NoOutputJobOutputter; do not store the pose after a run (no silent or scorefile)
 Default: false

 **-enzdes\_out** \<Boolean\>   
causes an enzdes-style scorefile (with information about catalytic res and some pose metric stuff ) to be written instead of the regular scorefile
 Default: false

 **-buffer\_silent\_output** \<Integer\>   
write structures to silent-files in blocks of N structures to
 Default: 1

 **-buffer\_flush\_frequency** \<Real\>   
when N structures (buffer\_silent\_output) are collected dump to file with probability X
 Default: 1.0

 **-delete\_old\_poses** \<Boolean\>   
Delete poses after they have been processed. For jobs that process a large number of structures, the memory consumed by old poses is wasteful.
 Default: false

 **-resource\_definition\_files** \<FileVector\>   
Specify all the jobs and all of their resources to the new JD2ResourceManager system

 **-checkpoint\_file** \<File\>   
write/read nstruct-based checkpoint files to the desired filename.

-   -evaluation
    -----------

 **-evaluation** \<Boolean\>   
evaluation option group

 **-rmsd\_target** \<FileVector\>   
[vector] determine rmsd against this/these structure(s)

 **-rmsd\_column** \<StringVector\>   
[vector] use xxx as column name: rms\_xxx

 **-rmsd\_select** \<FileVector\>   
[vector] a bunch of loop files which makes rmsds with tags: rms\_XXX, where XXX is basename of file

 **-align\_rmsd\_target** \<FileVector\>   
[vector] determine rmsd against this/these structure(s) using simple sequence alignment

 **-structural\_similarity** \<FileVector\>   
[vector] measure average similarity against these structures (option specifies a silent-file)

 **-contact\_map** \<Boolean\>   
Calculate contact map similarity using the given native

 **-jscore\_evaluator** \<StringVector\>   
Calculate scores using the given score function weights files and, residue type set names (e.g score12 fa\_standard score3 centroid)

 **-align\_rmsd\_column** \<StringVector\>   
[vector] use xxx as column name for align\_rmsd\_target: rms\_xxx

 **-align\_rmsd\_fns** \<FileVector\>   
[vector] of sequence alignments used for align\_rmsd files

 **-align\_rmsd\_format** \<String\>   
format for sequence alignment between structures used in evaluation
 Default: "grishin"

 **-predicted\_burial\_fn** \<String\>   
file for burial predictions
 Default: ""

 **-pool** \<File\>   
find closest matching structure in this pool and report tag and rmsd

 **-rmsd** \<FileVector\>   
[vector/pairs] tripletts: rmsd\_target (or NATIVE / IRMS) col\_name selection\_file (or FULL)

 **-chirmsd** \<FileVector\>   
[vector/tripletts]: rmsd\_target (or NATIVE / IRMS ) col\_name selection\_file ( or FULL)

 **-gdtmm** \<Boolean\>   
for each rmsd evaluator also a gdtmm evaluator is created
 Default: false

 **-gdttm** \<Boolean\>   
for each rmsd evaluator also a gdttm evaluator is created
 Default: false

 **-score\_with\_rmsd** \<Boolean\>   
score the pose on the same subset of atoms as in the rmsd poses

 **-constraints** \<FileVector\>   
[vector] evaluate against these constraint sets

 **-constraints\_column** \<FileVector\>   
[vector] use xxx as column name: cst\_xxx

 **-combined\_constraints** \<FileVector\>   
[vector] use xxx as cst-file but combine constraints before applying

 **-combined\_constraints\_column** \<FileVector\>   
[vector] use xxx as cst-file but combine constraints before applying

 **-combine\_statistics** \<Integer\>   
repeat constraint evaluation X times to get statistics of constraint combination
 Default: 10

 **-chemical\_shifts** \<StringVector\>   
compute chemical shift score with SPARTA+ use tuples: talos\_file [cs]\_column\_name (ATTENTION uses filesystem)

 **-sparta\_dir** \<String\>   
[optional] point to an external resource for the sparta directory (instead of minirosetta\_database)
 Default: "SPARTA+"

 **-cam\_shifts** \<StringVector\>   
compute chemical shift score with Camshift talos\_file [cs]\_column\_name (ATTENTION uses filesystem)

 **-pales** \<StringVector\>   
compute Residual Dipolar Couplings using the PALES program (ATTENTION uses filesystem)

 **-extra\_score** \<FileVector\>   
[vector] provide .wts files to generate extra columns

 **-extra\_score\_patch** \<FileVector\>   
[vector] provide .patch files, set NOPATCH for columns that are not patched

 **-extra\_score\_column** \<StringVector\>   
[vector] use xxx as column name: score\_xxx

 **-extra\_score\_select** \<FileVector\>   
[vector] /rigid/ files for selection, use SELECT\_ALL as placeholder

 **-rdc\_select** \<FileVector\>   
[vector] as rmsd\_select provide loop-file(RIGID) to compute RDC score on selected residues

 **-rdc\_target** \<FileVector\>   
[vector] as rmsd\_target/column provide PDB wih missing density to compute RDC score on selected residues

 **-symmetric\_rmsd** \<Boolean\>   
calculate the rmsd symmetrically by checking all chain orderings

 **-rdc\_column** \<StringVector\>   
[vector] column names for rdc\_select

 **-rdc** \<StringVector\>   
[vector] rdc-files and column names for RDC calculation

 **-built\_in\_rdc** \<String\>   
evaluate rdc from -in: <file:rdc> with standard score function and store under column xxx

 **-jump\_nr** \<Boolean\>   
adds the JumpNrEvaluator for the nrjumps column
 Default: false

 **-score\_exclude\_res** \<IntegerVector\>   
Calculates a select\_score column based on all residues not excluded by the command line vector

 **-score\_sscore\_short\_helix** \<Integer\>   
defines the maximum length of a helix that is not scored if it terminates a loop
 Default: 5

 **-score\_sscore\_maxloop** \<Integer\>   
defines the maximum length of a loop that is still considered for the sscore - score
 Default: 3

 **-rpf** \<Boolean\>   
will compute RPF score with distance cutoff 5 and store in column rpf\_score
 Default: false

 **-window\_size** \<Integer\>   
Window size for local RMSD calculations in windowed\_rmsd app
 Default: 5

 **-I\_sc** \<String\>   
score function name used to calculate I\_sc
 Default: "score12"

 **-Irms** \<Boolean\>   
will compute the docking interface rmsd
 Default: false

 **-Ca\_Irms** \<Boolean\>   
will compute the docking Ca-atom interface rmsd
 Default: false

 **-Fnat** \<Boolean\>   
will compute the docking recovered fraction of native contacts
 Default: false

 **-Lrmsd** \<Boolean\>   
will compute the docking ligand rmsd
 Default: false

 **-Fnonnat** \<Boolean\>   
will compute the fraction of non-native contacts for docking
 Default: false

 **-DockMetrics** \<Boolean\>   
will compute all docking metrics (I\_sc/Irms/Fnat/Lrmsd for now) for replica docking
 Default: false

-   -filters
    --------

 **-filters** \<Boolean\>   
filters option group

 **-disable\_all\_filters** \<Boolean\>   
turn off all centroid filters: RG, CO, and Sheet
 Default: false

 **-disable\_rg\_filter** \<Boolean\>   
turn off RG filter
 Default: false

 **-disable\_co\_filter** \<Boolean\>   
turn off contact order filter
 Default: false

 **-disable\_sheet\_filter** \<Boolean\>   
turn off sheet filter
 Default: false

 **-set\_pddf\_filter** \<Real\>   
Turns on PDDF filter with a given score cutoff
 Default: 5.0

 **-set\_saxs\_filter** \<Real\>   
Turns on SAXS energy filter with a given score cutoff
 Default: -3

-   -MonteCarlo
    -----------

 **-MonteCarlo** \<Boolean\>   
MonteCarlo option group

 **-temp\_initial** \<Real\>   
initial temperature for Monte Carlo considerations
 Range: 0.001-
 Default: 2

 **-temp\_final** \<Real\>   
final temperature for Monte Carlo considerations
 Range: 0.001-
 Default: 0.6

-   -frags
    ------

 **-frags** \<Boolean\>   
frags option group

 **-j** \<Integer\>   
Number of threads to use

 **-filter\_JC** \<Boolean\>   
Filter J-coupling values in the dynamic range
 Default: false

 **-bounded\_protocol** \<Boolean\>   
makes the picker use bounded protocol to select fragments. This is teh default behavior
 Default: true

 **-keep\_all\_protocol** \<Boolean\>   
makes the picker use keep-all protocol to select fragments. The default is bounded protocol
 Default: false

 **-quota\_protocol** \<Boolean\>   
quota protocol implies the use of a QuotaCollector and a QuotaSelelctor, no matter what user set up by other flags.
 Default: false

 **-nonlocal\_pairs** \<Boolean\>   
identifies and outputs nonlocal fragment pairs.
 Default: false

 **-fragment\_contacts** \<Boolean\>   
identifies and outputs fragment contacts.
 Default: false

 **-p\_value\_selection** \<Boolean\>   
the final fragment selection will b based on p-value rather than on a total score for the given fragment
 Default: false

 **-n\_frags** \<Integer\>   
number of fragments per position
 Default: 200

 **-allowed\_pdb** \<File\>   
provides a text file with allowed PDB chains (five characters per entry, e.g.'4mbA'). Only these PDB chains from Vall will be used to pick fragments

 **-ss\_pred** \<StringVector\>   
provides one or more files with secondary structure prediction (PsiPred SS2 format) , to be used by secondary structure scoring and quota selector. Each file name must be followed by a string ID.

 **-spine\_x** \<File\>   
provides phi and psi torsion angle predictions and solvent accessibility prediction from Spine-X

 **-depth** \<File\>   
provides residue depth values from DEPTH

 **-denied\_pdb** \<File\>   
provides a text file with denied PDB chains (five characters per entry, e.g.'4mbA'). This way close homologs may be excluded from fragment picking.

 **-frag\_sizes** \<IntegerVector\>   
sizes of fragments to pick from the vall
 Default: ['9', '3', '1']

 **-write\_ca\_coordinates** \<Boolean\>   
Fragment picker will store CA Cartesian coordinates in output fragment files. By default only torsion coordinates are stored.
 Default: false

 **-write\_scores** \<Boolean\>   
Fragment picker will write scores in output fragment files.
 Default: false

 **-annotate** \<Boolean\>   
read the annotation from the rosetta++ fragment file
 Default: false

 **-nr\_large\_copies** \<Integer\>   
make N copies for each standard 9mer (or so) fragment
 Default: 1

 **-n\_candidates** \<Integer\>   
number of fragment candidates per position; the final fragments will be selected from them
 Default: 200

 **-write\_rama\_tables** \<Boolean\>   
Fragment picker will spit out sequence specific ramachandran score tables for your viewing pleasure. These ramachandran tables are based on the secondary structure predictions fed into RamaScore, and you may occasionally want to look at what the program has defined.
 Default: false

 **-rama\_C** \<Real\>   
Constant in RamaScore equation, command line is for optimization tests
 Default: 0.0

 **-rama\_B** \<Real\>   
Constant in RamaScore equation, command line is for optimization tests
 Default: 1.0

 **-sigmoid\_cs\_A** \<Real\>   
Constant in CSScore equation, command line is for optimization tests
 Default: 2.0

 **-sigmoid\_cs\_B** \<Real\>   
Constant in CSScore equation, command line is for optimization tests
 Default: 4.0

 **-seqsim\_H** \<Real\>   
Secondary structure type prediction multiplier, for use in fragment picking
 Default: 1.0

 **-seqsim\_E** \<Real\>   
Secondary structure type prediction multiplier, for use in fragment picking
 Default: 1.0

 **-seqsim\_L** \<Real\>   
Secondary structure type prediction multiplier, for use in fragment picking
 Default: 1.0

 **-rama\_norm** \<Real\>   
Used to multiply rama table values after normalization, default (0.0) means use raw counts (unnormalized)
 Default: 0.0

 **-describe\_fragments** \<String\>   
Writes scores for all fragments into a file
 Default: ""

 **-picking\_old\_max\_score** \<Real\>   
maximal score allowed for fragments picked by the old vall (used by RosettaRemodel).
 Default: 1000000.0

 **-write\_sequence\_only** \<Boolean\>   
Fragment picker will output fragment sequences only. This option is for creating structure based sequence profiles using the FragmentCrmsdResDepth score.
 Default: false

 **-output\_silent** \<Boolean\>   
Fragment picker will output fragments into a silent file.
 Default: false

 **-score\_output\_silent** \<Boolean\>   
Fragment picker will output fragments into a silent file. Scores of relaxed fragments are added to the silent file.
 Default: false

-   ### -frags:scoring

 **-scoring** \<Boolean\>   
scoring option group

 **-config** \<File\>   
scoring scheme used for picking fragments
 Default: ""

 **-profile\_score** \<String\>   
scoring scheme used for profile-profile comparison
 Default: "L1"

 **-predicted\_secondary** \<FileVector\>   
provides one or more files with secondary structure prediction, to be used by secondary structure scoring and quota selector
 Default: ""

-   ### -frags:picking

 **-picking** \<Boolean\>   
picking option group

 **-selecting\_rule** \<String\>   
the way how fragments are selected from candidates, e.g. QuotaSelector of BestTotalScoreSelector
 Default: "BestTotalScoreSelector"

 **-selecting\_scorefxn** \<String\>   
in the case user chose BestTotalScoreSelector to be used, this option provides a custom scoring function to be used at the selection step

 **-quota\_config\_file** \<File\>   
provides a configuration file for quota selector

 **-query\_pos** \<IntegerVector\>   
provide sequence position for which fragments will be picked. By default fragments are picked for the whole query sequence

-   ### -frags:nonlocal

 **-nonlocal** \<Boolean\>   
nonlocal option group

 **-relax\_input** \<Boolean\>   
relax input before running protocol

 **-relax\_input\_with\_coordinate\_constraints** \<Boolean\>   
relax input with coordinate constraints before running protocol

 **-relax\_frags\_repeats** \<Integer\>   
relax repeats for relaxing fragment pair

 **-single\_chain** \<Boolean\>   
non-local fragment pairs will be restricted to the same chain

 **-min\_contacts\_per\_res** \<Real\>   
minimum contacts per residue in fragment to be considered a fragment pair
 Default: 1.0

 **-max\_ddg\_score** \<Real\>   
maximum DDG score of fragment pair

 **-max\_rmsd\_after\_relax** \<Real\>   
maximum rmsd of fragment pair after relax

 **-output\_frags\_pdbs** \<Boolean\>   
output non-local fragment pair PDBs

 **-output\_idealized** \<Boolean\>   
output an idealized pose which can be used for generating a new VALL

 **-output\_silent** \<Boolean\>   
output non-local fragment pairs silent file
 Default: true

-   ### -frags:contacts

 **-contacts** \<Boolean\>   
contacts option group

 **-min\_seq\_sep** \<Integer\>   
minimum sequence separation between contacts
 Default: 12

 **-dist\_cutoffs** \<RealVector\>   
distance cutoffs to be considered a contact. contact counts will only be saved.
 Default: ['9.0']

 **-centroid\_distance\_scale\_factor** \<Real\>   
Scaling factor for centroid distance cutoffs.
 Default: 1.0

 **-type** \<StringVector\>   
Atom considered for contacts
 Default: utility::vector1\<std::string\>(1,"ca")

 **-neighbors** \<Integer\>   
number of adjacent residues to a contact for finding neighboring contacts
 Default: 0

 **-output\_all** \<Boolean\>   
output all contacts
 Default: false

-   ### -frags:ABEGO

 **-ABEGO** \<Boolean\>   
ABEGO option group

 **-phi\_psi\_range\_A** \<Real\>   
Further filter phi&psi during frag picking process in design
 Default: 999.0

-   -broker
    -------

 **-broker** \<Boolean\>   
broker option group

 **-setup** \<FileVector\>   
setup file for topology-broker
 Default: "NO\_SETUP\_FILE"

-   -chunk
    ------

 **-chunk** \<Boolean\>   
chunk option group

 **-pdb2** \<File\>   
file for chunk2

 **-loop2** \<File\>   
rigid region for chunk2

-   -nonlocal
    ---------

 **-nonlocal** \<Boolean\>   
nonlocal option group

 **-builder** \<String\>   
One of {simple, star}. Specifies how non-local abinitio should construct the fold tree
 Default: "star"

 **-chunks** \<File\>   
Decsribes how the structure is partitioned into chunks. Each residue must be present in 1 and only 1 chunk. Loop file format.

 **-max\_chunk\_size** \<Integer\>   
Maximum allowable chunk size for comparative modeling inputs. If the chunk exceeds this threshold, it is recursively decomposed into smaller pieces.
 Default: 20

 **-randomize\_missing** \<Boolean\>   
Randomize the coordinates of missing loops. This occurs often in broken-chain folding from a sequence alignment and template pdb. Default value is false to preserve existing behavior in ThreadingJobInputter
 Default: false

 **-rdc\_weight** \<Real\>   
Weight for the rdc energy term in nonlocal abinitio protocol
 Default: 5

-   ### -abinitio:star

 **-star** \<Boolean\>   
star option group

 **-initial\_dist\_cutoff** \<Real\>   
Maximum distance cutoff for restraints that constrain aligned residues to their initial positions
 Default: 8.0

 **-min\_unaligned\_len** \<Integer\>   
Minimum length of an unaligned region
 Default: 3

 **-short\_loop\_len** \<Integer\>   
StarAbinitio treats short loops differently from long ones. If the sequence separation between the consecutive aligned regions is \<= short\_loop\_len, it is considered short, otherwise it is considered long.
 Default: 18

-   -abinitio
    ---------

 **-prob\_perturb\_weights** \<Real\>   
Probability of perturbing score function weights
 Range: 0-1
 Default: 0

 **-abinitio** \<Boolean\>   
Ab initio mode

 **-membrane** \<Boolean\>   
will use the membrane abinitio protocol. sequential insertion of TMH
 Default: false

 **-kill\_hairpins** \<File\>   
setup hairpin killing in score (kill hairpin file or psipred file)

 **-kill\_hairpins\_frequency** \<Real\>   
automated hairpin killing frequency (for use with psipred file)
 Default: 0.2

 **-smooth\_cycles\_only** \<Boolean\>   
Only smooth cycles in abinitio protocol
 Default: false

 **-relax** \<Boolean\>   
Do a relax after abinitio = abrelax ?

 **-final\_clean\_relax** \<Boolean\>   
Do a final relax without constraints

 **-fastrelax** \<Boolean\>   
Do a fastrelax after abinitio = abfastrelax ?

 **-multifastrelax** \<Boolean\>   
Do a fastrelax after abinitio = abfastrelax ?

 **-debug** \<Boolean\>   
No description
 Default: false

 **-clear\_pose\_cache** \<Boolean\>   
always clear extra-scores away before output
 Default: false

 **-explicit\_pdb\_debug** \<Boolean\>   
always dump pdb (not silent ) files during abinitio stages
 Default: false

 **-use\_filters** \<Boolean\>   
use RG, contact-order and sheet filters
 Default: false

 **-increase\_cycles** \<Real\>   
Increase number of cycles at each stage of fold\_abinitio (or pose\_abinitio) by this factor
 Range: 0.001-
 Default: 1.0

 **-number\_3mer\_frags** \<Integer\>   
Number of top 3mer fragments to use in fold\_abinitio protocol
 Range: 0-
 Default: 200

 **-number\_9mer\_frags** \<Integer\>   
Number of top 9mer fragments to use in fold\_abinitio protocol
 Range: 0-
 Default: 25

 **-temperature** \<Real\>   
Temperature used in fold\_abinitio
 Default: 2.0

 **-rg\_reweight** \<Real\>   
Reweight contribution of radius of gyration to total score by this scale factor
 Default: 1.0

 **-strand\_dist\_cutoff** \<Real\>   
Specify distance cutoff (in Angstroms) between strand dimers within which they are called paired
 Default: 6.5

 **-stretch\_strand\_dist\_cutoff** \<Boolean\>   
Allow strand distance cutoff to change from 6.5 A to a larger value (specified by '-max\_strand\_dist\_cutoff \<float\>') linearly scaled according to sequence separation over a range specified by '-seq\_sep\_scale \<float\>'

 **-rsd\_wt\_helix** \<Real\>   
Reweight env,pair,cb for helix residues by this factor
 Default: 1.0

 **-rsd\_wt\_strand** \<Real\>   
Reweight env,pair,cb for strand residues by this factor
 Default: 1.0

 **-rsd\_wt\_loop** \<Real\>   
Reweight env,pair,cb for loop residues by this factor
 Default: 1.0

 **-fast** \<Boolean\>   
Runs protocol without minimization or gradients, giving a significant speed advantage For NOE data only, -fast yields essentially the protocol published by Bowers et al., JBNMR, 2000. For RDC data only, -fast omits the refinement step included in examples published in Rohl&Baker, JACS, 2002. without the -fast option

 **-skip\_convergence\_check** \<Boolean\>   
this option turns off the convergence check in stage3 (score 2/5)

 **-stage1\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage1 abinitio

 **-stage2\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage2 abinitio

 **-stage3a\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage3a abinitio

 **-stage3b\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage3b abinitio

 **-stage4\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage4 abinitio

 **-stage5\_patch** \<FileVector\>   
Name of weights patch file (without extension .wts) to use during stage5 abinitio

 **-exit\_when\_converged** \<Boolean\>   
finish abinitio if mc\_converged
 Default: false

 **-steal\_3mers** \<Boolean\>   
stealing: use 3mers from native
 Default: false

 **-steal\_9mers** \<Boolean\>   
stealing: use 9mers from native
 Default: false

 **-no\_write\_failures** \<Boolean\>   
dont write failed structures to silent-out
 Default: false

 **-relax\_failures** \<Boolean\>   
relax failures anyway
 Default: false

 **-relax\_with\_jumps** \<Boolean\>   
switch to allow relax even if loops are not closed
 Default: false

 **-process\_store** \<Boolean\>   
run process\_decoy on each structure in the structure store
 Default: false

 **-fix\_residues\_to\_native** \<IntegerVector\>   
these residues torsions are copied from native and fixed
 Default: 0

 **-return\_full\_atom** \<Boolean\>   
return a full-atom structure even if no relax is done
 Default: false

 **-detect\_disulfide\_before\_relax** \<Boolean\>   
run detect\_disulfides() before relax
 Default: false

 **-close\_loops** \<Boolean\>   
close loops
 Default: false

 **-bGDT** \<Boolean\>   
compute gdtmmm
 Default: true

 **-dump\_frags** \<Boolean\>   
for control purposes... dump fragments
 Default: false

 **-jdist\_rerun** \<Boolean\>   
go through intput structures and evaluate ( pca, rmsd, cst-energy )
 Default: false

 **-perturb** \<Real\>   
add some perturbation (gaussian) to phi/psi of native
 Default: 0.0

 **-rerun** \<Boolean\>   
go through intput structures and evaluate ( pca, rmsd, cst-energy )
 Default: false

 **-rmsd\_residues** \<IntegerVector\>   
give start and end residue for rmsd calcul.
 Default: -1

 **-start\_native** \<Boolean\>   
start from native structure (instead of extended)
 Default: false

 **-debug\_structures** \<Boolean\>   
write structures to debug-out files
 Default: false

 **-log\_frags** \<File\>   
fragment insertions (each trial) will be logged to file
 Default: ""

 **-only\_stage1** \<Boolean\>   
useful for benchmarks sets cycle of all higher stages to 0
 Default: false

 **-end\_bias** \<Real\>   
set the endbias for Fragment moves
 Default: 30.0

 **-symmetry\_residue** \<Integer\>   
hacky symmetry mode for dimers, fragments are inserted at i and i + SR - 1
 Default: -1

 **-vdw\_weight\_stage1** \<Real\>   
vdw weight in stage1
 Default: 1.0

 **-override\_vdw\_all\_stages** \<Boolean\>   
apply vdw\_weight\_stage1 for all stages
 Default: false

 **-recover\_low\_in\_stages** \<IntegerVector\>   
say default: 2 3 4 recover\_low happens in stages 2 3 4
 Default: 0

 **-skip\_stages** \<IntegerVector\>   
say: 2 3 4, and it will skip stages 2 3 4
 Default: 0

 **-close\_chbrk** \<Boolean\>   
Chain break closure during classic abinito
 Default: false

 **-include\_stage5** \<Boolean\>   
stage5 contains small moves only
 Default: false

 **-close\_loops\_by\_idealizing** \<Boolean\>   
close loops by idealizing the structure after stage 4
 Default: false

 **-optimize\_cutpoints\_using\_kic** \<Boolean\>   
optimize around cutpoints using kinematic relax
 Default: false

 **-optimize\_cutpoints\_margin** \<Integer\>   
 Default: 5

 **-HD\_EX\_Info** \<File\>   
input list of residues with low amide protection

 **-HD\_penalty** \<Real\>   
penatlty for each inconsistent pairing with HD data
 Default: 0.1

 **-HD\_fa\_penalty** \<Real\>   
penalty for each Hbond donor inconsistent with HD donor
 Default: 0.1

 **-sheet\_edge\_pred** \<File\>   
file with interior/exterior predictions for strands

 **-SEP\_score\_scalling** \<Real\>   
scalling factor
 Default: 1.0

-   -fold\_cst
    ----------

 **-fold\_cst** \<Boolean\>   
fold\_cst option group

 **-constraint\_skip\_rate** \<Real\>   
if e.g., 0.95 it will randomly select 5% if the constraints each round – full-cst score in extra column
 Default: 0

 **-violation\_skip\_basis** \<Integer\>   
local skip\_rate is viol/base
 Default: 100

 **-violation\_skip\_ignore** \<Integer\>   
no skip for numbers below this level
 Default: 10

 **-keep\_skipped\_csts** \<Boolean\>   
final score only with active constraints
 Default: false

 **-no\_minimize** \<Boolean\>   
No minimization moves in fold\_constraints protocol. Useful for testing wheather fragment moves alone can recapitulate a given structure.
 Default: false

 **-force\_minimize** \<Boolean\>   
Minimization moves in fold\_constraints protocol also if no constraints present
 Default: false

 **-seq\_sep\_stages** \<RealVector\>   
give vector with sequence\_separation after stage1, stage3 and stage4
 Default: 0

 **-reramp\_cst\_cycles** \<Integer\>   
in stage2 do xxx cycles where atom\_pair\_constraint is ramped up
 Default: 0

 **-reramp\_start\_cstweight** \<Real\>   
drop cst\_weight to this value and ramp to 1.0 in stage2 – needs reramp\_cst\_cycles \> 0
 Default: 0.01

 **-reramp\_iterations** \<Integer\>   
do X loops of annealing cycles
 Default: 1

 **-skip\_on\_noviolation\_in\_stage1** \<Boolean\>   
if constraints report no violations — skip cycles
 Default: false

 **-stage1\_ramp\_cst\_cycle\_factor** \<Real\>   
spend x\*\<standard cycles\>=""\> on each step of sequence separation
 Default: 0.25

 **-stage2\_constraint\_threshold** \<Real\>   
stop runs that violate this threshold at end of stage2
 Default: 0

 **-ignore\_sequence\_seperation** \<Boolean\>   
usually constraints are switched on according to their separation in the fold-tree
 Default: false

 **-no\_recover\_low\_at\_constraint\_switch** \<Boolean\>   
dont recover low when max\_seq\_sep is increased
 Default: false

 **-ramp\_coord\_cst** \<Boolean\>   
ramp coord csts just like chainbreak-weights during fold-cst
 Default: false

-   -resample
    ---------

 **-resample** \<Boolean\>   
resample option group

 **-silent** \<File\>   
a silent file for decoys to restart sampling from
 Default: ""

 **-tag** \<String\>   
which decoy to select from silent file
 Default: ""

 **-stage1** \<Boolean\>   
if true restart after stage1, otherwise after stage2
 Default: false

 **-stage2** \<Boolean\>   
if true restart after stage1, otherwise after stage2
 Default: false

 **-jumps** \<Boolean\>   
if true restart after stage1, otherwise after stage2
 Default: false

 **-min\_max\_start\_seq\_sep** \<RealVector\>   
range of (random) start values for seq-separation
 Default: 0

-   -loopfcst
    ---------

 **-loopfcst** \<Boolean\>   
loopfcst option group

 **-coord\_cst\_weight** \<Real\>   
use coord constraints for template
 Default: 0.0

 **-coord\_cst\_all\_atom** \<Boolean\>   
use coord constraints on all atoms and not just CA
 Default: false

 **-use\_general\_protocol** \<Boolean\>   
use the new machinery around classes KinematicXXX
 Default: false

 **-coord\_cst\_weight\_array** \<File\>   
use these weights (per seqpos) for coord cst in rigid regions
 Default: ""

 **-dump\_coord\_cst\_weight\_array** \<File\>   
dump these weights (per seqpos) for coord cst in rigid regions
 Default: ""

-   -jumps
    ------

 **-jumps** \<Boolean\>   
jumps option group

 **-evaluate** \<Boolean\>   
evaluate N-CA-C gemoetry for all jumps in the fold-tree
 Default: false

 **-extra\_frags\_for\_ss** \<File\>   
use ss-def from this fragset
 Default: ""

 **-fix\_chainbreak** \<Boolean\>   
minimize to fix ccd in re-runs
 Default: false

 **-fix\_jumps** \<File\>   
read jump\_file
 Default: ""

 **-jump\_lib** \<File\>   
read jump\_library\_file for automatic jumps
 Default: ""

 **-loop\_definition\_from\_file** \<File\>   
use ss-def from this file
 Default: ""

 **-no\_chainbreak\_in\_relax** \<Boolean\>   
dont penalize chainbreak in relax
 Default: false

 **-pairing\_file** \<File\>   
file with pairings
 Default: ""

 **-random\_sheets** \<IntegerVector\>   
random sheet topology–\> replaces -sheet1 -sheet2 ... select randomly up to N sheets with up to -sheet\_i pairgins for sheet i
 Default: 1

 **-residue\_pair\_jump\_file** \<File\>   
a file to define residue pair jump
 Default: ""

 **-sheets** \<IntegerVector\>   
sheet topology–\> replaces -sheet1 -sheet2 ... -sheetN
 Default: 1

 **-topology\_file** \<File\>   
read a file with topology info ( PairingStats )
 Default: ""

 **-bb\_moves** \<Boolean\>   
Apply bb\_moves ( wobble, small, shear) during stage3 and stage 4.
 Default: false

 **-no\_wobble** \<Boolean\>   
Don t apply the useless wobble during stage3 and stage 4.
 Default: false

 **-no\_shear** \<Boolean\>   
Don t apply the useless shear during stage3 and stage 4.
 Default: false

 **-no\_sample\_ss\_jumps** \<Boolean\>   
sample jump-frags during folding
 Default: false

 **-invrate\_jump\_move** \<Integer\>   
give 5 here to have 5 torsion moves for each jump move
 Default: 10

 **-chainbreak\_weight\_stage1** \<Real\>   
the weight on chainbreaks
 Default: 1.0

 **-chainbreak\_weight\_stage2** \<Real\>   
the weight on chainbreaks
 Default: 1.0

 **-chainbreak\_weight\_stage3** \<Real\>   
the weight on chainbreaks
 Default: 1.0

 **-chainbreak\_weight\_stage4** \<Real\>   
the weight on chainbreaks
 Default: 1.0

 **-ramp\_chainbreaks** \<Boolean\>   
ramp up the chainbreak weight stage1-0, stage2 0.25, stage3 alternating 0.5..2.5, stage4 2.5..4
 Default: true

 **-increase\_chainbreak** \<Real\>   
multiply ramped chainbreak weight by this amount
 Default: 1.0

 **-overlap\_chainbreak** \<Boolean\>   
use the overlap chainbrak term in stage4
 Default: false

 **-sep\_switch\_accelerate** \<Real\>   
constraints and chainbreak depend on in-chain-separation. Accelerate their enforcement 1+num\_cuts()\*\<this\_factor\>
 Default: 0.4

 **-dump\_frags** \<Boolean\>   
dump jump\_fragments
 Default: false

 **-njumps** \<Integer\>   
number\_of\_jumps to select from library for each trajectory (membrane mode)
 Default: 1

 **-max\_strand\_gap\_allowed** \<Integer\>   
merge strands if they less than X residues but same register
 Default: 2

 **-contact\_score** \<Real\>   
the strand-weight will have a weight \* contact\_order component
 Default: 0.0

 **-filter\_templates** \<Boolean\>   
filter hybridization protocol templates
 Default: false

-   -templates
    ----------

 **-templates** \<Boolean\>   
templates option group

 **-config** \<File\>   
read a list of templates and alignments
 Default: "templates.dat"

 **-fix\_aligned\_residues** \<Boolean\>   
pick only from template fragments and then keep these residues fixed
 Default: false

 **-fix\_frag\_file** \<File\>   
fragments from this file are picked once in beginning and then kept fixed
 Default: ""

 **-fix\_margin** \<Integer\>   
keep n residues at edges of fixed fragments moveable
 Default: 1

 **-min\_nr\_large\_frags** \<Integer\>   
how many large fragments should be present
 Default: 100000

 **-min\_nr\_small\_frags** \<Integer\>   
how many small fragments should be present
 Default: 100000

 **-no\_pick\_fragments** \<Boolean\>   
no further fragment picking from templates
 Default: false

 **-nr\_large\_copies** \<Integer\>   
make N copies of each picked template fragment – a hacky way to weight them
 Default: 4

 **-nr\_small\_copies** \<Integer\>   
make N copies of each picked template fragment – a hacky way to weight them
 Default: 20

 **-pairings** \<Boolean\>   
use pairings from templates
 Default: false

 **-pick\_multiple\_sizes** \<Boolean\>   
pick 9mers, 18mers and 27mers
 Default: false

 **-strand\_constraint** \<Boolean\>   
use the template-based strand-constraints
 Default: false

 **-vary\_frag\_size** \<Boolean\>   
pick fragments as long as aligned regions
 Default: false

 **-no\_culling** \<Boolean\>   
dont throw out constraints that are violated by other templates
 Default: false

 **-helix\_pairings** \<File\>   
file with list of pairings that are enforced (pick jumps from templates with H)
 Default: ""

 **-prefix** \<File\>   
path for config directory – applied to all filenames in template\_config\_file
 Default: ""

 **-change\_movemap** \<Integer\>   
stage in which movemap is switched to allow all bb-residues to move, valid stages: 3..4 (HACK)
 Default: 3

 **-force\_native\_topology** \<Boolean\>   
force the native toplogy (geometries from templates)
 Default: false

 **-topology\_rank\_cutoff** \<Real\>   
select jumps from all topologies with a higher relative score than if 1.0 take top 5
 Default: 1.0

 **-min\_frag\_size** \<Integer\>   
smallest fragment picked from aligned template regions
 Default: 6

 **-max\_shrink** \<Integer\>   
pick fragments up to max\_shrink smaller than aligned regions
 Default: 0

 **-shrink\_step** \<Integer\>   
shrink\_step 5 , eg., 27mer 22mer 17mer
 Default: 5

 **-shrink\_pos\_step** \<Integer\>   
distance between start pos in shrinked fragments
 Default: 5

 **-min\_padding** \<Integer\>   
minimum space between fragment and gap
 Default: 0

 **-min\_align\_pos** \<Integer\>   
ignore aligned residues before this position
 Default: 0

 **-max\_align\_pos** \<Integer\>   
ignore aligned residues after this position
 Default: -1

-   ### -templates:cst

 **-cst** \<Boolean\>   
cst option group

 **-topN** \<Integer\>   
topN ranking models are used for constraints ( culling and source )
 Default: 0

 **-wTopol** \<Real\>   
weight for beta-pairing topology score in ranking
 Default: 0.5

 **-wExtern** \<Real\>   
weight for external score ( column in template\_config\_file, e.g, svn-score
 Default: 0.5

-   ### -templates:fragsteal

 **-fragsteal** \<Boolean\>   
fragsteal option group

 **-topN** \<Integer\>   
topN ranking models are used for fragment stealing
 Default: 0

 **-wTopol** \<Real\>   
weight for beta-pairing topology score in ranking
 Default: 0.5

 **-wExtern** \<Real\>   
weight for external score ( column in template\_config\_file, e.g, svn-score
 Default: 0.5

-   -abrelax
    --------

 **-abrelax** \<Boolean\>   
ab initio relax mode

 **-filters** \<Boolean\>   

 **-fail\_unclosed** \<Boolean\>   
structures which don't close loops are reported as FAIL\_DO\_NOT\_RETRY
 Default: false

-   -chemical
    ---------

 **-chemical** \<Boolean\>   
chemical option group

 **-exclude\_patches** \<StringVector\>   
Names of the residue-type-set patches which should not be applied; if you know which patches you do not need for a particular run, this flag can reduce your memory use

 **-include\_patches** \<StringVector\>   
Names of the residue-type-set patches which should be applied even if excluded/commented out in patches.txt; useful for testing non-default patches

 **-enlarge\_H\_lj** \<Boolean\>   
Use larger LJ\_WDEPTH for Hs to avoid RNA clashes
 Default: false

 **-add\_atom\_type\_set\_parameters** \<StringVector\>   
Additional AtomTypeSet extra-parameter files that should be read; format is a sequence of paired strings: \<atom-type-set-tag1\> \<filename1\> \<atom-type-set-tag2\> \<filename2\> ...

 **-set\_atom\_properties** \<StringVector\>   
Modify atom properties (the ones in \<atom-set\>/atom\_properties.txt) from the command line. Happens at time of AtomTypeSet creation inside ChemicalManager.cc. Format is: -chemical:set\_atom\_properties \<atom-set1\>:\<atom\_name1\>:\<param1\>:\<setting1\> \<atom-set2\>:\<atom2\>:\<param2\>:\<setting2\> ... For example: '-chemical:set\_atom\_properties fa\_standard:OOC:LK\_DGFREE:-5 fa\_standard:ONH2:LJ\_RADIUS:0.5'

-   -score
    ------

 **-score\_pose\_cutpoint\_variants** \<Boolean\>   
Include cutpoint variants in the pose during linear chainbreak
 Default: false

 **-score** \<Boolean\>   
scorefunction option group

 **-weights** \<String\>   
Name of weights file (without extension .wts)
 Default: "talaris2013"

 **-set\_weights** \<StringVector\>   
Modification to weights via the command line. Applied in ScoreFunctionFactory::create\_score\_function inside the function apply\_user\_defined\_reweighting\_. Format is a list of paired strings: -score::set\_weights \<score\_type1\> \<setting1\> \<score\_type2\> \<setting2\> ...

 **-pack\_weights** \<String\>   
Name of packing weights file (without extension .wts)
 Default: "talaris2013"

 **-soft\_wts** \<String\>   
Name of the 'soft' weights file, for protocols which use it.
 Default: "soft\_rep"

 **-docking\_interface\_score** \<Boolean\>   
the score is computed as difference between bound and unbound pose
 Default: false

 **-min\_score\_score** \<Real\>   
do not consider scores lower than min-score in monte-carlo criterion
 Default: 0.0

 **-custom\_atom\_pair** \<String\>   
filename for custom atom pair constraints
 Default: "empty"

 **-patch** \<FileVector\>   
Name of patch file (without extension)
 Default: ""

 **-empty** \<Boolean\>   
Make an empty score - i.e. NO scoring

 **-fa\_max\_dis** \<Real\>   
How far does the FA pair potential go out to ?
 Default: 6.0

 **-fa\_Hatr** \<Boolean\>   
Turn on Lennard Jones attractive term for hydrogen atoms

 **-no\_smooth\_etables** \<Boolean\>   
Revert to old style etables

 **-etable\_lr** \<Real\>   
lowers energy well at 6.5A

 **-no\_lk\_polar\_desolvation** \<Boolean\>   
Disable the polar-desolvation component of the LK solvation model; effectively set dGfree for polar atoms to 0

 **-input\_etables** \<String\>   
Read etables from files with given prefix

 **-output\_etables** \<String\>   
Write out etables to files with given prefix

 **-analytic\_etable\_evaluation** \<Boolean\>   
Instead of interpolating between bins, use an analytic evaluation of the lennard-jones and solvation energis
 Default: true

 **-rms\_target** \<Real\>   
Target of RMS optimization for RMS\_Energy EnergyMethod
 Default: 0.0

 **-ramaneighbors** \<Boolean\>   
Uses neighbor-dependent ramachandran maps
 Default: false

 **-optH\_weights** \<String\>   
Name of weights file (without extension .wts) to use during optH

 **-optH\_patch** \<String\>   
Name of weights file (without extension .wts) to use during optH

 **-hbond\_params** \<String\>   
Directory name in the database for which hydrogen bond parameters to use.
 Default: "sp2\_elec\_params"

 **-hbond\_disable\_bbsc\_exclusion\_rule** \<Boolean\>   
Disable the rule that protein bb/sc hbonds are excluded if the backbone group is already forming a hydrogen bond to a backbone group; with this flag, no hbonds are excluded
 Default: false

 **-symE\_units** \<Integer\>   
Number of symmetric Units in design for use with symE scoring
 Default: -1

 **-symE\_bonus** \<Real\>   
Energy bonus per match for use with symE scoring
 Default: 0.0

 **-NV\_lbound** \<Real\>   
Lower Bound for neighbor Vector scoring
 Default: 3.3

 **-NV\_ubound** \<Real\>   
Upper Bound for neighbor Vector scoring
 Default: 11.1

 **-NV\_table** \<String\>   
Location of path to potential lookup table
 Default: "scoring/score\_functions/NV/neighbor\_vector\_score.histogram"

 **-disable\_orientation\_dependent\_rna\_ch\_o\_bonds** \<Boolean\>   
Do not use orientation-dependent potential for RNA carbon hydrogen bonds
 Default: false

 **-rna\_torsion\_potential** \<String\>   
In RNA torsion calculation, directory containing 1D torsional potentials
 Default: "BLAHBLAHBLAH"

 **-rna\_torsion\_skip\_chainbreak** \<Boolean\>   
Don't score RNA torsions located at the chain\_breaks (aside from the ones that will be closed)
 Default: true

 **-rna\_chemical\_shift\_exp\_data** \<String\>   
rna\_chemical\_shift\_exp\_data
 Default: ""

 **-rna\_chemical\_shift\_H5\_prime\_mode** \<String\>   
rna\_chemical\_shift\_H5\_prime\_mode
 Default: ""

 **-rna\_chemical\_shift\_include\_res** \<IntegerVector\>   
rna\_chemical\_shift\_include\_res

 **-use\_2prime\_OH\_potential** \<Boolean\>   
Use torsional potential for RNA 2prime OH.
 Default: true

 **-include\_neighbor\_base\_stacks** \<Boolean\>   
In RNA score calculation, include stacks between i,i+1
 Default: false

 **-find\_neighbors\_3dgrid** \<Boolean\>   
Use a 3D lookup table for doing neighbor calculations. For spherical, well-distributed conformations, O(N) neighbor detection instead of general O(NlgN)
 Default: false

 **-find\_neighbors\_stripehash** \<Boolean\>   
should be faster than 3dgrid and use 1/8th the memory
 Default: false

 **-seqdep\_refene\_fname** \<String\>   
Filename for table containing sequence-dependent reference energies

 **-secondary\_seqdep\_refene\_fname** \<String\>   
Additional filename for table containing sequence-dependent reference energies

 **-exact\_occ\_pairwise** \<Boolean\>   
When using occ\_sol\_exact, compute energies subject to pairwise additivity (not recommended - intended for parameterization / evaluation purposes)
 Default: false

 **-exact\_occ\_skip\_Hbonders** \<Boolean\>   
When using occ\_sol\_exact, do not count contributions from occluding groups which form Hbonds to the polar group of interest
 Default: true

 **-exact\_occ\_include\_Hbond\_contribution** \<Boolean\>   
When using occ\_sol\_exact, include Hbonds in the solvation energy
 Default: false

 **-exact\_occ\_pairwise\_by\_res** \<Boolean\>   
When using occ\_sol\_exact, compute energies subject to by-residue pairwise additivity (not recommended - intended for parameterization / evaluation purposes)
 Default: false

 **-exact\_occ\_split\_between\_res** \<Boolean\>   
When using occ\_sol\_exact with the exact\_occ\_pairwise flag, split the energies between both contributing residues instead of assigning it just to the polar residue (not recommended - intended for parameterization / evaluation purposes)
 Default: false

 **-exact\_occ\_self\_res\_no\_occ** \<Boolean\>   
Setting this to false means that the self-residue CAN occlude when using the exact ODO model, leading to potential double-counting with the Dunbrack energy but better results in loop discrimination.
 Default: false

 **-exact\_occ\_radius\_scaling** \<Real\>   
When using occ\_sol\_exact, scale the radii of occluding atoms by this factor (intended for parameterization / evaluation purposes)
 Default: 1.0

 **-ref\_offsets** \<StringVector\>   
offset reference energies using 3 character residue types (example: TRP 0.9 HIS 0.3)

 **-output\_residue\_energies** \<Boolean\>   
Output the energy for each residue
 Default: false

 **-fa\_custom\_pair\_distance\_file** \<String\>   
Name of custom pair distance energy file
 Default: ""

 **-disulf\_matching\_probe** \<Real\>   
Size of probe to use in disulfide matching score
 Default: 2.5

 **-bonded\_params** \<RealVector\>   
Default spring constants for bonded parameters [length,angle,torsion,proton-torsion,improper-torsion]

 **-bonded\_params\_dir** \<String\>   
Spring constants for bonded parameters [length,angle,torsion,proton-torsion,improper-torsion]
 Default: "scoring/score\_functions/bondlength\_bondangle"

 **-extra\_improper\_file** \<String\>   
Add extra parameters for improper torsions

 **-pro\_close\_planar\_constraint** \<Real\>   
stdev of CD,N,CA,prevC trigonal planar constraint in pro\_close energy method
 Default: 0.1

 **-linear\_bonded\_potential** \<Boolean\>   
use linear (instead of quadratic) bonded potential
 Default: false

 **-geom\_sol\_correct\_acceptor\_base** \<Boolean\>   
Fixed definition of base atom for acceptors to match hbonds\_geom
 Default: true

 **-free\_sugar\_bonus** \<Real\>   
Amount to reward virtualization of a sugar/ribose
 Default: -1.0

 **-syn\_G\_potential\_bonus** \<Real\>   
Amount to reward syn chi conformation of guanosine
 Default: 0.0

 **-pack\_phosphate\_penalty** \<Real\>   
Amount to penalize instantiation of a 5' or 3' phosphate
 Default: 0.25

 **-rg\_local\_span** \<IntegerVector\>   
First,last res in rg\_local. For example to calc rg\_local from 1-20 would be 1,20
 Default: 0

 **-unmodifypot** \<Boolean\>   
Do not call modify pot to add extra repulsive interactions between Obb/Obb atom types at distances beneath 3.6 Angstroms

-   ### -score:saxs

 **-saxs** \<Boolean\>   
saxs option group

 **-min\_score** \<Real\>   
minimum value of saxs score; the parameter is used to flatten the energy funnel around its minimum
 Default: -5

 **-custom\_ff** \<String\>   
Name of config file providing extra from factors
 Default: ""

 **-print\_i\_calc** \<String\>   
File to optionally write scaled computed spectra
 Default: ""

 **-ref\_fa\_spectrum** \<File\>   
reads reference full-atom spectrum from a file

 **-ref\_cen\_spectrum** \<File\>   
reads reference centroid spectrum from a file

 **-ref\_spectrum** \<File\>   
reads reference spectrum from a file

 **-ref\_pddf** \<File\>   
reads reference pairwise distance distribution function

 **-skip\_hydrogens** \<Boolean\>   
skip hydrogen atoms
 Default: false

 **-d\_min** \<Real\>   
minimum value of distance used in PDDF score evaluation (in [A])
 Default: 5.0

 **-d\_max** \<Real\>   
maximum value of distance used in PDDF score evaluation (in [A])
 Default: 100.0

 **-d\_step** \<Real\>   
step of distance used in PDDF score evaluation (in [A])
 Default: 0.1

 **-q\_min** \<Real\>   
minimum value of q used in spectra calculations (in [A\^-1])
 Default: 0.01

 **-q\_max** \<Real\>   
maximum value of q used in spectra calculations (in [A\^-1])
 Default: 0.25

 **-q\_step** \<Real\>   
step of q used in spectra calculations (in [A\^-1])
 Default: 0.01

 **-fit\_pddf\_area** \<Boolean\>   
PDDF curve for a scored pose will be normalized to match the area under the reference PDDF curve
 Default: false

-   -score
    ------

 **-sidechain\_buried** \<IntegerVector\>   
count buried residues (rvernon pilot app)
 Default: -1

 **-sidechain\_exposed** \<IntegerVector\>   
count exposed residues (rvernon pilot app)
 Default: -1

 **-elec\_min\_dis** \<Real\>   
changes the minimum distance cut-off for hack-elec energy
 Default: 1.6

 **-elec\_max\_dis** \<Real\>   
changes the maximum distance cut-off for hack-elec energy
 Default: 5.5

 **-elec\_die** \<Real\>   
changes the dielectric constant for hack-elec energy
 Default: 10.0

 **-elec\_r\_option** \<Boolean\>   
changes the dielectric from distance dependent to distance independent
 Default: false

 **-intrares\_elec\_correction\_scale** \<Real\>   
Intrares elec scaling factor for free DOF atoms
 Default: 0.05

 **-smooth\_fa\_elec** \<Boolean\>   
Smooth the discontinuities in the elec energy function using a sigmoidal term
 Default: true

 **-facts\_GBpair\_cut** \<Real\>   
GBpair interaction distance cutoff (same as elec\_max\_dis)
 Default: 10.0

 **-facts\_kappa** \<Real\>   
GBpair interaction screening factor
 Default: 12.0

 **-facts\_asp\_patch** \<Integer\>   
AtomicSolvationParameter set for nonpolar interaction in FACTS
 Default: 3

 **-facts\_plane\_to\_self** \<Boolean\>   
Add atoms in same plane to self energy pairs
 Default: true

 **-facts\_saltbridge\_correction** \<Real\>   
FACTS Self energy parameter scaling factor for polarH
 Default: 1.0

 **-facts\_dshift** \<RealVector\>   
FACTS pair term denominator distance shift[bb/bbsc/scsc/saltbridge]
 Default: ['0.0', '1.5', '1.5', '1.5']

 **-facts\_die** \<Real\>   
FACTS dielectric constant
 Default: 1.0

 **-facts\_binding\_affinity** \<Boolean\>   
Activate FACTS options for binding affinity calculation
 Default: false

 **-facts\_intrascale\_by\_level** \<Boolean\>   
Apply internal scaling by path\_dist to CA? (definition below becomes G/D/E/Z/\>Z
 Default: false

 **-facts\_intbb\_elec\_scale** \<RealVector\>   
FACTS Coulomb scale for intrares bonded pairs: [1-4, 1-5, \>1-5]
 Default: ['0.0', '0.2', '0.0']

 **-facts\_intbb\_solv\_scale** \<RealVector\>   
FACTS GB scale for intrares bb-bb bonded pairs: [1-4, 1-5, \>1-5]
 Default: ['0.4', '0.4', '0.0']

 **-facts\_adjbb\_elec\_scale** \<RealVector\>   
FACTS Coulomb scale for adjacent bb-bb bonded pairs: [1-4, 1-5, 1-6, 2res-coupled, 1res-decoupled]
 Default: ['0.0', '0.2', '1.0', '0.5', '0.5']

 **-facts\_adjbb\_solv\_scale** \<RealVector\>   
FACTS GB scale for adjacent bb-bb bonded pairs: [1-4, 1-5, 1-6, 2res-coupled, 1res-decoupled]
 Default: ['0.0', '0.2', '1.0', '0.5', '0.5']

 **-facts\_intbs\_elec\_scale** \<RealVector\>   
FACTS Coulomb scale for intrares bb-sc bonded pairs: [1-4, 1-5, 1-6, \>1-6, dumm]
 Default: ['0.2', '0.2', '0.2', '0.2', '0.0']

 **-facts\_intbs\_solv\_scale** \<RealVector\>   
FACTS GB scale for intrares bb-sc bonded pairs: [1-4, 1-5, 1-6, \>1-6, dumm]
 Default: ['1.0', '0.6', '0.6', '0.6', '0.0']

 **-facts\_adjbs\_elec\_scale** \<RealVector\>   
FACTS Coulomb scale for adjacent bb-sc bonded pairs: [1-4, 1-5, 1-6, 1-7, \>1-7]
 Default: ['0.0', '0.2', '0.2', '0.2', '0.2']

 **-facts\_adjbs\_solv\_scale** \<RealVector\>   
FACTS GB scale for adjacent bb-sc bonded pairs: [1-4, 1-5, 1-6, 1-7, \>1-7]
 Default: ['1.0', '0.6', '0.6', '0.6', '0.6']

 **-facts\_intsc\_elec\_scale** \<RealVector\>   
FACTS Coulomb scale for intrares sc-sc pairs: [1-4, 1-5, \>1-5]
 Default: ['0.0', '0.0', '0.0']

 **-facts\_intsc\_solv\_scale** \<RealVector\>   
FACTS GB scale for intrares sc-sc pairs: [1-4, 1-5, \>1-5]
 Default: ['1.0', '0.0', '0.0']

 **-facts\_charge\_dir** \<String\>   
directory where residue topology files for FACTS charge are stored
 Default: "scoring/score\_functions/facts"

 **-facts\_eff\_charge\_dir** \<String\>   
directory where residue topology files for FACTS charge are stored
 Default: "scoring/score\_functions/facts/eff"

 **-facts\_plane\_aa** \<StringVector\>   
AAs to apply plane rule

 **-facts\_eq\_type** \<String\>   
FACTS equation type
 Default: "exact"

 **-length\_dep\_srbb** \<Boolean\>   
Enable helix-length-dependent sr backbone hbonds
 Default: false

 **-ldsrbb\_low\_scale** \<Real\>   
Helix-length-dependent scaling at minlength.
 Default: 0.5

 **-ldsrbb\_high\_scale** \<Real\>   
Helix-length-dependent scaling at maxlength.
 Default: 2.0

 **-ldsrbb\_minlength** \<Integer\>   
Helix-length-dependent scaling minlength.
 Default: 4

 **-ldsrbb\_maxlength** \<Integer\>   
Helix-length-dependent scaling maxlength.
 Default: 17

 **-nmer\_ref\_energies** \<String\>   
nmer ref energies database filename

 **-nmer\_ref\_energies\_list** \<String\>   
list of nmer ref energies database filenames

 **-nmer\_pssm** \<String\>   
nmer pssm database filename

 **-nmer\_pssm\_list** \<String\>   
list of nmer pssm database filenames

 **-nmer\_pssm\_scorecut** \<Real\>   
nmer pssm scorecut gate for ignoring lowscore nmers
 Default: 0.0

 **-nmer\_svm** \<String\>   
nmer svm filename (libsvm)

 **-nmer\_svm\_list** \<String\>   
list of nmer svm filenames (libsvm)

 **-nmer\_svm\_scorecut** \<Real\>   
nmer svm scorecut gate for ignoring lowscore nmers
 Default: 0.0

 **-nmer\_svm\_aa\_matrix** \<String\>   
nmer svm sequence encoding matrix filename

 **-nmer\_svm\_term\_length** \<Integer\>   
how many up/dnstream res to avg and incl in svm sequence encoding
 Default: 3

 **-nmer\_svm\_pssm\_feat** \<Boolean\>   
add pssm features to svm encoding?
 Default: true

 **-nmer\_ref\_seq\_length** \<Integer\>   
length of nmers in nmer\_ref score
 Default: 9

 **-just\_calc\_rmsd** \<Boolean\>   
In rna\_score, just calculate rmsd – do not replace score.
 Default: false

-   -ProQ
    -----

 **-ProQ** \<Boolean\>   
ProQ option group

 **-svmmodel** \<Integer\>   
SVM model to use (in cross-validation, default is to use all [1-5])
 Default: 1

 **-basename** \<String\>   
basename location for sequence specific inputfile)
 Default: ""

 **-membrane** \<Boolean\>   
use membrane version (ProQM)
 Default: false

 **-prof\_bug** \<Boolean\>   
reproduce the profile bug in ProQres
 Default: false

 **-output\_feature\_vector** \<Boolean\>   
outputs the feature vector
 Default: false

 **-output\_local\_prediction** \<Boolean\>   
outputs the local predicted values
 Default: false

 **-prefix** \<String\>   
prefix for outputfiles)
 Default: ""

 **-use\_gzip** \<Boolean\>   
gzip output files
 Default: false

 **-normalize** \<Real\>   
Normalizing factor (usually target sequence length)
 Default: 1.0

-   -corrections
    ------------

 **-corrections** \<Boolean\>   
corrections option group

 **-beta** \<Boolean\>   
use beta score function
 Default: false

 **-correct** \<Boolean\>   
turn on default corrections:-corrections::chemical:icoor\_05\_2009-corrections::score:p\_aa\_pp scoring/score\_functions/P\_AA\_pp/P\_AA\_pp\_08.2009-corrections::score:p\_aa\_pp\_nogridshift-corrections::score:p\_aa\_pp\_nogridshift-corrections::score:rama\_not\_squared-corrections::score:rama\_map scoring/score\_functions/rama/Rama.10.2009.yfsong.dat-scoring::hbond\_params helix\_hb\_06\_2009-corrections::score:hbond\_fade 1.9 2.3 2.3 2.6 0.3 0.7 0.0 0.05-corrections::score:ch\_o\_bond\_potential scoring/score\_functions/carbon\_hbond/ch\_o\_bond\_potential\_near\_min\_yf.dat
 Default: false

 **-hbond\_sp2\_correction** \<Boolean\>   
turn on the hbond Sp2 correction with a single flag use with sp2\_correction.wts. Note, these weight sets are chosen automatically by default. -score::hb\_sp2\_chipen -hb\_sp2\_BAH180\_rise 0.75 -hb\_sp2\_outer\_width 0.357 -hb\_fade\_energy -hbond\_measure\_sp3acc\_BAH\_from\_hvy -lj\_hbond\_hdis 1.75 -lj\_hbond\_OH\_donor\_dis 2.6 -hbond\_params sp2\_elec\_params -expand\_st\_chi2sampling -smooth\_fa\_elec -elec\_min\_dis 1.6 -elec\_r\_option false -chemical::set\_atom\_properties fa\_standard:ONH2:LK\_DGFREE:-5.85 fa\_standard:NH2O:LK\_DGFREE:-7.8 fa\_standard:Narg:LK\_DGFREE:-10.0 fa\_standard:OH:LK\_DGFREE:-6.70

 **-facts\_default** \<Boolean\>   
turn on default options for FACTS use with scorefacts.wts. Incompatible with hbond\_sp2\_correction option. -correct -lj\_hbond\_hdis 2.3 -lj\_hbond\_OH\_donor\_dis 3.4 -use\_bicubic\_interpolation -hbond\_params sp2\_elec\_params -hb\_sp2\_chipen -hbond\_measure\_sp3acc\_BAH\_from\_hby -facts\_GBpair\_cut 10.0 -facts\_min\_dis 1.5 -facts\_dshift 1.4 -facts\_die 1.0 -facts\_kappa 12.0 -facts\_asp\_patch 3 -facts\_intrares\_scale 0.4 -facts\_elec\_sh\_exponent 1.8
 Default: false

-   ### -corrections:score

 **-score** \<Boolean\>   
score option group

 **-bbdep\_omega** \<Boolean\>   
Enable phi-psi dependent omega

 **-bbdep\_bond\_params** \<Boolean\>   
Enable phi-psi dependent bondlengths and bondangles

 **-bbdep\_bond\_devs** \<Boolean\>   
Enable phi-psi dependent deviations for bondlengths and bondangles

 **-no\_his\_his\_pairE** \<Boolean\>   
Set pair term for His-His to zero

 **-no\_his\_DE\_pairE** \<Boolean\>   
Set pair term for His-Glu and His-Asp to zero

 **-hbond\_His\_Phil\_fix** \<Boolean\>   
Phil's fix on Histidine interaction angular dependence

 **-helix\_hb\_06\_2009** \<Boolean\>   
Helix backbone-backbone hbond potential with a different angular dependence

 **-use\_incorrect\_hbond\_deriv** \<Boolean\>   
Use deprecated hbond derivative calculation.
 Default: false

 **-p\_aa\_pp** \<String\>   
Name of scoring/score\_functions/P\_AA\_pp/P\_AA\_PP potential file (search in the local directory first, then look in the database)
 Default: "scoring/score\_functions/P\_AA\_pp/P\_AA\_pp"

 **-p\_aa\_pp\_nogridshift** \<Boolean\>   
the format of p\_aa\_pp changed from using i\*10+5 (5, 15, etc) to i\*10 (0,10,etc.) as grid points

 **-rama\_not\_squared** \<Boolean\>   
Rama potential calculated as input for both rama and rama2b. By default, the potential is square for (ram a+entropy) \> 1.0

 **-rama\_map** \<File\>   
Ramachandran file used by rama
 Default: "scoring/score\_functions/rama/Rama\_smooth\_dyn.dat\_ss\_6.4"

 **-cenrot** \<Boolean\>   
Use the Centroid Rotamer Model.
 Default: false

 **-dun10** \<Boolean\>   
Use the 2010 Dunbrack library instead of either the the 2002 library.
 Default: true

 **-dun10\_dir** \<String\>   
Name of dun10 dir
 Default: "rotamer/ExtendedOpt1-5"

 **-dun02\_file** \<String\>   
Name of dun02 input file
 Default: "rotamer/bbdep02.May.sortlib"

 **-ch\_o\_bond\_potential** \<String\>   
Name of ch\_o\_bond potential file (search in the local directory first, then look in the database)
 Default: "scoring/score\_functions/carbon\_hbond/ch\_o\_bond\_potential.dat"

 **-fa\_elec\_co\_only** \<Boolean\>   
Using only CO-CO interactions in fa\_elec\_bb\_bb
 Default: false

 **-lj\_hbond\_hdis** \<Real\>   
Lennard Jones sigma value for hatms, classically it's been at 1.95 but the average A-H distance for hydrogen bonding is 1.75 from crystal structures. (momeara)
 Default: 1.75

 **-lj\_hbond\_OH\_donor\_dis** \<Real\>   
Lennard Jones sigma value for O in OH donor groups. Classically it has been 3.0 but the average distances from crystal structurs is 2.6 (momeara)
 Default: 2.6

 **-score12prime** \<Boolean\>   
Restore to score funciton parameters to score12 parameters and have getScoreFuntion return with score12prime.wts. The score12prime.wts differs from standard.wts + score12.wts\_patch, in that the reference energies have been optimized with optE for sequence profile recovery
 Default: false

 **-hbond\_energy\_shift** \<Real\>   
The shift upwards (through addition) of the well depth for the hydrogen bond polynomials; this shift is applied before the weights are applied.
 Default: 0.0

 **-hb\_sp2\_BAH180\_rise** \<Real\>   
The rise from -0.5 for the BAH=180 value for the additive chi/BAH sp2 potential
 Default: 0.75

 **-hb\_sp2\_outer\_width** \<Real\>   
The width between the peak when CHI=0 and BAH=120 to when the BAH is at a maximum (Units: pi \* radians. E.g. 1/3 means the turn off hbonding when BAH \< 60, larger values mean a wider potential). Use 0.357 in conjunction with the hb\_energy\_fade flag.
 Default: 0.357

 **-hb\_sp2\_chipen** \<Boolean\>   
Experimental term for hydrogen bonds to sp2 acceptors: penalizes out-of-plane geometry by 67%
 Default: true

 **-hbond\_measure\_sp3acc\_BAH\_from\_hvy** \<Boolean\>   
If true, then the BAH angle for sp3 (aka hydroxyl) acceptors is measured donor-hydrogen–acceptor-heavyatom–heavyatom-base instead of donor-hydrogen–accptor-heavyatom–hydroxyl-hydrogen
 Default: true

 **-hb\_fade\_energy** \<Boolean\>   
Rather than having a strict cutoff of hbond definition at 0, fade the energy smoothly in the range [-0.1, 0.1]. This is necessary to prevent a discontinuity in the derivative when E=0 that arise because of the additive form of the hbond function.
 Default: true

 **-use\_bicubic\_interpolation** \<Boolean\>   
Instead of using bilinear interpolation to evaluate the Ramachandran, P\_AA\_pp and Dunbrack potentials, use bicubic interpolation. Avoids pile-ups at the grid boundaries where discontinuities in the derivatives frustrate the minimizer
 Default: true

 **-dun\_normsd** \<Boolean\>   
Use height-normalized guassian distributions to model p(chi|phi,psi) instead of height-unnormalized gaussians
 Default: false

 **-dun\_entropy\_correction** \<Boolean\>   
Add Shanon entropy correction to rotamer energy: E = -logP + S
 Default: false

-   ### -corrections:chemical

 **-chemical** \<Boolean\>   
chemical option group

 **-icoor\_05\_2009** \<Boolean\>   
New set of idealized coordinates for full atom, 05-2009

 **-parse\_charge** \<Boolean\>   
Use PARSE charge set.

 **-expand\_st\_chi2sampling** \<Boolean\>   
Ugly temporary hack. Expand the chi2 sampling for serine and threonine in the fa\_standard residue type set so that samples are taken every 20 degrees (instead of every 60 degrees. This will soon be changed in the SER and THR params files themselves. This flag can be used with any residue type set (including the pre-talaris fa\_standard version, and with the fa\_standard\_05.2009\_icoor version) but is unncessary for the talaris2013 version (currently named fa\_standard) as the expanded SER and THR sampling is already encoded in .params files for these two residues
 Default: false

-   -mistakes
    ---------

 **-mistakes** \<Boolean\>   
mistakes option group

 **-restore\_pre\_talaris\_2013\_behavior** \<Boolean\>   
Restore the set of defaults that were in place before the Talaris2013 parameters were made default. This is an umbrella flag and sets the following flags if they are not set on the command line to some other value -mistakes::chemical::pre\_talaris2013\_geometries true -corrections::score::dun10 false -corrections::score::use\_bicubic\_interpolation false -corrections::score:hb\_sp2\_chipen false -corrections::score::hb\_fade\_energy false -corrections::score::hbond\_measure\_sp3acc\_BAH\_from\_hvy false -corrections::score::lj\_hbond\_hdis 1.95 -corrections::score::lj\_hbond\_OH\_donor\_dis 3.0 -corrections::chemical::expand\_st\_chi2sampling false -score::weights pre\_talaris\_2013\_standard.wts -score::patch score12.wts\_patch -score::analytic\_etable\_evaluation false -score::hbond\_params score12\_params -score::smooth\_fa\_elec false -score::elec\_min\_dis 1.5 -chemical::set\_atom\_properties fa\_standard:ONH2:LK\_DGFREE:-10.0 fa\_standard:NH2O:LK\_DGFREE:-10.0 fa\_standard:Narg:LK\_DGFREE:-11.0 fa\_standard:OH:LK\_DGFREE:-6.77
 Default: false

-   ### -mistakes:chemical

 **-chemical** \<Boolean\>   
chemical option group

 **-pre\_talaris2013\_geometries** \<Boolean\>   
Use the version of the fa\_standard geometries that were active before the Talaris2013 parameters were taken as default
 Default: false

-   -willmatch
    ----------

 **-willmatch** \<Boolean\>   
willmatch option group

 **-arg\_dun\_th** \<Real\>   
fa\_dun thresh for ARG
 Default: 16.0

 **-asp\_dun\_th** \<Real\>   
fa\_dun thresh for ASP
 Default: 8.0

 **-glu\_dun\_th** \<Real\>   
fa\_dun thresh for GLU
 Default: 12.0

 **-lys\_dun\_th** \<Real\>   
fa\_dun thresh for LYS
 Default: 16.0

 **-usecache** \<Boolean\>   
use cached stage 1 data
 Default: false

 **-write\_reduced\_matchset** \<StringVector\>   
\<name\> \<pdb1\> \<pdb2\> ...

 **-interface\_size** \<Real\>   
num CB-CB within 8A
 Default: 30

 **-max\_dis\_any** \<Real\>   
 Default: 3.0

 **-max\_dis\_all** \<Real\>   
 Default: 2.6

 **-max\_dis\_hb** \<Real\>   
 Default: 3.2

 **-min\_dis\_hb** \<Real\>   
 Default: 2.2

 **-max\_dis\_hb\_colinear** \<Real\>   
 Default: 0.7

 **-max\_dis\_metal** \<Real\>   
 Default: 1.0

 **-max\_ang\_metal** \<Real\>   
 Default: 5.0

 **-clash\_dis** \<Real\>   
 Default: 3.5

 **-c2\_linker\_dist** \<Real\>   
 Default: 3.5

 **-identical\_match\_dis** \<Real\>   
 Default: 0.0001

 **-chi1\_increment** \<Real\>   
 Default: 10.0

 **-chi2\_increment** \<Real\>   
 Default: 20.0

 **-c2\_symm\_increment** \<Real\>   
 Default: 20.0

 **-cb\_sasa\_thresh** \<Real\>   
 Default: 20.0

 **-design\_interface** \<Boolean\>   
 Default: true

 **-chilist** \<File\>   

 **-fixed\_res** \<File\>   

 **-native1** \<File\>   

 **-native2** \<File\>   

 **-exclude\_res1** \<File\>   
 Default: ""

 **-exclude\_res2** \<File\>   
 Default: ""

 **-taglist** \<File\>   

 **-residues** \<IntegerVector\>   

 **-symmetry\_d2** \<Boolean\>   
 Default: false

 **-symmetry\_c2\_dock** \<Boolean\>   
 Default: false

 **-splitwork** \<IntegerVector\>   

 **-exclude\_ala** \<Boolean\>   
 Default: false

 **-match\_overlap\_dis** \<Real\>   
distance under which to consider matches redundant
 Default: 00.20

 **-match\_overlap\_ang** \<Real\>   
ang(deg) under which to consider matches redundant
 Default: 10.00

 **-forbid\_residues** \<IntegerVector\>   
disallow residues for matching

 **-poi** \<RealVector\>   
xyz coords of some site of interest

 **-poidis** \<Real\>   
poi distance threshold

 **-homodimer** \<Boolean\>   
examine only homodimer configs
 Default: false

 **-fa\_dun\_thresh** \<Real\>   
 Default: 6.0

-   -holes
    ------

 **-holes** \<Boolean\>   
holes option group

 **-dalphaball** \<File\>   
The DAlaphaBall\_surf program

 **-params** \<File\>   
File containing score parameters
 Default: "holes\_params.dat"

 **-h\_mode** \<Integer\>   
include H's or no... see PoseBalls.cc
 Default: 0

 **-water** \<Boolean\>   
include water or no
 Default: false

 **-make\_pdb** \<Boolean\>   
make pdb with scores
 Default: false

 **-make\_voids** \<Boolean\>   
do separate SLOW void calculation
 Default: false

 **-atom\_scores** \<Boolean\>   
output scores for all atoms
 Default: false

 **-residue\_scores** \<Boolean\>   
output scores for all residues (avg over atoms)
 Default: false

 **-cav\_shrink** \<Real\>   
Cavity ball radii reduced by this amount
 Default: 0.7

 **-minimize** \<String\>   
RosettaHoles params to use: decoy15, decoy25 or resl
 Default: "decoy15"

 **-debug** \<Boolean\>   
dump debug output
 Default: false

-   -packstat
    ---------

 **-packstat** \<Boolean\>   
packstat option group

 **-include\_water** \<Boolean\>   
Revert to old style etables
 Default: false

 **-oversample** \<Integer\>   
Precision of SASA measurements
 Default: 0

 **-packstat\_pdb** \<Boolean\>   
Output a pdb with packing visualizations
 Default: false

 **-surface\_accessibility** \<Boolean\>   
Compute extra cavity burial information
 Default: false

 **-residue\_scores** \<Boolean\>   
Output the score for each resdiue
 Default: false

 **-cavity\_burial\_probe\_radius** \<Real\>   
Radius probe to consider a cavity buried
 Default: 1.4

 **-raw\_stats** \<Boolean\>   
Output the raw stats per-residue (for training, etc...)
 Default: false

 **-threads** \<Integer\>   
Number of threads to use (0 for no threading)
 Default: 0

 **-cluster\_min\_volume** \<Real\>   
voids smaller than this will not be shown.
 Default: 30

 **-min\_surface\_accessibility** \<Real\>   
voids must be at least this exposed
 Default: -1.0

 **-min\_cluster\_overlap** \<Real\>   
void-balls must overlap by this much to be clustered
 Default: 0.1

 **-min\_cav\_ball\_radius** \<Real\>   
radius of smallest void-ball to consider
 Default: 0.7

 **-max\_cav\_ball\_radius** \<Real\>   
radius of largest void-ball to consider
 Default: 3.0

-   -crossmatch
    -----------

 **-crossmatch** \<Boolean\>   
crossmatch option group

 **-write\_reduced\_matchset** \<StringVector\>   
\<name\> \<pdb1\> \<pdb2\> ...

 **-interface\_size** \<Integer\>   
num CB-CB within 8A
 Default: 30

 **-max\_dis\_any** \<Real\>   
 Default: 3.0

 **-max\_dis\_all** \<Real\>   
 Default: 2.6

 **-max\_dis\_metal** \<Real\>   
 Default: 1.0

 **-clash\_dis** \<Real\>   
 Default: 3.0

 **-identical\_match\_dis** \<Real\>   
 Default: 0.0001

-   -smhybrid
    ---------

 **-smhybrid** \<Boolean\>   
smhybrid option group

 **-add\_cavities** \<Boolean\>   
output cavities in result pdbs
 Default: false

 **-abinitio\_design** \<Boolean\>   
do a design run in centroid mode
 Default: true

 **-fa\_refine** \<Boolean\>   
Do nobu's flxbb
 Default: true

 **-virtual\_nterm** \<Boolean\>   
remove Nterm
 Default: false

 **-debug** \<Boolean\>   
debug
 Default: false

 **-refine** \<Boolean\>   
don't do bit centroid moves
 Default: false

 **-filter** \<Boolean\>   
filter centroid results as you go
 Default: false

 **-floating\_scs\_rep** \<Boolean\>   
should floating scs repel those in other subunits?
 Default: false

 **-flxbb** \<Boolean\>   
allow bb moves in minimization
 Default: false

 **-centroid\_all\_val** \<Boolean\>   
mutate all to VAL in centroid mode
 Default: false

 **-subsubs\_attract** \<Boolean\>   
attract subsubs togeher
 Default: false

 **-linker\_cst** \<Boolean\>   
attract N/C termini for linker
 Default: false

 **-pseudosym** \<Boolean\>   
HACK pseudosymmetry
 Default: false

 **-design\_linker** \<Boolean\>   
allow design on added 'linker' residues
 Default: true

 **-design** \<Boolean\>   
allow design on added 'linker' residues
 Default: true

 **-restrict\_design\_to\_interface** \<Boolean\>   
allow design on added 'linker' residues
 Default: false

 **-restrict\_design\_to\_subsub\_interface** \<Boolean\>   
allow design on added 'linker' residues
 Default: false

 **-design\_hydrophobic** \<Boolean\>   
design all hydrophobic
 Default: false

 **-add\_metal\_at\_0** \<Boolean\>   
DEPRECATED
 Default: false

 **-nres\_mono** \<Integer\>   
target number of residues per monomer
 Default: 20

 **-abinitio\_cycles** \<Integer\>   
number of abinitio cycles
 Default: 10000

 **-primary\_subsubunit** \<Integer\>   
primary subunut
 Default: 1

 **-minbb** \<Integer\>   
level of bb min 0=None 1=little 2=all
 Default: 1

 **-switch\_concert\_sub** \<Integer\>   
assume prmary subsub is on this subunit for concerted RB moves
 Default: 1

 **-temperature** \<Real\>   
MC temp for cen fold
 Default: 2.0

 **-inter\_subsub\_cst** \<Boolean\>   
add dis csts inter-subsub
 Default: false

 **-rb\_mag** \<Real\>   
magnitude of rb moves
 Default: 1.0

 **-ss** \<String\>   
secondary structure
 Default: ""

 **-symm\_def\_template** \<File\>   
template for symmetry definition file

 **-symm\_def\_template\_reduced** \<File\>   
template for reduced symmetry definition file

 **-attach\_as\_sc** \<IntegerVector\>   
attach the group via side chain

 **-attach\_as\_sc\_sub** \<IntegerVector\>   
attach the group via side chain in this sub

 **-inversion\_subs** \<IntegerVector\>   
subunits to be inverted, if any

 **-chainbreaks** \<BooleanVector\>   
close chainbreak from this subsub to the next

 **-design\_res\_files** \<StringVector\>   
files containing designable residues for each component pose
 Default: ""

 **-fixed\_res\_files** \<StringVector\>   
files containing fixed residues (no repack even) for each component pose
 Default: ""

 **-frag\_res\_files** \<StringVector\>   
files containing residues ok to insert frags into. will have starting ss
 Default: ""

 **-scattach\_res\_files** \<StringVector\>   
files containing residues ok to scattach to.
 Default: ""

 **-rep\_edge\_files** \<StringVector\>   
files containing residues which are edge strands.
 Default: ""

 **-virtual\_res\_files** \<StringVector\>   
files containing residues that should be virtual
 Default: ""

 **-jumpcut\_files** \<StringVector\>   
file specifying jumps and cuts for subsubunits
 Default: ""

 **-cst\_sub\_files** \<StringVector\>   
file specifying which subunits are part of a structural unit and shoudl be constrained
 Default: ""

 **-symm\_file\_tag** \<StringVector\>   
label for each subunit
 Default: ""

 **-attach\_atom** \<StringVector\>   
attach atom on each subunit
 Default: ""

 **-add\_res\_before** \<StringVector\>   
SS to add before each subunit region
 Default: ""

 **-add\_res\_after** \<StringVector\>   
SS to add after each subunit region
 Default: ""

 **-add\_ss\_before** \<StringVector\>   
residues to add
 Default: ""

 **-add\_ss\_after** \<StringVector\>   
SS to add after each subunit region
 Default: ""

 **-add\_atom\_at\_cen** \<StringVector\>   
SS to add after each subunit region
 Default: ""

 **-attach\_rsd** \<StringVector\>   
attach rsd on each subunit
 Default: ""

-   -evolution
    ----------

 **-evolution** \<Boolean\>   
evolution option group

 **-parentlist** \<FileVector\>   
File(s) containing list(s) of Parent PDB files to process

 **-childlist** \<FileVector\>   
File(s) containing list(s) of Parent PDB files to process

 **-action** \<String\>   
One of the following: diversify, intensify
 Default: "diversify"

 **-rms\_threshold** \<Real\>   
RMS Clustering threshold
 Default: 3.5

 **-rms\_topmargin** \<Real\>   
RMS Clustering threshold
 Default: 5.0

 **-targetdir** \<String\>   
Write target new parent polulation to this directory !
 Default: "./"

 **-padding\_score\_filter** \<Real\>   
RMS Clustering threshold
 Default: 5.0

 **-padding\_stage2\_filter** \<Real\>   
RMS Clustering threshold
 Default: 15.0

-   -cluster
    --------

 **-cluster** \<Boolean\>   
cluster option group

 **-lite** \<Boolean\>   
uses light-weight method of outputting cluster-centers, useful for when there's a HUGE amount of data!
 Default: false

 **-input\_score\_filter** \<Real\>   
Only read in structures below a certain energy
 Default: 1000000.0

 **-output\_score\_filter** \<Real\>   
Only read in structures below a certain energy
 Default: 1000000.0

 **-exclude\_res** \<IntegerVector\>   
Residue numbers to be excluded from cluster RMS calculation
 Default: -1

 **-thinout\_factor** \<Real\>   
Ignore this fraction of decoys in the first round !
 Default: -1

 **-max\_cluster\_seeds** \<Integer\>   
Do not calculate initial cluster centers for more then this many structuers
 Default: 500

 **-radius** \<Real\>   
Cluster radius
 Default: 3.0

 **-limit\_cluster\_size** \<Integer\>   
For each cluster only retain top N
 Default: -1

 **-limit\_cluster\_size\_percent** \<Real\>   
0 to 1. For each cluster only retain top N %

 **-random\_limit\_cluster\_size\_percent** \<Real\>   
0 to 1. For each cluster only retain random N %

 **-limit\_clusters** \<Integer\>   
Only retain largest N clusters
 Default: 100

 **-limit\_total\_structures** \<Integer\>   
Only retain the first N structures (ordered by cluster number)
 Default: -1

 **-max\_total\_cluster** \<Integer\>   
Only ever make N clusters or less
 Default: 1000

 **-gdtmm** \<Boolean\>   
Cluster by gdtmm instead of RMS
 Default: false

 **-sort\_groups\_by\_energy** \<Boolean\>   
Sort clusters by energy
 Default: false

 **-sort\_groups\_by\_size** \<Boolean\>   
Sort clusters by energy
 Default: false

 **-remove\_singletons** \<Boolean\>   
Get rid of single-member clusters
 Default: false

 **-export\_only\_low** \<Boolean\>   
Print only the lowest energy member
 Default: false

 **-remove\_highest\_energy\_member** \<Boolean\>   
Remove highest energy member from each cluster
 Default: false

 **-idealize\_final\_structures** \<Boolean\>   
Run an idealization over the resulting structures
 Default: false

 **-limit\_dist\_matrix** \<Integer\>   
Only calculate full matrix for a subset of structres. Then simply assign structures to nearest cluster
 Default: -1

 **-make\_ensemble\_cst** \<Boolean\>   
Create a set of constraints describing the variablity in each cluster of each residue.
 Default: false

 **-hotspot\_hash** \<Boolean\>   
Cluster hotspot hashing results. Each input PDB must contain both the target and the newly docked hotspot (which should be the last residue in the pose).
 Default: false

 **-loops** \<Boolean\>   
Cluster the loop specified with the -loops:loop\_file option
 Default: false

 **-population\_weight** \<Real\>   
Order Clusters by (1-p)\*score - p\*size whpere p = population\_weight
 Default: 0.09

 **-template\_scores** \<String\>   
imple textfile containing template names (in caps) and scores.

 **-K\_level** \<Integer\>   
Hierarchical cluster level number
 Default: 1

 **-K\_radius** \<RealVector\>   
Radius list of different level of cluster
 Default: utility::vector1\<float\>(1, 2.0)

 **-K\_n\_cluster** \<IntegerVector\>   
How many clusters in each level
 Default: utility::vector1\<int\>(1, 10000)

 **-K\_style** \<StringVector\>   
Which K-cluster engine to use
 Default: utility::vector1\<std::string\>(9, "GKC")

 **-K\_threshold** \<Real\>   
Threshold for test the convergence of iteration
 Default: 0.01

 **-K\_n\_sub** \<Integer\>   
Number of clusters in subdir
 Default: 100

 **-K\_deque\_size** \<Integer\>   
Size of subcluster deque
 Default: 20

 **-K\_deque\_level** \<Integer\>   
Provide deque in top level
 Default: 1

 **-K\_redundant** \<Boolean\>   
Keep all the higher level center structure in sub-pools
 Default: true

 **-K\_not\_fit\_xyz** \<Boolean\>   
Do not rotate xyz when calculate rmsd
 Default: false

 **-K\_save\_headers** \<Boolean\>   
Save headers in silent file
 Default: false

 **-score\_diff\_cut** \<Real\>   
score difference cut for RNA and SWA clustering
 Default: 1000000.0

 **-auto\_tune** \<Boolean\>   
autotune rmsd for clustering between 0.1A up to 2.0A, for SWA clusterer
 Default: false

-   -rescore
    --------

 **-rescore** \<Boolean\>   
rescore option group

 **-pose\_metrics** \<Boolean\>   
Do pose metrics calc

 **-assign\_ss** \<Boolean\>   
Invoke DSSP to assign secondary structure.
 Default: false

 **-skip** \<Boolean\>   
Dont actually call scoring function (i.e. get evaluators only)

 **-verbose** \<Boolean\>   
Full break down of weights, raw scores and weighted scores ?

 **-msms\_analysis** \<String\>   
Run MSMS on the structure and determine surface properties.

-   -mc
    ---

 **-mc** \<Boolean\>   
mc option group

 **-hierarchical\_pool** \<String\>   
specify prefix in order to look for hierarchical pool

 **-read\_structures\_into\_pool** \<File\>   
specify the silent-structs to create a hierarchy for lazy users

 **-convergence\_check\_frequency** \<Integer\>   
how often check for convergences in MC object?
 Default: 100

 **-known\_structures** \<File\>   
specify a filename of a silent-file containing known structures
 Default: "known\_structs.in"

 **-max\_rmsd\_against\_known\_structures** \<Real\>   
stop sampling if rmsd to a known-structure is lower than X
 Default: 1.5

 **-excluded\_residues\_from\_rmsd** \<IntegerVector\>   
residues that are not used for RMSD computation in pool

 **-heat\_convergence\_check** \<Integer\>   
jump out of current abinitio run if X unsuccesful mc-trials reached
 Default: 0

-   -batch\_relax
    -------------

 **-batch\_relax** \<Boolean\>   
batch\_relax option group

 **-batch\_size** \<Integer\>   
Size of batches - note that thsie affects memory usage significantly
 Default: 100

-   -relax
    ------

 **-relax** \<Boolean\>   
relax option group

 **-fast** \<Boolean\>   
Do a preset, small cycle number FastRelax

 **-thorough** \<Boolean\>   
Do a preset, large cycle number FastRelax

 **-membrane** \<Boolean\>   
Do membrane relax
 Default: false

 **-centroid\_mode** \<Boolean\>   
Use centroid relax protocol
 Default: false

 **-default\_repeats** \<Integer\>   
Default number of repeats done by FastRelax. Has no effect if a custom script is used!
 Default: 5

 **-dualspace** \<Boolean\>   
Do 3 FastRelax cycles of internal coordinate relax followed by two cycles of Cartesian relax - cart\_bonded energy term is required, pro\_close energy term should be turned off, and use of -relax::minimize\_bond\_angles is recommended

 **-ramady** \<Boolean\>   
Run ramady code which aleviates stuck bad ramachandran energies
 Default: false

 **-ramady\_rms\_limit** \<Real\>   
(ramady-only) Reject rama changes which perturb structure by more than this
 Default: 0.5

 **-ramady\_cutoff** \<Real\>   
(ramady-only) Cutoff at which a rama is considered bad
 Default: 2.0

 **-ramady\_max\_rebuild** \<Integer\>   
(ramady-only) The maximum number of bad ramas to fix per repack-min cycle
 Default: 1

 **-ramady\_force** \<Boolean\>   
(ramady-only) Force rebuilding of bad ramas (normal skip-rate = 10%)
 Default: false

 **-script** \<File\>   
Relax script file
 Default: ""

 **-script\_max\_accept** \<Integer\>   
Limit number of best accepts
 Default: 10000000

 **-superimpose\_to\_native** \<Boolean\>   
Superimpose input structure to native
 Default: false

 **-superimpose\_to\_file** \<File\>   
Superimpose input structure to file
 Default: "false"

 **-constrain\_relax\_to\_native\_coords** \<Boolean\>   
For relax and fastrelax, tether backbone coordinates of the pdbs being relaxed to the coordinates in the xtal native
 Default: false

 **-constrain\_relax\_to\_start\_coords** \<Boolean\>   
For relax and fastrelax, tether backbone coordinates of the pdbs being relaxed to the coordinates in the xtal native
 Default: false

 **-coord\_constrain\_sidechains** \<Boolean\>   
For relax and fastrelax, also tether sidechain heavy atom coordinates (requires either -constrain\_relax\_to\_native\_coords or -constrain\_relax\_to\_start\_coords)
 Default: false

 **-sc\_cst\_maxdist** \<Real\>   
Use distance constraints between pairs of input side-chains atoms which are closer than the given upper distance cutoff (0 =\> no sc-sc restraints)
 Default: 0.0

 **-limit\_aroma\_chi2** \<Boolean\>   
limit chi2 rotamer of PHE,TYR, and HIS around 90
 Default: false

 **-respect\_resfile** \<Boolean\>   
Tell FastRelax to respect the input resfile. Used mainly for doing design within FastRelax.
 Default: false

 **-bb\_move** \<Boolean\>   
allow backbone to move during relax
 Default: true

 **-chi\_move** \<Boolean\>   
allow sidechain to move during relax
 Default: true

 **-jump\_move** \<Boolean\>   
allow jump to move during relax
 Default: false

 **-dna\_move** \<Boolean\>   
allow dna to move during relax + allow DNA-DNA interactions. Best if used with orbitals scorefunction. DNA stays together with great molprobity results. Not recommended for general use at this time.
 Default: false

 **-fix\_omega** \<Boolean\>   
Fix omega angles during relax
 Default: false

 **-minimize\_bond\_lengths** \<Boolean\>   
Free bond length DOFs during relax for all atoms
 Default: false

 **-minimize\_bond\_angles** \<Boolean\>   
Free bond angle DOFs during relax for all atoms
 Default: false

 **-minimize\_bondlength\_subset** \<Integer\>   
Minimize only a subset of bondlengths 0 Default all bondlengths 1 backbone only 2 sidechain only 3 CA only (Ca-C,Ca-N and Ca-Cb)
 Default: 0

 **-minimize\_bondangle\_subset** \<Integer\>   
Minimize only a subset of bondlengths 0 Default all bondangles 1 backbone only 2 sidechain only 3 tau only 4 Ca-Cb only
 Default: 0

 **-min\_type** \<String\>   
minimizer to use during relax.
 Default: "dfpmin\_armijo\_nonmonotone"

 **-cartesian** \<Boolean\>   
Use Cartesian minimizer
 Default: false

 **-chainbreak\_weight** \<Real\>   
chainbreak weight
 Default: 0.0

 **-linear\_chainbreak\_weight** \<Real\>   
linear chainbreak weight
 Default: 0.0

 **-overlap\_chainbreak\_weight** \<Real\>   
overlap chainbreak weight
 Default: 0.0

 **-classic** \<Boolean\>   
Do very old classic relax ! This is a poor protocol - don't use it !

 **-sequence\_file** \<File\>   
Relax script file
 Default: ""

 **-quick** \<Boolean\>   
Do a preset, small cycle number FastRelax

 **-sequence** \<Boolean\>   
Do a preset, small cycle number FastRelax

 **-minirelax\_repeats** \<Integer\>   
 Default: 2

 **-minirelax\_sdev** \<Real\>   
tether on coordinate constraints for minirelax
 Default: 0.5

 **-wobblemoves** \<Boolean\>   
Do Wobble moves ?
 Default: false

 **-constrain\_relax\_segments** \<File\>   
loop definition file
 Default: ""

 **-coord\_cst\_width** \<Real\>   
Width on coordinate constraints from constrain\_relax\_\* options
 Default: 0.0

 **-coord\_cst\_stdev** \<Real\>   
Stdev on coordinate constraints from constrain\_relax\_\* options
 Default: 0.5

 **-ramp\_constraints** \<Boolean\>   
Ramp constraints during phase1 of relax from full to zero
 Default: false

 **-energycut** \<Real\>   
Rottrial energycut (per residue!)
 Default: 0.01

 **-mini** \<Boolean\>   
perform a relax that is only a minimization and repack.
 Default: false

 **-stage1\_ramp\_cycles** \<Integer\>   
Ramp cyclesin stage 1
 Default: 8

 **-stage1\_ramp\_inner\_cycles** \<Integer\>   
Inner cycles means how many small shear moves + rottrials
 Default: 1

 **-stage2\_repack\_period** \<Integer\>   
Full repack after how many cycles in stage 2
 Default: 100

 **-stage2\_cycles** \<Integer\>   
How many stage 2 cycles ? (by default its -1 means Nresidues\*4 )
 Default: -1

 **-min\_tolerance** \<Real\>   
Minimizer tolerance
 Default: 0.00025

 **-stage3\_cycles** \<Integer\>   
How many stage 3 cycles ? (by default its -1 means Nresidues )
 Default: -1

 **-cycle\_ratio** \<Real\>   
Post-multiplier for cycle numbers
 Default: 1.0

 **-filter\_stage2\_beginning** \<Real\>   
FArelax score filter
 Default: 99999999.00

 **-filter\_stage2\_quarter** \<Real\>   
FArelax score filter
 Default: 99999999.00

 **-filter\_stage2\_half** \<Real\>   
FArelax score filter
 Default: 99999999.00

 **-filter\_stage2\_end** \<Real\>   
FArelax score filter
 Default: 99999999.00

-   ### -relax:centroid

 **-centroid** \<Boolean\>   
centroid option group

 **-weights** \<String\>   
Weights to use for centroid minimization
 Default: "score4\_smooth\_cen\_relax"

 **-ramp\_vdw** \<Boolean\>   
Ramp up the VDW weight
 Default: true

 **-ramp\_rama** \<Boolean\>   
Ramp up the rama/rama2b weight
 Default: false

 **-parameters** \<String\>   
Database file for ramp/min parameter
 Default: "sampling/cen\_relax/default\_relax\_parameters.txt"

 **-do\_final\_repack** \<Boolean\>   
Repack sidechains in movemap after protocol if given a fullatom structure
 Default: false

 **-increase\_vdw\_radii** \<Boolean\>   
Increase BB vdw radii
 Default: false

-   -enzdes
    -------

 **-enzdes** \<Boolean\>   
enzdes option group

 **-checkpoint** \<String\>   
write/read checkpoint files to the desired filename.
 Default: ""

 **-enz\_score** \<Boolean\>   
prevent repacking in enzyme design calculation
 Default: false

 **-enz\_repack** \<Boolean\>   
prevent redesign in enzyme design calculation
 Default: false

 **-cst\_opt** \<Boolean\>   
pre design constraint minimization
 Default: false

 **-cst\_predock** \<Boolean\>   
docks a ligand relative the catalytic residue
 Default: false

 **-trans\_magnitude** \<Real\>   
rigid body translation in Angstrom
 Default: 0.1

 **-rot\_magnitude** \<Real\>   
rigid body rotation in deg
 Default: 2

 **-dock\_trials** \<Real\>   
number of docking trials
 Default: 100

 **-cst\_min** \<Boolean\>   
after design minimization, constraints turned off
 Default: false

 **-cst\_design** \<Boolean\>   
invokes actual design
 Default: false

 **-design\_min\_cycles** \<Integer\>   
determines how many iterations of designing/minimizing are done during a design run
 Default: 1

 **-make\_consensus\_mutations** \<Boolean\>   
Invokes mutations back to sequence profile consensus throughout whole protein in EnzdesFixBB protocol. sequence profile file must be specified through -in:pssm option.
 Default: false

 **-bb\_min** \<Boolean\>   
allows backbone of active site residues to move during cst\_opt and cst\_min. In the cst\_opt stage, residue Cas will be constrained to their original positions.
 Default: false

 **-bb\_min\_allowed\_dev** \<Real\>   
distance by which Cas are allowed to move during backbone minimization before a penalty is assigned.
 Default: 0.5

 **-loop\_bb\_min\_allowed\_dev** \<Real\>   
distance by which Cas are allowed to move during backbone minimization before a penalty is assigned. Applied only for loops as determined by DSSP.
 Default: 0.5

 **-minimize\_ligand\_torsions** \<Real\>   
degrees by which ligand torsions are allowed to rotate before a penalty is assigned. Only those torsions which have diversity in the conformational ensemble are allowed this std dev. rest are constrained to 0.1
 Default: 10.0

 **-minimize\_all\_ligand\_torsions** \<Real\>   
allows constrained minimization of all ligand torsions using stddev.
 Default: 10.0

 **-chi\_min** \<Boolean\>   
allows chi values of active site residues to move during cst\_opt and cst\_min.
 Default: false

 **-min\_all\_jumps** \<Boolean\>   
allows all jumps in the pose to minimize during cst\_opt and cst\_min. By default only ligand-associated jumps minimize
 Default: false

 **-cst\_dock** \<Boolean\>   
ligand docking after design. By default, constraints (except covalent connections will be turned off for this stage.
 Default: false

 **-run\_ligand\_motifs** \<Boolean\>   
run ligand motif search and add motif rotamers to packer
 Default: false

 **-enz\_debug** \<Boolean\>   
invokes various debug routines around the enzdes code
 Default: false

 **-cstfile** \<File\>   
file that contains all necessary constraints for an enzyme design calculation
 Default: "constraints.cst"

 **-enz\_loops\_file** \<File\>   
file that contains definitions of loop regions
 Default: "eloops.els"

 **-flexbb\_protocol** \<Boolean\>   
triggers flexible backbone design
 Default: false

 **-remodel\_protocol** \<Boolean\>   
triggers remodel protocol design
 Default: false

 **-kic\_loop\_sampling** \<Boolean\>   
Generate alternate loop conformations using KIC loop closure instead of backrub
 Default: false

 **-dump\_loop\_samples** \<String\>   
yes/no? Create loop pdb files named loopreg\_[regionid]\_[whichsample].pdb for the chosen loop samples; if 'quit\_afterwards' is given, then the program exits after all loops have been generated
 Default: "no"

 **-fix\_catalytic\_aa** \<Boolean\>   
preventing catalytic aa from repacking
 Default: false

 **-additional\_packing\_ligand\_rb\_confs** \<Integer\>   
Ligand Rotamers will be built at additional random rigid body positions during packing
 Default: 0

 **-ex\_catalytic\_rot** \<Integer\>   
convenience option to use higher number of rotamers for catalytic residues. The chosen level will be applied to all chis of every catalytic residue.
 Default: 1

 **-single\_loop\_ensemble\_size** \<Integer\>   
number of conformations generated for each of the independent loops in a flexbb calculation
 Default: 100

 **-loop\_generator\_trials** \<Integer\>   
number of trials of that the respective loop generator(backrub/kinematic kic) does in enzdes flexbb
 Default: 200

 **-no\_catres\_min\_in\_loopgen** \<Boolean\>   
prevents minimization of catalytic residues when generating loop ensembles
 Default: false

 **-mc\_kt\_low** \<Real\>   
low monte carlo limit for ensemble generation using backrub
 Default: 0.6

 **-mc\_kt\_high** \<Real\>   
high monte carlo limit for ensemble generation using backrub
 Default: 0.9

 **-min\_cacb\_deviation** \<Real\>   
Fragment uniqueness filter. On by default. Minimum CA/CB average deviation that at least one residue must have from all other already-included fragments for a new fragment to be included
 Default: 0.3

 **-max\_bb\_deviation** \<Real\>   
Fragment smoothness filter. Off by default. Upper limit on the backbone average deviation a new fragment may have to its most-similar fragment that has already been included in the fragment set.
 Default: 0.1

 **-max\_bb\_deviation\_from\_startstruct** \<Real\>   
Fragment native-proximity Filter. Always on. Maximum tolerated backbone average deviation from the starting backbone for a fragment that to be included in the fragment set.
 Default: 1.5

 **-flexbb\_outstructs** \<Integer\>   
doesn't do much anymore in the current implementation of the flexbb protocol
 Default: 10

 **-remodel\_trials** \<Integer\>   
how often each loop is being remodeled in the enzdes\_remodel mover
 Default: 100

 **-remodel\_secmatch** \<Boolean\>   
if constrained interactions are missing in the pose during remodel, the SecondaryMatcher will be used to try to find them in the remodeled region. very experimental at this point
 Default: false

 **-dump\_inverse\_rotamers** \<Boolean\>   
in case of remodel secmatching against inverse rotamers, these rotamers will be dumped before the protocol starts for visual inspection by the user
 Default: false

 **-remodel\_aggressiveness** \<Real\>   
determines the aggressiveness with which a given loop is remodeled. legal values between 0 and 1, where 1 is aggressive and 0 conservative.
 Default: 0.1

 **-favor\_native\_res** \<Real\>   
a bonus energy assigned to the native res during a design calculation
 Default: 0.5

 **-detect\_design\_interface** \<Boolean\>   
automatically detect design/repack region around ligand(s)
 Default: false

 **-include\_catres\_in\_interface\_detection** \<Boolean\>   
if option -detect\_design\_interface is active, invoking this option causes all residues that are within the specified cuts of any catalytic residue are also set to designing/repacking
 Default: false

 **-arg\_sweep\_interface** \<Boolean\>   
Use protein-DNA design-like interface detection, involving generation of arginine rotamers at each position, checking to see if argininte can make interaction with ligand.
 Default: false

 **-arg\_sweep\_cutoff** \<Real\>   
Interaction cutoff distance from arginine to ligand when performing arginine sweep interface detection.
 Default: 3.7

 **-cut1** \<Real\>   
option to specify redesign cutoff 1 in enzdes calculation
 Default: 0.0

 **-cut2** \<Real\>   
option to specify redesign cutoff 2 in enzdes calculation
 Default: 0.0

 **-cut3** \<Real\>   
option to specify repack cutoff 1 in enzdes calculation
 Default: 10.0

 **-cut4** \<Real\>   
option to specify repack cutoff 2 in enzdes calculation
 Default: 10.0

 **-lig\_packer\_weight** \<Real\>   
specifies the weights for protein ligand interaction during packing (and only packing!! )
 Default: 1.0

 **-no\_unconstrained\_repack** \<Boolean\>   
no unconstrained repacking after the design stage
 Default: false

 **-secmatch\_Ecutoff** \<Real\>   
the maximum constraint energy at which a residue is accepted in the secondary matcher
 Default: 1.0

 **-change\_lig** \<File\>   
Can be used with the secondary matching protocol if different incarnations of the ligand are used for design and primary matching. The file needs to contain information on what atoms to superimpose.
 Default: "ligchange\_file.txt"

 **-process\_ligrot\_separately** \<String\>   
In the EnzdesFixBB protocol, causes the protocol to be executed separately for all non\_bb clashing ligand rotamers.
 Default: "default\_lig"

 **-start\_from\_random\_rb\_conf** \<Boolean\>   
In the EnzdesFixBB protocol, if there are additional ligand rigid body conformations available (from a multimodel pdb), a random one of these will be the starting point for the protocol.
 Default: false

 **-bb\_bump\_cutoff** \<Real\>   
option to specify the maximum allowed backbone energie when replacing a new residue type
 Default: 2.0

 **-sc\_sc\_bump\_cutoff** \<Real\>   
option to specify the maximum allowed energy between two newly placed sidechains in the secondary matcher
 Default: 2.0

 **-no\_packstat\_calculation** \<Boolean\>   
will determine whether the computationally intensive packstat calculation will be done at the end of a run
 Default: false

 **-compare\_native** \<String\>   
triggers comparison of every designed structure to its respective native pdb. the value of the option needs to be a directory path that contains all the native pdb files
 Default: "./"

 **-final\_repack\_without\_ligand** \<Boolean\>   
if a scorefile is requested, this option triggers every structure to be repacked without the ligand. the resulting structure will be output in a multimodel pdb, and differences in energy and rmsd are added to the scorefile.
 Default: false

 **-dump\_final\_repack\_without\_ligand\_pdb** \<Boolean\>   
If option -final\_repack\_without\_ligand is active, this option will cause the repacked structure to be separately dumped.
 Default: false

 **-parser\_read\_cloud\_pdb** \<Boolean\>   
read cloud format PDB for enzdes in rosetta scripts
 Default: false

-   -packing
    --------

 **-packing** \<Boolean\>   
Packing option group

 **-repack\_only** \<Boolean\>   
Disable design at all positions
 Default: false

 **-prevent\_repacking** \<Boolean\>   
Disable repacking (or design) at all positions
 Default: false

 **-cenrot\_cutoff** \<Real\>   
Cutoff to generate centroid rotamers
 Default: 0.16

 **-ignore\_ligand\_chi** \<Boolean\>   
Disable param file chi-angle based rotamer generation in SingleLigandRotamerLibrary
 Default: false

 **-ndruns** \<Integer\>   
Number of fixbb packing iterations. Each time packing occurs, it will pack this many times and return only the best result. Implemented at level of PackRotamersMover.
 Range: 1-
 Default: 1

 **-soft\_rep\_design** \<Boolean\>   
Use larger LJ radii for softer potential

 **-use\_electrostatic\_repulsion** \<Boolean\>   
Use electrostatic repulsion

 **-dump\_rotamer\_sets** \<Boolean\>   
Output NMR-style PDB's with the rotamer sets used during packing

 **-dunbrack\_prob\_buried** \<Real\>   
fraction of possible dunbrack rotamers to include in each single residue rotamer set, for 'buried' residues
 Range: 0-1
 Default: 0.98

 **-dunbrack\_prob\_nonburied** \<Real\>   
fraction of possible dunbrack rotamers to include in each single residue rotamer set, for 'nonburied' residues
 Range: 0-1
 Default: 0.95

 **-dunbrack\_prob\_nonburied\_semirotameric** \<Real\>   
fraction of possible dunbrack rotamers to include in each single residue rotamer set, for 'nonburied', semi-rotameric residues
 Range: 0-1
 Default: 0.95

 **-no\_optH** \<Boolean\>   
Do not optimize hydrogen placement at the time of a PDB load
 Default: true

 **-optH\_MCA** \<Boolean\>   
If running optH, use the Multi-Cool Annealer (more consistent, but slower)
 Default: false

 **-pack\_missing\_sidechains** \<Boolean\>   
Run packer to fix residues with missing sidechain density at PDB load
 Default: true

 **-preserve\_c\_beta** \<Boolean\>   
Preserve c-beta positions during rotamer construction

 **-flip\_HNQ** \<Boolean\>   
Consider flipping HIS, ASN, and GLN during hydrogen placement optimization

 **-fix\_his\_tautomer** \<IntegerVector\>   
seqpos numbers of his residus whose tautomer should be fixed during repacking
 Default: []

 **-print\_pymol\_selection** \<Boolean\>   
include pymol-style selections when printing a PackerTask
 Default: false

-   ### -packing:ex1

 **-ex1** \<Boolean\>   
use extra chi1 sub-rotamers for all residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi1 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

 **-operate** \<Boolean\>   
apply special operations (see RotamerOperation class) on ex1 rotamers

-   ### -packing:ex2

 **-ex2** \<Boolean\>   
use extra chi2 sub-rotamers for all residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi2 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

 **-operate** \<Boolean\>   
apply special operations (see RotamerOperation class) on ex2 rotamers

-   ### -packing:ex3

 **-ex3** \<Boolean\>   
use extra chi1 sub-rotamers for all residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi3 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

 **-operate** \<Boolean\>   
apply special operations (see RotamerOperation class) on ex3 rotamers

-   ### -packing:ex4

 **-ex4** \<Boolean\>   
use extra chi1 sub-rotamers for all residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi4 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

 **-operate** \<Boolean\>   
apply special operations (see RotamerOperation class) on ex4 rotamers

-   ### -packing:ex1aro

 **-ex1aro** \<Boolean\>   
use extra chi1 sub-rotamers for aromatic residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi1 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

-   ### -packing:ex2aro

 **-ex2aro** \<Boolean\>   
use extra chi1 sub-rotamers for aromatic residues that pass the extrachi\_cutoff

 **-level** \<Integer\>   
use extra chi2 sub-rotamers for all residues that pass the extrachi\_cutoff The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

-   ### -packing:ex1aro\_exposed

 **-ex1aro\_exposed** \<Boolean\>   
use extra chi1 sub-rotamers for all aromatic residues

 **-level** \<Integer\>   
use extra chi1 sub-rotamers for all aromatic residues The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

-   ### -packing:ex2aro\_exposed

 **-ex2aro\_exposed** \<Boolean\>   
use extra chi2 sub-rotamers for all aromatic residues

 **-level** \<Integer\>   
use extra chi2 sub-rotamers for all aromatic residues The integers that follow the ex flags specify the pattern for chi dihedral angle sampling There are currently 8 options; they all include the original chi dihedral angle. NO\_EXTRA\_CHI\_SAMPLES 0 original dihedral only; same as using no flag at all EX\_ONE\_STDDEV 1 Default +/- one standard deviation (sd); 3 samples EX\_ONE\_HALF\_STEP\_STDDEV 2 +/- 0.5 sd; 3 samples EX\_TWO\_FULL\_STEP\_STDDEVS 3 +/- 1 & 2 sd; 5 samples EX\_TWO\_HALF\_STEP\_STDDEVS 4 +/- 0.5 & 1 sd; 5 samples EX\_FOUR\_HALF\_STEP\_STDDEVS 5 +/- 0.5, 1, 1.5 & 2 sd; 9 samples EX\_THREE\_THIRD\_STEP\_STDDEVS 6 +/- 0.33, 0.67, 1 sd; 7 samples EX\_SIX\_QUARTER\_STEP\_STDDEVS 7 +/- 0.25, 0.5, 0.75, 1, 1.25 & 1.5 sd; 13 samples
 Default: 1

-   ### -packing:exdna

 **-exdna** \<Boolean\>   
use extra dna rotamers

 **-level** \<Integer\>   
extra dna rotamer sample level – rotbuilder converts from 0-7 to number
 Default: 1

-   -packing
    --------

 **-extrachi\_cutoff** \<Integer\>   
number of neighbors a residue must have before extra rotamers are used. default: 18
 Default: 18

 **-resfile** \<FileVector\>   
resfile filename(s). Most protocols use only the first and will ignore the rest; it does not track against -s or -l automatically.
 Default: ['"resfile"']

 **-outeriterations\_scaling** \<Real\>   
Multiplier for number of outer iterations
 Default: 1.0

 **-inneriterations\_scaling** \<Real\>   
Multiplier for number of inner iterations
 Default: 1.0

 **-explicit\_h2o** \<Boolean\>   
Use rotamers with explicit waters

 **-adducts** \<StringVector\>   
Gives list of adduct names to generate for residue definitions. Each adduct name may be followed by an optional integer, which gives a maximum number of adducts of that type which will be generated.

 **-solvate** \<Boolean\>   
Add explicit water, but don't try to place water such that it bridges Hbonds, just put it on every available Hbond donor/acceptor where there's no clash (implies explicit\_h2o)

 **-use\_input\_sc** \<Boolean\>   
Use rotamers from input structure in packing By default, input sidechain coords are NOT included in rotamer set but are discarded before the initial pack; with this flag, the the input rotamers will NOT be discarded. Note that once the starting rotamers are replaced by any mechanism, they are no longer included in the rotamer set (rotamers included by coordinates)

 **-unboundrot** \<FileVector\>   
Read 'native' rotamers from supplied PDB(s). Unlike -use\_input\_sc, these rotamers will not be lost during repacks. This option requires specific support from the protocol; it is NOT built in to PackerTask.initialize\_from\_command\_line()

 **-max\_rotbump\_energy** \<Real\>   
discard rotamers with poor interactions with the background using the specified cutoff. Values must be in the range of 0 to 5.0.
 Default: 5.0

 **-lazy\_ig** \<Boolean\>   
Force the packer to always allocate pair energy storage but procrastinate energy caclulation until each RPE is needed; each RPE is computed at most once. Memory use is quadratic in rotamers per residue. The InteractionGraphFactory will prefer the linear-memory interaction graph to the Lazy Interaction graph, so specifying both linmem\_ig and lazy\_ig results in the use of the linear-memory interaction graph. The Surface-series IGs (surface weight in scorefunction is nonzero) also overrides this IG.
 Default: false

 **-double\_lazy\_ig** \<Boolean\>   
Force the packer to always procrastinate allocation AND energy caclulation until each RPE is needed; each RPE is computed at most once. The InteractionGraphFactory will prefer the linear-memory interaction graph to the DoubleLazy Interaction graph, so specifying both linmem\_ig and lazy\_ig results in the use of the linear-memory interaction graph. The Surface-series IGs (surface weight in scorefunction is nonzero) also overrides this IG.
 Default: false

 **-double\_lazy\_ig\_mem\_limit** \<Integer\>   
The amount of memory, in MB, that each double-lazy interaction graph should be allowed to allocate toward rotamer pair energies. Using this flag will not trigger the use of the double-lazy interaction graph, and this flag is not read in the PackerTask's initialize\_from\_command\_line routine. For use in multistate design
 Default: 0

 **-linmem\_ig** \<Integer\>   
Force the packer to use the linear memory interaction graph; each RPE may be computed more than once, but recently-computed RPEs are reused. The integer parameter specifies the number of recent rotamers to store RPEs for. 10 is the recommended size. Memory use scales linearly with the number of rotamers at about 200 bytes per rotamer per recent rotamers to store RPEs for (\~4 KB per rotamer by default)
 Default: 10

 **-multi\_cool\_annealer** \<Integer\>   
Alternate annealer for packing. Runs multiple quence cycles in a first cooling stage, and tracks the N best network states it observes. It then runs low-temperature rotamer substitutions with repeated quenching starting from each of these N best network states. 10 is recommended.

 **-minpack\_temp\_schedule** \<RealVector\>   
Alternate annealing schedule for min\_pack.

 **-minpack\_inner\_iteration\_scale** \<Integer\>   
The number of inner iterations per rotamer to run at each temperature in min pack.

 **-minpack\_disable\_bumpcheck** \<Boolean\>   
Disable bump check in min pack (i.e. include rotamers that collide with the background.

-   -phil
    -----

 **-phil** \<Boolean\>   
phil option group

 **-nloop** \<Integer\>   
No description
 Default: 10

 **-vall\_file** \<String\>   
No description

 **-align\_file** \<String\>   
No description

-   -wum
    ----

 **-wum** \<Boolean\>   
wum option group

 **-n\_slaves\_per\_master** \<Integer\>   
A value between 32 and 128 is usually recommended
 Default: 64

 **-n\_masters** \<Integer\>   
Manual override for -n\_slaves\_per\_master. How many master nodes should be spawned ? 1 by default. generall 1 for eery 256-512 cores is recommended depending on master workload
 Default: 1

 **-memory\_limit** \<Integer\>   
Memory limit for queues (in kB)
 Default: 0

 **-extra\_scorefxn** \<String\>   
Extra score function for post-batchrelax-rescoring

 **-extra\_scorefxn\_ref\_structure** \<File\>   
Extra score function for post-batchrelax-rescoring reference structure for superimposition (for scorefunctions that depend on absolute coordinates such as electron denisty)

 **-extra\_scorefxn\_relax** \<Integer\>   
After doing batch relax and adding any extra\_scorefunction terms do another N fast relax rounds (defaut=0)
 Default: 0

 **-trim\_proportion** \<Real\>   
No description
 Default: 0.0

-   -els
    ----

 **-els** \<Boolean\>   
els option group

 **-master\_wu\_per\_send** \<Integer\>   
How many wu to send in one isend from master. Set to \~ (WU generated: slaves per master) ratio
 Default: 1

 **-vars** \<String\>   
Any variables you want to pass to lua, semi colon separated, in the form: myvar=5
 Default: ""

 **-script** \<File\>   
Path to the ElScript
 Default: ""

 **-num\_traj** \<Integer\>   
Number of trajectories

 **-traj\_per\_master** \<Integer\>   
Number of trajectories per master node

 **-shortest\_wu** \<Integer\>   
Length of time of shortest wu in seconds, used for determining status request resend period. Err on the side of smaller times
 Default: 60

 **-pool** \<Boolean\>   
Using pool node?
 Default: false

 **-singlenode** \<Boolean\>   
Using singlenode role with mpi?
 Default: false

-   -lh
    ---

 **-lh** \<Boolean\>   
lh option group

 **-db\_prefix** \<String\>   
stem for loop database
 Default: "loopdb"

 **-loopsizes** \<IntegerVector\>   
Which loopsizes to use
 Default: ['10', '15', '20']

 **-num\_partitions** \<Integer\>   
Number of partitions to split the database into
 Default: 1

 **-db\_path** \<Path\>   
Path to database
 Default: ""

 **-exclude\_homo** \<Boolean\>   
Use a homolog exclusion filter
 Default: false

 **-bss** \<Boolean\>   
Use BinaryProteinSilentStruct instead of ProteinSilentStruct (needed for nonideal)
 Default: false

 **-refstruct** \<String\>   
File with a target reference structure
 Default: ""

 **-homo\_file** \<String\>   
File containing homologs to exclude
 Default: ""

 **-createdb\_rms\_cutoff** \<RealVector\>   
RMS cutoff used for throwing out similar fragments.
 Default: ['0', '0', '0']

 **-min\_bbrms** \<Real\>   
No description
 Default: 20.0

 **-max\_bbrms** \<Real\>   
No description
 Default: 1400.0

 **-min\_rms** \<Real\>   
No description
 Default: 0.5

 **-max\_rms** \<Real\>   
No description
 Default: 4.0

 **-filter\_by\_phipsi** \<Boolean\>   
No description
 Default: true

 **-max\_radius** \<Integer\>   
No description
 Default: 4

 **-max\_struct** \<Integer\>   
No description
 Default: 10

 **-max\_struct\_per\_radius** \<Integer\>   
No description
 Default: 10

 **-grid\_space\_multiplier** \<Real\>   
No description
 Default: 1

 **-grid\_angle\_multiplier** \<Real\>   
No description
 Default: 2.5

 **-skim\_size** \<Integer\>   
No description
 Default: 100

 **-rounds** \<Integer\>   
No description
 Default: 100

 **-jobname** \<String\>   
Prefix (Ident string) !
 Default: "default"

 **-max\_lib\_size** \<Integer\>   
No description
 Default: 2

 **-max\_emperor\_lib\_size** \<Integer\>   
No description
 Default: 25

 **-max\_emperor\_lib\_round** \<Integer\>   
No description
 Default: 0

 **-library\_expiry\_time** \<Integer\>   
No description
 Default: 2400

 **-objective\_function** \<String\>   
What to use as the objective function
 Default: "score"

 **-expire\_after\_rounds** \<Integer\>   
If set to \> 0 this causes the Master to expire a structure after it has gone through this many cycles
 Default: 0

 **-mpi\_resume** \<String\>   
Prefix (Ident string) for resuming a previous job!

 **-mpi\_feedback** \<String\>   
No description
 Default: "no"

 **-mpi\_batch\_relax\_chunks** \<Integer\>   
No description
 Default: 100

 **-mpi\_batch\_relax\_absolute\_max** \<Integer\>   
No description
 Default: 300

 **-mpi\_outbound\_wu\_buffer\_size** \<Integer\>   
No description
 Default: 60

 **-mpi\_loophash\_split\_size** \<Integer\>   
No description
 Default: 50

 **-mpi\_metropolis\_temp** \<Real\>   
No description
 Default: 1000000.0

 **-mpi\_save\_state\_interval** \<Integer\>   
No description
 Default: 1200

 **-mpi\_master\_save\_score\_only** \<Boolean\>   
No description
 Default: true

 **-max\_loophash\_per\_structure** \<Integer\>   
No description
 Default: 1

 **-rms\_limit** \<Real\>   
How to deal with returned relaxed structures
 Default: 2.0

 **-centroid\_only** \<Boolean\>   
false
 Default: false

 **-write\_centroid\_structs** \<Boolean\>   
Output raw loophashed decoys as well as relaxed ones
 Default: false

 **-write\_all\_fa\_structs** \<Boolean\>   
Write out all structures returned from batch relax
 Default: false

 **-sandbox** \<Boolean\>   
Sand box mode
 Default: false

 **-create\_db** \<Boolean\>   
Make database with this loopsize
 Default: false

 **-sample\_weight\_file** \<File\>   
Holds the initial per residue sample weights

-   ### -lh:fragpdb

 **-fragpdb** \<Boolean\>   
fragpdb option group

 **-out\_path** \<String\>   
Path where pdbs are saved
 Default: ""

 **-indexoffset** \<IntegerVector\>   
list of index offset pairs
 Default: ['-1']

 **-bin** \<StringVector\>   
list of bin keys
 Default: utility::vector1\<std::string\>()

-   ### -lh:symfragrm

 **-symfragrm** \<Boolean\>   
symfragrm option group

 **-pdblist** \<FileVector\>   
list of pdbs to be processed

-   -rbe
    ----

 **-rbe** \<Boolean\>   
rbe option group

 **-server\_url** \<String\>   
serverurl for rosetta backend

 **-server\_port** \<String\>   
port for rosetta backend
 Default: "80"

 **-poll\_frequency** \<Real\>   
No description
 Default: 1.0

-   -blivens
    --------

 **-blivens** \<Boolean\>   
blivens option group

-   ### -blivens:disulfide\_scorer

 **-disulfide\_scorer** \<Boolean\>   
disulfide\_scorer option group

 **-nds\_prob** \<Real\>   
The probability of scoring a non-disulfide pair
 Default: 0.0

 **-cys\_prob** \<Real\>   
The probability of outputing a pair of non-disulf cysteines. Default to nds\_prob
 Default: -1.0

-   -blivens
    --------

 **-score\_type** \<String\>   
The scoring type to use, eg for a filter.
 Default: "total\_score"

-   -krassk
    -------

 **-krassk** \<Boolean\>   
krassk option group

 **-left\_tail** \<Integer\>   
No description
 Default: 0

 **-right\_tail** \<Integer\>   
No description
 Default: 0

 **-tail\_mode** \<Boolean\>   
No description
 Default: false

 **-tail\_mode\_name** \<Integer\>   
No description
 Default: 1

 **-tail\_output\_file\_name** \<String\>   
No description
 Default: "tail\_output"

-   -rotamerdump
    ------------

 **-rotamerdump** \<Boolean\>   
rotamerdump option group

 **-xyz** \<Boolean\>   
when using the RotamerDump application, output the xyz coords of every rotamer
 Default: false

 **-one\_body** \<Boolean\>   
when using the RotamerDump application, output the one\_body energies of every rotamer
 Default: false

 **-two\_body** \<Boolean\>   
when using the RotamerDump application, output the two\_body energies of every rotamer
 Default: false

 **-annealer** \<Boolean\>   
Run the annealer and output the rotamers it chose
 Default: false

-   -robert
    -------

 **-robert** \<Boolean\>   
robert option group

 **-pairdata\_input\_pdb\_list** \<String\>   
Takes in a file containing a list of pdb locations paired with protocol specific data (eg: one disulfide pair)
 Default: ""

 **-pcs\_maxsub\_filter** \<Real\>   
minimum normalized maxsub for PCS clustering protocol
 Default: 0.9

 **-pcs\_maxsub\_rmsd** \<Real\>   
maxsub calculation's rmsd threshold
 Default: 4.0

 **-pcs\_dump\_cluster** \<Boolean\>   
No description
 Default: false

 **-pcs\_cluster\_coverage** \<Real\>   
cluster coverage required
 Default: 0.3

 **-pcs\_cluster\_lowscoring** \<Boolean\>   
cluster lowest 20% against lowest 50%
 Default: true

-   -cmiles
    -------

 **-cmiles** \<Boolean\>   
cmiles option group

-   ### -cmiles:kcluster

 **-kcluster** \<Boolean\>   
kcluster option group

 **-num\_clusters** \<Integer\>   
Number of clusters to use during k clustering

-   ### -cmiles:jumping

 **-jumping** \<Boolean\>   
jumping option group

 **-resi** \<Integer\>   
Residue i

 **-resj** \<Integer\>   
Residue j

-   -james
    ------

 **-james** \<Boolean\>   
james option group

 **-min\_seqsep** \<Integer\>   
No description
 Default: 0

 **-atom\_names** \<StringVector\>   
No description
 Default: utility::vector1\<std::string\>()

 **-dist\_thresholds** \<RealVector\>   
No description
 Default: utility::vector1\<float\>(1, 1.0)

 **-torsion\_thresholds** \<RealVector\>   
No description
 Default: utility::vector1\<float\>(1, 30.0)

 **-sog\_cutoff** \<Real\>   
No description
 Default: 5.0

 **-shift\_sog\_func** \<Boolean\>   
No description
 Default: true

 **-min\_type** \<String\>   
No description
 Default: "dfpmin\_armijo\_nonmonotone"

 **-min\_tol** \<Real\>   
No description
 Default: 0.0001

 **-debug** \<Boolean\>   
No description
 Default: false

 **-real** \<Real\>   
Option for keeping things real.
 Default: 7.0

 **-n\_designs** \<Integer\>   
total number of designs that James should make.
 Default: 1

 **-awesome\_mode** \<Boolean\>   
activates or deactivates awesome\_mode.
 Default: true

 **-n\_clusters** \<Integer\>   
number of clusters for k-means clustering.
 Default: 10

 **-thread\_unaligned** \<Boolean\>   
basic\_threading without performing an alignment
 Default: false

-   -membrane
    ---------

 **-membrane** \<Boolean\>   
membrane option group

 **-normal\_cycles** \<Integer\>   
number of membrane normal cycles
 Default: 100

 **-normal\_mag** \<Real\>   
magnitude of membrane normal angle search (degrees)
 Default: 5

 **-center\_mag** \<Real\>   
magnitude of membrane normal center search (Angstroms)
 Default: 1

 **-thickness** \<Real\>   
one leaflet hydrocarbon thickness for solvation calculations (Angstroms)
 Default: 15

 **-smooth\_move\_frac** \<Real\>   
No description
 Default: 0.5

 **-no\_interpolate\_Mpair** \<Boolean\>   
No description
 Default: false

 **-Menv\_penalties** \<Boolean\>   
No description
 Default: false

 **-Membed\_init** \<Boolean\>   
No description
 Default: false

 **-Fa\_Membed\_update** \<Boolean\>   
No description
 Default: false

 **-center\_search** \<Boolean\>   
perform membrane center search
 Default: false

 **-normal\_search** \<Boolean\>   
perform membrane normal search
 Default: false

 **-center\_max\_delta** \<Integer\>   
magnitude of maximum membrane width deviation during membrane center search (Angstroms)
 Default: 5

 **-normal\_start\_angle** \<Integer\>   
magnitude of starting angle during membrane normal search (degrees)
 Default: 10

 **-normal\_delta\_angle** \<Integer\>   
magnitude of angle deviation during membrane normal search (degrees)
 Default: 10

 **-normal\_max\_angle** \<Integer\>   
magnitude of maximum angle deviation during membrane normal search (degrees)
 Default: 40

 **-debug** \<Boolean\>   
No description
 Default: false

 **-fixed\_membrane** \<Boolean\>   
fix membrane position, by default the center is at [0,0,0] and membrane normal is the z-axis
 Default: false

 **-membrane\_center** \<RealVector\>   
membrane center x,y,z

 **-membrane\_normal** \<RealVector\>   
membrane normal x,y,z

 **-view** \<Boolean\>   
viewing pose during protocol
 Default: false

 **-Mhbond\_depth** \<Boolean\>   
membrane depth dependent correction to the hbond potential
 Default: false

-   -casp
    -----

 **-casp** \<Boolean\>   
casp option group

 **-decoy** \<String\>   
No description

 **-wt** \<String\>   
No description

 **-rots** \<String\>   
No description

 **-opt\_radius** \<Real\>   
optimization radius for repacking and minimization

 **-repack** \<Boolean\>   
should we repack the structure?

 **-sc\_min** \<Boolean\>   
should we sidechain minimize the structure?

 **-sequential** \<Boolean\>   
should mutations be considered in sequence or all together?

 **-num\_iterations** \<Real\>   
number of iterations to perform

 **-weight\_file** \<String\>   
what weight-file to use?

 **-refine\_res** \<String\>   
specifies file that contains which residues to refine

-   -pose\_metrics
    --------------

 **-pose\_metrics** \<Boolean\>   
pose\_metrics option group

 **-atomic\_burial\_cutoff** \<Real\>   
maximum SASA that is allowed for an atom to count as buried for the BuriedUnsatisfiedPolarsCalculator
 Default: 0.3

 **-sasa\_calculator\_probe\_radius** \<Real\>   
the probe radius used in the SASA calculator (and thus implicitly in the BuriedUnsatisfiedPolarsCalculator
 Default: 1.4

 **-interface\_cutoff** \<Real\>   
distance in angstroms (def. 10.0) for calculating what residues are at an interface via InterfaceNeighborDefinitionCalculator
 Default: 10.0

 **-min\_sequence\_separation** \<Integer\>   
minimum number of sequence positions that two residues need to be apart to count as nonlocal in the NonlocalContactsCalculator
 Default: 6

 **-contact\_cutoffE** \<Real\>   
maximum interaction energy allowed between two residues to count as a contact in the NonlocalContactsCalculator
 Default: -1.0

 **-neighbor\_by\_distance\_cutoff** \<Real\>   
distance in angstroms (def. 10.0) for calculating neighbors of a residue via NeighborByDistanceCalculator
 Default: 10.0

 **-inter\_group\_neighbors\_cutoff** \<Real\>   
distance in angstroms (def. 10.0) for calculating interfaces between domains with InterGroupNeighborsCalculator
 Default: 10.0

 **-semiex\_water\_burial\_cutoff** \<Real\>   
water hbond states fraction cutiff for SemiExplicitWaterUnsatisfiedPolarsCalculator (0.0,1.0)
 Default: 0.25

-   -ddg
    ----

 **-ddg** \<Boolean\>   
ddg option group

 **-avg\_rot\_cst\_enrg** \<Boolean\>   
No description
 Default: false

 **-use\_bound\_cst** \<Boolean\>   
No description
 Default: false

 **-cap\_rot\_cst\_enrg** \<Real\>   
No description
 Default: false

 **-opt\_input\_structure** \<Boolean\>   
No description
 Default: false

 **-pack\_until\_converge** \<Boolean\>   
No description
 Default: false

 **-no\_constraints** \<Boolean\>   
No description
 Default: false

 **-apply\_rot\_cst\_to\_mutation\_region\_only** \<Real\>   
No description

 **-rot\_cst\_enrg\_cutoff** \<Real\>   
No description

 **-use\_rotamer\_constraints\_to\_native** \<Boolean\>   
No description
 Default: false

 **-single\_res\_scoring** \<Boolean\>   
No description

 **-downweight\_by\_sasa** \<Boolean\>   
No description

 **-global** \<Boolean\>   
No description

 **-exclude\_solvent\_exposed\_res** \<Boolean\>   
No description

 **-radius** \<Real\>   
No description

 **-wt** \<String\>   
No description

 **-mut** \<String\>   
No description

 **-suppress\_checkpointing** \<Boolean\>   
boinc specific options to suppress checkpointing behavior
 Default: false

 **-wt\_only** \<Boolean\>   
option added to minirosetta app in order to produce only refinement in wt structures

 **-mut\_only** \<Boolean\>   
options added to minirosetta app in order to produce refinement in only mutant structure

 **-output\_silent** \<Boolean\>   
No description

 **-minimization\_scorefunction** \<String\>   
No description

 **-minimization\_patch** \<String\>   
No description

 **-min\_cst** \<Boolean\>   
Following sidechain optimization in the packer, should we then proceed to minimize the backbone at all. Constraints will be used to keep the structure from moving too far.
 Default: true

 **-lowest\_x\_decoys** \<Integer\>   
No description

 **-local\_opt\_only** \<Boolean\>   
No description
 Default: false

 **-print\_per\_res\_diff** \<Boolean\>   
No description
 Default: false

 **-mean** \<Boolean\>   
No description

 **-min** \<Boolean\>   
No description

 **-rb\_restrict\_to\_mutsite\_nbrs** \<Boolean\>   
No description
 Default: false

 **-no\_bb\_movement** \<Boolean\>   
No description
 Default: false

 **-initial\_repack** \<Boolean\>   
No description
 Default: false

 **-rb\_file** \<String\>   
No description

 **-interface\_ddg** \<Integer\>   
Calculate ddGs across an interface? Uses jump \# specified for determining interface.
 Default: 0

 **-ens\_variation** \<Real\>   
No description
 Default: 0.5

 **-sc\_min\_only** \<Boolean\>   
No description
 Default: true

 **-min\_cst\_weights** \<String\>   
No description
 Default: "talaris2013"

 **-opt\_radius** \<Real\>   
No description
 Default: 8.0

 **-output\_dir** \<String\>   
No description
 Default: "./"

 **-last\_accepted\_pose\_dir** \<String\>   
No description
 Default: "./"

 **-min\_with\_cst** \<Boolean\>   
Used in ensemble generation
 Default: false

 **-temperature** \<Real\>   
because I really dont know what the monte carlo temperature should be set to
 Default: 10

 **-ramp\_repulsive** \<Boolean\>   
set fa\_rep to 0.1, 0.33 of original value when minimizing in the minimization phase following packing
 Default: false

 **-mut\_file** \<String\>   
alternate specification for mutations. File format described in fix\_bb\_monomer\_ddg.cc above the read\_in\_mutations function

 **-out\_pdb\_prefix** \<String\>   
specifies the prefix assigned to output so that no overwriting happens

 **-constraint\_weight** \<Real\>   
because that other option isnt working
 Default: 1.0

 **-harmonic\_ca\_tether** \<Real\>   
default CA tether for harmonic constraints
 Default: 2.0

 **-iterations** \<Integer\>   
specifies the number of iterations of refinement
 Default: 20

 **-out** \<String\>   
create output file of predicted ddgs
 Default: "ddg\_predictions.out"

 **-debug\_output** \<Boolean\>   
specify whether or not to write a whole bunch of debug statements to standard out
 Default: false

 **-dump\_pdbs** \<Boolean\>   
specify whether or not to dump repacked wild-type and mutant pdbs
 Default: true

 **-weight\_file** \<String\>   
specifies the weight-files to be used in calculations
 Default: "ddg.wts"

 **-translate\_by** \<Integer\>   
specify the distance in Angstrom that takes to move away when unbounded. Should keep it around 100 when this protocol is used in conjunction with the Poisson-Boltzmann potential score-term.

-   -murphp
    -------

 **-murphp** \<Boolean\>   
murphp option group

 **-inv\_kin\_lig\_loop\_design\_filename** \<String\>   
input filename to be used for inv\_kin\_lig\_loop\_design

-   -motifs
    -------

 **-motifs** \<Boolean\>   
motifs option group

 **-close\_enough** \<Real\>   
4-atom rmsd cutoff beyond which you don't bother trying an inverse rotamer
 Default: 1.0

 **-max\_depth** \<Integer\>   
Maximum recursion depth - i.e., maximum number of motifs to incorporate
 Default: 1

 **-keep\_motif\_xtal\_location** \<Boolean\>   
used to dna\_motif\_collector - controls whether motifs are moved away from original PDB location (comparison is easier if they are moved, so that's default)
 Default: false

 **-pack\_score\_cutoff** \<Real\>   
used in dna\_motif\_collector - fa\_atr + fa\_rep energy threshold for a two-residue interaction to determine if it is a motif
 Default: -0.5

 **-hb\_score\_cutoff** \<Real\>   
used in dna\_motif\_collector - hbond\_sc energy threshold for a two-residue interaction to determine if it is a motif
 Default: -0.3

 **-water\_score\_cutoff** \<Real\>   
used in dna\_motif\_collector - h2o\_hbond energy threshold for a two-residue interaction to determine if it is a motif
 Default: -0.3

 **-motif\_output\_directory** \<String\>   
used in dna\_motif\_collector - path for the directory where all the collected motifs are dumped as 2-residue pdbs

 **-eliminate\_weak\_motifs** \<Boolean\>   
used to dna\_motif\_collector - controls whether only the top 1-2 motifs are counted for every protein position in a protein-DNA interface
 Default: true

 **-duplicate\_motif\_cutoff** \<Real\>   
used in dna\_motif\_collector - RMSD cutoff for an identical base placed via a motif to see if that motif already exists in a motif library
 Default: 0.2

 **-preminimize\_motif\_pdbs** \<Boolean\>   
used to dna\_motif\_collector - controls whether the input PDB structure sidechains and bb are minimized before motifs are collected
 Default: false

 **-preminimize\_motif\_pdbs\_sconly** \<Boolean\>   
used to dna\_motif\_collector - controls whether the input PDB structure sidechains are minimized before motifs are collected
 Default: false

 **-place\_adduct\_waters** \<Boolean\>   
used to dna\_motif\_collector - whether or not adduct waters are placed before motifs are collected, there will be no water interaction calculated if this is false
 Default: true

 **-list\_motifs** \<FileVector\>   
File(s) containing list(s) of PDB files to process

 **-motif\_filename** \<String\>   
File containing motifs

 **-BPData** \<String\>   
File containing BuildPosition specific motifs and/or rotamers

 **-list\_dnaconformers** \<FileVector\>   
File(s) containing list(s) of PDB files to process

 **-target\_dna\_defs** \<StringVector\>   
 Default: ""

 **-motif\_build\_defs** \<StringVector\>   
 Default: ""

 **-motif\_build\_position\_chain** \<String\>   
 Default: ""

 **-motif\_build\_positions** \<IntegerVector\>   

 **-r1** \<Real\>   
RMSD cutoff between motif anchor position and motif target position for allowing a particular motif rotamer to continue on to expand with DNA conformers
 Range: 0-
 Default: 4.5

 **-r2** \<Real\>   
RMSD cutoff between motif anchor position and motif target position for accepting the motif
 Range: 0-
 Default: 1.1

 **-z1** \<Real\>   
DNA motif specific: cutoff between motif target DNA position and standardized base for allowing a particular motif to continue on to expand with DNA conformers
 Range: 0-
 Default: 0.75

 **-z2** \<Real\>   
DNA motif specific: cutoff between motif target DNA position and DNA conformer placed according to motif for accepting the pair of residues
 Range: 0-
 Default: 0.95

 **-dtest** \<Real\>   
DNA motif specific: cutoff between motif target DNA position and DNA conformer placed according to motif for accepting the pair of residues
 Range: 0-
 Default: 5.5

 **-rotlevel** \<Integer\>   
level of rotamer sampling for motif search
 Range: 1-
 Default: 5

 **-num\_repacks** \<Integer\>   
number of cycles of dropping special\_rot weight and design
 Range: 0-
 Default: 5

 **-minimize** \<Boolean\>   
whether or not to minimize the motifs toward the xtal structure DNA
 Default: true

 **-minimize\_dna** \<Boolean\>   
whether or not to minimize DNA after every round of design with special\_rot weight dropping
 Default: true

 **-run\_motifs** \<Boolean\>   
whether or not to use motifs in DnaPackerMotif
 Default: true

 **-expand\_motifs** \<Boolean\>   
whether or not to use expand (use all types) motifs in DnaPackerMotif
 Default: true

 **-aromatic\_motifs** \<Boolean\>   
whether or not to use expand (use aromatic only types) motifs in DnaPackerMotif
 Default: true

 **-dump\_motifs** \<Boolean\>   
whether or not to output pdbs with the best rotamer/conformer for each motifs
 Default: true

 **-quick\_and\_dirty** \<Boolean\>   
quick motif run to get a list of all possible motifs before doing a real run
 Default: true

 **-special\_rotweight** \<Real\>   
starting weight for the weight on motif rotamers
 Default: -40.0

 **-output\_file** \<String\>   
name of output file for all the best motifs and rotamers or for the dna\_motif\_collector it is the file where all the motifs are dumped

 **-data\_file** \<String\>   
name of output file for any data about how many rotamers and motifs pass what tests, etc

 **-constraint\_max** \<Real\>   
highest value for constraint score (before and after minimization) that results in the rotamer being dropped
 Range: 0-
 Default: 20.0

 **-flex\_sugar** \<Boolean\>   
whether or not to add the flexible sugar, not using PB way of adding options
 Default: true

 **-clear\_bprots** \<Boolean\>   
whether or not to clear the rotamers that were read in from a previous run and restart with only the motifs that were read in and the specified rotlevel
 Default: true

 **-rots2add** \<Integer\>   
number of rotamers to add to design from the MotifSearch for each amino acid type
 Range: 1-
 Default: 100

 **-restrict\_to\_wt** \<Boolean\>   
restrict the motif search to finding motifs of the same amino acid as the starting pose, for homology modeling
 Default: true

 **-rerun\_motifsearch** \<Boolean\>   
setting the MotifSearch to run again, using the rotamers in the build position, most likely to change stringency or amino acid type on a second run
 Default: true

 **-no\_rotamer\_bump** \<Boolean\>   
skip the bump check when making the rotamers that will be tested for motif interactions, makes code much slower, but it is advised to increase the max\_rotbump\_energy to at least 10.0 instead of the default of 5.0 if bump\_check is being used
 Default: false

 **-ligand\_motif\_sphere** \<Real\>   
option to specify radius of motif search around ligand
 Default: 6.0

-   -constraints
    ------------

 **-constraints** \<Boolean\>   
constraints option group

 **-CA\_tether** \<Real\>   
default CA tether for harmonic constraints
 Default: 2.0

 **-exit\_on\_bad\_read** \<Boolean\>   
exit if error is encountered reading constraints
 Default: false

 **-cst\_file** \<StringVector\>   
constraints filename(s) for centoroid. When multiple files are given a *random* one will be picked.

 **-cst\_weight** \<Real\>   
No description
 Default: 1.0

 **-max\_cst\_dist** \<Real\>   
No description
 Default: 12.0

 **-cst\_fa\_file** \<StringVector\>   
constraints filename(s) for fullatom. When multiple files are given a *random* one will be picked.

 **-cst\_fa\_weight** \<Real\>   
No description
 Default: 1.0

 **-normalize\_mixture\_func** \<Boolean\>   
No description
 Default: false

 **-penalize\_mixture\_func** \<Boolean\>   
No description
 Default: true

 **-forest\_file** \<File\>   
file with constraintforest
 Default: ""

 **-compute\_total\_dist\_cst** \<Boolean\>   
only relevant for debug: atom\_pair\_constraints during abinito depends on seq\_sep, this computes also the score without regarding seq\_sep
 Default: false

 **-cull\_with\_native** \<Integer\>   
if option is set all constraints that violate the native structure with more than X are thrown out!
 Default: 1

 **-dump\_cst\_set** \<File\>   
dump the cstset\_ to file
 Default: ""

 **-evaluate\_max\_seq\_sep** \<IntegerVector\>   
evaluate constraints to this seq-sep [vector]
 Default: 0

 **-named** \<Boolean\>   
enable named constraints to avoid problems with changing residue-types e.g., cutpoint-variants
 Default: false

 **-no\_cst\_in\_relax** \<Boolean\>   
remove constraints for relax
 Default: false

 **-no\_linearize\_bounded** \<Boolean\>   
dont switch to linearized in BOUNDED func
 Default: false

 **-pocket\_constraint\_weight** \<Real\>   
Weight of the Pocket Constraint
 Default: 0

 **-pocket\_zero\_derivatives** \<Boolean\>   
Return zero for PocketConstaint derivatives
 Default: false

 **-viol** \<Boolean\>   
show violations
 Default: false

 **-viol\_level** \<Integer\>   
how much detail for violation output
 Default: 1

 **-viol\_type** \<String\>   
work only on these types of constraints
 Default: ""

 **-sog\_cst\_param** \<Real\>   
weight parameter for SOGFunc constraints
 Default: 0.0

 **-sog\_upper\_bound** \<Real\>   
Upper cutoff for SOGFunc constraints
 Default: 10.0

 **-epr\_distance** \<Boolean\>   
use epr distance potential
 Default: false

 **-combine** \<Integer\>   
combine constraints randomly into OR connected groups (Ambiguous). N-\>1
 Default: 1

 **-combine\_exclude\_region** \<File\>   
core-defintion file do not combine constraints that are core-core

 **-skip\_redundant** \<Boolean\>   
skip redundant constraints
 Default: false

 **-skip\_redundant\_width** \<Integer\>   
radius of influence for redundant constraints
 Default: 2

 **-increase\_constraints** \<Real\>   
Multiplicative factor applied to constraints. Not widely supported yet.
 Default: 1.0

-   -dna
    ----

 **-dna** \<Boolean\>   
dna option group

-   ### -dna:specificity

 **-specificity** \<Boolean\>   
specificity option group

 **-exclude\_dna\_dna** \<Boolean\>   
No description
 Default: true

 **-params** \<RealVector\>   
vector of real-valued params

 **-frag\_files** \<FileVector\>   
files to collect frags from

 **-exclude\_bb\_sc\_hbonds** \<Boolean\>   
No description
 Default: false

 **-only\_repack** \<Boolean\>   
No description
 Default: false

 **-design\_DNA** \<Boolean\>   
No description
 Default: false

 **-run\_test** \<Boolean\>   
No description
 Default: false

 **-soft\_rep** \<Boolean\>   
No description
 Default: false

 **-dump\_pdbs** \<Boolean\>   
No description
 Default: false

 **-fast** \<Boolean\>   
No description
 Default: false

 **-randomize\_motif** \<Boolean\>   
No description
 Default: false

 **-Wfa\_elec** \<Real\>   
No description
 Default: 0

 **-Wdna\_bs** \<Real\>   
No description
 Default: 0

 **-Wdna\_bp** \<Real\>   
No description
 Default: 0

 **-minimize\_tolerance** \<Real\>   
No description
 Default: 0.001

 **-weights\_tag** \<String\>   
No description

 **-weights\_tag\_list** \<String\>   
No description

 **-min\_type** \<String\>   
No description
 Default: "dfpmin"

 **-tf** \<String\>   
No description

 **-mode** \<String\>   
No description

 **-score\_function** \<String\>   
No description

 **-pre\_minimize** \<Boolean\>   
No description
 Default: false

 **-post\_minimize** \<Boolean\>   
No description
 Default: false

 **-pre\_pack** \<Boolean\>   
No description
 Default: false

 **-nloop** \<Integer\>   
No description
 Default: 20

 **-n\_inner** \<Integer\>   
No description

 **-n\_outer** \<Integer\>   
No description

 **-nstep\_water** \<Integer\>   
No description
 Default: 0

 **-moving\_jump** \<Integer\>   
No description
 Default: 0

 **-motif\_begin** \<Integer\>   
No description
 Default: 0

 **-motif\_size** \<Integer\>   
No description
 Default: 0

 **-pdb\_pos** \<StringVector\>   
list of one or more positions in the input pdb, eg: -pdb\_pos 125:A 127:A 4:C
 Default: ""

 **-methylate** \<StringVector\>   
list of one or more positions in the input pdb to be methylated, eg: -methylate 125:A 127:A 4:C
 Default: ""

-   ### -dna:design

 **-design** \<Boolean\>   
design option group

 **-output\_initial\_pdb** \<Boolean\>   
write pdb file for loaded and scored input structure
 Default: false

 **-output\_unbound\_pdb** \<Boolean\>   
write out an unbound pdb if doing binding score calculations
 Default: false

 **-z\_cutoff** \<Real\>   
distance along DNA-axis from designing DNA bases to allow amino acids to design
 Range: 0-
 Default: 3.5

 **-protein\_scan** \<String\>   
single-residue scanning of protein residue types for binding and specificity scores
 Default: "ACDEFGHIKLMNPQRSTVWY"

 **-checkpoint** \<String\>   
write/read checkpoint files for higher-level protocols that proceed linearly for long periods of time. Provide a checkpoint filename after this option.
 Default: ""

 **-minimize** \<Boolean\>   
Perform minimization in DNA design mode.
 Default: false

 **-iterations** \<Integer\>   
 Range: 1-
 Default: 1

 **-bb\_moves** \<String\>   
 Default: "ccd"

 **-dna\_defs** \<StringVector\>   
 Default: ""

 **-dna\_defs\_file** \<String\>   
 Default: ""

 **-preminimize\_interface** \<Boolean\>   
 Default: false

 **-prepack\_interface** \<Boolean\>   
 Default: false

 **-flush** \<Boolean\>   
enable some tracer flushes in order to see more frequent output
 Default: false

 **-nopdb** \<Boolean\>   
use this flag to disable pdb output
 Default: false

 **-nopack** \<Boolean\>   
don't actually repack structures
 Default: false

 **-more\_stats** \<Boolean\>   
No description
 Default: false

 **-pdb\_each\_iteration** \<Boolean\>   
No description
 Default: false

 **-designable\_second\_shell** \<Boolean\>   
No description
 Default: false

 **-base\_contacts\_only** \<Boolean\>   
No description
 Default: false

 **-probe\_specificity** \<Integer\>   
Rapidly estimate the explicit specificity of DNA designs during fixed-backbone repacking
 Default: 1

-   #### -dna:design:specificity

 **-specificity** \<Boolean\>   
specificity option group

 **-output\_structures** \<Boolean\>   
output structures for each sequence combination
 Default: false

 **-include\_dna\_potentials** \<Boolean\>   
include DNA potentials in calculations of DNA sequence specificity
 Default: false

-   ### -dna:design

 **-reversion\_scan** \<Boolean\>   
Try to revert spurious mutations after designing
 Default: false

-   #### -dna:design:reversion

 **-reversion** \<Boolean\>   
reversion option group

 **-dscore\_cutoff** \<Real\>   
limit for acceptable loss in energy
 Default: 1.5

 **-dspec\_cutoff** \<Real\>   
limit for acceptable loss in specificity
 Default: -0.05

-   ### -dna:design

 **-binding** \<Boolean\>   
compute a protein-DNA binding energy
 Default: false

 **-Boltz\_temp** \<Real\>   
temperature for Boltzmann calculations
 Default: 0.6

 **-repack\_only** \<Boolean\>   
Do not allow protein sequences to mutate arbitrarily
 Default: false

 **-sparse\_pdb\_output** \<Boolean\>   
Output only coordinates that change relative to the input structure
 Default: false

-   -flxbb
    ------

 **-flxbb** \<Boolean\>   
flxbb option group

 **-view** \<Boolean\>   
viewing pose during protocol

 **-ncycle** \<Integer\>   
number of cycles of design and relax

 **-constraints\_sheet** \<Real\>   
weight constraints between Ca atoms in beta sheet

 **-constraints\_sheet\_include\_cacb\_pseudotorsion** \<Boolean\>   
puts an additional constraint on two residues paired in a beta-sheet to ensure their CA-CB vectors are pointing the same way.
 Default: false

 **-constraints\_NtoC** \<Real\>   
weight constraints between N- and C- terminal CA atoms

 **-filter\_trial** \<Integer\>   
number of filtering trial

 **-filter\_type** \<String\>   
filter type name, currently only packstat is available

 **-exclude\_Met** \<Boolean\>   
do not use Met for design

 **-exclude\_Ala** \<Boolean\>   
do not use Ala for design

 **-blueprint** \<File\>   
blueprint file

 **-movemap\_from\_blueprint** \<Boolean\>   
viewing pose during protocol

-   ### -flxbb:layer

 **-layer** \<String\>   
design core, boundary, and surface with different aa types
 Default: "normal"

 **-pore\_radius** \<Real\>   
sphere radius for sasa calculation

 **-burial** \<Real\>   
surface area when residues regarded as core

 **-surface** \<Real\>   
surface area when residues regarded as surface

-   -fldsgn
    -------

 **-fldsgn** \<Boolean\>   
fldsgn option group

 **-view** \<Boolean\>   
viewing pose during protocol

 **-blueprint** \<FileVector\>   
blueprint filename(s).
 Default: ['"blueprint"']

 **-dr\_cycles** \<Integer\>   
design-refine cycles
 Default: 3

 **-centroid\_sfx** \<String\>   
filename of the centroid score function to use,

 **-centroid\_sfx\_patch** \<String\>   
filename of the centroid score function patch to use,

 **-fullatom\_sfx** \<String\>   
filename of the full-atom score function to use

 **-fullatom\_sfx\_patch** \<String\>   
filename of the full-atom score function patch to use

 **-run\_flxbb** \<Integer\>   
run flxbb at the given stage

-   -rna
    ----

 **-rna** \<Boolean\>   
rna option group

 **-minimize\_rounds** \<Integer\>   
The number of rounds of minimization.
 Default: 2

 **-corrected\_geo** \<Boolean\>   
Use PHENIX-based RNA sugar close energy and params files
 Default: true

 **-vary\_geometry** \<Boolean\>   
Let bond lengths and angles vary from ideal in minimizer
 Default: false

 **-skip\_coord\_constraints** \<Boolean\>   
Skip first stage of minimize with coordinate constraints
 Default: false

 **-skip\_o2prime\_trials** \<Boolean\>   
No O2\* packing in minimizer
 Default: false

 **-vall\_torsions** \<String\>   
Torsions file containing information on fragments from RNA models
 Default: "rna.torsions"

 **-jump\_database** \<Boolean\>   
Generate a database of jumps extracted from base pairings from a big RNA file
 Default: false

 **-bps\_database** \<Boolean\>   
Generate a database of base pair steps extracted from a big RNA file
 Default: false

 **-rna\_prot\_erraser** \<Boolean\>   
Allows rna\_prot\_erraser residue type set, featuring both RNA and protein (for ERRASER purposes). You must also use -rna:corrected\_geo.
 Default: false

 **-deriv\_check** \<Boolean\>   
In rna\_minimize, check derivatives numerically
 Default: false

-   -cm
    ---

 **-cm** \<Boolean\>   
cm option group

-   ### -cm:sanitize

 **-sanitize** \<Boolean\>   
sanitize option group

 **-bound\_delta** \<Real\>   
Distance in Angstroms from aligned position before a penalty is incurred
 Default: 0.5

 **-bound\_sd** \<Real\>   
Value of standard deviation in bound func
 Default: 1.0

 **-num\_fragments** \<Integer\>   
Use the top k fragments at each position during sanitization
 Default: 25

 **-cst\_weight\_pair** \<Real\>   
atom\_pair\_constraint weight
 Default: 1.0

 **-cst\_weight\_coord** \<Real\>   
coordinate\_constraint weight
 Default: 1.0

-   -cm
    ---

 **-start\_models\_only** \<Boolean\>   
Make starting models only!
 Default: false

 **-aln\_format** \<String\>   
No description
 Default: "grishin"

 **-recover\_side\_chains** \<Boolean\>   
recover side-chains
 Default: false

 **-steal\_extra\_residues** \<FileVector\>   
list of template extra residues (ie ligands) to add to query pose in comparative modeling

 **-loop\_mover** \<String\>   
No description
 Default: "quick\_ccd"

 **-loop\_close\_level** \<Integer\>   
level of aggressiveness to use in closing loops. The integers that follow flags specify how aggressively loops are rebuilt. Each option implies all non-zero levels below it, so that loop\_close\_level 2 implies level 1 as well. Meaning of the options are: NO\_REBUILD 0 don't rebuild loops at all REBUILD\_UNALIGNED 1 rebuild loops around unaligned regions REBUILD\_CHAINBREAK 2 rebuild loops around chainbreaks REBUILD\_EXHAUSTIVE 3 rebuild loops around regions with a chainbreak until no chainbreaks remain
 Default: 0

 **-min\_loop\_size** \<Integer\>   
Minimum size of loops to remodel when building threading models.
 Default: 5

 **-max\_loop\_rebuild** \<Integer\>   
Maximum number of times to try to rebuild a loop before giving up.
 Default: 10

 **-loop\_rebuild\_filter** \<Real\>   
Maximum score a structure must have after loop rebuilding.
 Default: 0

 **-aln\_length\_filter\_quantile** \<Real\>   
Only use alignment lengths longer than the Xth quantile. e.g. setting this to 0.75 will only use the 25% longest alignments
 Default: 0.0

 **-aln\_length\_filter** \<Integer\>   
Only use alignment longer or equal to this length
 Default: -1

 **-template\_ids** \<StringVector\>   
List of template identifiers to use in comparative modeling

 **-ligand\_pdb** \<File\>   
Add a ligand to the system

 **-seq\_score** \<StringVector\>   
sequence-based scoring scheme used for generating alignments
 Default: utility::vector1\<std::string\>(1,"Simple")

 **-aligner** \<String\>   
algorithm for making sequence alignments

 **-min\_gap\_open** \<Real\>   
gap opening penalty for sequence alignments (usually negative)
 Default: -2.0

 **-max\_gap\_open** \<Real\>   
gap opening penalty for sequence alignments (usually negative)
 Default: -2.0

 **-min\_gap\_extend** \<Real\>   
gap extension penalty for sequence alignments (usually negative)
 Default: -0.2

 **-max\_gap\_extend** \<Real\>   
gap extension penalty for sequence alignments (usually negative)
 Default: -0.2

 **-nn** \<Integer\>   
number of neighbors to include in constraint derivation
 Default: 500

 **-fr\_temperature** \<Real\>   
temperature to use during fragment-based refinement of structures
 Default: 2.0

 **-ev\_map** \<FileVector\>   
Input file that maps pdbChains to blast e-values

 **-hh\_map** \<FileVector\>   
Input file that maps pdbChains to hhsearch probabilities

-   ### -cm:hybridize

 **-hybridize** \<Boolean\>   
hybridize option group

 **-templates** \<FileVector\>   
Input list of template files

 **-template\_list** \<File\>   
Input list of templates, constaints, cluster, and weights

 **-starting\_template** \<IntegerVector\>   
Define starting templates

 **-realign\_domains** \<Boolean\>   
domain parse and realign the starting templates
 Default: true

 **-add\_non\_init\_chunks** \<Boolean\>   
non chunks from templates other than the initial one
 Default: false

 **-ss** \<String\>   
secondary structure elements used to split the pose
 Default: "HE"

 **-stage1\_increase\_cycles** \<Real\>   
Scale stage 1 cycles
 Default: 1.0

 **-stage2\_increase\_cycles** \<Real\>   
Scale stage 2 cycles
 Default: 1.0

 **-stage2min\_increase\_cycles** \<Real\>   
Scale minimizer cycles after stage 2
 Default: 1.0

 **-stage1\_probability** \<Real\>   
Probability of running stage 1, 0=never, 1=always
 Default: 1.0

 **-stage1\_weights** \<String\>   
weight for fold tree hybridize stage
 Default: "score3"

 **-stage1\_patch** \<String\>   
weight patch for fold tree hybridize stage
 Default: ""

 **-skip\_stage2** \<Boolean\>   
skip cartesian fragment hybridize stage
 Default: false

 **-no\_global\_frame** \<Boolean\>   
no global-frame fragment insertions
 Default: false

 **-linmin\_only** \<Boolean\>   
linmin only in stage 2
 Default: false

 **-stage2\_weights** \<String\>   
weight for cartesian fragment hybridize stage
 Default: "score4\_smooth\_cart"

 **-stage2\_patch** \<String\>   
weight patch for cartesian fragment hybridize stage
 Default: ""

 **-relax** \<Integer\>   
if n==1, perform relax at end; if n\>1 perform batch relax over n centroids
 Default: 0

 **-frag\_weight\_aligned** \<Real\>   
Probability of fragment insertion in the aligned region
 Default: 0.

 **-move\_anchor** \<Boolean\>   
move anchor residue when copying xyz in stage 1
 Default: false

 **-max\_registry\_shift** \<Integer\>   
maximum registry shift
 Default: 0

 **-alignment\_from\_template\_seqpos** \<Boolean\>   
alignment from template resSeq
 Default: true

 **-alignment\_from\_chunk\_mapping** \<IntegerVector\>   
alignment from secondary structure mapping

 **-virtual\_loops** \<Boolean\>   
use virtual loops
 Default: false

 **-revert\_real\_loops** \<Boolean\>   
revert back to non-virtual loops
 Default: false

 **-realign\_domains\_stage2** \<Boolean\>   
realign the starting templates to the pose after stage1
 Default: false

 **-frag\_1mer\_insertion\_weight** \<Real\>   
weight for 1mer fragment insertions where fragments are not allowed vs. template chunk insertions in stage1
 Default: 0.0

 **-small\_frag\_insertion\_weight** \<Real\>   
weight for small fragment insertions where large fragments are not allowed vs. template chunk insertions in stage1
 Default: 0.0

 **-big\_frag\_insertion\_weight** \<Real\>   
weight for big fragment insertions vs. template chunk insertions in stage1
 Default: 0.5

 **-auto\_frag\_insertion\_weight** \<Boolean\>   
automatically set the weight for fragment insertions vs. template chunk insertions in stage1
 Default: true

 **-stage1\_1\_cycles** \<Integer\>   
Number of cycles for ab initio stage 1 in Stage1
 Default: 2000

 **-stage1\_2\_cycles** \<Integer\>   
Number of cycles for ab initio stage 2 in Stage1
 Default: 2000

 **-stage1\_3\_cycles** \<Integer\>   
Number of cycles for ab initio stage 3 in Stage1
 Default: 2000

 **-stage1\_4\_cycles** \<Integer\>   
Number of cycles for ab initio stage 4 in Stage1
 Default: 400

 **-stage2\_temperature** \<Real\>   
Monte Carlo temperature in the stage2
 Default: 2.0

 **-stage1\_4\_cenrot\_score** \<String\>   
Switch to cenrot model in stage1\_4
 Default: "score\_cenrot\_cm\_stage1\_4.wts"

-   -ms
    ---

 **-ms** \<Boolean\>   
ms option group

 **-share\_data** \<Boolean\>   
share rotamers and energies between states – valid only if state variability is defined rotamerically
 Default: false

 **-verbose** \<Boolean\>   
 Default: false

 **-restrict\_to\_canonical** \<Boolean\>   
design only canonical residue types
 Default: false

 **-pop\_from\_ss** \<Integer\>   
generate starting sequence population based on single-state design results
 Default: 0

 **-pop\_size** \<Integer\>   
genetic algorithm population size
 Default: 100

 **-generations** \<Integer\>   
number of genetic algorithm generations
 Default: 20

 **-num\_packs** \<Integer\>   
number of repack trials per sequence/state combination
 Default: 1

 **-numresults** \<Integer\>   
number of top-fitness results to save for explicit reference at the end of multistate design
 Default: 1

 **-anchor\_offset** \<Real\>   
energy offset from the energy of single-state design toward the target state – used to generate an affinity anchor for fitness calculations
 Default: 5.0

 **-Boltz\_temp** \<Real\>   
thermodynamic temperature to use for specificity calculations
 Default: 0.6

 **-mutate\_rate** \<Real\>   
rate of mutation per position
 Default: 0.5

 **-fraction\_by\_recombination** \<Real\>   
fraction of the population that should be generated by recombination during the evolution stage
 Default: 0.5

-   ### -ms:checkpoint

 **-checkpoint** \<Boolean\>   
checkpoint option group

 **-prefix** \<String\>   
prefix to add to the beginning of checkpoint file names
 Default: ""

 **-interval** \<Integer\>   
frequency with which the entity checkpoint is written
 Default: 0

 **-gz** \<Boolean\>   
compress checkpoing files with gzip
 Default: false

 **-rename** \<Boolean\>   
rename checkpoint files after genetic algorithm completes
 Default: false

-   -loops
    ------

 **-loops** \<Boolean\>   
loop modeling option group
 Default: true

 **-cen\_weights** \<String\>   
ScoreFunction weights file for centroid phase of loop-modeling
 Default: "cen\_std"

 **-cen\_patch** \<String\>   
ScoreFunction patch for for centroid phase of loop-modeling
 Default: "score4L"

 **-input\_pdb** \<File\>   
template pdb file
 Default: "input\_pdb"

 **-loop\_file** \<StringVector\>   
Loop definition file(s). When multiple files are given a *random* one will be picked each time when this parameter is requested.

 **-extended\_loop\_file** \<File\>   
loop definition file for loops to be extended (used in abrelax)
 Default: "loop\_file"

 **-mm\_loop\_file** \<File\>   
loop definition file
 Default: "loop\_file"

 **-fix\_natsc** \<Boolean\>   
fix sidechains in template region in loop modeling
 Default: false

 **-refine\_only** \<Boolean\>   
perform full atom refinement only on loops
 Default: false

 **-fa\_input** \<Boolean\>   
input structures are in full atom format
 Default: false

 **-fast** \<Boolean\>   
reduce number of simulation cycles in loop modeling
 Default: false

 **-vall\_file** \<File\>   
vall database file
 Default: "vall\_file"

 **-frag\_sizes** \<IntegerVector\>   
lengths of fragments to be used in loop modeling
 Default: ['9', '3', '1']

 **-frag\_files** \<FileVector\>   
fragment libraries files
 Default: ['"frag9"', '"frag3"', '"frag1"']

 **-output\_pdb** \<File\>   
output model pdb file
 Default: "output.pdb"

 **-debug** \<Boolean\>   
No description
 Default: false

 **-build\_initial** \<Boolean\>   
Precede loop-modeling with an initial round of just removing the missing densities and building simple loops
 Default: false

 **-extended** \<Boolean\>   
Force extended on loops, independent of loop input file
 Default: false

 **-remove\_extended\_loops** \<Boolean\>   
Before building any loops, remove all loops marked as extended
 Default: false

 **-idealize\_after\_loop\_close** \<Boolean\>   
Run structure through idealizer after loop\_closing
 Default: false

 **-idealize\_before\_loop\_close** \<Boolean\>   
Run structure through idealizer before loop\_closing
 Default: false

 **-select\_best\_loop\_from** \<Integer\>   
Keep building loops until N and choose best (by score)
 Default: 1

 **-build\_attempts** \<Integer\>   
Build attempts per growth attempt
 Default: 3

 **-grow\_attempts** \<Integer\>   
Total loop growth attempts
 Default: 7

 **-random\_grow\_loops\_by** \<Real\>   
Randomly grow loops by up to this number of residues on either side.
 Default: 0.0

 **-accept\_aborted\_loops** \<Boolean\>   
accept aborted loops
 Default: false

 **-strict\_loops** \<Boolean\>   
Do not allow growing of loops
 Default: false

 **-superimpose\_native** \<Boolean\>   
Superimpose the native over the core before calculating looprms
 Default: false

 **-build\_specific\_loops** \<IntegerVector\>   
Numbers of the loops to be built

 **-random\_order** \<Boolean\>   
build in random order
 Default: true

 **-build\_all\_loops** \<Boolean\>   
build all loops(no skip)
 Default: false

 **-fa\_closure\_protocol** \<Boolean\>   
Abrelax uses FASlidingWindowLoopClosure...
 Default: false

 **-combine\_rate** \<Real\>   
Combine successive loops at this rate
 Default: 0.0

 **-remodel** \<String\>   
 Default: "no"

 **-intermedrelax** \<String\>   
 Default: "no"

 **-refine** \<String\>   
method for performing full-atom refinement on loops
 Default: "no"

 **-relax** \<String\>   
 Default: "no"

 **-n\_rebuild\_tries** \<Integer\>   
number of times to retry loop-rebuilding
 Default: 1

 **-final\_clean\_fastrelax** \<Boolean\>   
Add a final fastrelax without constraints
 Default: false

 **-relax\_with\_foldtree** \<Boolean\>   
keep foldtree during relax
 Default: false

 **-constrain\_rigid\_segments** \<Real\>   
Use Coordinate constraints on the non-loop regions
 Default: 0.0

 **-loopscores** \<String\>   
Calculate loopscores individually

 **-timer** \<Boolean\>   
Output time spent in seconds for each loop modeling job
 Default: false

 **-vicinity\_sampling** \<Boolean\>   
only sample within a certain region of the current torsion values
 Default: false

 **-vicinity\_degree** \<Real\>   
number of degrees to sample within current torsion values for vicinity sampling
 Default: 1.0

 **-neighbor\_dist** \<Real\>   
CB distance cutoff for repacking, rotamer trails, and side-chain minimization during loop modeling. NOTE: values over 10.0 are effectively reduced to 10.0
 Default: 10.0

 **-kic\_max\_seglen** \<Integer\>   
maximum size of residue segments used in kinematic closure calculations
 Default: 12

 **-kic\_recover\_last** \<Boolean\>   
If true, do not recover lowest scoring pose after each outer cycle and at end of protocol in kic remodel and refine
 Default: false

 **-kic\_min\_after\_repack** \<Boolean\>   
Should the kinematic closure refine protocol minimize after repacking steps
 Default: true

 **-optimize\_only\_kic\_region\_sidechains\_after\_move** \<Boolean\>   
Should we perform rotamer trials and minimization after every KIC move but only within the loops:neighbor\_dist of the residues in the moved KIC segment. Useful to speed up when using very large loop definitions (like when whole chains are used for ensemble generation).
 Default: false

 **-max\_kic\_build\_attempts** \<Integer\>   
Number of attempts at initial kinematic closure loop building
 Default: 10000

 **-remodel\_kic\_attempts** \<Integer\>   
Number of kic attempts per inner cycle during perturb\_kic protocol
 Default: 300

 **-max\_kic\_perturber\_samples** \<Integer\>   
Maximum number of kinematic perturber samples
 Default: 500

 **-nonpivot\_torsion\_sampling** \<Boolean\>   
enables sampling of non-pivot residue torsions when the kinematic loop closure segment length is \> 3
 Default: true

 **-fix\_ca\_bond\_angles** \<Boolean\>   
Freezes N-CA-C bond angles in KIC loop sampling
 Default: false

 **-kic\_use\_linear\_chainbreak** \<Boolean\>   
Use linear\_chainbreak instead of (harmonic) chainbreak in KIC loop sampling
 Default: false

 **-sample\_omega\_at\_pre\_prolines** \<Boolean\>   
Sample omega in KIC loop sampling
 Default: false

 **-allow\_omega\_move** \<Boolean\>   
Allow loop omega to minimize during loop modeling
 Default: false

 **-kic\_with\_cartmin** \<Boolean\>   
Use cartesian minimization in KIC loop modeling
 Default: false

 **-allow\_takeoff\_torsion\_move** \<Boolean\>   
Allow takeoff phi/psi to move during loop modeling
 Default: false

 **-extend\_length** \<Integer\>   
Number of alanine residues to append after cutpoint in loopextend app
 Range: 0-
 Default: 0

 **-outer\_cycles** \<Integer\>   
outer cycles in fullatom loop refinement
 Range: 1-
 Default: 3

 **-max\_inner\_cycles** \<Integer\>   
maxium number of inner cycles in fullatom loop refinement
 Range: 1-
 Default: 1

 **-repack\_period** \<Integer\>   
repack period during fullatom loop refinement
 Range: 1-
 Default: 20

 **-repack\_never** \<Boolean\>   
option to disable repacking during loop movement
 Default: false

 **-remodel\_init\_temp** \<Real\>   
Initial temperature for loop rebuiding. Currently only supported in kinematic (KIC) mode
 Default: 2.0

 **-remodel\_final\_temp** \<Real\>   
Final temperature for loop rebuilding. Currently only supported in kinematic (KIC) mode
 Default: 1.0

 **-refine\_init\_temp** \<Real\>   
Initial temperature for loop refinement. Currently only supported in kinematic (KIC) mode
 Default: 1.5

 **-refine\_final\_temp** \<Real\>   
Final temperature for loop refinement. Currently only supported in kinematic (KIC) mode
 Default: 0.5

 **-gapspan** \<Integer\>   
when automatically identifying loop regions, this is the maximum gap length for a single loop
 Range: 1-
 Default: 6

 **-spread** \<Integer\>   
when automatically identifying loop regions, this is the number of neighboring residues by which to extend out loop regions
 Range: 1-
 Default: 2

 **-kinematic\_wrapper\_cycles** \<Integer\>   
maximum number of KinematicMover apply() tries per KinematicWrapper apply()
 Default: 20

 **-kic\_num\_rotamer\_trials** \<Integer\>   
number of RotamerTrial iterations in each KIC cycle – default is 1
 Default: 1

 **-kic\_omega\_sampling** \<Boolean\>   
Perform sampling of omega angles around 179.6 for trans, and including 0 for pre-prolines – default false, for legacy reasons
 Default: false

 **-kic\_bump\_overlap\_factor** \<Real\>   
allow some atomic overlap in initial loop closures (should be remediated in subsequent repacking and minimization)
 Default: 0.36

 **-kic\_cen\_weights** \<String\>   
centroid weight set to be used for KIC and next-generation KIC – note that the smooth weights are strongly recommended for use with Talaris2013
 Default: "score4\_smooth"

 **-kic\_cen\_patch** \<String\>   
weights patch file to be used for KIC+NGK centroid modeling stage
 Default: ""

 **-restrict\_kic\_sampling\_to\_torsion\_string** \<String\>   
restrict kinematic loop closure sampling to the phi/psi angles specified in the torsion string
 Default: ""

 **-derive\_torsion\_string\_from\_native\_pose** \<Boolean\>   
apply torsion-restricted sampling, and derive the torsion string from the native [or, if not provided, starting] structure
 Default: false

 **-always\_remodel\_full\_loop** \<Boolean\>   
always remodel the full loop segment (i.e. the outer pivots are always loop start & end) – currently this only applies to the perturb stage – EXPERIMENTAL
 Default: false

 **-taboo\_sampling** \<Boolean\>   
enhance diversity in KIC sampling by pre-generating different torsion bins and sampling within those – this flag activates Taboo sampling in the perturb stage
 Default: false

 **-taboo\_in\_fa** \<Boolean\>   
enhance diversity in KIC sampling by pre-generating different torsion bins and sampling within those – this flag activates Taboo sampling in the first half of the full-atom stage; use in combination with -loops:taboo\_sampling or -kic\_leave\_centroid\_after\_initial\_closure
 Default: false

 **-ramp\_fa\_rep** \<Boolean\>   
ramp the weight of fa\_rep over outer cycles in refinement
 Default: false

 **-ramp\_rama** \<Boolean\>   
ramp the weight of rama over outer cycles in refinement
 Default: false

 **-kic\_rama2b** \<Boolean\>   
use neighbor-dependent Ramachandran distributions in random torsion angle sampling
 Default: false

 **-kic\_small\_moves** \<Boolean\>   
sample torsions by adding or subtracting a small amount from the previous value, instead of picking from the Ramachandran distribution.
 Default: false

 **-kic\_small\_move\_magnitude** \<Real\>   
specify the magnitude of the small moves. Only meant to be used for initial testing and optimization.
 Default: 5.0

 **-kic\_pivot\_based** \<Boolean\>   
use ramachandran sampling if the pivots are closer than 8 residues apart, otherwise use small moves.
 Default: false

 **-kic\_no\_centroid\_min** \<Boolean\>   
don't minimize in centroid mode during KIC perturb
 Default: false

 **-kic\_leave\_centroid\_after\_initial\_closure** \<Boolean\>   
only use centroid mode for initial loop closure – all further loop closures will be performed in full-atom
 Default: false

 **-kic\_repack\_neighbors\_only** \<Boolean\>   
select neigbors for repacking via the residue-dependent NBR\_RADIUS, not via a generic threshold (WARNING: this overrides any setting in -loops:neighbor\_dist)
 Default: false

 **-legacy\_kic** \<Boolean\>   
always select the start pivot first and then the end pivot – biases towards sampling the C-terminal part of the loop more (false by default)
 Default: false

 **-alternative\_closure\_protocol** \<Boolean\>   
use WidthFirstSliding...
 Default: false

 **-chainbreak\_max\_accept** \<Real\>   
accept all loops that have a lower cumulative chainbreak score (linear,quadratic(if present), and overlap)
 Default: 2.0

 **-debug\_loop\_closure** \<Boolean\>   
dump structures before and after loop closing
 Default: false

 **-non\_ideal\_loop\_closing** \<Boolean\>   
allow small non-idealities at the chainbreak residue after loop-closing – requires binary silent out
 Default: false

 **-scored\_frag\_cycles** \<Real\>   
cycle-ratio for scored\_frag\_cycles ( loop\_size\<10 ) after jumping-abinitio
 Default: 0.1

 **-short\_frag\_cycles** \<Real\>   
cycle-ratio for short\_frag\_cycles ( loop\_size\<10 ) after jumping-abinitio
 Default: 0.2

 **-rmsd\_tol** \<Real\>   
rmsd tolerance to deviate from original pose
 Default: 10000.0

 **-chain\_break\_tol** \<Real\>   
acceptable tolerance for chain break score
 Default: 0.2

 **-random\_loop** \<Boolean\>   
randomize loop stub positions
 Default: false

 **-stealfrags** \<FileVector\>   
StealFragPDBS

 **-stealfrags\_times** \<Integer\>   
StealFragPDBS how many times ?
 Default: 1

 **-coord\_cst** \<Real\>   
restraintweight
 Default: 0.0

 **-skip\_1mers** \<Real\>   
rate at which you should skip a 1 mer insertion
 Default: 0.0

 **-skip\_3mers** \<Real\>   
rate at which you should skip a 3 mer insertion
 Default: 0.0

 **-skip\_9mers** \<Real\>   
rate at which you should skip a 9 mer insertion
 Default: 0.0

 **-loop\_model** \<Boolean\>   
loop modeling option
 Default: false

 **-score\_filter\_cutoff** \<Real\>   
value for score filter
 Default: 1.0

 **-loop\_farlx** \<Boolean\>   
do fullatom loop refinement
 Default: false

 **-ccd\_closure** \<Boolean\>   
apply ccd closure
 Default: false

 **-skip\_ccd\_moves** \<Boolean\>   
when running in ccd\_moves mode, dont actually do ccd\_moves.. just do fragment insertions
 Default: false

 **-no\_randomize\_loop** \<Boolean\>   
Leave loop as it is
 Default: false

 **-loops\_subset** \<Boolean\>   
pick subset of desired loops
 Default: false

 **-num\_desired\_loops** \<Integer\>   
number of desired loops
 Default: 1

 **-loop\_combine\_rate** \<Real\>   
skip rate for not combining a chosen loop
 Default: 0.0

 **-final\_score\_filter** \<Real\>   
Only output structures that score bette rthan that
 Default: 1000000.0

 **-no\_combine\_if\_fail** \<Boolean\>   
combine loops if loop modeling fails
 Default: true

 **-shorten\_long\_terminal\_loop** \<Boolean\>   
shorten long loops
 Default: false

 **-backrub\_trials** \<Integer\>   
number of backrub steps to do in loop relax
 Default: 10

 **-looprlx\_cycle\_ratio** \<Real\>   
fraction of the total looprlx cycles
 Default: 1.0

 **-extended\_beta** \<Real\>   
Extended tempfactor: stochastic extendedness: p\_ext = exp( - beta \* length )
 Default: -1.0

 **-shortrelax** \<Boolean\>   
do a short fullatom relax after loop remodeling
 Default: false

 **-fastrelax** \<Boolean\>   
do a fast fullatom relax after loop remodeling
 Default: false

 **-no\_looprebuild** \<Boolean\>   
do not rebuild loops
 Default: false

 **-allow\_lig\_move** \<Boolean\>   
allow ligands to move during loop modeling
 Default: false

 **-keep\_natro** \<File\>   
list of residues where the rotamers are kept fixed
 Default: "keep\_natro"

 **-refine\_design\_iterations** \<Integer\>   
iterations of refine and design
 Default: 1

-   ### -loops:loop\_closure

 **-loop\_closure** \<Boolean\>   
loop\_closure option group

 **-loop\_insert** \<String\>   
List of chain names with loop sizes in between where loops are inserted. e.g. A5B6CDE to insert a loop of size 5 in between A and B, and a loop of 6 between B and C. loop\_insert\_, loop\_insert\_rclrc and blueprint options are mutually exclusive.

 **-loop\_insert\_rclrc** \<String\>   
Comma delimited list of tuples, each formed as R1C1:L:R2C2, where R1C1 means residue R1 in chain C1 as start terminal and R2 in C2 as end terminal of the loop to be created. N is the length of the loop in number of residues. e.g. 25A:7:28B,50B:6:53C for building a loop of length 6 between res 25 in chain A and 29 in chain B , and another with 6 residues between res 50 in chain B and 53 in chain C. loop\_insert, loop\_insert\_rclrc and blueprint options are mutually exclusive.

 **-blueprint** \<String\>   
path to a blueprint file specifying loops. loop\_insert, loop\_insert\_rclrc and blueprint options are mutually exclusive

-   -assembly
    ---------

 **-assembly** \<Boolean\>   
assembly option group

 **-pdb1** \<File\>   
pdb1 file

 **-pdb2** \<File\>   
pdb2 file

 **-nterm\_seq** \<String\>   
extra sequence at Nterminus
 Default: ""

 **-cterm\_seq** \<String\>   
extra sequence at Cterminus
 Default: ""

 **-linkers\_pdb1** \<IntegerVector\>   
Residue numbers to be built as linkers

 **-linkers\_pdb2** \<IntegerVector\>   
Residue numbers to be built as linkers

 **-preserve\_sidechains\_pdb1** \<IntegerVector\>   
Residue numbers to be sidchain-preserved

 **-preserve\_sidechains\_pdb2** \<IntegerVector\>   
Residue numbers to be sidchain-preserved

-   -fast\_loops
    ------------

 **-fast\_loops** \<Boolean\>   
fast\_loops option group

 **-window\_accept\_ratio** \<Real\>   
windows with more than x percent of good loops in fast-loop sampling are used for scored-sampling
 Default: 0.0

 **-nr\_scored\_sampling\_passes** \<Integer\>   
good windows go into scored-sampling N times
 Default: 4

 **-nr\_scored\_fragments** \<Integer\>   
scored loops sampled per good window each pass
 Default: 10

 **-min\_breakout\_good\_loops** \<Integer\>   
stop doing scored sampling if N or more good loops have been found
 Default: 5

 **-min\_breakout\_fast\_loops** \<Integer\>   
stop doing fast sampling if N or more good loops have been found
 Default: 40

 **-min\_good\_loops** \<Integer\>   
treat as failure if less good-loops than
 Default: 0

 **-min\_fast\_loops** \<Integer\>   
treat as failure if less fast-loops than
 Default: 3

 **-vdw\_delta** \<Real\>   
accept as good loop if vdw-score \< vdw-score-start+vdw-delta
 Default: 0

 **-give\_up** \<Integer\>   
if N scored\_frag\_attemps didnt give any good loop – jump out
 Default: 50

 **-chainbreak\_max** \<Real\>   
accept only loops that have a maximum chainbreak score of... (sum of linear\_chainbreak / chainbreak and overlap\_chainbreak
 Default: 0.2

 **-fragsample\_score** \<File\>   
Scorefunction used durgin scored-frag sampling
 Default: "loop\_fragsample.wts"

 **-fragsample\_patch** \<File\>   
Patch weights for scorefunction used during scored-frag sampling

 **-overwrite\_filter\_scorefxn** \<File\>   
force Scorefunction to be used during filter stage (instead last score of sampling protocol)

 **-patch\_filter\_scorefxn** \<File\>   
apply patch to Scorefunction used during filter stage

 **-filter\_cst\_file** \<File\>   
use these constraints to filter loops — additional to whatever is in pose already

 **-filter\_cst\_weight** \<Real\>   
weight for constraints versus normal score (might contain additional constraints)
 Default: 1.0

 **-fast\_relax\_sequence\_file** \<File\>   
use this FastRelax protocol for loop-selection

-   -SSrbrelax
    ----------

 **-SSrbrelax** \<Boolean\>   
SSrbrelax option group

 **-input\_pdb** \<File\>   
input pdb file
 Default: "input\_pdb"

 **-rb\_file** \<File\>   
rb definition file
 Default: "rb\_file"

 **-rb\_param\_file** \<File\>   
rb param file
 Default: "rb\_param\_file"

 **-frag\_sizes** \<IntegerVector\>   
lengths of fragments to be used in loop modeling
 Default: ['9', '3', '1']

 **-frag\_files** \<FileVector\>   
fragment libraries files
 Default: ['"FragFile9"', '"FragFile3"', '"FragFile1"']

-   -boinc
    ------

 **-boinc** \<Boolean\>   
boinc option group

 **-graphics** \<Boolean\>   
The boinc client uses this option for the windowed graphics
 Default: false

 **-fullscreen** \<Boolean\>   
The boinc client uses this option for the screensaver full screen graphics
 Default: false

 **-max\_fps** \<Integer\>   
Maximum frames per second, overrides user preference.
 Default: 0

 **-max\_cpu** \<Integer\>   
Maximum cpu percentage, overrides user preferecne.
 Default: 0

 **-noshmem** \<Boolean\>   
for testing graphics without shared memory.
 Default: false

 **-cpu\_run\_time** \<Integer\>   
Target cpu run time in seconds
 Default: 10800

 **-max\_nstruct** \<Integer\>   
Maximum number of output models (failed or successful) for a given client
 Default: 99

 **-cpu\_frac** \<Real\>   
Percentage of CPU time used for graphics
 Default: 10.0

 **-frame\_rate** \<Real\>   
Number of frames per second for graphics
 Default: 10.0

 **-watchdog** \<Boolean\>   
Turn watchdog on
 Default: false

 **-watchdog\_time** \<Integer\>   
Time interval in seconds used by watchdog to check if run is stuck or going too long (default every 5 minutes)
 Default: 300

 **-cpu\_run\_timeout** \<Integer\>   
Maximum time the WU may exceed the users WU time settings. Default is 4 hours. Used by watchdog.
 Default: 14400

 **-description\_file** \<File\>   
work unit description file
 Default: "rosetta\_description.txt"

-   -LoopModel
    ----------

 **-LoopModel** \<Boolean\>   
LoopModel option group

 **-input\_pdb** \<File\>   
input pdb file
 Default: "LoopModel::input\_pdb"

 **-loop\_file** \<File\>   
input loops list file
 Default: "LoopModel::loop\_file"

-   -AnchoredDesign
    ---------------

 **-AnchoredDesign** \<Boolean\>   
AnchoredDesign option group

 **-anchor** \<File\>   
anchor specification file
 Default: "anchor"

 **-allow\_anchor\_repack** \<Boolean\>   
allow repacking of anchor (default is to prevent)
 Default: false

 **-vary\_cutpoints** \<Boolean\>   
vary loop cutpoints. Picks new cutpoints at start of each nstruct
 Default: false

 **-no\_frags** \<Boolean\>   
use no fragments. Overrides passing an old-style fragment file. Skips new-style fragment generation.
 Default: false

 **-debug** \<Boolean\>   
debug mode (extra checks and pdb dumps)
 Default: false

 **-show\_extended** \<Boolean\>   
dump pre-perturb PDB to check if loop torsions are extended and/or sequence is fuzzed; debugging only
 Default: false

 **-refine\_only** \<Boolean\>   
refine only mode (skip perturbation step)
 Default: false

 **-perturb\_show** \<Boolean\>   
dump perturbed centroid pdbs as well as final results
 Default: false

 **-perturb\_cycles** \<Integer\>   
perturbation phase runs for \<input\> cycles
 Default: 5

 **-perturb\_temp** \<Real\>   
perturbation phase temperature for monte carlo
 Default: 0.8

 **-perturb\_CCD\_off** \<Boolean\>   
CCD-style loop remodeling off in perturb phase (meaning, KIC only)
 Default: false

 **-perturb\_KIC\_off** \<Boolean\>   
KIC-style loop remodeling off in perturb phase (meaning, CCD only)
 Default: false

 **-refine\_CCD\_off** \<Boolean\>   
CCD-style loop remodeling off in refine phase (meaning, KIC only)
 Default: false

 **-refine\_KIC\_off** \<Boolean\>   
KIC-style loop remodeling off in refine phase (meaning, CCD only)
 Default: false

 **-refine\_cycles** \<Integer\>   
refinement phase runs for \<input\> cycles
 Default: 5

 **-refine\_temp** \<Real\>   
refinement phase temperature for monte carlo
 Default: 0.8

 **-refine\_repack\_cycles** \<Integer\>   
refinement phase runs repack every \<input\> cycles
 Range: 2-
 Default: 20

 **-rmsd** \<Boolean\>   
Calculate result structure CA RMSD from starting structure
 Default: false

 **-unbound\_mode** \<Boolean\>   
Ignore the anchor, as if this were loop modeling
 Default: false

 **-chainbreak\_weight** \<Real\>   
Chainbreak term weight
 Default: 2.0

-   ### -AnchoredDesign:filters

 **-filters** \<Boolean\>   
filters option group

 **-score** \<Real\>   
do not print trajectories with scores greater than this total scorefunction value
 Default: 0

 **-sasa** \<Real\>   
do not print trajectories with sasas less than this interface delta sasa value
 Default: 500

 **-omega** \<Boolean\>   
filter out non-trans omegas
 Default: false

-   ### -AnchoredDesign:akash

 **-akash** \<Boolean\>   
akash option group

 **-dyepos** \<Integer\>   
dye position
 Default: 0

-   ### -AnchoredDesign:testing

 **-testing** \<Boolean\>   
testing option group

 **-VDW\_weight** \<Real\>   
centroid VDW weight; testing if 2 better than 1
 Range: 0-
 Default: 1.0

 **-anchor\_via\_constraints** \<Boolean\>   
allow anchor&jump to move; anchor held in place via constraints - you must specify constraints!
 Default: false

 **-delete\_interface\_native\_sidechains** \<Boolean\>   
benchmarking option. delete input sidechains as prepacking step before running centroid or fullatom phases. use if also using use\_input\_sc and doing benchmarking. use\_input\_sc is used because of sidechain minimization, not to maintain input sidechains.

 **-RMSD\_only\_this** \<File\>   
Perform only RMSD calculations without modifying input. Only used for re-running metrics during benchmarking/debugging.

 **-anchor\_noise\_constraints\_mode** \<Boolean\>   
Hold the anchor loosely (via constraints), not rigidly. Automatically generate the constraints from the starting pose. Mildly randomize the anchor's placement before modeling (up to 1 angstrom in x,y,z from initial placement.) Only compatible with single-residue anchors. Used to meet a reviewer's commentary.
 Default: false

 **-super\_secret\_fixed\_interface\_mode** \<Boolean\>   
hold the anchor-containing loop fixed. Currently in testing.
 Default: false

 **-randomize\_input\_sequence** \<Boolean\>   
randomizes the input sequence by packing with a null scorefunction; uses the AnchoredDesign-specified packer task (obeys resfile, etc).
 Default: false

-   -chemically\_conjugated\_docking
    --------------------------------

 **-chemically\_conjugated\_docking** \<Boolean\>   
chemically\_conjugated\_docking option group

 **-UBQpdb** \<File\>   
ubiquitin structure, or the structure for the attached thing that is moving
 Default: "1UBQ.pdb"

 **-E2pdb** \<File\>   
E2 structure, or the structure of the thing that is attached to (has cysteine) and does not move; should be one chain
 Default: "2OB4.pdb"

 **-E2\_residue** \<Integer\>   
E2 catalytic cysteine (PDB numbering) (where the ubiquitin gets attached; assumed to be on the first chain of E2pdb
 Default: 85

 **-SASAfilter** \<Real\>   
filter out structures with interface dSASA less than this
 Default: 1000

 **-scorefilter** \<Real\>   
filter out structures with total score greater than this
 Default: 10

 **-publication** \<Boolean\>   
output statistics used in publication. TURN OFF if not running (original Saha et al.) publication demo.
 Default: false

 **-n\_tail\_res** \<Integer\>   
Number of c-terminal \~tail\~ residues to make flexible (terminus inclusive)
 Default: 3

 **-two\_ubiquitins** \<Boolean\>   
Mind-blowing - use two ubiquitins (assembled for a K48 linkage) to try to examine the transition state. Don't use this option unless trying to reproduce publication XXXX
 Default: false

 **-extra\_bodies** \<FileVector\>   
extra structures to add before modeling. Should be in the coordinate frame of the non-moving partner. Will not move during modeling. Will be detected as part of the nonmoving body for repacking purposes.
 Default: ""

 **-UBQ2\_lys** \<Integer\>   
which Lys on the second UB will be conjugated
 Default: 48

 **-UBQ2\_pdb** \<File\>   
PDB for second ubiquitin (second moving chain). Only active if -two\_ubiquitins is used; inactive otherwise. Optional; defaults to value of -UBQpdb if not passed.

 **-dont\_minimize\_omega** \<Boolean\>   
disable minimization of omega angles near thioester in MoveMap; not present in original publications (Saha; Baker)
 Default: false

 **-pdz** \<Boolean\>   
For the UBQ\_Gp\_LYX-Cterm executable, if -publication is already on, switch to the PDZ center of mass instead of ubiquitin center of mass for the extra statistics calculations. Don't use this option unless trying to reproduce publication XXXX
 Default: false

 **-GTPasepdb** \<File\>   
GTPase structure, or the structure of the thing that is attached to (has cysteine) and does not move; should be one chain
 Default: "2OB4.pdb"

 **-GTPase\_residue** \<Integer\>   
GTPase lysine (PDB numbering) (where the ubiquitin gets attached; assumed to be on the first chain of GTPase\_pdb
 Default: 85

-   -FloppyTail
    -----------

 **-FloppyTail** \<Boolean\>   
FloppyTail option group

 **-flexible\_start\_resnum** \<Integer\>   
starting residue for the flexible region, using PDB numbering
 Default: 180

 **-flexible\_stop\_resnum** \<Integer\>   
stop residue for the flexible region, using PDB numbering. If unspecified, it assumes the end of the pose.
 Default: 0

 **-flexible\_chain** \<String\>   
chain ID for flexible region
 Default: "C"

 **-shear\_on** \<Real\>   
fraction of perturb moves when shear turns on (0.5 = halfway through)
 Default: 1.0/3.0

-   ### -FloppyTail:short\_tail

 **-short\_tail** \<Boolean\>   
short\_tail option group

 **-short\_tail\_fraction** \<Real\>   
what fraction of the flexible segment is used in the short-tail section of refinement (not compatible with non-terminal flexible regions)
 Default: 1.0

 **-short\_tail\_off** \<Real\>   
fraction of refine cycles where movemap reverts to full tail (0.5 = halfway through)
 Default: 0.0

-   -FloppyTail
    -----------

 **-pair\_off** \<Boolean\>   
turn off Epair electrostatics term. Used once for a simple side experiment, not meant for general use.
 Default: false

 **-publication** \<Boolean\>   
output statistics used in publication. TURN OFF if not running publication demo.
 Default: false

 **-C\_root** \<Boolean\>   
Reroot the fold\_tree to the C-terminus. If your flexible region is N-terminal, or closer to the first half of the pose, this will speed computation.
 Default: false

 **-force\_linear\_fold\_tree** \<Boolean\>   
Force a linear fold tree. Used in combination with C\_root and reordering the chains in your input PDB to ensure you get exactly the right kinematics
 Default: false

 **-debug** \<Boolean\>   
debug mode (extra checks and pdb dumps)
 Default: false

 **-cen\_weights** \<String\>   
Use a different/custom scorefunction for centroid step

 **-perturb\_show** \<Boolean\>   
dump perturbed centroid pdbs as well as final results
 Default: false

 **-perturb\_cycles** \<Integer\>   
perturbation phase runs for \<input\> cycles
 Default: 5

 **-perturb\_temp** \<Real\>   
perturbation phase temperature for monte carlo
 Default: 0.8

 **-refine\_cycles** \<Integer\>   
refinement phase runs for \<input\> cycles
 Default: 5

 **-refine\_temp** \<Real\>   
refinement phase temperature for monte carlo
 Default: 0.8

 **-refine\_repack\_cycles** \<Integer\>   
refinement phase runs repack every \<input\> cycles
 Range: 2-
 Default: 20

-   -DenovoProteinDesign
    --------------------

 **-DenovoProteinDesign** \<Boolean\>   
DenovoProteinDesign option group

 **-redesign\_core** \<Boolean\>   
redesign core of pdb
 Default: false

 **-redesign\_loops** \<Boolean\>   
redesign loops of pdb
 Default: false

 **-redesign\_surface** \<Boolean\>   
redesign surface of pdb
 Default: false

 **-redesign\_complete** \<Boolean\>   
complete redesign of pdb
 Default: false

 **-disallow\_native\_aa** \<Boolean\>   
do not allow native aa in design
 Default: false

 **-optimize\_loops** \<Boolean\>   
do serious loop modeling at the end of designrelax mover

 **-secondary\_structure\_file** \<File\>   
has fasta file format - describes secondary structure of desired target with H/C/E

 **-hydrophobic\_polar\_pattern** \<File\>   
has fasta file format - describes hydrophobic(B) polar(P) pattern

 **-use\_template\_sequence** \<Boolean\>   
use the template pdbs sequence when creating starting structures
 Default: false

 **-use\_template\_topology** \<Boolean\>   
use templates phi/psi in loops and begin/end helix/sheet generate only template like starting structures
 Default: false

 **-create\_from\_template\_pdb** \<File\>   
create starting structure from a template pdb, follow with pdb name

 **-create\_from\_secondary\_structure** \<Boolean\>   
create starting structure from a file that contains H/C/E to describe topology or B/P pattern, has fasta file format
 Default: false

-   -RBSegmentRelax
    ---------------

 **-RBSegmentRelax** \<Boolean\>   
RBSegmentRelax option group

 **-input\_pdb** \<File\>   
input pdb file
 Default: "--"

 **-rb\_file** \<File\>   
input rb segment file
 Default: "--"

 **-cst\_wt** \<Real\>   
Weight on constraint term in scoring function
 Default: 0.1

 **-cst\_width** \<Real\>   
Width of harmonic constraints on csts
 Default: 1.0

 **-cst\_pdb** \<String\>   
PDB file from which to draw constraints
 Default: "--"

 **-nrbmoves** \<Integer\>   
number of rigid-body moves
 Default: 100

 **-nrboutercycles** \<Integer\>   
number of rigid-body moves
 Default: 5

 **-rb\_scorefxn** \<String\>   
number of rigid-body moves
 Default: "score5"

 **-skip\_fragment\_moves** \<Boolean\>   
omit fragment insertions (in SS elements)
 Default: false

 **-skip\_seqshift\_moves** \<Boolean\>   
omit sequence shifting moves
 Default: false

 **-skip\_rb\_moves** \<Boolean\>   
omit rigid-body moves
 Default: false

 **-helical\_movement\_params** \<RealVector\>   
helical-axis-rotation, helical-axis-translation, off-axis-rotation, off-axis-translation
 Default: utility::vector1\<float\>(4,0.0)

 **-strand\_movement\_params** \<RealVector\>   
strand-in-plane-rotation, strand-in-plane-translation, out-of-plane-rotation, out-of-plane-translationn
 Default: utility::vector1\<float\>(4,0.0)

 **-default\_movement\_params** \<RealVector\>   
default-rotation, default-translation
 Default: utility::vector1\<float\>(2,0.0)

 **-cst\_seqwidth** \<Integer\>   
sequence width on constraints
 Default: 0

-   -edensity
    ---------

 **-edensity** \<Boolean\>   
edensity option group

 **-debug** \<Boolean\>   
No description
 Default: false

 **-mapfile** \<String\>   
No description

 **-mapreso** \<Real\>   
No description
 Default: 0.0

 **-grid\_spacing** \<Real\>   
No description
 Default: 0.0

 **-centroid\_density\_mass** \<Real\>   
No description
 Default: 0.0

 **-sliding\_window** \<Integer\>   
No description
 Default: 1

 **-cryoem\_scatterers** \<Boolean\>   
No description
 Default: false

 **-force\_apix** \<Real\>   
force pixel spacing to take a particular value
 Default: 0.0

 **-fastdens\_wt** \<Real\>   
wt of fast edens score
 Default: 0.0

 **-fastdens\_params** \<RealVector\>   
parameters for fastdens scoring

 **-legacy\_fastdens\_score** \<Boolean\>   
use the pre-June 2013 normalization for scoring
 Default: false

 **-sliding\_window\_wt** \<Real\>   
wt of edens sliding-window score
 Default: 0.0

 **-score\_sliding\_window\_context** \<Boolean\>   
when using sl. win. density fit, include neighbor atoms (slows trajectory)
 Default: false

 **-whole\_structure\_ca\_wt** \<Real\>   
wt of edens centroid (CA-only) scoring
 Default: 0.0

 **-whole\_structure\_allatom\_wt** \<Real\>   
wt of edens centroid (allatom) scoring
 Default: 0.0

 **-no\_edens\_in\_minimizer** \<Boolean\>   
exclude density score from minimizer
 Default: false

 **-debug\_derivatives** \<Boolean\>   
calculate numeric derivatives for density terms and compare with analytical
 Default: false

 **-realign** \<String\>   
how to initially align the pose to density
 Default: "no"

 **-membrane\_axis** \<String\>   
the membrane normal axis
 Default: "Z"

 **-atom\_mask** \<Real\>   
override default (=3.2A) atom mask radius to this value (hi-res scoring)
 Default: 3.2

 **-atom\_mask\_min** \<Real\>   
override the 3 sigma minimum value which takes precedence over atom\_mask value (hi-res scoring)
 Default: 2.0

 **-ca\_mask** \<Real\>   
override default (=6A) CA mask radius to this value (low-res scoring)
 Default: 6.0

 **-score\_symm\_complex** \<Boolean\>   
If set, scores the structure over the entire symmetric complex; otherwise just use controlling monomer
 Default: false

 **-sc\_scaling** \<Real\>   
Scale sidechain density by this amount (default same as mainchain density)
 Default: 1.0

 **-n\_kbins** \<Integer\>   
Number of B-factor bins
 Default: 1

 **-render\_sigma** \<Real\>   
initially render at this sigma level (extras=graphics build only)
 Default: 2

 **-unmask\_bb** \<Boolean\>   
Only include sidechain atoms in atom mask
 Default: false

-   -patterson
    ----------

 **-patterson** \<Boolean\>   
patterson option group

 **-debug** \<Boolean\>   
No description
 Default: false

 **-weight** \<Real\>   
wt of patterson correlation
 Default: 0.0

 **-sc\_scaling** \<Real\>   
Scale sidechain density by this amount (default = same as mainchain density)
 Default: 1.0

 **-radius\_cutoffs** \<RealVector\>   
patterson-space radius cuttoffs

 **-resolution\_cutoffs** \<RealVector\>   
reciprocal space F\^2 cuttoffs

 **-Bsol** \<Real\>   
solvent B
 Default: 300.0

 **-Fsol** \<Real\>   
solvent fraction
 Default: 0.95

 **-model\_B** \<Real\>   
B factor computing patterson CC
 Default: 0.0

 **-rmsd** \<Real\>   
Expected RMS error for sigma-A calculation
 Default: 2.0

 **-no\_ecalc** \<Boolean\>   
Do not normalize p\_o with ecalc
 Default: false

 **-nshells** \<Integer\>   
Number of resolution shells for patterson normalization
 Default: 50

 **-use\_spline\_interpolation** \<Boolean\>   
use spline interpolation for derivative evaluation? (default trilinear)
 Default: false

 **-use\_on\_repack** \<Boolean\>   
SLOW - use patterson correlation on repacks (default no)
 Default: false

 **-dont\_use\_symm\_in\_pcalc** \<Boolean\>   
perform Pcalc in P1 (default no)
 Default: false

-   -cryst
    ------

 **-cryst** \<Boolean\>   
cryst option group

 **-mtzfile** \<String\>   
mtz file

 **-crystal\_refine** \<Boolean\>   
Turns on crystal-refinement-specific options
 Default: false

-   -optE
    -----

 **-optE** \<Boolean\>   
optE option group

 **-load\_from\_silent** \<String\>   
load from silent instead of pdb - uses path of requested pdb to find silent file, each PDB needs to have all of its structures in its own folder (ie: 1agy/pdb\_set.silent) - only works in optimize\_decoy\_discrimination
 Default: "pdb\_set.silent"

 **-data\_in** \<String\>   
file from which to read in optE data
 Default: "optE.data"

 **-data\_out** \<String\>   
file to which to write optE data
 Default: "optE.data.out"

 **-weights** \<String\>   
a conventional weightfile that optE will use to determine which weights will be counted. All non-zero weights in the file will contribute to rotamer energies and be fit; use the -optE::fix option to fix any of these weights. Weight values will also be used as starting values for optimization.

 **-fix** \<StringVector\>   
weights to be fixed (must also appear in the weightfile given by the -optE::weights option)

 **-free** \<File\>   
IterativeOptEDriver flag: specify a file to read score types that are free – optionally include a starting weight for each score type

 **-fixed** \<File\>   
IterativeOptEDriver flag: specify a file to read score types and weights for score types that are on but fixed

 **-parse\_tagfile** \<File\>   
a file in utility::tag format that optE may parse to customize its operation

 **-constant\_logic\_taskops\_file** \<File\>   
a file in utility::tag format that optE uses to build a task that will not change with the context of the pose after design

 **-optE\_soft\_rep** \<Boolean\>   
Instruct the IterativeOptEDriver to use the soft-repulsion etable

 **-no\_hb\_env\_dependence** \<Boolean\>   
Disable environmental dependent weighting of hydrogen bond terms

 **-no\_hb\_env\_dependence\_DNA** \<Boolean\>   
Disable environmental dependent weighting of hydrogen bonds involving DNA

 **-optE\_no\_protein\_fa\_elec** \<Boolean\>   
Instruct the IterativeOptEDriver to use the soft-repulsion etable
 Default: false

 **-design\_first** \<Boolean\>   
Do not optimize the weights in the context of the native structure, but rather, start by designing the protein with the input weight set. Requires that all score types listed in -optE::free have specificed weights.

 **-n\_design\_cycles** \<Integer\>   
The number of outer-loop design cycles to complete; default of 10 after which convergence has usually occurred
 Default: 10

 **-recover\_nat\_rot** \<Boolean\>   
With the iterative optE driver, repack to recover the native rotamers

 **-component\_weights** \<File\>   
With the iterative optE driver, weight the individual components according to the input file – default weight of 1 for all components. Weight file consists of component-name/weight pairs on separate lines: e.g. prob\_native\_structure 100.0

 **-optimize\_nat\_aa** \<Boolean\>   
With the iterative optE driver, optimize weights to maximize the probability of the native rotamer

 **-optimize\_nat\_rot** \<Boolean\>   
With the iterative optE driver, optimize weights to maximize the probability of the native rotamer in the native context

 **-optimize\_ligand\_rot** \<File\>   
With the iterative optE driver, optimize weights to maximize the probability of the native rotamer around the ligand

 **-optimize\_pssm** \<Boolean\>   
With the iterative optE driver, optimize weights to maximize the match between a BLAST generated pssm probabillity distribution

 **-optimize\_dGbinding** \<File\>   
With the iterative optE driver, optimize weights to minimize squared error between the predicted dG of binding and the experimental dG; provide a file listing 1. bound PDB structure, 2. unbound PDB structure, and 3. measured dG

 **-optimize\_ddG\_bind\_correlation** \<File\>   
With the iterative optE driver, optimize weights to minimize squared error between the predicted ddG of binding for a mutation to the experimental ddG; provide a file listing 1. list file containing wt complexes, 2. list file containing mut complexes, 3. list file containing wt unbounds structures, 4. list file containing mut unbounds structures, and 5. measured ddG of binding

 **-optimize\_ddGmutation** \<File\>   
With the iterative optE driver, optimize weights to minimize the predicted ddG of mutation and the measured ddG; provide a file listing 1. repacked wt pdb list, 2. repacked mut pdb list, and 3. measured ddG triples

 **-optimize\_ddGmutation\_straight\_mean** \<Boolean\>   
With the iterative optE driver, predict the the ddGmut to be the difference between the straight mean (1/n Sum(E\_i)) of the WT and MUT structures provided. Requires the -optimize\_ddGmutation flag be set.

 **-optimize\_ddGmutation\_boltzman\_average** \<Boolean\>   
With the iterative optE driver, predict the the ddGmut to be the difference between the boltzman average energies ( Sum( E\_i \* e\*\*-E\_i/kT)/Sum( e\*\*-E\_i/kT) ) of the WT and MUT structures provided. Requires the -optimize\_ddGmutation flag be set.

 **-exclude\_badrep\_ddGs** \<Real\>   
With the iterative optE driver, consider only ddG data where the unweighted repulsive energy delta mut-wt \< given value

 **-pretend\_no\_ddG\_repulsion** \<Boolean\>   
With the iterative optE driver, set all repulsive scores to zero when looking for ddG correlations

 **-optimize\_decoy\_discrimination** \<File\>   
With the iterative optE driver, optimize weights to maximize the partition between relaxed natives and low-scoring decoys. File is a list of file-list pairs and a single pdb file \< native\_pdb\_list, decoy\_pdb\_list, crystal\_native\_pdb \>.

 **-normalize\_decoy\_score\_spread** \<String\>   
In decoy discrimination optimization, normalize both the native and decoy energies generated by a set of weights by sigma\_curr /sigma\_start where sigma\_start is computed as the standard deviation of the decoy energies given an input weight set

 **-ramp\_nativeness** \<Boolean\>   
In decoy discrimination optimization, give structures in the range between max\_rms\_from\_native and min\_decoy\_rms\_to\_native a nativeness score (which ramps linearly from 1 to 0 in that range) and include scores from structures in the numerator of the partition.

 **-n\_top\_natives\_to\_optimize** \<Integer\>   
For use with the -optimize\_decoy\_discrimination flag. Objective function considers top N natives in partition function
 Default: 1

 **-approximate\_decoy\_entropy** \<Real\>   
Alpha expansion of conformation space size as a function of nres: size \~ alpha \^ nres; entropy \~ nres ln alpha.

 **-repack\_and\_minimize\_decoys** \<Boolean\>   
Generate new structures in each round of iterative optE by repacking and minimizing the input decoys & natives using the weights obtained in the last round

 **-repack\_and\_minimize\_input\_structures** \<Boolean\>   
Minimizing the input decoys & natives using the starting weights – allows structures a chance to see the energy function before decoy discrimination begins without the memory overhead of the repack\_and\_minimize\_decoys flag

 **-output\_top\_n\_new\_decoys** \<Integer\>   
For use with repack\_and\_minimize\_decoys flag: Write out the top N decoys generated each round in this iterative refinement
 Default: 0

 **-optimize\_ligand\_discrimination** \<File\>   
With the iterative optE driver, optimize weights to maximize the partition between relaxed natives and low-scoring decoys. File is a list of file-list pairs and a single pdb file \< native\_pdb\_list, decoy\_pdb\_list, crystal\_native\_pdb \>.

 **-no\_design** \<Boolean\>   
Don't bother loading pdbs and doing design; just optimize weights for decoy-discrim and or native rotamer recovery

 **-sqrt\_pssm** \<Boolean\>   
Turn the pssm probability vectors into unit vectors so that dot product is a true similarity measure

 **-min\_decoy\_rms\_to\_native** \<Real\>   
For use with the optimize\_decoy\_discrimination flag: exclude decoys that are within a certain RMS of the native structure

 **-max\_rms\_from\_native** \<Real\>   
For use with the optimize\_decoy\_discrimination flag: exclude natives that are more than a certain RMS of the crystal structure. max\_rms\_from\_native of 1.5, min\_decoy\_rms\_from\_native 2.0 would throw out structures in the range of 1.5 and 2.0 RMS from consideration

 **-optimize\_starting\_free\_weights** \<Boolean\>   
With the iterative optE driver, try many different starting points for the minimization
 Default: false

 **-wrap\_dof\_optimization** \<File\>   
Create new dofs and setup arithmetic dependencies for free dofs.

 **-randomly\_perturb\_starting\_free\_weights** \<Real\>   
With the iterative optE driver, perturb the weights by +/- \<input value\>=""\> for those weights listed as free

 **-inv\_kT\_natrot** \<Real\>   
1 / kT for the pNativeRotamer fitness function
 Default: 1

 **-inv\_kT\_nataa** \<Real\>   
1 / kT for the pNatAA and PSSM fitness function
 Default: 1

 **-inv\_kT\_natstruct** \<Real\>   
1 / kT for the pNativeStructure fitness function
 Default: 1

 **-mpi\_weight\_minimization** \<Boolean\>   
Distribute OptEMultifunc func/dfunc evaluations across nodes

 **-dont\_use\_reference\_energies** \<Boolean\>   
Do not use reference energies anywhere during the protocol.
 Default: false

 **-number\_of\_swarm\_particles** \<Integer\>   
The number of particles to use during particle swarm weight optimization.
 Default: 100

 **-number\_of\_swarm\_cycles** \<Integer\>   
The number of cycles to run the swarm minimizer for.
 Default: 20

 **-constrain\_weights** \<File\>   
When minimizing the fitness objective function, also include weight constraints in the objective function

 **-fit\_reference\_energies\_to\_aa\_profile\_recovery** \<Boolean\>   
In the inner-loop sequence recovery/weight tweaking stage, accept/reject weight sets based on both the sequence recovery rate, and the mutual information between the expected and observed amino acid frequency distributions

 **-starting\_refEs** \<File\>   
IterativeOptEDriver flag: specify a weights file to read reference energies from; do not optimize reference energies in the first round of weight fitting

 **-repeat\_swarm\_optimization\_until\_fitness\_improves** \<Boolean\>   
After the first time though the particle swarm optimization phase, if the end fitness is not better than the start fitness, recreate the swarm around the start dofs and repeat the swarm optimization.
 Default: false

 **-design\_with\_minpack** \<Boolean\>   
Use the min-packer to design in the sequence recovery stages.
 Default: false

 **-limit\_bad\_scores** \<Boolean\>   
Quit after 100,000 inf or NaN errors in optE objective function

-   ### -optE:rescore

 **-rescore** \<Boolean\>   
rescore option group

 **-weights** \<File\>   
Weight set to use when rescoring optE partition functions

 **-context\_round** \<Integer\>   
Integer of the context PDBs generated during design to use to measure the pNatAA

 **-outlog** \<File\>   
File to which the OptEPosition data should be written

 **-measure\_sequence\_recovery** \<Boolean\>   
When rescoring a weight set, run design with that weight set and measure the sequence recovery.
 Default: false

-   -optE
    -----

 **-no\_design\_pdb\_output** \<Boolean\>   
Do not write out the designed pdbs to the workdir\_ directories over the course of the optE run

-   -backrub
    --------

 **-backrub** \<Boolean\>   
backrub option group

 **-pivot\_residues** \<IntegerVector\>   
residues for which contiguous stretches can contain segments (internal residue numbers, defaults to all residues)
 Default: utility::vector1\<int\>()

 **-pivot\_atoms** \<StringVector\>   
main chain atoms usable as pivots
 Default: utility::vector1\<std::string\>(1, "CA")

 **-min\_atoms** \<Integer\>   
minimum backrub segment size (atoms)
 Default: 3

 **-max\_atoms** \<Integer\>   
maximum backrub segment size (atoms)
 Default: 34

-   -bbg
    ----

 **-bbg** \<Boolean\>   
bbg option group

 **-factorA** \<Real\>   
Control how big the move would be(acceptance rate), default 1.0
 Default: 1.0

 **-factorB** \<Real\>   
Control how local the move would be(folded 10.0, unfolded 0.1), default 10.0
 Default: 10.0

 **-ignore\_improper\_res** \<Boolean\>   
Skip improper residues (proline)
 Default: false

 **-fix\_short\_segment** \<Boolean\>   
Do not apply small mover to short segments, for loop
 Default: false

-   -flexpack
    ---------

 **-flexpack** \<Boolean\>   
flexpack option group

-   ### -flexpack:annealer

 **-annealer** \<Boolean\>   
annealer option group

 **-inner\_iteration\_scale** \<Real\>   
Scale up or down the number of inner iterations in the flexpack annealer

 **-outer\_iteration\_scale** \<Real\>   
Scale up or down the number of outer iterations in the flexpack annealer

 **-fixbb\_substitutions\_scale** \<Real\>   
Scale up or down the number of fixed-backbone rotamer substitutions in the flexpack annealer

 **-pure\_movebb\_substitutions\_scale** \<Real\>   
Scale up or down the number of backbone moves

 **-rotsub\_movebb\_substitutions\_scale** \<Real\>   
Scale up or down the number of rotamer substitions with backbone moves

-   -hotspot
    --------

 **-hotspot** \<Boolean\>   
hotspot option group

 **-allow\_gly** \<Boolean\>   
Allow glycines in hotspot hashing constraints?
 Default: false

 **-allow\_proline** \<Boolean\>   
Allow prolines in hotspot hashing constraints?
 Default: false

 **-benchmark** \<Boolean\>   
Score existing interface?
 Default: false

 **-residue** \<StringVector\>   
mini residue name3 to use for hotspot hashing
 Default: utility::vector1\<std::string\>(1,"ALL")

 **-hashfile** \<File\>   
Existing hotspot hash file.

 **-target** \<File\>   
Target PDB of the hotspot hash. Used for both de novo hashing and making hash density maps.

 **-target\_res** \<Integer\>   
Rosetta residue number of interest on the target PDB. Used for targeted hashing

 **-target\_dist** \<Real\>   
Tolerated distance from the target residue. Used for targeted hashing
 Default: 20

 **-density** \<File\>   
Filename to write *unweighted* hotspot density (compared to -target PDB).

 **-weighted\_density** \<File\>   
Filename to write *score weighted* hotspot density (compared to -target PDB).

 **-rms\_target** \<File\>   
Filename to write best rms of hotspot to target complex. Suitable for pymol data2b\_res

 **-rms\_hotspot** \<File\>   
Filename to write best rms of hotspot to target complex. Suitable for rms vs E scatter plots.

 **-rms\_hotspot\_res** \<Integer\>   
Rosetta residue \# to use for calculating rms\_hotspot.

 **-rescore** \<Boolean\>   
Rescore hotspots from -hashfile based on the supplied -target PDB.
 Default: false

 **-threshold** \<Real\>   
Score threshold for hotspot accepts. Found hotspots must be better than or equal to threshold
 Default: -1.0

 **-sc\_only** \<Boolean\>   
Make backbone atoms virtual to find sidechain-only hotspots?
 Default: true

 **-fxnal\_group** \<Boolean\>   
Only use a stubs functional group for rmsd calculations.
 Default: true

 **-cluster** \<Boolean\>   
Cluster stubset. Will take place before colonyE.
 Default: false

 **-colonyE** \<Boolean\>   
Rescore hotspots from -hashfile based on colony energy.
 Default: false

 **-length** \<Integer\>   
Length of hotspot peptide to use for hashing. Sidechain-containing group will be in the center.
 Default: 1

 **-envhb** \<Boolean\>   
Use environment dependent Hbonds when scoring hotspots.
 Default: false

 **-angle** \<Real\>   
Maximum allowed angle between stubCA, target CoM, and stubCB. Used to determine if stub is pointing towards target. Negative numbers deactivates this check (default)
 Default: -1

 **-angle\_res** \<Integer\>   
Residue to use for angle calculation from stubCA, \<this option\>=""\>, and stubCB. Used to determine if stub is pointing towards target. 0 uses the default, which is the targets center of mass
 Default: 0

-   -parser
    -------

 **-parser** \<Boolean\>   
parser option group

 **-protocol** \<String\>   
File name for the xml parser protocol

 **-script\_vars** \<StringVector\>   
Variable substitutions for xml parser, in the form of name=value

 **-view** \<Boolean\>   
Use the viewer?

 **-patchdock** \<String\>   
Patchdock output file name.

 **-patchdock\_random\_entry** \<IntegerVector\>   
Pick a random patchdock entry between two entry numbers. inclusive

-   -DomainAssembly
    ---------------

 **-DomainAssembly** \<Boolean\>   
DomainAssembly option group

 **-da\_setup** \<Boolean\>   
run DomainAssembly setup routine
 Default: false

 **-da\_setup\_option\_file** \<File\>   
input list of pdbs and linker sequences
 Default: "--"

 **-da\_setup\_output\_pdb** \<File\>   
PDB file output by DomainAssemblySetup
 Default: "--"

 **-da\_linker\_file** \<File\>   
input file with linker definitions
 Default: "--"

 **-da\_require\_buried** \<File\>   
Input file containing residues to be buried in the domain interface
 Default: "--"

 **-da\_start\_pdb** \<File\>   
input pdb for linker optimization
 Default: "--"

 **-run\_fullatom** \<Boolean\>   
Run fullatom stage of the protocol
 Default: false

 **-run\_centroid** \<Boolean\>   
Run centroid stage of the protocol
 Default: false

 **-run\_centroid\_abinitio** \<Boolean\>   
Run centroid abinitio stage of the protocol
 Default: true

 **-da\_nruns** \<Integer\>   
number of runs
 Default: 1

 **-da\_start\_pdb\_num** \<Integer\>   
starting number for output pdb files
 Default: 1

 **-da\_linker\_file\_rna** \<File\>   
input file with moveable RNA definitions
 Default: "--"

 **-residues\_repack\_only** \<String\>   
Residues not to be redesigned under any circumstances

 **-da\_eval\_pose\_map** \<File\>   
input file that maps pose coordinates to structurally related positions of native pose

-   -remodel
    --------

 **-remodel** \<Boolean\>   
remodel option group

 **-help** \<Boolean\>   
help menu.

 **-autopilot** \<Boolean\>   
autopilot

 **-blueprint** \<File\>   
blueprint file name

 **-cstfile** \<File\>   
description

 **-cstfilter** \<Integer\>   
filter cst energy
 Default: 10

 **-cen\_sfxn** \<String\>   
centroid score function to be used for building
 Default: "remodel\_cen"

 **-check\_scored\_centroid** \<Boolean\>   
dump centroid structures after build

 **-num\_trajectory** \<Integer\>   
Number of remodel trajectories.
 Default: 10

 **-save\_top** \<Integer\>   
the number of final low scoring pdbs to keep.
 Default: 5

 **-swap\_refine\_confirm\_protocols** \<Boolean\>   
swapping the protocols used refinement and confirmation
 Default: false

 **-num\_frag\_moves** \<Integer\>   
number of fragment moves to try in the centroid stage.

 **-bypass\_fragments** \<Boolean\>   
only works on input PDB, so no extensions or deletions are honored in the blueprint. Blueprint (H,L,E,D) becomes allow\_move definitionsi.

 **-use\_same\_length\_fragments** \<Boolean\>   
harvest fragments that matches the length to rebuild
 Default: true

 **-enable\_ligand\_aa** \<Boolean\>   
handles ligand attachment and clash check after centroid build.

 **-no\_jumps** \<Boolean\>   
will setup simple foldtree and fold through it during centroid build.

 **-backrub** \<Boolean\>   
run backrub MC trajectory after every completed loop building attempt

 **-use\_blueprint\_sequence** \<Boolean\>   
picks fragments based on both secondary structure and the second column (sequence) in blueprint file

 **-randomize\_equivalent\_fragments** \<Boolean\>   
will randomize identical scoring fragments; without either this flag or

 **-quick\_and\_dirty** \<Boolean\>   
only do fragment insertion

 **-checkpoint** \<Boolean\>   
this writes out the best pdbs collected so far after each design step.

 **-use\_ccd\_refine** \<Boolean\>   
maintain a default chainbreak position (loop start+1) and try using CCD for refinement. try 20 times for 5 closed loops.

 **-use\_pose\_relax** \<Boolean\>   
an alternative to the default minimization step, but use constraints in a similar way.

 **-use\_cart\_relax** \<Boolean\>   
an alternative to the default minimization step, but use constraints in a similar way.

 **-free\_relax** \<Boolean\>   
running pose\_relax with no constraints.

 **-use\_dssp\_assignment** \<Boolean\>   
use dssp assignment.

 **-keep\_jumps\_in\_minimizer** \<Boolean\>   
no constraint is setup for minimization, only rebuilt regions allow bbmove.

 **-output\_fragfiles** \<File\>   
output fragment file [filename ,e.g. aafr01].

 **-read\_fragfile** \<File\>   
read fragment file.

 **-generic\_aa** \<String\>   
the type of AA for centroid building
 Default: "V"

 **-cluster\_radius** \<Real\>   
cluster radius for accumulator, default to auto set value
 Default: -1.0

 **-use\_clusters** \<Boolean\>   
use clustering in accumulator
 Default: false

 **-run\_confirmation** \<Boolean\>   
use KIC rms confirmation
 Default: false

 **-cluster\_on\_entire\_pose** \<Boolean\>   
cluster use all pose, not just loops
 Default: false

 **-collect\_clustered\_top** \<Integer\>   
take the best N from each cluster
 Default: 1

 **-dr\_cycles** \<Integer\>   
number of design-refine cycles to use
 Default: 3

 **-two\_chain\_tree** \<Integer\>   
label the start of the second chain

 **-repeat\_structure** \<Integer\>   
build identical repeats this many times
 Default: 1

 **-lh\_ex\_limit** \<Integer\>   
loophasing neighboring bin expansion limit
 Default: 5

 **-lh\_filter\_string** \<StringVector\>   
loophash ABEGO filter target fragment type. list sequentially for each loop

 **-lh\_cbreak\_selection** \<Integer\>   
loophash with cbreak dominant weight
 Default: 10

 **-lh\_closure\_filter** \<Boolean\>   
filter for close rms when bypass\_closure is used
 Default: false

 **-cen\_minimize** \<Boolean\>   
centroid minimization after fragment building
 Default: false

 **-core\_cutoff** \<Integer\>   
number of neighbors required to consider core in auto design
 Default: 18

 **-boundary\_cutoff** \<Integer\>   
number of neighbors required to consider boundary in auto design
 Default: 15

 **-resclass\_by\_sasa** \<Boolean\>   
switch to use sasa for residue classification
 Default: false

 **-helical\_rise** \<Real\>   
helical parameter: rise
 Default: 0.0

 **-helical\_radius** \<Real\>   
helical parameter: radius
 Default: 0.0

 **-helical\_omega** \<Real\>   
helical parameter: omega
 Default: 0.0

 **-COM\_sd** \<Real\>   
center of mass coordinate constraint sd value
 Default: 1.0

 **-COM\_tolerance** \<Real\>   
center of mass coordinate constraint tolerance value
 Default: 0.0

-   ### -remodel:staged\_sampling

 **-staged\_sampling** \<Boolean\>   
sampling first with 9mers then 3mers. Staged energies. For rebuilding entire structure not loop closure
 Default: false

 **-residues\_to\_sample** \<File\>   
residues to allow sampling (format:1,3,5)
 Default: ""

 **-starting\_sequence** \<String\>   
AA sequence to start
 Default: ""

 **-starting\_pdb** \<File\>   
pdb to start
 Default: ""

 **-require\_frags\_match\_blueprint** \<Boolean\>   
makes sure the frags match the definition in the blueprint
 Default: true

 **-start\_w\_ideal\_helices** \<Boolean\>   
begins with all helices set to -63.8 phi and -41.1 for psi.
 Default: false

 **-sample\_over\_loops** \<Boolean\>   
sample residues defined as loops in the blueprint
 Default: false

 **-small\_moves** \<Boolean\>   
add a stage of small moves
 Default: false

 **-fa\_relax\_moves** \<Boolean\>   
Adds a stage of fa relax
 Default: false

-   ### -remodel:domainFusion

 **-domainFusion** \<Boolean\>   
domainFusion option group

 **-insert\_segment\_from\_pdb** \<File\>   
segment pdb file to be inserted [insert pdb file name].
 Default: ""

-   -remodel
    --------

 **-vdw** \<Real\>   
set vdw weight
 Default: 1.0

 **-rama** \<Real\>   
set rama weight
 Default: 0.1

 **-cbeta** \<Real\>   
set cbeta weight
 Default: 0.0

 **-cenpack** \<Real\>   
set cenpack weight
 Default: 0.0

 **-rg\_local** \<Real\>   
set rg\_local weight
 Default: 0.0

 **-hb\_lrbb** \<Real\>   
set hbond\_lrbb weight
 Default: 0.0

 **-hb\_srbb** \<Real\>   
set hbond\_srbb weight
 Default: 0.0

 **-rg** \<Real\>   
set rg weight

 **-rsigma** \<Real\>   
set rsigma weight
 Default: 0.0

 **-ss\_pair** \<Real\>   
set sspair weight
 Default: 0.0

 **-build\_disulf** \<Boolean\>   
build disulfides
 Default: false

 **-max\_disulf\_allowed** \<Integer\>   
number of disulf pairs can be generated at a time
 Default: 1

 **-match\_rt\_limit** \<Real\>   
match RT score cutoff
 Default: 0.4

 **-disulf\_landing\_range** \<IntegerVector\>   
residue range for disulf landing sites

-   ### -remodel:design

 **-design** \<Boolean\>   
design option group

 **-no\_design** \<Boolean\>   
skips all design steps. WARNING: will only output centroid level structures and dump all fragment tries.

 **-design\_all** \<Boolean\>   
force AUTO design procedure (layered) to perform design on all positions.

 **-allow\_rare\_aro\_chi** \<Boolean\>   
allow all aromatic rotamers, not issuing AroChi2 filter
 Default: false

 **-silent** \<Boolean\>   
dumps all structures by silent-mode WARNING: will work only during no\_design protocol (see -no\_design).

 **-skip\_partial** \<Boolean\>   
skip design stage that operate only on burial positions
 Default: false

 **-design\_neighbors** \<Boolean\>   
design neighbors.
 Default: false

 **-find\_neighbors** \<Boolean\>   
find neighbors for design/repack
 Default: false

-   -remodel
    --------

 **-rank\_by\_bsasa** \<Boolean\>   
rank results by bsasa.

-   ### -remodel:RemodelLoopMover

 **-RemodelLoopMover** \<Boolean\>   
RemodelLoopMover option group

 **-max\_linear\_chainbreak** \<Real\>   
linear chainbreak is \<= this value, loop is considered closed (default 0.07)
 Default: 0.07

 **-randomize\_loops** \<Boolean\>   
randomize loops prior to running main protocol (default true)
 Default: true

 **-use\_loop\_hash** \<Boolean\>   
centroid build with loop hash (default false)
 Default: false

 **-allowed\_closure\_attempts** \<Integer\>   
the allowed number of overall closure attempts (default 1)
 Default: 1

 **-loophash\_cycles** \<Integer\>   
the number of loophash closure cycles to perform (default 8)
 Default: 8

 **-simultaneous\_cycles** \<Integer\>   
the number of simultaneous closure cycles to perform (default 2)
 Default: 2

 **-independent\_cycles** \<Integer\>   
the number of independent closure cycles to perform (default 8)
 Default: 8

 **-boost\_closure\_cycles** \<Integer\>   
the maximum number of possible lockdown closure cycles to perform (default 30)
 Default: 30

 **-force\_cutting\_N** \<Boolean\>   
force a cutpoint at N-term side of blueprint assignment
 Default: false

 **-bypass\_closure** \<Boolean\>   
turning off CCD closure in the mover for tethered docking purpose
 Default: false

 **-cyclic\_peptide** \<Boolean\>   
circularize structure joining N and C-term.
 Default: false

 **-temperature** \<Real\>   
temperature for monte carlo ( default 2.0)
 Default: 2.0

 **-max\_chews** \<Integer\>   
maxium number of residues to chew on either side of loop
 Default: 1

-   -fold\_from\_loops
    ------------------

 **-fold\_from\_loops** \<Boolean\>   
fold\_from\_loops option group

 **-native\_ca\_cst** \<Boolean\>   
derive constraints from the native topology
 Default: false

 **-swap\_loops** \<File\>   
pdb of the target loops
 Default: "--"

 **-checkpoint** \<String\>   
write/read checkpoint files for nstruct. Provide a checkpoint filename after this option.
 Default: ""

 **-ca\_csts\_dev** \<Real\>   
standard deviation allowed to each constraint
 Default: 0.5

 **-add\_relax\_cycles** \<Integer\>   
additional relax cycles
 Default: 2

 **-loop\_mov\_nterm** \<Integer\>   
Movable region inside the provided loop(nterm)
 Default: 0

 **-loop\_mov\_cterm** \<Integer\>   
Moveable region inside the provided loop(cterm)
 Default: 0

 **-ca\_rmsd\_cutoff** \<Real\>   
Filter the decoys to pass the relax-design stage
 Default: 5.0

 **-res\_design\_bs** \<IntegerVector\>   
enumerate the residues to be designed within the fixed binding site

 **-clear\_csts** \<File\>   
input loops file with ranges free of CA csts
 Default: "--"

 **-output\_centroid** \<Boolean\>   
output centroid structures befor the design stage
 Default: false

 **-add\_cst\_loop** \<Boolean\>   
add CA csts of motif to constraint set
 Default: false

-   -symmetry
    ---------

 **-symmetry** \<Boolean\>   
symmetry option group

 **-symmetry\_definition** \<String\>   
Text file describing symmetry setup

 **-reweight\_symm\_interactions** \<Real\>   
Scale intersubunit interactions by a specified weight
 Default: 1.0

 **-initialize\_rigid\_body\_dofs** \<Boolean\>   
Initialize the RB dofs from the symmetry definition file?
 Default: false

 **-detect\_bonds** \<Boolean\>   
allow new cross subunit bond formation
 Default: true

 **-perturb\_rigid\_body\_dofs** \<RealVector\>   
(As in docking) Do a small perturbation of the symmetric DOFs: -perturb\_rigid\_body\_dofs ANGSTROMS DEGREES

 **-symmetric\_rmsd** \<Boolean\>   
calculate the rmsd symmetrically by checking all chain orderings

-   -fold\_and\_dock
    ----------------

 **-fold\_and\_dock** \<Boolean\>   
fold\_and\_dock option group

 **-move\_anchor\_points** \<Boolean\>   
move the anchor points that define symmetric coordinate system during symmetry fragment insertion
 Default: false

 **-set\_anchor\_at\_closest\_point** \<Boolean\>   
set the anchor points that define symmetric coordinate system to the nearest point between two consecutive chains during fragment insertion
 Default: false

 **-rotate\_anchor\_to\_x** \<Boolean\>   
rotate the anchor residue to the x-axis before applying rigid body transformations
 Default: true

 **-trans\_mag\_smooth** \<Real\>   
translation perturbation size for smooth refinement
 Default: 0.1

 **-rot\_mag\_smooth** \<Real\>   
rotational perturbation size for smooth refinement
 Default: 1.0

 **-rb\_rot\_magnitude** \<Real\>   
rotational perturbation size for rigid body pertubations
 Default: 8.0

 **-rb\_trans\_magnitude** \<Real\>   
translational perturbation size rigid body pertubations
 Default: 3.0

 **-rigid\_body\_cycles** \<Integer\>   
number of rigid bosy cycles during fold and dock fragment insertion
 Default: 50

 **-move\_anchor\_frequency** \<Real\>   
Frequency of slide-anchor moves
 Default: 1.0

 **-rigid\_body\_frequency** \<Real\>   
The fraction of times rigid body cycles are applied during fragment assembly moves
 Default: 0.2

 **-rigid\_body\_disable\_mc** \<Boolean\>   
Dissallow moves to be accepted locally by MC criteria within the rigid body mover
 Default: false

 **-slide\_contact\_frequency** \<Real\>   
The fraction of times subunits are slided together during fragment assembly moves
 Default: 0.1

-   -match
    ------

 **-match** \<Boolean\>   
match option group

 **-lig\_name** \<String\>   
Name of the ligand to be matched. This should be the same as the NAME field of the ligand's parameter file (the .params file)

 **-bump\_tolerance** \<Real\>   
The permitted level of spherical overlap betweeen any two atoms. Used to detect collisions between the upstream atoms and the background, the upstream atoms and the downstream atoms, and the downstream atoms and the background
 Default: 0.0

 **-active\_site\_definition\_by\_residue** \<File\>   
File describing the active site of the scaffold as a set of resid/radius pairs

 **-active\_site\_definition\_by\_gridlig** \<File\>   
File containing 1s and Os describing the volume of space for the active site. .gridlig file format from Rosetta++

 **-required\_active\_site\_atom\_names** \<File\>   
File listing the downstream-residue-atom names which must reside in the defined active site. Requires either the flag active\_site\_definition\_by\_residue or the flag active\_site\_definition\_by\_gridlig to be specified.

 **-grid\_boundary** \<File\>   
File describing the volume in space in which the third orientation atom must lie
 Default: ""

 **-geometric\_constraint\_file** \<File\>   
File describing the geometry of the downstream object relative to the upstream object

 **-scaffold\_active\_site\_residues** \<File\>   
File with the residue indices on the scaffold that should be considered as potential launch points for the scaffold's active site. File format described in MatcherTask.cc in the details section of the initialize\_scaffold\_active\_site\_residue\_list\_from\_command\_line() method.
 Default: ""

 **-scaffold\_active\_site\_residues\_for\_geomcsts** \<File\>   
File which lists the residue indices on the scaffold to consider as potential launch points for the scaffold's active site for each geometric constraint; each constraint may have a separate set of residue ids. File format described in MatcherTask.cc in the details section of the initialize\_scaffold\_active\_site\_residue\_list\_from\_command\_line() method.
 Default: ""

 **-euclid\_bin\_size** \<Real\>   
The bin width for the 3-dimensional coordinate hasher, in Angstroms
 Default: 1.0

 **-euler\_bin\_size** \<Real\>   
The bin width for the euler angle hasher, in degrees
 Default: 10.0

 **-consolidate\_matches** \<Boolean\>   
Instead of outputting all matches, group matches and then write only the top -match::output\_matches\_per\_group from each group.
 Default: false

 **-output\_matches\_per\_group** \<Integer\>   
The number of matches to output per group. Requires the -match::consolidate\_matches flag is active.
 Default: 10

 **-orientation\_atoms** \<StringVector\>   
The three atoms, by name, on the downstream partner to use to describe its 6 dimensional coordinate; its position and orientation. Only usable when the downstream partner is a single residue. Exactly 3 atom names must be given. If these atoms are unspecified, the matcher will use the residues neighbor atom and two atoms bonded to the neighbor atom to define the orientation. The euclidean coordinate of the third orientation atom is used as the first the dimensions of the downstream residues 6D coordinate; the other three dimensions are the three euler angles described by creating a coordinate frame at orientation atom 3, with the z axis along the vector from orientation atom 2 to orientation atom 3, and the y axis lying in the plane with orientation atoms 1,2&3.

 **-output\_format** \<String\>   
The format in which the matches are output
 Default: "CloudPDB"

 **-match\_grouper** \<String\>   
The parameters that matches are grouped according to by the MatchConsolidator or the CloudPDBWriter
 Default: "SameSequenceAndDSPositionGrouper"

 **-grouper\_downstream\_rmsd** \<Real\>   
Maximum allowed rmsd between two orientations of the downstream pose to be considered part of the same group
 Default: 1.5

 **-output\_matchres\_only** \<Boolean\>   
Whether to output the matched residues only or the whole pose for every match
 Default: false

 **-geom\_csts\_downstream\_output** \<IntegerVector\>   
For which of the geometric constraints the downstream residue/ligand will be output
 Default: ['1']

 **-filter\_colliding\_upstream\_residues** \<Boolean\>   
Filter the output matches if the hits induce a collision between the upstream residues
 Default: true

 **-upstream\_residue\_collision\_tolerance** \<Real\>   
The amount of atom overlap allowed between upstream residues in a match. If this is unspecified on the command line, then the value in the bump\_tolerance option is used
 Default: 0.0

 **-upstream\_residue\_collision\_score\_cutoff** \<Real\>   
The score cutoff for upstream residue pairs to use in the collision filter. Activating this cutoff uses the etable atr/rep/sol terms to evaluate residue-pair interactions instead of hard-sphere overlap detection
 Default: 10.0

 **-upstream\_residue\_collision\_Wfa\_atr** \<Real\>   
The fa\_atr weight to use in the upstream-collision filter; use in tandem with upstream\_residue\_collision\_score\_cutoff
 Default: 0.8

 **-upstream\_residue\_collision\_Wfa\_rep** \<Real\>   
The fa\_rep weight to use in the upstream-collision filter; use in tandem with upstream\_residue\_collision\_score\_cutoff
 Default: 0.44

 **-upstream\_residue\_collision\_Wfa\_sol** \<Real\>   
The fa\_sol weight to use in the upstream-collision filter; use in tandem with upstream\_residue\_collision\_score\_cutoff
 Default: 0.0

 **-filter\_upstream\_downstream\_collisions** \<Boolean\>   
Filter the output matches if the hits induce a collision between the upstream residues and the downstream pose
 Default: true

 **-updown\_collision\_tolerance** \<Real\>   
The amount of atom overlap allowed between upstream and downstream atoms in a match. If this is unspecified on the command line, then the value in the bump\_tolerance option is used
 Default: 0.0

 **-updown\_residue\_collision\_score\_cutoff** \<Real\>   
The score cutoff for upstream/downstream residue pairs to use in the collision filter. Activating this cutoff uses the etable atr/rep/sol terms to evaluate residue-pair interactions instead of hard-sphere overlap detection
 Default: 10.0

 **-updown\_residue\_collision\_Wfa\_atr** \<Real\>   
The fa\_atr weight to use in the upstream-downstream-collision filter; use in tandem with updown\_residue\_collision\_score\_cutoff
 Default: 0.8

 **-updown\_residue\_collision\_Wfa\_rep** \<Real\>   
The fa\_rep weight to use in the upstream-downstream-collision filter; use in tandem with updown\_residue\_collision\_score\_cutoff
 Default: 0.44

 **-updown\_residue\_collision\_Wfa\_sol** \<Real\>   
The fa\_sol weight to use in the upstream-downstream-collision filter; use in tandem with updown\_residue\_collision\_score\_cutoff
 Default: 0.0

 **-define\_match\_by\_single\_downstream\_positioning** \<Boolean\>   
Enumerate combinations of matches where a single positioning of the downstream partner as well as the conformations of the upstream residues defines the match; it is significantly faster to enumerate unique matches when they are defined this way instead of enumerating the (combinatorially many) matches when a match is defined by n-geometric-constraint locations of the downstream partner. This faster technique for outputting matches is automatically chosen when the flag -match::output\_format is PDB.

 **-ligand\_rotamer\_index** \<Integer\>   
Match with a particular conformation of the ligand; the index represents which conformation in the multi-model .pdb file specified in the ligand's .params file by the PDB\_ROTAMERS field. The index of the first conformation in that file is 1; valid indices range from 1 to the number of entries in the multi-model .pdb file. If this command-line flag is not used, then the conformation of the ligand described by the ICOOR\_INTERNAL lines of the ligand's .params file is used instead.

 **-enumerate\_ligand\_rotamers** \<Boolean\>   
Match with all ligand rotamers specified in the multi-model .pdb file specified in the ligand's .params file by the PDB\_ROTAMERS field. This flag may not be used in combination with the match::ligand\_rotamer\_index flag. Geometry of the ligand rotamers in the .pdb file will be idealized to the .params file bond angles and lengths.
 Default: true

 **-only\_enumerate\_non\_match\_redundant\_ligand\_rotamers** \<Boolean\>   
Only defined if enumerate\_ligand\_rotamers is true this option causes the matcher to determine which rotamers in the ligand rotamer library are redundant in terms of matching, meaning the atoms they're matched through are superimposable. after having subdivided the ligand rotamer library into match-redundant subgroups, the matcher will then only place the first nonclashing rotamer from each subgroup.
 Default: true

 **-dynamic\_grid\_refinement** \<Boolean\>   
When too many hits land in the same 'connected component', requiring the enumeration of twoo many matches, refine the grid size to be smaller so that fewer matches have to be enumerated. This process works on individual connected components and is not applied to all regions of 6D. This is significantly more efficient than enumerating all matches, while allowing the grid size to remain large and the rotamer and external geometry to remain dense. (\*A connected component refers to

 **-build\_round1\_hits\_twice** \<Boolean\>   
Memory saving strategy that avoids paying for the storage of all the round-1 hits and instead records only what 6D voxels those hits fall in to. Then the second round of matching proceeds storing only the hits that fall into the same voxels that the hits from the first round fell into. Then the matcher goes back and generates the first-round hits again, but only keeps the ones that land into the same voxels that hits from round 2 fell into. To be used, round 2 must also use the classic match algorithm (and must not use secondary matching).
 Default: false

-   -canonical\_sampling
    --------------------

 **-canonical\_sampling** \<Boolean\>   
canonical\_sampling option group

-   ### -canonical\_sampling:probabilities

 **-probabilities** \<Boolean\>   
probabilities option group

 **-sc** \<Real\>   
probability of making a side chain move
 Default: 0.25

 **-localbb** \<Real\>   
probability of making a small move
 Default: 0.75

 **-sc\_prob\_uniform** \<Real\>   
probability of uniformly sampling chi angles
 Default: 0.1

 **-sc\_prob\_withinrot** \<Real\>   
probability of sampling within the current rotamer
 Default: 0.9

 **-sc\_prob\_perturbcurrent** \<Real\>   
probability of perturbing the current rotamer
 Default: 0.0

 **-MPI\_sync\_pools** \<Boolean\>   
use MPI to synchronize pools and communicate between nodes
 Default: false

 **-MPI\_bcast** \<Boolean\>   
use broadcasting in syncing
 Default: false

 **-fast\_sc\_moves** \<Boolean\>   
use the fast SidechainMCMover
 Default: false

 **-fast\_sc\_moves\_ntrials** \<Real\>   
specify the number of ntrials for each call of scmover apply
 Default: 1000

 **-no\_jd2\_output** \<Boolean\>   
do not write to silent-file specified by -out: <file:silent>
 Default: false

 **-use\_hierarchical\_clustering** \<Boolean\>   
use the HierarchicalLevel class
 Default: false

 **-hierarchical\_max\_cache\_size** \<Integer\>   
set the max-cache size of the hierarchy
 Default: 1000

 **-backrub** \<Real\>   
set the probability of executing a backrub move when making a backbone move
 Default: 0.5

 **-conrot** \<Real\>   
set relative probability of executing a conrot move when making a backbone move
 Default: 0.0

-   ### -canonical\_sampling:sampling

 **-sampling** \<Boolean\>   
sampling option group

 **-no\_detailed\_balance** \<Boolean\>   
preserve detailed balance
 Default: false

 **-ntrials** \<Integer\>   
number of Monte Carlo trials to run
 Default: 1000

 **-mc\_kt** \<Real\>   
value of kT for Monte Carlo
 Default: 0.6

 **-interval\_pose\_dump** \<Integer\>   
dump a pose out every x steps
 Default: 1000

 **-interval\_data\_dump** \<Integer\>   
dump data out every x steps
 Default: 100

 **-output\_only\_cluster\_transitions** \<Boolean\>   
output only cluster transitions
 Default: false

 **-transition\_threshold** \<Real\>   
if rmsd to known\_structures larger than X, add a new structure to pool
 Default: 2.0

 **-max\_files\_per\_dir** \<Integer\>   
distribute traj and transition files into subdirectories with max N entries
 Default: 1000

 **-save\_loops\_only** \<Boolean\>   
save only loop conformation to pool
 Default: false

 **-dump\_loops\_only** \<Boolean\>   
dump only loop conformation in silent-files
 Default: false

-   ### -canonical\_sampling:out

 **-out** \<Boolean\>   
out option group

 **-new\_structures** \<File\>   
 Default: "discovered\_decoys.out"

-   -rdc
    ----

 **-rdc** \<Boolean\>   
rdc option group

 **-correct\_NH\_length** \<Boolean\>   
fix N-H bond-vector to 1.04 as measured in ottiger&bax 98
 Default: true

 **-reduced\_couplings** \<Boolean\>   
gives more equal weights to different bond-vectors
 Default: false

 **-weights** \<File\>   
specify weights for individual residues ( works for all couplings at this reside)

 **-iterate\_weights** \<Real\>   
do a wRDC computation, i.e., iterate tensor calculation until weights are \~exp ( -dev2/sigma )
 Default: 1

 **-segment\_file** \<File\>   
Definition of rigid segments for alignment tensor optimization

 **-segment\_scoring\_mode** \<String\>   
Type of treatment of alignment tensor-based scoring : pairwise or fixed\_axis\_z (e.g. for homo-dimers)

 **-total\_weight** \<Real\>   
Weight for RDC scores of individual al. tensors
 Default: 1.0

 **-tensor\_weight** \<Real\>   
Weight for pairwise scoring of al. tensors
 Default: 1.0

 **-print\_rdc\_values** \<File\>   
print computed vs experimental RDC values

 **-iterate\_tol** \<Real\>   
tolerance for tensor iterations
 Default: 0.01

 **-iterate\_reset** \<Boolean\>   
reset weights to 1.0 when optimizing for new structure
 Default: false

 **-dump\_weight\_trajectory** \<File\>   
if yes, write weights to file for each scoring event

 **-fix\_normAzz** \<RealVector\>   
divide by this axial tensor component

 **-select\_residues\_file** \<File\>   
loop/rigid-file with RIGID entries that define the set of residues active for RDC score

 **-fit\_method** \<String\>   
No description
 Default: "nls"

 **-fixDa** \<RealVector\>   
No description

 **-fixR** \<RealVector\>   
No description

 **-nlsrepeat** \<Integer\>   
No description
 Default: 5

-   -csa
    ----

 **-csa** \<Boolean\>   
csa option group

 **-useZ** \<Boolean\>   
Use absolute zaxis for scoring csa

-   -dc
    ---

 **-dc** \<Boolean\>   
dc option group

 **-useZ** \<Boolean\>   
Use absolute zaxis for scoring dc

-   -antibody
    ---------

 **-antibody** \<Boolean\>   
Antibody option group

 **-numbering\_scheme** \<String\>   
The numbering scheme of the PDB file. Options are: Chothia\_Scheme, Enhanced\_Chothia\_Scheme, AHO\_Scheme, IMGT\_Scheme. Kabat\_Scheme is also accepted, but not fully supported due to H1 numbering conventions. Use Kabat\_Scheme with caution.
 Default: "Chothia\_Scheme"

 **-cdr\_definition** \<String\>   
The CDR definition to use. Current Options are: Chothia, Aroop, North, Kabat, Martin
 Default: "Aroop"

 **-graft\_l1** \<Boolean\>   
Graft CDR L1 from template
 Default: false

 **-l1\_template** \<String\>   
Choose specified template for CDR L1 grafting
 Default: "l1.pdb"

 **-graft\_l2** \<Boolean\>   
Graft CDR L2 from template
 Default: false

 **-l2\_template** \<String\>   
Choose specified template for CDR L2 grafting
 Default: "l2.pdb"

 **-graft\_l3** \<Boolean\>   
Graft CDR L3 from template
 Default: false

 **-l3\_template** \<String\>   
Choose specified template for CDR L3 grafting
 Default: "l3.pdb"

 **-graft\_h1** \<Boolean\>   
Graft CDR H1 from template
 Default: false

 **-h1\_template** \<String\>   
Choose specified template for CDR H1 grafting
 Default: "h1.pdb"

 **-graft\_h2** \<Boolean\>   
Graft CDR H2 from template
 Default: false

 **-h2\_template** \<String\>   
Choose specified template for CDR H2 grafting
 Default: "h2.pdb"

 **-graft\_h3** \<Boolean\>   
Graft CDR H3 from template
 Default: false

 **-h3\_template** \<String\>   
Choose specified template for CDR H3 grafting
 Default: "h3.pdb"

 **-h3\_no\_stem\_graft** \<Boolean\>   
Graft CDR H3 from template, use stem to superimpose, but do not copy the stem
 Default: false

 **-packonly\_after\_graft** \<Boolean\>   
Only do packing after grafting, do not do minimization
 Default: false

 **-stem\_optimize** \<Boolean\>   
turn on/off the option to optimize the grafted stems
 Default: true

 **-stem\_optimize\_size** \<Integer\>   
define the size of the stem to optimize
 Default: 4

 **-preprocessing\_script\_version** \<String\>   
Rosetta 2 using Perl script has errors for grafting
 Default: "R3\_Python"

 **-model\_h3** \<Boolean\>   
Model CDR H3 from scratch using fragments
 Default: false

 **-snugfit** \<Boolean\>   
Adjust relative orientation of VL-VH
 Default: false

 **-refine\_h3** \<Boolean\>   
Refine CDR H3 in high resolution
 Default: true

 **-h3\_filter** \<Boolean\>   
filter decoys having neither kink nor extend form
 Default: true

 **-h3\_filter\_tolerance** \<Real\>   
maximum number of tries for the filter
 Default: 5

 **-cter\_insert** \<Boolean\>   
insert kind or extend Ab fragments to CDR H3
 Default: true

 **-flank\_residue\_min** \<Boolean\>   
minimize flank residues of CDR H3 during high-reso refinement
 Default: true

 **-sc\_min** \<Boolean\>   
minimize the side chain after finishing the rotamer packing
 Default: false

 **-rt\_min** \<Boolean\>   
minimize the rotamer each packing
 Default: false

 **-bad\_nter** \<Boolean\>   
the n-terminal is bad because of bad H3 grafting
 Default: true

 **-extend\_h3\_before\_modeling** \<Boolean\>   
extend the H3 to forget the intial H3 configuration
 Default: true

 **-idealize\_h3\_stems\_before\_modeling** \<Boolean\>   
idealize the H3 stem, H3 grafting does not copy the coordinates which makes the grafting bad
 Default: true

 **-remodel** \<String\>   
Choose a perturb method to model H3 in centroid mode
 Default: "legacy\_perturb\_ccd"

 **-refine** \<String\>   
Choose a refine method to model H3 in high-resol model
 Default: "legacy\_perturb\_ccd"

 **-centroid\_refine** \<String\>   
Choose a refine method to refine a loop in centroid mode
 Default: "refine\_kic"

 **-constrain\_cter** \<Boolean\>   
The option to turn on/off the cterminal constrain penalty in loop scoring function
 Default: false

 **-constrain\_vlvh\_qq** \<Boolean\>   
The option to turn on/off the VL-VH QQ H-bond in docking scoring function
 Default: false

 **-snug\_loops** \<Boolean\>   
Allow CDR loop backbone flexibility during minimization
 Default: false

 **-input\_fv** \<File\>   
input antibody variable (Fv) region
 Default: "FR02.pdb"

 **-camelid** \<Boolean\>   
Camelid input with only heavy (VH) chain
 Default: false

 **-camelid\_constraints** \<Boolean\>   
Display constraints file for use with camelid H3 modeler
 Default: false

-   ### -antibody:design

 **-design** \<Boolean\>   
design option group

 **-instructions** \<String\>   
Path for instruction file
 Default: "/sampling/antibodies/design/default\_instructions.txt"

 **-antibody\_database** \<String\>   
Path to the Antibody Database. Download from dunbrack.fccc.edu
 Default: "/sampling/antibodies/antibody\_database\_rosetta.db"

 **-design\_cdrs** \<StringVector\>   
Design these CDRs in graft and sequence design steps (if enabled). Use instead of an instruction file. If an instruction file is given, will override FIX options for both stages.

 **-do\_graft\_design** \<Boolean\>   
Run the GraftDesign step for low-resolution cluster-based CDR structural sampling. Overrides instruction file.
 Default: true

 **-do\_post\_graft\_design\_modeling** \<Boolean\>   
Run dock/min modeling step after the graft design step if run.
 Default: false

 **-do\_sequence\_design** \<Boolean\>   
Run the CDRDesign step for high-resolution cluster-based CDR sequence design. Overrides instruction file.
 Default: true

 **-do\_post\_design\_modeling** \<Boolean\>   
Run dock/min modeling step after the sequence design step if run
 Default: false

 **-graft\_rounds** \<Integer\>   
Rounds for graft\_design. Each round is one CDR graft from set
 Default: 1000

 **-top\_graft\_designs** \<Integer\>   
Number of top graft designs to keep (ensemble). These will be written to a PDB and each move onto the next step in the protocol.
 Default: 10

 **-initial\_perturb** \<Boolean\>   
Run the docking perturber post graft. Controlled by command-line flags. See docking manual. It will at least slide into contact.
 Default: false

 **-use\_deterministic** \<Boolean\>   
Use the deterministic algorithm if graft rounds is \<= number of possible permutations. This involves multiple grafts per permutation in random CDR order, but always starts with the starting structure. You only try each full permutation once, but no monte carlo boltzmann propagation of good models or designs occur. Will still, however, keep the top x best structures found after each graft round has completed.
 Default: false

 **-dump\_post\_graft\_designs** \<Boolean\>   
Write the top ensembles to file directly after the graft-design step and after any optional modeling.
 Default: false

 **-interface\_dis** \<Real\>   
Interface distance cutoff. Used for repacking of interface, etc.
 Default: 6.0

 **-neighbor\_dis** \<Real\>   
Neighbor distance cutoff. Used for repacking after graft, minimization, etc.
 Default: 4.0

 **-dock\_post\_graft** \<Boolean\>   
Run a short lowres + highres docking step after each graft and before any minimization. Inner/Outer loops for highres are hard coded, while low-res can be changed through regular low\_res options.
 Default: false

 **-pack\_post\_graft** \<Boolean\>   
Pack CDR and neighbors after each graft. Before any docking or minimization.
 Default: true

 **-rb\_min\_post\_graft** \<Boolean\>   
Minimize the ab-ag interface post graft and any docking/cdr min by minimizing the jump
 Default: false

 **-design\_post\_graft** \<Boolean\>   
Design during any time the packer is called post graft. This includes relax, high-res docking, etc. Used to increasing sampling of potential designs.
 Default: false

 **-dock\_rounds** \<Integer\>   
Number of rounds for post\_graft docking. If you are seeing badly docked structures, increase this value.
 Default: 2

 **-ab\_dock\_chains** \<String\>   
Override the antibody dock chains. Used for if your creating a bivalent antibody where only L or H is docking antigen. Also used if you are creating an antibody where you are only interested in L or H primarily being the binding site. Changing the default is not recommended for general use.
 Default: "LH"

 **-design\_method** \<String\>   
Design method to use.
 Default: "fixbb"

 **-design\_rounds** \<Integer\>   
Number of CDRDesign rounds. If using relaxed\_design, only one round recommended.
 Default: 3

 **-design\_scorefxn** \<String\>   
Scorefunction to use during design. Orbitals\_talaris2013\_softrep works well for fixedbb, orbitals\_talaris2013 works well for relaxed design. If not set will use the main scorefunction set.

 **-benchmark\_basic\_design** \<Boolean\>   
Used to benchmark basic design vs probabilistic vs conservative. Not for general use.
 Default: false

 **-use\_filters** \<Boolean\>   
Use filters after graft step and design step. Defaults false for now to optimize sensitivity
 Default: false

 **-stats\_cutoff** \<Integer\>   
Value for probabilistic -\> conservative design switch. If number of total sequences used for probabilistic design for a particular cdr cluster being designed is less than this value, conservative design will occur. This is why the default graft settings are type 1 clusters. More data = better predictability.
 Default: 10

 **-sample\_zero\_probs\_at** \<Integer\>   
Value for probabilstic design. Probability that a normally zero prob will be chosen as a potential residue each time packer task is called. Increase to increase variablility of positions. Use with caution.
 Default: 0

 **-conservative\_h3\_design** \<Boolean\>   
Use a conservative strategy for H3 design. Instructions file overwrites this setting
 Default: true

 **-turn\_conservation** \<Boolean\>   
try to conserve turn structure using known turn-based conservative mutations during conservative design.
 Default: true

 **-extend\_native\_cdrs** \<Boolean\>   
extend native CDRs as part of the graft design step. Used for benchmarking
 Default: false

-   -flexPepDocking
    ---------------

 **-flexPepDocking** \<Boolean\>   
flexPepDocking option group

 **-params\_file** \<String\>   
parameters file that describe the complex details, like anchor residues, etc.

 **-peptide\_anchor** \<Integer\>   
Set the peptide anchor residue mannualy (instead of using the center of mass
 Range: 1-
 Default: 1

 **-receptor\_chain** \<String\>   
chain-id of receptor protein

 **-peptide\_chain** \<String\>   
chain-id of peptide protein

 **-pep\_fold\_only** \<Boolean\>   
Only fold a peptide, without docking (no input receptor is expected in this case).
 Default: false

 **-lowres\_abinitio** \<Boolean\>   
Do a preemptive ab-initio low-resolution peptide docking
 Default: false

 **-lowres\_preoptimize** \<Boolean\>   
Do a preemptive optimization in low resolution
 Default: false

 **-flexPepDockingMinimizeOnly** \<Boolean\>   
Just do simple minimization on input structure
 Default: false

 **-extend\_peptide** \<Boolean\>   
start the protocol with the peptide in extended conformation
 Default: false

 **-pep\_refine** \<Boolean\>   
High-resolution peptide refinement over receptor surface, equivalent to the obsolete -rbMCM -torsionsMCM flags
 Default: false

 **-rbMCM** \<Boolean\>   
Do rigid body mcm in the main loop of the protocol (obsolete)
 Default: false

 **-torsionsMCM** \<Boolean\>   
Do torsions (small/shear mcm in the main loop of the protocol (obsolete)
 Default: false

 **-peptide\_loop\_model** \<Boolean\>   
Do cycles of random loop modeling to peptide backbone
 Default: false

 **-backrub\_peptide** \<Boolean\>   
Adds a backrub stage to the protocol
 Default: false

 **-boost\_fa\_atr** \<Boolean\>   
while ramping up the fa\_rep, start from high atr and lower to normal
 Default: true

 **-ramp\_fa\_rep** \<Boolean\>   
Whether to ramp the full-atom repulsive score during the protocol
 Default: true

 **-ramp\_rama** \<Boolean\>   
Whether to ramp the Ramachandran score during the protocol
 Default: false

 **-flexpep\_score\_only** \<Boolean\>   
just reads in the pose and scores it
 Default: false

 **-ref\_startstruct** \<File\>   
Alternative start structure for scoring statistics, instead of the original start structure (useful as reference for rescoring previous runs)

 **-use\_cen\_score** \<Boolean\>   
when in score\_only mode, uses centroid weights to score
 Default: false

 **-design\_peptide** \<Boolean\>   
Add a desing stage to each cycle of the RB-torsions perturbations
 Default: false

 **-rep\_ramp\_cycles** \<Integer\>   
Number of cycles for the ramping up of repulsion term
 Range: 0-
 Default: 10

 **-mcm\_cycles** \<Integer\>   
Number of cycles for the mcm procedures (rb/torsions)
 Range: 0-
 Default: 8

 **-random\_phi\_psi\_preturbation** \<Real\>   
Size of random perturbation of peptide's phi/psi
 Range: 0.0-
 Default: 0.0

 **-smove\_angle\_range** \<Real\>   
Defines the perturbations size of small/sheer moves
 Range: 0.0-
 Default: 6.0

 **-min\_receptor\_bb** \<Boolean\>   
Whether to include protein backbone in minimization
 Default: false

 **-random\_trans\_start** \<Real\>   
Size of random perturbation of peptide's rigid body translation
 Range: 0.0-
 Default: 0.0

 **-random\_rot\_start** \<Real\>   
Size of random perturbation of peptide's rigid body rotation
 Range: 0.0-
 Default: 0.0

 **-flexpep\_prepack** \<Boolean\>   
Prepack an initial structure and exit
 Default: false

 **-flexpep\_noprepack1** \<Boolean\>   
Do not repack the side-chains of partner 1 ( = globular protein).
 Default: false

 **-flexpep\_noprepack2** \<Boolean\>   
Do not repack the side-chains of partner 2 ( = peptide).
 Default: false

 **-score\_filter** \<Real\>   
Only output decoys with scores lower than this filter.
 Default: 10000.0

 **-hb\_filter** \<Integer\>   
Only output decoys with more h-bonds than this filter.
 Range: 0-
 Default: 0

 **-hotspot\_filter** \<Integer\>   
Only output decoys with more hotspots than this filter.
 Range: 0-
 Default: 0

 **-frag5** \<String\>   
5-mer fragments for ab-initio flexPepDock

 **-frag9\_weight** \<Real\>   
Relative weight of 9-mers in ab-initio
 Range: 0-
 Default: 0.1

 **-frag5\_weight** \<Real\>   
relative weight of 5-mers in ab-initio
 Range: 0-
 Default: 0.25

 **-frag3\_weight** \<Real\>   
Relative weight of 3-mers in ab-initio
 Range: 0-
 Default: 1.0

 **-pSer2Asp\_centroid** \<Boolean\>   
convert pSer to Asp during centroid mode
 Default: false

 **-pSer2Glu\_centroid** \<Boolean\>   
convert pSer to Glu during centroid mode
 Default: false

 **-dumpPDB\_abinitio** \<Boolean\>   
dump PDB during Monte-Carlo ab-initio
 Default: false

 **-dumpPDB\_lowres** \<Boolean\>   
dump PDB during Monte-Carlo low-res
 Default: false

 **-dumpPDB\_hires** \<Boolean\>   
dump PDB during Monte-Carlo hi-res
 Default: false

-   -threadsc
    ---------

 **-threadsc** \<Boolean\>   
threadsc option group

 **-src\_chain** \<String\>   
Chain of source pdb

 **-trg\_chain** \<String\>   
Chain of target pdb

 **-src\_first\_resid** \<Integer\>   
Residue id of first residue in source pdb range

 **-trg\_first\_resid** \<Integer\>   
Residue id of first residue in source pdb range

 **-nres** \<Integer\>   
Number of residues to be threaded

 **-trg\_anchor** \<Integer\>   
anchor residue for backbone threading

-   -cp
    ---

 **-cp** \<Boolean\>   
cp option group

 **-cutoff** \<Real\>   
designable neighbor cutoff
 Default: 16

 **-minimizer** \<String\>   
minimizer to use for initial minimization
 Default: "score12\_full"

 **-relax\_sfxn** \<String\>   
score function for final relaxation step
 Default: "score12\_full"

 **-pack\_sfxn** \<String\>   
score function for mutational trials
 Default: "soft\_rep\_design"

 **-minimizer\_tol** \<Real\>   
tolerance for minimization
 Default: .0001

 **-minimizer\_score\_fxn** \<String\>   
score function for initial minimization
 Default: "score12\_full"

 **-output** \<String\>   
file where we want to dump the final pose
 Default: "final\_mutant.pdb"

 **-ncycles** \<Integer\>   
how many cycles to run refinement for
 Default: 0

 **-max\_failures** \<Integer\>   
how many failures to tolerate at each iteration before quitting
 Default: 1

 **-print\_reports** \<Boolean\>   
print reports to text file?
 Default: false

 **-vipReportFile** \<String\>   
File to print reports to
 Default: "reports.txt"

 **-exclude\_file** \<String\>   
Optional input file to specify positions that should not be mutated
 Default: "cp\_excludes"

 **-relax\_mover** \<String\>   
relax w/o constraints=relax, w constraints=cst\_relax
 Default: "relax"

 **-skip\_relax** \<Boolean\>   
Skip relax step... may reduce accurate identification of mutations
 Default: false

 **-local\_relax** \<Boolean\>   
Limit relax step to neighbors
 Default: false

 **-print\_intermediate\_pdbs** \<Boolean\>   
Output a pdb file for each consecutive mutation
 Default: false

 **-use\_unrelaxed\_starting\_points** \<Boolean\>   
For subsequent iterations, uses mutation before relaxation
 Default: false

 **-easy\_vip\_acceptance** \<Boolean\>   
For all iterations, use initial energy for acceptance test
 Default: false

-   -archive
    --------

 **-archive** \<Boolean\>   
archive option group

 **-reread\_all\_structures** \<Boolean\>   
ignore pool file... reread from batches
 Default: false

 **-completion\_notify\_frequency** \<Integer\>   
tell Archive every X completed decoys
 Default: 100

-   -optimization
    -------------

 **-optimization** \<Boolean\>   
optimization option group

 **-default\_max\_cycles** \<Integer\>   
max cycles for MinimizerOptions
 Default: 2000

 **-armijo\_min\_stepsize** \<Real\>   
min stepsize in armijo minimizer
 Default: 1e-8

 **-scale\_normalmode\_dampen** \<Real\>   
dampening scale over normal mode index, used for NormalModeMinimizer
 Default: 0.05

 **-lbfgs\_M** \<Integer\>   
number of corrections to approximate the inverse hessian matrix.
 Default: 64

 **-scale\_d** \<Real\>   
max cycles for MinimizerOptions
 Default: 1

 **-scale\_theta** \<Real\>   
max cycles for MinimizerOptions
 Default: 1

 **-scale\_rb** \<Real\>   
max cycles for MinimizerOptions
 Default: 10

 **-scale\_rbangle** \<Real\>   
max cycles for MinimizerOptions
 Default: 1

 **-scmin\_nonideal** \<Boolean\>   
Do we allow sidechain nonideality during scmin (e.g. rtmin and min\_pack)
 Default: false

 **-scmin\_cartesian** \<Boolean\>   
Toggle Cartesian-space minimization during scmin (e.g. rmin and min\_pack)
 Default: false

 **-nonideal** \<Boolean\>   
Permit bond geometries to vary from ideal values
 Default: false

-   -stepwise
    ---------

 **-stepwise** \<Boolean\>   
stepwise option group

 **-s1** \<StringVector\>   
input file(s)

 **-s2** \<StringVector\>   
input file(s)

 **-silent1** \<StringVector\>   
input file

 **-silent2** \<StringVector\>   
input file

 **-tags1** \<StringVector\>   
input tag(s)

 **-tags2** \<StringVector\>   
input tag(s)

 **-slice\_res1** \<IntegerVector\>   
Residues to slice out of starting file
 Default: []

 **-slice\_res2** \<IntegerVector\>   
Residues to slice out of starting file
 Default: []

 **-input\_res1** \<IntegerVector\>   
Residues already present in starting file
 Default: []

 **-input\_res2** \<IntegerVector\>   
Residues already present in starting file2
 Default: []

 **-backbone\_only1** \<Boolean\>   
just copy protein backbone DOFS, useful for homology modeling

 **-backbone\_only2** \<Boolean\>   
just copy protein backbone DOFS, useful for homology modeling

-   ### -stepwise:monte\_carlo

 **-monte\_carlo** \<Boolean\>   
monte\_carlo option group

 **-verbose\_scores** \<Boolean\>   
Show all score components
 Default: false

 **-skip\_deletions** \<Boolean\>   
no delete moves – just for testing
 Default: false

 **-erraser** \<Boolean\>   
Use KIC sampling
 Default: true

 **-allow\_internal\_hinge\_moves** \<Boolean\>   
Allow moves in which internal suites are sampled (hinge-like motions)
 Default: true

 **-allow\_internal\_local\_moves** \<Boolean\>   
Allow moves in which internal cutpoints are created to allow ERRASER rebuilds
 Default: false

 **-allow\_skip\_bulge** \<Boolean\>   
Allow moves in which an intervening residue is skipped and the next one is modeled as floating base
 Default: false

 **-allow\_from\_scratch** \<Boolean\>   
Allow modeling of 'free' dinucleotides that are not part of input poses
 Default: false

 **-allow\_split\_off** \<Boolean\>   
Allow chunks that do not contain fixed domains to split off after nucleating on fixed domains.
 Default: true

 **-cycles** \<Integer\>   
Number of Monte Carlo cycles
 Default: 50

 **-temperature** \<Real\>   
Monte Carlo temperature
 Default: 1.0

 **-add\_delete\_frequency** \<Real\>   
Frequency of add/delete vs. resampling
 Default: 0.5

 **-minimize\_single\_res\_frequency** \<Real\>   
Frequency with which to minimize the residue that just got rebuilt, instead of all
 Default: 0.0

 **-allow\_variable\_bond\_geometry** \<Boolean\>   
In 10% of moves, let bond angles & distance change
 Default: true

 **-switch\_focus\_frequency** \<Real\>   
Frequency with which to switch the sub-pose that is being modeled
 Default: 0.5

 **-just\_min\_after\_mutation\_frequency** \<Real\>   
After a mutation, how often to just minimize (without further sampling the mutated residue)
 Default: 0.5

 **-constraint\_x0** \<Real\>   
Target RMSD value for constrained runs
 Default: 0.5

 **-constraint\_tol** \<Real\>   
Size of flat region for coordinate constraints
 Default: 0.5

 **-extra\_min\_res** \<IntegerVector\>   
specify residues other than those being built that should be minimized
 Default: []

 **-make\_movie** \<Boolean\>   
create silent files in movie/ with all steps and accepted steps
 Default: false

-   ### -stepwise:rna

 **-rna** \<Boolean\>   
rna option group

 **-sampler\_num\_pose\_kept** \<Integer\>   
set\_num\_pose\_kept by ResidueSampler )
 Default: 108

 **-sample\_res** \<IntegerVector\>   
residues to build, the first element is the actual sample res while the other are the bulge residues
 Default: []

 **-sampler\_native\_rmsd\_screen** \<Boolean\>   
native\_rmsd\_screen ResidueSampler
 Default: false

 **-sampler\_native\_screen\_rmsd\_cutoff** \<Real\>   
sampler\_native\_screen\_rmsd\_cutoff
 Default: 2.0

 **-sampler\_cluster\_rmsd** \<Real\>   
Clustering rmsd of conformations in the sampler
 Default: 0.5

 **-native\_edensity\_score\_cutoff** \<Real\>   
native\_edensity\_score\_cutoff
 Default: -1.0

 **-sampler\_perform\_o2prime\_pack** \<Boolean\>   
perform O2' hydrogen packing inside StepWiseRNA\_ResidueSampler
 Default: true

 **-sampler\_perform\_phosphate\_pack** \<Boolean\>   
perform terminal phosphate packing inside StepWiseRNA\_ResidueSampler
 Default: true

 **-sampler\_use\_green\_packer** \<Boolean\>   
use packer instead of rotamer trials for O2' optimization
 Default: false

 **-VERBOSE** \<Boolean\>   
VERBOSE
 Default: false

 **-distinguish\_pucker** \<Boolean\>   
distinguish pucker when cluster:both in sampler and clusterer
 Default: true

 **-finer\_sampling\_at\_chain\_closure** \<Boolean\>   
Samplerer: finer\_sampling\_at\_chain\_closure
 Default: false

 **-PBP\_clustering\_at\_chain\_closure** \<Boolean\>   
Samplerer: PBP\_clustering\_at\_chain\_closure
 Default: false

 **-sampler\_allow\_syn\_pyrimidine** \<Boolean\>   
sampler\_allow\_syn\_pyrimidine
 Default: false

 **-sampler\_extra\_chi\_rotamer** \<Boolean\>   
Samplerer: extra\_syn\_chi\_rotamer
 Default: false

 **-sampler\_extra\_beta\_rotamer** \<Boolean\>   
Samplerer: extra\_beta\_rotamer
 Default: false

 **-sampler\_extra\_epsilon\_rotamer** \<Boolean\>   
Samplerer: extra\_epsilon\_rotamer
 Default: true

 **-force\_centroid\_interaction** \<Boolean\>   
Require base stack or pair even for single residue loop closed (which could also be bulges!)
 Default: false

 **-virtual\_sugar\_legacy\_mode** \<Boolean\>   
In virtual sugar sampling, use legacy protocol to match Parin's original workflow
 Default: false

 **-erraser** \<Boolean\>   
Use KIC sampling
 Default: false

 **-centroid\_screen** \<Boolean\>   
centroid\_screen
 Default: true

 **-VDW\_atr\_rep\_screen** \<Boolean\>   
classic VDW\_atr\_rep\_screen
 Default: true

 **-skip\_sampling** \<Boolean\>   
no sampling step in rna\_swa residue sampling
 Default: false

 **-minimizer\_perform\_minimize** \<Boolean\>   
minimizer\_perform\_minimize
 Default: true

 **-minimize\_and\_score\_native\_pose** \<Boolean\>   
minimize\_and\_score\_native\_pose
 Default: false

 **-rm\_virt\_phosphate** \<Boolean\>   
Remove virtual phosphate patches during minimization
 Default: false

 **-VDW\_rep\_alignment\_RMSD\_CUTOFF** \<Real\>   
use with VDW\_rep\_screen\_info
 Default: 0.001

 **-VDW\_rep\_delete\_matching\_res** \<StringVector\>   
delete residues in VDW\_rep\_pose that exist in the working\_pose
 Default: []

 **-VDW\_rep\_screen\_physical\_pose\_clash\_dist\_cutoff** \<Real\>   
The distance cutoff for VDW\_rep\_screen\_with\_physical\_pose
 Default: 1.2

 **-integration\_test** \<Boolean\>   
integration\_test
 Default: false

 **-allow\_bulge\_at\_chainbreak** \<Boolean\>   
Allow sampler to replace chainbreak res with virtual\_rna\_variant if it looks have bad fa\_atr score.
 Default: true

 **-parin\_favorite\_output** \<Boolean\>   
parin\_favorite\_output
 Default: true

 **-reinitialize\_CCD\_torsions** \<Boolean\>   
Samplerer: reinitialize\_CCD\_torsions: Reinitialize\_CCD\_torsion to zero before every CCD chain closure
 Default: false

 **-sample\_both\_sugar\_base\_rotamer** \<Boolean\>   
Samplerer: Super hacky for SQUARE\_RNA
 Default: false

 **-sampler\_include\_torsion\_value\_in\_tag** \<Boolean\>   
Samplerer:include\_torsion\_value\_in\_tag
 Default: true

 **-sampler\_assert\_no\_virt\_sugar\_sampling** \<Boolean\>   
sampler\_assert\_no\_virt\_sugar\_sampling
 Default: false

 **-sampler\_try\_sugar\_instantiation** \<Boolean\>   
for floating base sampling, try to instantiate sugar if it looks promising
 Default: false

 **-do\_not\_sample\_multiple\_virtual\_sugar** \<Boolean\>   
Samplerer: do\_not\_sample\_multiple\_virtual\_sugar
 Default: false

 **-sample\_ONLY\_multiple\_virtual\_sugar** \<Boolean\>   
Samplerer: sample\_ONLY\_multiple\_virtual\_sugar
 Default: false

 **-allow\_base\_pair\_only\_centroid\_screen** \<Boolean\>   
allow\_base\_pair\_only\_centroid\_screen
 Default: false

 **-minimizer\_output\_before\_o2prime\_pack** \<Boolean\>   
minimizer\_output\_before\_o2prime\_pack
 Default: false

 **-minimizer\_perform\_o2prime\_pack** \<Boolean\>   
perform O2' hydrogen packing inside StepWiseRNA\_Minimizer
 Default: true

 **-minimizer\_rename\_tag** \<Boolean\>   
Reorder and rename the tag by the energy\_score
 Default: true

 **-num\_pose\_minimize** \<Integer\>   
optional: set\_num\_pose\_minimize by Minimizer
 Default: 999999

 **-fixed\_res** \<IntegerVector\>   
Do not move these residues during minimization.
 Default: []

 **-minimize\_res** \<IntegerVector\>   
alternative to fixed\_res
 Default: []

 **-alignment\_res** \<StringVector\>   
align\_res\_list
 Default: []

 **-native\_alignment\_res** \<IntegerVector\>   
optional: native\_alignment\_res
 Default: []

 **-rmsd\_res** \<IntegerVector\>   
residues that will be use to calculate rmsd ( for clustering as well as RMSD to native\_pdb if specified )
 Default: []

 **-missing\_res** \<IntegerVector\>   
Residues missing in starting pose\_1, alternative to input\_res
 Default: []

 **-missing\_res2** \<IntegerVector\>   
Residues missing in starting pose\_2, alternative to input\_res2
 Default: []

 **-job\_queue\_ID** \<Integer\>   
swa\_rna\_sample()/combine\_long\_loop mode: Specify the tag pair in filter\_output\_filename to be read in and imported ( start from 0! )
 Default: 0

 **-minimize\_and\_score\_sugar** \<Boolean\>   
minimize and sugar torsion + angle? and include the rna\_sugar\_close\_score\_term
 Default: true

 **-global\_sample\_res\_list** \<IntegerVector\>   
A list of all the nucleotide to be build/sample over the entire dag.
 Default: []

 **-filter\_output\_filename** \<File\>   
CombineLongLoopFilterer: filter\_output\_filename
 Default: "filter\_struct.txt"

 **-combine\_long\_loop\_mode** \<Boolean\>   
Sampler: combine\_long\_loop\_mode
 Default: false

 **-combine\_helical\_silent\_file** \<Boolean\>   
CombineLongLoopFilterer: combine\_helical\_silent\_file
 Default: false

 **-output\_extra\_RMSDs** \<Boolean\>   
output\_extra\_RMSDs
 Default: false

 **-force\_syn\_chi\_res\_list** \<IntegerVector\>   
optional: sample only syn chi for the res in sampler.
 Default: []

 **-force\_north\_sugar\_list** \<IntegerVector\>   
optional: sample only north sugar for the res in sampler.
 Default: []

 **-force\_south\_sugar\_list** \<IntegerVector\>   
optional: sample only south sugar for the res in sampler.
 Default: []

 **-protonated\_H1\_adenosine\_list** \<IntegerVector\>   
optional: protonate\_H1\_adenosine\_list
 Default: []

 **-native\_virtual\_res** \<IntegerVector\>   
optional: native\_virtual\_res
 Default: []

 **-simple\_append\_map** \<Boolean\>   
simple\_append\_map
 Default: false

 **-allow\_fixed\_res\_at\_moving\_res** \<Boolean\>   
mainly just to get Hermann Duplex modeling to work
 Default: false

 **-force\_user\_defined\_jumps** \<Boolean\>   
Trust and use user defined jumps
 Default: false

 **-test\_encapsulation** \<Boolean\>   
Test ability StepWiseRNA Modeler to figure out what it needs from just the pose - no JobParameters
 Default: false

 **-jump\_point\_pairs** \<StringVector\>   
optional: extra jump\_points specified by the user for setting up the fold\_tree
 Default: []

 **-terminal\_res** \<IntegerVector\>   
optional: residues that are not allowed to stack during sampling
 Default: []

 **-add\_virt\_root** \<Boolean\>   
add\_virt\_root
 Default: false

 **-floating\_base** \<Boolean\>   
floating\_base
 Default: false

 **-floating\_base\_anchor\_res** \<Integer\>   
If we want floating base to be connected via a jump to an anchor res (with no intervening virtual residues), specify the anchor.
 Default: 0

 **-allow\_chain\_boundary\_jump\_partner\_right\_at\_fixed\_BP** \<Boolean\>   
mainly just to get Hermann nano - square RNA modeling to work
 Default: false

 **-virtual\_res** \<IntegerVector\>   
optional: residues to be made virtual
 Default: []

 **-bulge\_res** \<IntegerVector\>   
optional: residues to be turned into a bulge variant
 Default: []

 **-rebuild\_bulge\_mode** \<Boolean\>   
rebuild\_bulge\_mode
 Default: false

 **-choose\_random** \<Boolean\>   
ask swa residue sampler for a random solution
 Default: false

 **-virtual\_sugar\_keep\_base\_fixed** \<Boolean\>   
When instantiating virtual sugar, keep base fixed – do not spend a lot of time to minimize!
 Default: true

 **-num\_random\_samples** \<Integer\>   
In choose\_random/monte-carlo mode, number of samples from swa residue sampler before minimizing best
 Default: 20

 **-filter\_user\_alignment\_res** \<Boolean\>   
filter\_user\_alignment\_res
 Default: true

 **-output\_pdb** \<Boolean\>   
output\_pdb: If true, then will dump the pose into a PDB file at different stages of the stepwise assembly process.
 Default: false

-   -full\_model
    ------------

 **-full\_model** \<Boolean\>   
full\_model option group

 **-cutpoint\_open** \<IntegerVector\>   
open cutpoints in full model
 Default: []

 **-cutpoint\_closed** \<IntegerVector\>   
closed cutpoints in full model
 Default: []

 **-other\_poses** \<StringVector\>   
list of PDB files containing other poses

-   -ufv
    ----

 **-ufv** \<Boolean\>   
ufv option group

 **-left** \<Integer\>   
left endpoint

 **-right** \<Integer\>   
right endpoint

 **-ss** \<String\>   
secondary structure string

 **-aa\_during\_build** \<String\>   
amino acid string during centroid build

 **-aa\_during\_design\_refine** \<String\>   
amino acid string during design-refine

 **-keep\_junction\_torsions** \<Boolean\>   
when rebuilding loops, keep (approx) the original torsions at the junctions of the loop endpoints
 Default: false

 **-ufv\_loops** \<File\>   
use this multiple loop file in place of specifying single loop options on command line

 **-use\_fullmer** \<Boolean\>   
use full-mer fragments when building loop
 Default: false

 **-centroid\_loop\_mover** \<String\>   
the centroid loop mover to use
 Default: "RemodelLoopMover"

 **-no\_neighborhood\_design** \<Boolean\>   
only repack the neighborhood of the loop, don't design
 Default: false

 **-dr\_cycles** \<Integer\>   
design-refine cycles
 Default: 3

 **-centroid\_sfx** \<String\>   
filename of the centroid score function to use,

 **-centroid\_sfx\_patch** \<String\>   
filename of the centroid score function patch to use,

 **-fullatom\_sfx** \<String\>   
filename of the full-atom score function to use

 **-fullatom\_sfx\_patch** \<String\>   
filename of the full-atom score function patch to use

-   ### -ufv:insert

 **-insert** \<Boolean\>   
insert option group

 **-insert\_pdb** \<File\>   
pdb of insert structure

 **-attached\_pdb** \<File\>   
pdb of structure in rigid body relationship with insert structure

 **-connection\_scheme** \<String\>   
enforce type of insertion: choose either n2c or c2n

-   -chrisk
    -------

 **-chrisk** \<Boolean\>   
chrisk option group

 **-hb\_elec** \<Boolean\>   
turn on hb-elec switch function
 Default: false

-   -rot\_anl
    ---------

 **-rot\_anl** \<Boolean\>   
rot\_anl option group

 **-tag** \<String\>   
nametag
 Default: "."

 **-premin** \<Boolean\>   
do all sc min and dump pdb
 Default: false

 **-min** \<Boolean\>   
do sc min
 Default: false

 **-diff\_to\_min** \<Boolean\>   
native pose is post-min
 Default: false

 **-repack** \<Boolean\>   
 Default: false

 **-rtmin** \<Boolean\>   
 Default: false

 **-scmove** \<Boolean\>   
 Default: false

 **-design** \<Boolean\>   
 Default: false

 **-score\_tol** \<Real\>   
score filter for dump\_pdb
 Default: 1.0

 **-rmsd\_tol** \<Real\>   
rmsd filter for dump\_pdb
 Default: 1.0

 **-dump\_pdb** \<Boolean\>   
dump\_pdb when pass thresh
 Default: false

 **-nloop\_scmove** \<Integer\>   
base of scmover loop (total=nloop\^n\_chi)
 Default: 9

-   -sewing
    -------

 **-sewing** \<Boolean\>   
sewing option group

 **-query\_structure\_path** \<File\>   

 **-frag1\_start** \<Integer\>   

 **-frag1\_end** \<Integer\>   

 **-frag2\_start** \<Integer\>   

 **-frag2\_end** \<Integer\>   

 **-minimum\_helix\_contacts** \<Integer\>   

 **-helices\_to\_add** \<Integer\>   

 **-single\_helix\_rmsd\_cutoff** \<Real\>   

 **-helix\_pair\_rmsd\_cutoff** \<Real\>   

 **-nat\_ro\_file** \<File\>   
A file containing coordinates for 'native' rotamers

 **-helix\_cap\_dist\_cutoff** \<Real\>   
Maximum distance between c-alpha residues at the end of two helices in order to call them part of the same bundle

 **-helix\_contact\_dist\_cutoff** \<Real\>   
Maximum distance between c-alpha residues in two helices in order to call them interacting

 **-min\_helix\_size** \<Integer\>   
Minimum size of a helix in a bundle

-   -strand\_assembly
    -----------------

 **-strand\_assembly** \<Boolean\>   
strand\_assembly option group

 **-min\_num\_strands\_to\_deal** \<Integer\>   
Minimum number of strands to handle beta-sandwich

 **-max\_num\_strands\_to\_deal** \<Integer\>   
Maximum number of strands to handle beta-sandwich

 **-extract\_native\_only** \<Boolean\>   
if true, extract native full strands only

 **-min\_res\_in\_strand** \<Integer\>   
minimum number of residues in a strand, for edge strand definition & analysis

 **-max\_res\_in\_strand** \<Integer\>   
Maximum number of residues in a strand, for edge strand definition & analysis

 **-min\_O\_N\_dis** \<Real\>   
Minimum distance between backbone oxygen and backbone nitrogen

 **-max\_O\_N\_dis** \<Real\>   
Maximum distance between backbone oxygen and backbone nitrogen

 **-min\_sheet\_dis** \<Real\>   
Minimum distance between sheets (CA and CA)

 **-max\_sheet\_dis** \<Real\>   
Maximum distance between sheets (CA and CA)

 **-min\_sheet\_torsion** \<Real\>   
Minimum torsion between sheets (CA and CA) with respect to terminal residues

 **-max\_sheet\_torsion** \<Real\>   
Maximum torsion between sheets (CA and CA) with respect to terminal residues

 **-min\_sheet\_angle** \<Real\>   
Minimum angle between sheets (CA and CA)

 **-max\_sheet\_angle** \<Real\>   
Maximum angle between sheets (CA and CA)

 **-min\_shortest\_dis\_sidechain\_inter\_sheet** \<Real\>   
minimum distance between sidechains between sheets (pairs of strands)

-   -pepspec
    --------

 **-pepspec** \<Boolean\>   
pepspec option group

 **-soft\_wts** \<String\>   
No description
 Default: "soft\_rep.wts"

 **-cen\_wts** \<String\>   
No description
 Default: "cen\_ghost.wts"

 **-binding\_score** \<Boolean\>   
No description
 Default: true

 **-no\_cen** \<Boolean\>   
No description
 Default: true

 **-no\_cen\_rottrials** \<Boolean\>   
No description
 Default: true

 **-run\_sequential** \<Boolean\>   
No description
 Default: false

 **-pep\_anchor** \<Integer\>   
No description

 **-pep\_chain** \<String\>   
No description
 Default: " "

 **-n\_peptides** \<Integer\>   
No description
 Default: 8

 **-n\_build\_loop** \<Integer\>   
No description
 Default: 1000

 **-n\_cgrelax\_loop** \<Integer\>   
No description
 Default: 1

 **-n\_dock\_loop** \<Integer\>   
No description
 Default: 4

 **-interface\_cutoff** \<Real\>   
No description
 Default: 5.0

 **-use\_input\_bb** \<Boolean\>   
No description
 Default: false

 **-remove\_input\_bb** \<Boolean\>   
No description
 Default: false

 **-homol\_csts** \<String\>   
No description
 Default: "prep.csts"

 **-p\_homol\_csts** \<Real\>   
No description
 Default: 1.0

 **-frag\_file** \<String\>   
No description
 Default: "sampling/filtered.vall.dat.2006-05-05.gz"

 **-gen\_pep\_bb\_sequential** \<Boolean\>   
No description
 Default: false

 **-input\_seq** \<String\>   
No description

 **-ss\_type** \<String\>   
No description

 **-upweight\_interface** \<Boolean\>   
No description
 Default: false

 **-calc\_sasa** \<Boolean\>   
No description
 Default: false

 **-diversify\_pep\_seqs** \<Boolean\>   
No description
 Default: true

 **-diversify\_lvl** \<Integer\>   
No description
 Default: 10

 **-dump\_cg\_bb** \<Boolean\>   
No description
 Default: false

 **-save\_low\_pdbs** \<Boolean\>   
No description
 Default: true

 **-save\_all\_pdbs** \<Boolean\>   
No description
 Default: false

 **-no\_design** \<Boolean\>   
No description
 Default: false

 **-pdb\_list** \<String\>   
No description

 **-ref\_pdb\_list** \<String\>   
No description

 **-add\_buffer\_res** \<Boolean\>   
No description
 Default: false

 **-cg\_res\_type** \<String\>   
No description
 Default: "ALA"

 **-native\_pep\_anchor** \<Integer\>   
No description

 **-native\_pep\_chain** \<String\>   
No description
 Default: ""

 **-native\_align** \<Boolean\>   
No description
 Default: false

 **-rmsd\_analysis** \<Boolean\>   
No description
 Default: false

 **-phipsi\_analysis** \<Boolean\>   
No description
 Default: false

 **-anchor\_type** \<String\>   
No description
 Default: "ALA"

 **-no\_prepack\_prot** \<Boolean\>   
No description
 Default: false

 **-prep\_use\_ref\_rotamers** \<Boolean\>   
No description
 Default: false

 **-n\_prepend** \<Integer\>   
No description
 Default: 0

 **-n\_append** \<Integer\>   
No description
 Default: 0

 **-clash\_cutoff** \<Real\>   
No description
 Default: 5

 **-n\_anchor\_dock\_std\_devs** \<Real\>   
No description
 Default: 1.0

 **-prep\_trans\_std\_dev** \<Real\>   
No description
 Default: 0.5

 **-prep\_rot\_std\_dev** \<Real\>   
No description
 Default: 10.0

 **-seq\_align** \<Boolean\>   
No description
 Default: false

 **-prep\_align\_prot\_to** \<String\>   
No description

-   -sicdock
    --------

 **-sicdock** \<Boolean\>   
sicdock option group

 **-clash\_dis** \<Real\>   
max acceptable clash dis
 Default: 3.5

 **-contact\_dis** \<Real\>   
max acceptable contact dis
 Default: 12.0

 **-hash\_2D\_vs\_3D** \<Real\>   
grid spacing top 2D hash
 Default: 1.3

 **-term\_min\_expose** \<Real\>   
terminus at least X exposed
 Default: 0.1

 **-term\_max\_angle** \<Real\>   
terminus at most X degrees from XY plane
 Default: 45.0

-   -mh
    ---

 **-mh** \<Boolean\>   
mh option group

 **-motif\_out\_file** \<String\>   
file to dump ResPairMotifs to
 Default: "default"

 **-harvest\_motifs** \<FileVector\>   
files to harvest ResPairMotifs from
 Default: "SPECIFY\_ME\_DUMMY"

 **-print\_motifs** \<FileVector\>   
files to print ResPairMotifs from
 Default: "SPECIFY\_ME\_DUMMY"

 **-dump\_motif\_pdbs** \<FileVector\>   
files to extract ResPairMotifs clusters from
 Default: "SPECIFY\_ME\_DUMMY"

 **-merge\_motifs** \<FileVector\>   
files to merge ResPairMotifs from
 Default: "SPECIFY\_ME\_DUMMY"

 **-merge\_motifs\_one\_per\_bin** \<Boolean\>   
keep only one motif per hash bin (for sepcified grid)
 Default: false

 **-generate\_reverse\_motifs** \<Boolean\>   
keep only one motif per hash bin (for sepcified grid)
 Default: false

 **-dump\_input\_pdb** \<FileVector\>   
files to dump biount interpretation from
 Default: "SPECIFY\_ME\_DUMMY"

 **-score\_pdbs** \<FileVector\>   
files to score with input counts file
 Default: "SPECIFY\_ME\_DUMMY"

 **-xform\_score\_data** \<FileVector\>   
motif hash data for scoring

 **-xform\_score\_data\_ee** \<FileVector\>   
motif hash data for scoring

 **-xform\_score\_data\_eh** \<FileVector\>   
motif hash data for scoring

 **-xform\_score\_data\_he** \<FileVector\>   
motif hash data for scoring

 **-xform\_score\_data\_hh** \<FileVector\>   
motif hash data for scoring

 **-xform\_score\_data\_sspair** \<FileVector\>   
motif hash data for scoring strand pairings

 **-sequence\_recovery** \<FileVector\>   
pdb files to score
 Default: "SPECIFY\_ME\_DUMMY"

 **-explicit\_motif\_score** \<FileVector\>   
pdb files to score
 Default: "SPECIFY\_ME\_DUMMY"

 **-input\_motifs** \<FileVector\>   
motifs to score with
 Default: "SPECIFY\_ME\_DUMMY"

 **-harvest\_scores** \<FileVector\>   
get counts from ResPairMotif files and dump to binary counts file
 Default: ""

 **-print\_scores** \<File\>   
print a binary counts file
 Default: ""

 **-dump\_matching\_motifs** \<FileVector\>   
pdb files to score
 Default: "SPECIFY\_ME\_DUMMY"

 **-dump\_matching\_motifs\_cutoff** \<Real\>   
rms cutoff
 Default: 1.0

 **-score\_across\_chains\_only** \<Boolean\>   
ignore intra-chain motifs
 Default: false

 **-normalize\_score\_ncontact** \<Boolean\>   
normalize by total num contacts
 Default: true

 **-dump\_motif\_pdbs\_min\_counts** \<Integer\>   
min counts to dump
 Default: 99999999

 **-hash\_cart\_size** \<Real\>   
dimensions of binned space
 Default: 12.0

 **-hash\_cart\_resl** \<Real\>   
width of cartesian bin
 Default: 0.8

 **-hash\_angle\_resl** \<Real\>   
width of euler angle bin
 Default: 15.0

 **-harvest\_motifs\_min\_hh\_ends** \<Integer\>   
restrict to middle of hilix contacts
 Default: 0

 **-harvest\_scores\_min\_count** \<Integer\>   
 Default: 0

 **-ignore\_io\_errors** \<Boolean\>   
 Default: false

 **-motif\_match\_radius** \<Real\>   
width of euler angle bin
 Default: 0.6

 **-merge\_similar\_motifs** \<RealVector\>   
give 3 hash params

-   ### -mh:score

 **-score** \<Boolean\>   
score option group

 **-noloops** \<Boolean\>   
ignore loop ss in scored structs
 Default: true

 **-spread\_ss\_element** \<Boolean\>   
ignore loop ss in scored structs
 Default: true

 **-min\_cover\_fraction** \<Real\>   
ignore loop ss in scored structs
 Default: 0.0

 **-strand\_pair\_weight** \<Real\>   
ignore loop ss in scored structs
 Default: 1.0

 **-min\_contact\_pairs** \<Real\>   
ignore loop ss in scored structs
 Default: 0.0

 **-max\_contact\_pairs** \<Real\>   
ignore loop ss in scored structs
 Default: 9e9

-   ### -mh:filter

 **-filter** \<Boolean\>   
filter option group

 **-filter\_harvest** \<Boolean\>   
filter while harvesting
 Default: true

 **-filter\_io** \<Boolean\>   
filter while reading filter
 Default: true

 **-restype** \<String\>   
allowed res types
 Default: "ACDEFGHIKLMNPQRSTVWY"

 **-restype\_one** \<String\>   
allowed res types need at least one
 Default: "ACDEFGHIKLMNPQRSTVWY"

 **-not\_restype** \<String\>   
disallowed res types
 Default: "ACGP"

 **-not\_restype\_one** \<String\>   
disallowed res types at least one not
 Default: "ACGP"

 **-seqsep** \<Integer\>   
min filter seqsep
 Default: 0

 **-no\_hb\_bb** \<Boolean\>   
no bb hbonded
 Default: false

 **-mindist2** \<Real\>   
min CA-CA dist sq
 Default: 0.0

 **-maxdist2** \<Real\>   
max CA-CA dist sq
 Default: 999999.0

 **-ss1** \<String\>   
filter ss1
 Default: ""

 **-ss2** \<String\>   
filter ss2
 Default: ""

 **-dssp1** \<String\>   
filter dssp1
 Default: ""

 **-dssp2** \<String\>   
filter dssp2
 Default: ""

 **-aa1** \<String\>   
filter aa1
 Default: ""

 **-aa2** \<String\>   
filter aa2
 Default: ""

 **-sasa** \<Real\>   
filter max sasa
 Default: 999.0

 **-faatr** \<Real\>   
filter max faatr (default 999.0 = no filtering
 Default: 999.0

 **-hb\_sc** \<Real\>   
filter max hb\_sc (default 999.0 = no filtering
 Default: 999.0

 **-hb\_bb\_sc** \<Real\>   
filter max hb\_bb\_sc (default 999.0 = no filtering
 Default: 999.0

 **-hb\_bb** \<Real\>   
filter max hb\_bb (default 999.0 = no filtering
 Default: 999.0

 **-occupancy** \<Real\>   
filter min occupancy (default 0.0 = no filtering
 Default: 0.0

 **-coorderr** \<Real\>   
filter max bfac coorderr = sqrt(B/8\*pi\*\*2)) (default 999.0 = no filtering
 Default: 999.0

 **-faatr\_or\_hbbb** \<Real\>   
filter require atr or hb (bb allowed) below thresh
 Default: 999.0

 **-faatr\_or\_hb** \<Real\>   
filter require atr or hb below thresh
 Default: 999.0

 **-noloops** \<Boolean\>   
 Default: false

 **-oneloop** \<Boolean\>   
 Default: false

 **-nodisulf** \<Boolean\>   
 Default: false

-   -orbitals
    ---------

 **-orbitals** \<Boolean\>   
orbitals option group

 **-Hpol** \<Boolean\>   
look at only polar hydrogen interactions
 Default: false

 **-Haro** \<Boolean\>   
look at only aromatic hydrogen interactions
 Default: false

 **-bb\_stats** \<Boolean\>   
look at orbital backbone stats
 Default: false

 **-sc\_stats** \<Boolean\>   
look at orbital sc stats
 Default: false

 **-orb\_orb\_stats** \<Boolean\>   
look at orbital orbital stats
 Default: false

 **-sc\_bb** \<Boolean\>   
score the backbone
 Default: false

-   -cutoutdomain
    -------------

 **-cutoutdomain** \<Boolean\>   
cutoutdomain option group

 **-start** \<Integer\>   
start residue
 Default: 1

 **-end** \<Integer\>   
end residue
 Default: 2

-   -carbohydrates
    --------------

 **-carbohydrates** \<Boolean\>   
carbohydrates option group

 **-lock\_rings** \<Boolean\>   
Sets whether or not alternative ring conformationswill be sampled by the protocol, (e.g, ring flips orpuckering). The default value is false.
 Default: false

-   -dwkulp
    -------

 **-dwkulp** \<Boolean\>   
dwkulp option group

 **-forcePolyAAfragments** \<String\>   
a single amino acid that will be used for fragment picking,default is blank which means taking actual sequence from pose
 Default: ""

-   -matdes
    -------

 **-matdes** \<Boolean\>   
matdes option group

 **-num\_subs\_building\_block** \<Integer\>   
The number of subunits in the oligomeric building block
 Default: 1

 **-num\_subs\_total** \<Integer\>   
The number of subunits in the target assembly
 Default: 1

 **-pdbID** \<String\>   
The PDB ID
 Default: "0xxx"

 **-prefix** \<String\>   
Prefix appended to output PDB files. Perhaps useful to describe the architecture, e.g., 532\_3\_...
 Default: "pre\_"

 **-radial\_disp** \<RealVector\>   
Specify the radial displacement from the center of a closed point group assembly. Use with -in::olig\_search::dump\_pdb

 **-angle** \<RealVector\>   
Specify the angle by which a building block is rotated in a symmetrical assembly. Use with -in::olig\_search::dump\_pdb

 **-tag** \<String\>   
Four digit ID tag attached to a design model during design

-   ### -matdes:dock

 **-dock** \<Boolean\>   
dock option group

 **-neg\_r** \<Real\>   
Specify whether radial displacement is positive or negative. 1 for negative, 0 for positive.
 Default: 0

 **-dump\_pdb** \<Boolean\>   
Dump a pdb of a particular docked configuration
 Default: false

 **-dump\_chainA\_only** \<Boolean\>   
Only output chain A (the asymmetric unit) of the symmetrical assembly. Use with -in::olig\_search::dump\_pdb
 Default: false

-   ### -matdes:design

 **-design** \<Boolean\>   
design option group

 **-contact\_dist** \<Real\>   
CA-CA distance for defining interface residues
 Default: 10.0

 **-grid\_size\_angle** \<Real\>   
The width of angle space to start design/minimize runs from, centered on the starting angle
 Default: 1.0

 **-grid\_size\_radius** \<Real\>   
The width of radius space to start design/minimize runs from, centered on the starting radius
 Default: 1.0

 **-grid\_nsamp\_angle** \<Integer\>   
The number of samples the rigid body grid is divided into in angle space
 Default: 9

 **-grid\_nsamp\_radius** \<Integer\>   
The number of samples the rigid body grid is divided into in radius space
 Default: 9

 **-fav\_nat\_bonus** \<Real\>   
Bonus to be awarded to native residues
 Default: 0.0

-   ### -matdes:mutalyze

 **-mutalyze** \<Boolean\>   
mutalyze option group

 **-calc\_rot\_boltz** \<Boolean\>   
Specify whether to calculate RotamerBoltzmann probabilities or not
 Default: 0

 **-ala\_scan** \<Boolean\>   
Specify whether to calculate ddGs for alanine-scanning mutants at the designed interface
 Default: 1

 **-revert\_scan** \<Boolean\>   
Specify whether to calculate ddGs for reversion mutants at the designed interface
 Default: 1

 **-min\_rb** \<Boolean\>   
Specify whether to minimize the rigid body DOFs
 Default: 1

-   -gpu
    ----

 **-gpu** \<Boolean\>   
Enable/Disable GPU support
 Default: true

 **-device** \<Integer\>   
GPU device to use
 Default: 1

 **-threads** \<Integer\>   
Max GPU threads to use
 Default: 2048

-   -pb\_potential
    --------------

 **-pb\_potential** \<Boolean\>   
pb\_potential option group

 **-charged\_chains** \<IntegerVector\>   
Chain numbers that carries charge in the PB calculation
 Default: 1

 **-sidechain\_only** \<Boolean\>   
Only calculate interactions to sidechain.
 Default: true

 **-revamp\_near\_chain** \<IntegerVector\>   
Scale down PB interactions if near the given chain. Use chain numbers as input.

 **-apbs\_path** \<String\>   
Path to the APBS (Adaptive Poisson-Boltzmann Solver) executable

 **-potential\_cap** \<Real\>   
Cap for PB potential input
 Default: 20.0

 **-epsilon** \<Real\>   
Tolerance in A. When a charged atom moves byond this tolerance, the PDE is resolved.
 Default: 2.0

 **-apbs\_debug** \<Integer\>   
APBS debug level [0-6]
 Default: 2

 **-calcenergy** \<Boolean\>   
Calculate energy?
 Default: false

-   -bunsat\_calc2
    --------------

 **-bunsat\_calc2** \<Boolean\>   
bunsat\_calc2 option group

 **-layered\_sasa** \<Boolean\>   
Use the variable solvent distance SASA calculator for finding buried unsats
 Default: true

 **-generous\_hbonds** \<Boolean\>   
Use generous hbond criteria
 Default: true

 **-sasa\_burial\_cutoff** \<Real\>   
Minimum SASA to be considered exposed
 Default: 0.01

 **-AHD\_cutoff** \<Real\>   
Minimum AHD angle for secondary geometry based h-bond detection
 Default: 120

 **-dist\_cutoff** \<Real\>   
max dist
 Default: 3.0

 **-hxl\_dist\_cutoff** \<Real\>   
hxl max dist
 Default: 3.5

 **-sulph\_dist\_cutoff** \<Real\>   
max sulph dist
 Default: 3.3

 **-metal\_dist\_cutoff** \<Real\>   
max metal dist
 Default: 2.7


