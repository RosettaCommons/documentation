<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
A TaskOp that takes a regex-like pattern and turns it into a set of design residues.  The string should identify what to do for each position.  Does not TURN OFF design or packing for ANY residue other than those specified in the motif as '-' or with specific resfile command!

```xml
<SequenceMotifTaskOperation name="(&string;)" motif="(&string;)"
        residue_selector="(&string;)" />
```

-   **motif**: This is slightly similar to a regex, but not quite. We are not matching a sequence,
   we are designing in a motif regardless of the current sequence, anywhere in a protein.

   - Each letter corresponds to a position. Using [ ] indicates a more complicated expression for that position.
   - An X indicates it can be anything, and that we are designing here.
   - An AA Letter, like V, indicates that that position will be designed to a V.
   - A - charactor indicates that that position stays with whatever it is currently.  We essentially skip this position.
   - An expression like: [^PAV] indicates that we will design anything except Proline, Alanine, and Valine 
   - An expression like: [NTS] indicates that that position can be Asparigine, Threonine, or Serine and 
      only of these will be enabled during the design.
   - RESFILE commands are accepted as well. These require a % charactor in from of the whole expression.
     For example [%POLAR] would set that position to only polar design.

 EXAMPLE:
  Glycosylation N-Linked motif design: N[^P][ST]
-   **residue_selector**: . The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.

---
