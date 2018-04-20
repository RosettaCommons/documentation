Computes the Boltzmann probability of occurrence of each rotamer in the pose within the user-provided residue subset. The method upon which this filter is based is published in Fleishman et al. (2011) Protein Sci. 20:753. This filter is essentially an extension of the original [[RotamerBoltzmannWeightFilter]], and is unit tested to produce the same results when run with similar options, and also works with symmetry. The original RotamerBoltzmannWeight filter is published and so it's usage is/should be essentially unchanged for reproducibility sake. However, this filter can adapt to future needs. There are three fundamental improvements over the original RotamerBoltzmannWeight filter:

1. Rather than being specifically geared toward interfaces, RotamerBoltzmannWeight2 uses a residue selector as the only means of specifying a subset of residues on which to work, which greatly simplifies the internal logic and is transparent to the user.

2. Can use several methods of computing probability of each rotamer (see below)

3. Can report several different types of scores

4. Simplified options with the aim of greater user transparency.

###Score Computation

RotamerBoltzmannWeight2 uses a two-step process to compute a score.  First, rotamer probabilities are computed using the method specified by the 'probability_type' option for all selected residues. Next, these probabilities are combined to a single number using the method specified by the 'score_type' option.

Note that this filter does not perform any pose modification prior to computation. If rotamer probabilities in the 'unbound' state (or other modified states) are desired, the [[MoveBeforeFilter]] should be used with RotamerBoltzmannWeight2 as the filter.

###Caveats

Alanine and Glycine have no distinct heavy-atom rotamers. Therefore, the probability score for ALA and GLY will always be 1.0. So, if you are using MAX_PROBABILITY and a residue subset that includes ALA or GLY, the score for the entire residue subset will be 1.0. To avoid this, you can exclude ALA and GLY in your residue selector as below:

```xml
<RESIDUE_SELECTORS>
   <ResidueName name="ala_gly" residue_name3="ALA,GLY" />
   <Not name="not_ala_gly" selector="ala_gly" />
   <And name="boltz_subset" selectors="not_ala_gly,your_residue_subset" />
</RESIDUE_SELECTORS>
<FILTERS>
    <RotamerBoltzmann2 name="rot_boltz_skip_ala_gly" residue_selector="boltz_subset" />
</FILTERS>
```

```xml
<RotamerBoltzmannWeight2 name="(&string)"
    residue_selector="('TrueSelector' &string)"
    scorefxn="(talaris2014 &string)"
    probability_type="('ROTAMER_BOLTZMANN' &string)"
    score_type="('MEAN_PROBABILITY' &string)"
    temperature="(0.8 &real)"
    lambda="(0.5 &real)" />
```

**Options**

* residue\_selector -- Computes rotamer probability for all residues specified here. 

* probability\_type -- The method that will be used to compute rotamer probabilities. The methods are as follows:

     1. BOLTZMANN_SUM -- A simple boltzmann sum defined by 1/SUM( e^( -(score - score_0)/temp ) ), where score_0 is the score with the rotamer in the input pose. The score of the input pose is included in this sum, and therefore it can range from (0, 1].  All rotamers not in the input pose are essentially considered equally "far" from the input.

     2. PNEAR -- Probability of being near the input state, using a Gaussian to define nearness in sidechain heavy atom RMSD to the input state as proposed by Vikram Mulligan in the Baker Lab. The lambda parameter defines the width of the Gaussian.  For a lambda of 0.5, a rotamer with sidechain RMSD of 0.5 will be scored as as half "near" and half "far" from the input state. PNEAR is defined as NUMERATOR/DENOMINATOR, where NUMERATOR = SUM( e^(-rms^2/lambda^2)*e(-(score - score_0)/temp) ), and DENOMINATOR = SUM( e^( -(score - score_0)/temp ).

* score\_type -- The method used to combine the rotamer probabilities into the single number reported by the filter.  Available score types are:

    1. MEAN_PROBABILITY -- Returns the mean of all computed probabilities

    2. MAX_PROBABILITY -- Returns the maximum of all computed probabilities

    3. MODIFIED_DDG -- Returns a ddG value weighted by the rotamer probabilities as described in Fleishman et al. (2011) Protein Sci. 20:753.

* temperature -- The temperature to be used in computing rotamer probabilities

* lambda -- The "lambda" value to be used in computing "nearness" to the input state during rotamer probability calculation. This is only used if "PNEAR" is the probability method.
