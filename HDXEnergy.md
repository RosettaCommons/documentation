# HDX Energy

Creator Names:
* Tung Nguyen
* Daniel Marzolf
* Justin Seffernick
* Sten Heinze
* PI: Steffen Lindert (lindert.1@osu.edu)

Date created: February 22, 2022

Use Hydrogen-deuterium exchange (HDX) data measured by nuclear magnetic resonance (NMR) to evaluate protein structural information and to supplemented computational prediction methods with a scoring function to quantify the agreement with HDX data.

Reference: https://doi.org/10.1016/j.str.2021.10.006

### Categorical

Use strength categories that corresponded to HDX rates (rather than the quantitative exchange rates) to score.

### Quantitative

Use quantitative protection factors (PFs) from HDX-NMR for scoring.

### Usage

To use the application, the following command line options can be specified: 

```
-in:file:s 1a2p_A.pdb
-in::file::HDX 1a2p_pf.txt
-ResPF
-out::file::o 1a2p_test.out

```

### Example

```
./HDXEnergy.linuxgccrelease -in:file:s 1a2p_A.pdb -in::file::HDX 1a2p_pf.txt -out::file::o 1a2p_test.out -ResPF           
```

