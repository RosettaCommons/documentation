## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 8/19/15

## Algorithm Description
This application makes a mutation and then repacks the mutation site for a soluble protein. The score function it uses is talaris2014. The mutation is on the command line (-mp:mutate_relax:mutation) 

## Code and Demo
The application can be found at `apps/pilot/jkleman/mutate.cc`. 

## Run the application

Example flags: 

```
Rosetta/main/source/bin/mp_mutate_relax.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \

# specified mutation to make. (This is not for MPs, I just hijacked it's flag for now!)
-mp:mutate_relax:mutation A163F       
```

