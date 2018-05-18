revert\_design\_to\_native application
----------------------------------

This application is not yet strictly speaking part of RosettaScripts but is strongly related to the design purposes of RS.

The application was described in:

Fleishman et al. Science 332: 816. Here is the relevant excerpt:

For each design that passed the abovementioned filters, the contribution of each amino-acid substitution at the interface is assessed by singly reverting residues to their wildtype identities and testing the effects of the reversion on the computed binding energy. If the difference in binding energy between the designed residue and the reverted one is less than 0.5R.e.u. in favor of the design, then the position is reverted to its wildtype identity. A Rosetta application to compute these values is available in the Rosetta release and is called revert\_design\_to\_native. A report of all residue changes was produced and each suggestion was reviewed manually.

<code>
Usage: revert\_design\_to\_native -revert\_app:wt \<Native protein PDB\> -revert\_app:design \<Designed PDB\> -ex1 -ex2 -use\_input\_sc -database \<\> \> log
</code>

Keep the log. At its end you'll find a summary of all mutations attempted and their significance for binding energy.
