# DsspDesign
## DsspDesign
    
Design residues with selected amino acids depending on the local secondary structure. The secondary structure at each residue is determined by DSSP (or read from a blueprint file).

All functionality here is included in the LayerDesign task operation, which is much more powerful. However, this filter has significantly reduced overhead by avoiding slow SASA calculations.

    <DsspDesign name=(&string) blueprint=(&string)>
        <SecStructType aas=(&string) append(&string) exclude=(&string)/>
    </DsspDesign>
- blueprint: a blueprint file which specifies the secondary structure at each position.

Below are the valid secondary structure types and the default set of allowed residue types.
- Helix: ADEFIKLNQRSTVWY
- Sheet: DEFHIKLNQRSTVWY
- Loop: ACDEFGHIKLMNPQRSTVWY
- HelixStart: ADEFHIKLNPQRSTVWY
- HelixCapping: DNST
- Nterm: ACDEFGHIKLMNPQRSTVWY
- Cterm: ACDEFGHIKLMNPQRSTVWY

The set of allowed residues for each secondary structure type can be customized.
- aas: define the set of residues allowed for the defined secondary structure type; the string is composed of one letter amino acid codes.
- append: append the following residues to the set of allowed residues for the defined secondary structure type.
- exclude: opposite of append.

