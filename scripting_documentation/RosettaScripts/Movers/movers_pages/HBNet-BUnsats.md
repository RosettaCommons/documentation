#HBNet Unsats

*Back to [[HBNet|HBNetMover]] page.  Back to [[Mover|Movers-RosettaScripts]] page.  Back to [[RosettaScripts|RosettaScripts]] page.*<br>

###How HBNet treats buried unsatisfied polar atoms
HBNet has its own internal method for evaluating and counting buried unsatisfied polar atoms.  Each network requires all buried heavy-atom donors and acceptors to participate in h-bonds.  Any network that does not meet and requires that does not meet this requirement is automatically thrown out.  Networks are first ranked and sorted based on the number of Hpol unsats, and users can specify ```max\_unsat\_Hpol```.  The reasoning is that buried polar heavy atoms incur a large energetic penalty (~5-6kcal/mol) if they do not form compensating hydrogen bonds, whereas for example, an NH2 of Asn or Gln that donates one Hpol but not the other is more tolerated.

###See also:
[[BuriedUnsatHbondsFilter]]