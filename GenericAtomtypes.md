## UNDER CONSTRUCTION!

### Motivation


### Basic rules for assigning generic atom types
1. Element type (currently supports H,C,N,O,S,P, and halogens only)
2. Given element type, whether it belongs to a common functional group (alcohol, amide, and so on)
3. If not, assign as general type based on hybridization state
3-1. for Carbons, further subtype based one whether attached to any polar atoms (N,O)
3-2. for Halogens, further subtype based on whether attached to aromatic system
4. Finally split types by number of hydrogens attached; this is Rosetta-specific thing since the solvation model treats hydrogens implicitly

### List and definitions of generic atom types
Below is the list of atom types defined by the rule above. Note that the logic here is still to be optimized, and can be updated/added/deleted/merged/splitted in the future.

Also listed at source/scripts/python/public/generic_potential/Types.py,
detailed logic can be found at source/scripts/python/public/generic_potential/AtomTypeClassifier.py.

-------------------------------------

```html
**Carbon**
CS  :
CS1 :
CS2 :
CS3 :
CD  :
CD2 :
CR  :
CT  :
CSp :
CDp :
CRp :
CTp :
CRb :

**Nitrogen**
Nam :
Nam2:
Nad :
Nad3:
Nin :
Nim :
Ngu1:
Ngu2:
NG3 :
NG2 :
NG21:
NG22:
NG1 :
NGb :

**Oxygen**
Ohx :
Oet :
Oal :
Oad :
Ofu :
Ont :
OG2 :
OG3 :
OG31:

**Hydrogen**
HC  :
HR  :
HO  :
HN  :
HS  :
HG  :

**Sulfur & Phosphorus**
Sth :
Ssl :
SG2 :
SG3 :
SG5 :
PG3 :
PG5 :

**Halogens**
F   :
Cl  :
Br  :
I   :
FR  :
ClR :
Br  :
IR  :

```

### How to generate a params file with generic atom types
* mol2genparams.py
located at source/scripts/python/public/generic_potential/