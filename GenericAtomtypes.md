## UNDER CONSTRUCTION!

### Motivation
* Missing atom types in fa_standard! Keep appending "new" ones to protein-based atom types may not generalize atom type set...

* Why do we need own atom type set instead of borrowing existing ones (from generic MM force fields and so on)?
- The optimal set for Rosetta modeling and scoring can be quite different from those from other tools; for instance, those generally lack considerations for implicit-hydrogen solvation terms (#4 below). Also once we establish our own set we have control over, we can continuously optimize it for our own purpose at any time.

### Basic rules for assigning generic atom types
Rules are listed by priority; for instance, lookup for functional group always precedes hybridization state. 

1. Element type (currently supports H,C,N,O,S,P, and halogens only)
2. Given element type, whether it belongs to a common functional group (alcohol, amide, and so on)
3. If not, assign as general type based on hybridization state
3-1. for Carbons, further subtype based one whether attached to any polar atoms (N,O)
3-2. for Halogens, further subtype based on whether attached to aromatic system
4. Finally split types by number of hydrogens attached; this is Rosetta-specific thing since the solvation model treats hydrogens implicitly

### List and definitions of generic atom types
Below is the list of atom types defined by the rule above, as of March 2018. Note that the logic here is still to be optimized, and can be updated/added/deleted/merged/splitted in the future.

Up-to-date list can be found at source/scripts/python/public/generic_potential/Types.py,
detailed logic at source/scripts/python/public/generic_potential/AtomTypeClassifier.py.

-------------------------------------

```html
**Carbon**
CS  : sp3 aliphatic, 0-H
CS1 : sp3 aliphatic, 1-H
CS2 : sp3 aliphatic, 2-H
CS3 : sp3 aliphatic, 3-H
CD  : sp2 aliphatic, 0-H
CD1 : sp2 aliphatic, 1-H
CD2 : sp2 aliphatic, 2-H
CT  : sp1 aliphatic (no distinction for #H attached)
CR  : aromatic, 0-H
CSp : sp3 aliphatic, 0-H
CDp : sp3 aliphatic, 0-H
CRp : sp3 aliphatic, 0-H
CTp : sp1, attached to polar atom(s)
CRb : Aromatic carbon, as an axis of biaryl dihedrals

**Nitrogen**
Nam : N at AMonium/AMine, primary, >= 1-H
Nam2: N at AMonium/AMine, secondary~tertiary, >= 1-H (w/o H goes to NG3)
Nad : N at AmiDe, primary~secondary, >= 1-H
Nad3: N at AmiDe, 0-H == tertiary OR w/ lonepair
Nin : N at INdole, 1-H
Nim : N at IMine, w/ lone pair and 0-H
Ngu1: N at GUanidium, 1-H
Ngu2: N at GUanidium, 2-H
NG3 : Generic sp3 N; 0-H SHOULD BE non-acceptor/donor
NG2 : Generic sp2 N; 0-H
NG21: Generic sp2 N; 1-H
NG22: Generic sp2 N; 2-H
NG1 : Generic sp1 N; 0-H
NGb : Aromatic N, as an axis of biaryl dihedrals

**Oxygen**
Ohx : O at HydroXyl (== 1-H)
Oet : O at ETher (== 0-H)
Oal : O at ALdehyde and ketone (== 0-H)
Oad : O at AmiDe
Ofu : O at FUran
Ont : O at NiTro
OG2 : Generic sp2 O; 0-H
OG3 : Generic sp3 O; 0-H
OG31: Generic sp3 O; 1-H #exceptional cases with 1H attached and not a hydroxyl

**Hydrogen**
HC  : H attached to aliphatic C
HR  : H attached to aromatic C
HO  : H attached to O
HN  : H attached to N
HS  : H attached to S
HG  : H attached to other elements

**Sulfur/Phosphorus**
Sth : S at THiol (== 1-H)
Ssl : S at SuLfide (== 0-H)
SG2 : Generic sp2 S (for example, thione)
SG3 : Generic sp3 S 
SG5 : Generic sp5 S (for example, Sulfonate)
PG3 : Generic sp3 P
PG5 : Generic sp5 P (for example, Phosphate)

**Halogens**
F   : Aliphatic Fluorine
Cl  : Aliphatic Chlorine
Br  : Aliphatic Bromine
I   : Aliphatic Iodine
FR  : Aromatic Fluorine
ClR : Aromatic Chlorine
Br  : Aromatic Bromine
IR  : Aromatic Iodine

```

### How to generate a params file with generic atom types
* mol2genparams.py
located at source/scripts/python/public/generic_potential/