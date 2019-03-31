### Motivation
* A set of atom types that covers most of the chemistry we are interested in

The standard atom type set (namely "fa_standard") has been originally derived from proteins only, then has been extended whenever there was a strong need for certain atom type chemistry of which was completely missing. Instead of this adaptive approach, we thought it is worth systematically building up a new set that should cover most of the chemistry required in broad range of biomolecular modeling studies.

* To address features speicific for Rosetta energy

Also, instead of copying over existing generic molecular mechanics force field parameters, we sought for our own definitions of atom types which we thought should be optimal for Rosetta modeling and scoring. There are several unique features that Rosetta energy function has (compared to other force fields/energy functions), which should be carefully considered when defining atom types; for instance, implicit treatment of solvation effects by hydrogens (#4 below), orientation dependence in solvation and H-bond terms, explicit definitions of H-bond donor/acceptors, distinction between intra vs inter residue energy, and so on. 

Another advantage is, once we establish our own set we have control over, we can continuously optimize it for our own purpose at any time.

### Basic rules for assigning generic atom types
Rules are listed by priority; for instance, lookup for corresponding functional group always precede hybridization state. 

1) Element type (currently supports H,C,N,O,S,P, and halogens only)

2) Given element type, whether it belongs to a common functional group (alcohol, amide, and so on; details below)

3) If not, assign as general type based on hybridization state

- for Carbons, further subtype based one whether attached to any polar atoms (N,O)

- for Halogens, further subtype based on whether attached to aromatic system

4) Finally split types by number of hydrogens attached; this is Rosetta-specific thing since the solvation model treats hydrogens implicitly

### List and definitions of generic atom types
Below is the list of atom types defined by the rule above, as of March 2018. Note that the logic here is still to be optimized, and can be updated/added/deleted/merged/splitted in the future.

Up-to-date list can be found at source/scripts/python/public/generic_potential/Types.py,

detailed logic at source/scripts/python/public/generic_potential/AtomTypeClassifier.py.

-------------------------------------

```html
**Carbon**
CS  : sp3 aliphatic, 0-H [Maps to CH0] 
CS1 : sp3 aliphatic, 1-H [Maps to CH1]
CS2 : sp3 aliphatic, 2-H [Maps to CH2]
CS3 : sp3 aliphatic, 3-H [Maps to CH3]
CD  : sp2 aliphatic, 0-H [No match]
CD1 : sp2 aliphatic, 1-H [No match]
CD2 : sp2 aliphatic, 2-H [No match]
CT  : sp aliphatic (no #H condition) [No match]
CR  : aromatic, 0or1-H [Maps to aroC]
CSp : sp3 aliphatic, (no #H condition) [Maps to CAbb?] 
CDp : sp2 aliphatic, (no #H condition) [Maps to CObb?] 
CRp : aromatic, (no #H condition) [Maps to CR?] 
CTp : sp, attached to polar atom(s) [No match] 
CRb : Aromatic carbon, as an axis of biaryl dihedrals [No match] 

**Nitrogen**
Nam : N at AMonium/AMine, primary, >= 1-H [Maps to Nlys] 
Nam2: N at AMonium/AMine, secondary~tertiary, >= 1-H (w/o H goes to NG3) [No match] 
Nad : N at AmiDe, primary~secondary, >= 1-H [Maps to Nbb or NH2O] 
Nad3: N at AmiDe, 0-H == tertiary OR w/ lonepair #Azo also goes here [Maps to Npro] 
Nin : N at INdole, 1-H [Maps to Ntrp] 
Nim : N at IMine, w/ lone pair and 0-H [Maps to Nhis]
Ngu1: N at GUanidium, 1-H [Maps to NtrR]
Ngu2: N at GUanidium, 2-H [Maps to Narg]
NG3 : Generic sp3 N; 0-H SHOULD BE non-acceptor/donor [No match]
NG2 : Generic sp2 N; 0-H [No match]
NG21: Generic sp2 N; 1-H [No match]
NG22: Generic sp2 N; 2-H [No match]
NG1 : Generic sp N; 0-H [No match]
NGb : Aromatic N, as an axis of biaryl dihedrals [No match]

**Oxygen**
Ohx : O at HydroXyl (== 1-H) (also -O-H at acids) [Maps to OH]
Oet : O at ETher (== 0-H) [Maps to Oet2,3]
Oal : O at ALdehyde (== 0-H) (also at ketone, acetyl, ester, =O at acids) [No match]
Oad : O at AmiDe [Maps to OCbb, ONH2]
Oat : O at carboxylATe (currently =O at phosphates/sulfonates goes to Oal)
Ofu : O at FUran [Maps to Oaro?]
Ont : O at NiTro [No match]
OG2 : Generic sp2 O; 0-H [No match]
OG3 : Generic sp3 O; 0-H [No match]
OG31: Generic sp3 O; 1-H #excpt. cases with 1H attached and not a hydroxyl [No match]

**Hydrogen**
HC  : H attached to aliphatic C [Maps to Hapo]
HR  : H attached to aromatic C [Maps to Haro]
HO  : H attached to O [Maps to Hpol]
HN  : H attached to N [Maps to Hpol]
HS  : H attached to S [Maps to HS]
HG  : H attached to other elements

**Sulfur/Phosphorus**
Sth : S at THiol (== 1-H) [Maps to SH1]
Ssl : S at SuLfide (== 0-H) [Maps to S]
SG2 : Generic sp2 S (for example, thione) [No match]
SG3 : Generic sp3 S [No match]
SG5 : Generic sp5 S (for example, Sulfonate) [No match]
PG3 : Generic sp3 P [Maps to Pbb or Phos?]
PG5 : Generic sp5 P (for example, Phosphate) [Maps to Pha?]

**Halogens**
F   : Aliphatic Fluorine
Cl  : Aliphatic Chlorine
Br  : Aliphatic Bromine
I   : Aliphatic Iodine
FR  : Aromatic Fluorine [No match]
ClR : Aromatic Chlorine [No match]
Br  : Aromatic Bromine [No match]
IR  : Aromatic Iodine [No match]

```

### Grouping for torsion param assignments
-------------------------------------

```html

TBA

```

### How to generate a params file
* mol2genparams.py
located at source/scripts/python/public/generic_potential/

python mol2genparams.py [-s mol2file or -l list-of-mol2files]

more information about mol2genparams.py and preprocessing inputs can be found [[here|GALigandDock-Preprocessing]]

### Limitations
- Currently does not support elements other than H,C,N,O,S,P,and halogens; **will fail to generate params file when the molecule includes Si,Be,B,or any metals or ions**
- FoldTree setup part is sometimes unstable; can be optimized in future
- Biaryl-axis atom types (CRb and NGb) override any existing types whenever (potential) biaryl dihedral connected to the atom is detected. This can sometimes hurt correct torsion type assignments for other torsions
- Requires a mol2 file (and only mol2 file!) to generate params file. Will be generalized to support more file formats if necessary

