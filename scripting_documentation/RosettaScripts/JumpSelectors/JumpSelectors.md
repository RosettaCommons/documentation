<!-- --- title: JumpSelectors -->

*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

# JumpSelectors
----------------

JumpSelectors select a subset of Jumps from the FoldTree of a Pose. Their apply() method takes a Pose and returns a JumpSubset (a utility::vector1\< bool \>). This vector1 will be as large as there are jumps in the input Pose, and its ith entry will be "true" if jump i has been selected. 

The most common way of using a JumpSelector is with a [[MoveMapFactory |MoveMapFactories-RosettaScripts]] where you can construct a MoveMap that allows some jumps to minimize while keeping other jumps fixed. They can also be used to select residues, e.g. with the JumpDownstreamSelector or the JumpUpstreamSelector (coming soon).

JumpSelectors can be declared in their own block, outside of the TaskOperation block. For example:
```xml
    <JUMP_SELECTORS>
        <JumpIndex name="jump1" jump="1"/>
        <Interchain name="interchain"/>
    </JUMP_SELECTORS>
```
Some JumpSelectors can nest other JumpSelectors in their definition; e.g.
```xml
    <JUMP_SELECTORS>
        <Or name="interchain_and_jump1">
           <JumpIndex jump="1"/>
           <Interchain/>
        </Or>
    </JUMP_SELECTORS>
```
In this case, the documented structure of the Or JumpSelector will be stated as
```xml
    <Or name=(%string)>
        <(Selector)>
    </Or>
```
With the <(Selector)> subtag designating that any JumpSelector can be nested inside it,
including an Or selector (if you so desired).


### [[_TOC_]]

### Logical JumpSelectors

#### NotJumpSelector

    <Not name="(&string)" selector="(&string)">

or

    <Not name="(&string)">
        <(Selector) .../>
    </Not>

-   The NotJumpSelector requires exactly one selector.
-   The NotJumpSelector flips the boolean status returned by the apply function of the selector it contains.
-   If the "selector" option is given, then a previously declared JumpSelector (from a JUMP\_SELECTORS block of the XML file) will be retrieved from the DataMap
-   If the "selector" option is not given, then a sub-tag containing an anonymous/unnamed JumpSelector must be declared. This sub-selector will not end up in the DataMap.  For example, it is possible to nest an Index selector beneath a Not selector to say "give me all jumps except for Jump 2"
    ```xml
    <Not name="all_but_jump2">
       <JumpIndex jump="2"/>
    </Not>
    ```
any JumpSelector can be defined as a subtag of the Not selector.  You cannot, however, pass the subselector by name except by using the "selector" option.

#### AndJumpSelector

    <And name="(&string)" selectors="(&string)">
       <(Selector1)/>
       <(Selector2)/>
        ...
    </And>

-   The AndJumpSelector can take arbitrarily many selectors.
-   The AndJumpSelector takes a logical *AND* of the JumpSubset vectors returned by the apply functions of each of the JumpSelectors it contains.  <b>Practically speaking, this means that it returns the <i>intersection</i> of the selected sets -- the jumps that are in set 1 AND in set 2.</b>  (Do not confuse this with the "or" selector, which returns the union of the two sets -- the jumps that are in set 1 OR in set 2.)
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the AndJumpSelector, but will not be added to the DataMap.

#### OrJumpSelector

    <Or name="(&string)" selectors="(&string)">
       <(Selector1)/>
       <(Selector2)/>
        ...
    </Or>

-   The OrJumpSelector can take arbitrarily many selectors.
-   The OrJumpSelector takes a logical *OR* of the JumpSubset vectors returned by the apply functions of each of the JumpSelectors it contains.  <b>Practically speaking, this means that it returns the <i>union</i> of the selected sets -- the jumps that are in set 1 OR in set 2.</b>  (Do not confuse this with the "and" selector, which returns the intersection of the two sets -- the jumps that are in set 1 AND in set 2.)
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the OrJumpSelector, but will not be added to the DataMap.

### Conformation Independent Jump Selectors

#### JumpIndex

    <JumpIndex jump="(&int)"/>

-   This can select a single jump only

#### Interchain

    <Interchain/>

-   This selector selects all jumps that span two chains


####See Also

* [[MoveMapFactory |MoveMapFactories-RosettaScripts]]

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta