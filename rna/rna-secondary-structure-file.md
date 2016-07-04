# RNA secondary structure file
# Basics
+ Use dot-parens notation.
+ Can use parentheses (`(`,`)`), square brackets (`[`,`]`), and curly brackets (`{`,`}`).
+ After first line, can put anything you want.

#Examples
# Simple
```
(....()....)
ucagguaagcag
```
in `demos/public/RNA_Denovo/chunk002_1lnt_.secstruct`.

# Complex
For GIR1 ribozyme (RNA puzzle5):
```
(((((..((((((.(((((((((.......))))))))).((((((((((((((......(((((...((((((((((....))))....)).))))((....)).....[[[[[...))))).((((...)))))))))))))...]]]]].((((....))))....))))).))))))..)))))
gguuggguugggaaguaucauggcuaaucaccaugaugcaaucggguugaacacuuaauuggguuaaaacggugggggacgaucccguaacauccguccuaacggcgacagacugcacggcccugccucuuagguguguucaaugaacagucguuccgaaaggaagcauccgguaucccaagacaauc
```
in `tests/integration/tests/rna_puzzle5_P15P3P8_noP4P6_4RB_G208phosphate_ligation/GIR1_secstruct.txt`

# See Also
* [[rna-denovo]]: main application where this file format is used.
* [[RNA applications]]: The RNA applications home page
