# RestrictIdentities
## RestrictIdentities

(This is a devel TaskOperation and not availible in the released version.)

<!--- BEGIN_INTERNAL -->

Used to specify a set of amino acid identities that are either restricted to repacking, or prevented from repacking altogether. Useful if you don't want to design away, for instance, prolines and glycines.

      <RestrictIdentities name=(&string) identities=(comma-delimited list of strings) prevent_repacking=(0 &bool) />

-   identities - A comma-delimited list of the amino acid types that you'd like to prevent from being designed or repacked (e.g., "PRO,GLY").
-   prevent\_repacking - Whether you want those identities to be prevented from repacking altogether (pass true) or just from being designed (pass false).

<!--- END_INTERNAL --> 

