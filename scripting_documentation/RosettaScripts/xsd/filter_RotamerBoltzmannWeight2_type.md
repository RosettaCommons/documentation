<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<RotamerBoltzmannWeight2 name="(&string;)"
        probability_type="(BOLTZMANN_SUM &string;)"
        score_type="(MODIFIED_DDG &string;)" lambda="(0.5 &string;)"
        temperature="(0.8 &string;)" residue_selector="(&string;)"
        scorefxn="(&string;)" confidence="(1.0 &real;)" />
```

-   **probability_type**: How probabilities are calculated: BOLTZMANN_SUM -- A simple boltzmann sum defined by 1/SUM( e^( -(score - score_0)/temp ) ), where score_0 is the score with the rotamer in the input pose. The score of the input pose is included in this sum, and therefore it can range from (0, 1]. All rotamers not in the input pose are essentially considered equally "far" from the input. PNEAR -- Probability of being near the input state, using a Gaussian to define nearness in sidechain heavy atom RMSD to the input state as proposed by Vikram Mulligan in the Baker Lab. The lambda parameter defines the width of the Gaussian. For a lambda of 0.5, a rotamer with sidechain RMSD of 0.5 will be scored as as half "near" and half "far" from the input state. PNEAR is defined as NUMERATOR/DENOMINATOR, where NUMERATOR = SUM( e^(-rms^2/lambda^2)*e(-(score - score_0)/temp) ), and DENOMINATOR = SUM( e^( -(score - score_0)/temp ).
-   **score_type**: The method used to combine the rotamer probabilities into the single number reported by the filter. Available score types are: MEAN_PROBABILITY -- Returns the mean of all computed probabilities. MAX_PROBABILITY -- Returns the maximum of all computed probabilities. MIN_PROBABILITY -- Returns the minimum of all computed probabilities. PROBABILITY -- Returns the product of all computed probabilities. MODIFIED_DDG -- Returns a ddG value weighted by the rotamer probabilities as described in Fleishman et al. (2011) Protein Sci. 20:753.
-   **lambda**: The "lambda" value to be used in computing "nearness" to the input state during rotamer probability calculation. This is only used if "PNEAR" is the probability method.
-   **temperature**: The temperature to be used in computing rotamer probabilities
-   **residue_selector**: XRW TO DO. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **scorefxn**: Name of score function to use
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
