# SetSecStructEnergies
## SetSecStructEnergies

Give a bonus to the secondary structures specified by a blueprint header. For example "1-4.A.99" in a blueprint would specify an antiparallel relationship between strand 1 and strand 4; when this is present a bonus (negative) score is applied to the pose.

```
<SetSecStructEnergies name=(&string) scorefxn=(&string) blueprint="file.blueprint" natbias_ss=(&float)/> 
```

-   blueprint = a blueprint file with a header line for the desired pairing. Strand pairs are indicated by number (1-4 is strand 1 / strand 4) followed by a ".", followed by A of P (Antiparallel/Parallel), followed by a ".", followed by the desired register shift where "99" indicates any register shift.
-   e.g. "1-6.A.99;2-5.A.99;" Indicates an antiparallel pair between strand 1 and strand 6 with any register; and an antiparallel pair between strand 2 and strand 5 with any register
-   In the order of secondary structure specification, pairs start from the lowest strand number. So a strand 1 / strand 2 pair would be 1-2.A, not 2-1.A, etc.
-   natbias\_ss = score bonus for a correct pair.


