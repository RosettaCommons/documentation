#RosettaScripts Conventions

*Note: This page is not a complete listing of all RosettaScripts conventions*

Overview
--------

RosettaScripts is becoming a significant tool in the Rosetta community, and most of the movers and filters in Rosetta already exist in the form of a RosettaScript parsable module. The lack of a standard RosettaScript XML file created a situation where each module (mover or filter) performed identical functions in different ways. This document was designed to correct this issue - a standard form will enable other application (pyRosetta, RosettaDiagrams) to work with RosettaScripts much more elegantly, and make it much easier to even hard-code.

Conventions
-----------

### Score Functions

All score function attributes should begin with *scorefxn*. In case 2 score functions are used (for example, low and high resolution) an underscore should be added: *scorefxn\_low*, *scorefxn\_high*.

### Task Operations

A task operations attribute should be named *task\_operations*, and will contain a comma separated list (without spaces) of all task operations.

### Contained Movers / Filters

There are several ways you can include other modules in your own module:

#### One mover / filter

Use the attribute *mover\_name* or *filter\_name* within your protocol tag.

#### Several movers / filters

use the \<Add mover\_name=.../\> or \<Add filter\_name=.../\> tags. for example:

    <Your_Mover some_attr=...>
        <Add mover_name="looper"/>
        <Add filter_name="minimizer"/>
    </Your_Mover>

#### Logical Operations

Please refrain from using logical operations within your tag, as it will only overpopulate the schema. If you want to enable logical operations that contain filters, please use the CompoundStatement Filter. For example, the following Code:

    <SomeMover ... >
        <AND filter_name ="filter1"/>
        <AND filter_name="filter2"/>
    </SomeMover>

Should be:

    <CompoundStatement name="compoundFilter" .. >
        <AND filter_name="filter2"/>
        <AND filter_name="filter1"/>
    </CompoundStatement>
    <SomeMover ... filter_name="compoundFilter"/>

OR

    <CompoundStatement name="compoundFilter" .. >
        <AND filter_name="filter2"/>
        <AND filter_name="filter1"/>
    </CompoundStatement>
    <SomeMover ... >
        <Add filter_name="compoundFilter"/>
    </SomeMover>

##See Also

* [[RosettaDiagrams (external link)|http://www.rosettadiagrams.org/]]: Provides a graphical interactive service to produce RosettaScripts XML files, with some ability to run the scripts as well.
* [[RosettaScripts]]: The RosettaScripts home page
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts Filters|Filters-RosettaScripts]]
* [[RosettaScripts TaskOperations|TaskOperations-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta