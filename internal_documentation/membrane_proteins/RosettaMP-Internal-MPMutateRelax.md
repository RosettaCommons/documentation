## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 4/26/15

## Algorithm Description
This application makes a mutation and then optionally repacks the mutation site or within a radius of the mutation site or runs MPQuickRelax on a membrane protein. The score function it uses is mpframework_smooth_fa_2012. The mutation can either specified on the command line (-mp:mutate_relax:mutation) or given in a mutation file. The mutation file can contain several independent constructs to run this application for. An example of the mutation file is:

```
A14F S57K
L3I
H29T A85N D34E
```

The file above describes three different constructs, the first one with two mutations, the second one with a single point mutation and the third one with three mutations; pose numbering is used here. The application will create independent models for each construct.

The default run for this application is mutation-only. This means if you want to repack or relax, you have to specify it with the options below. 

To be able to run the application from the mutation file, yet get multiple decoys per construct, it runs outside of JD2. **The -nstruct flag should therefore always be 1**, otherwise the same models will be overwritten! The number of models generated here are 100 by default, but can be changed by the flag -mp:mutate_relax:iter.

## Code and Demo
The application can be found at `apps/pilot/jkleman/mp_mutate_relax.cc`. The underlying mover is located in `protocols/membrane/MPMutateRelaxMover`.

## Options

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-mp:mutate_relax:mutation A14F|wildtype residue / pose residue number / mutation - residues in one-letter-codes|string|
|-mp:mutate_relax:mutant_file mutations_1AFO.mut|mutation file; provide EITHER mutation or mutant_file|string|
|-mp:mutate_relax:iter 50|Number of models created for running relax, replaces -nstruct for this app! For mutation only and repack the default is 1 (because packer is pretty much deterministic), for relax it is 100|integer|
|-mp:mutate_relax:repack_mutation_only 1|optional: repack only the mutated residue|boolean|
|-mp:mutate_relax:repack_radius 8|optional: repack residues within X Angstrom around the mutated residue|float|
|-mp:mutate_relax:relax 1|optional: do a full relax run with MPQuickRelax|boolean|
|-mp:quickrelax:angle_max 1|optional for relax: maximum dihedral angle deviation allowed, typically 1 or less for large proteins, can be larger for small proteins; test and eyeball|float|
|-mp:quickrelax:nmoves nres|optional for relax: number of Small and ShearMoves within relax; can either be "nres" or an integer; typically nres|string(int)|

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_mutate_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \

# spanfile defining protein topology
-mp:setup:spanfiles 1AFO__tr.span \ 

# specify that you want to run relax
-mp:mutate_relax:relax 1 \

# optional, maximum allowed dihedral angle change, typical value around 1.0, default 1.0
-mp:quickrelax:angle_max 1.0 \        

# number of Small and ShearMoves for relax                                      
-mp:quickrelax:nmoves nres \          

# specified mutation to make. Either this flag or mutant_file flag must be given.
-mp:mutate_relax:mutation A163F       

# optional, only build 5 models. Default is 100
-mp:mutate_relax:iter 5 \             

# required, MUST be 1, otherwise models will be overwritten n times!
-nstruct 1 \                          
```

## Reference

This protocol is currently not published yet. The framework and previous protocol was published in:

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
