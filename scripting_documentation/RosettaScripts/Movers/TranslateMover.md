# Translate
## Translate

```
<Translate name="&string" chain="&string" distribution=[uniform|gaussian] angstroms=(&float) cycles=(&int)/>
```

The Translate mover is for performing a course random movement of a small molecule in xyz-space. This movement can be anywhere within a sphere of radius specified by "angstroms". The chain to move should match that found in the PDB file (a 1-letter code). "cycles" specifies the number of attempts to make such a movement without landing on top of another molecule. The first random move that does not produce a positive repulsive score is accepted. The random move can be chosen from a uniform or gaussian distribution. This mover uses an attractive-repulsive grid for lightning fast score lookup.

