<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
The smart annealer uses tensorflow to decrease the sample space of a typical packing run

```xml
<EnableSmartAnnealer name="(&string;)" model="(generation2 &string;)"
        cutoff="(0.25 &real;)" pick_again="(true &bool;)"
        disable_during_quench="(true &bool;)" />
```

-   **model**: Choose which neural network to use for the smart annealer. Look at database/protocol_data/tensorflow_graphs/smart_annealer/ to see the options.
-   **cutoff**: Choose a number from 0 to 1 to tune how aggressive the smart annealer is. Higher numbers are more agressive (risky) but have a potentially greater speedup (speedup requires pick_again=false)
-   **pick_again**: f disabled, the smart annealer just skips unfruitful amino acids. Enabling this option tells the annealer to pick a fruitful rotamer to sample this round instead of skipping the round. Will not give you a speedup but may give you a better final outcome.
-   **disable_during_quench**: Run the final quenching stage as normal, regardless of how bad an amino acid may be.

---
