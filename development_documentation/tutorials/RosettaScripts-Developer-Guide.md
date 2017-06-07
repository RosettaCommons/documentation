#RosettaScripts Developer Guide

[[Return to RosettaScripts|RosettaScripts]]

*This page was modified in the Minicon 11 Wiki Update, but we didn't quite finish it for reasons of lack of time or knowledge. If you can finish it, please do!*

 Using RosettaScripts in its most basic sense involves organizing a workflow of [[Mover|Movers-RosettaScripts]] classes that are defined and parameterized in an XML-like scripting language that is read and processed into an arbitrary minirosetta protocol at runtime. The use of Filter classes is also used to further control protocol flow.

Review of RosettaScript Structure 
---------------------------------
A RosettaScript is an XML document which MUST be contained within opening and closing `<ROSETTASCRIPTS>` tags. Within those tags lie several top-level elements:
- Movers are defined in the MOVERS element and stored in the Movers_map. They are handled directly by the RosettaScriptsParser.
- Similarly, Filters are defined in the FILTERS element and stored in the Filters_map. They are also handled directly by the RosettaScriptsParser.
- The PROTOCOLS element is required, order-sensitive, and defines the order in which movers and filters will be applied. It is really just the tag for the ParsedProtocol mover and handles its own parsing.
- The APPLY_TO_POSE element is deprecated and really shouldn't be used. It allows users to define movers that will be applied to the pose BEFORE other movers/filters are parsed, which could affect residue numbering, add constraints, etc. All of these functions can be handled elsewhere (through reference poses, constraint generators, etc.).
- The OUTPUT element's only attribute is a score function; it is used to designate which score function should be used to score the final pose at the end of a protocol.
- All other top-level elements (defining score functions, task operations, residue selectors, etc.) are parsed by DataLoader classes and stored in the DataMap.

DataMap
-------

The DataMap is an internal structure for holding pointers to objects of arbitrary type. Each Mover's parse\_my\_tag() method has const access to the DataMap, and can recover pointers from it. This can be useful for communication between movers. For example, both the LoopFinder and KinematicLoop movers can get a common LoopsOP during parsing. At apply time the LoopFinder can fill the LoopsOP with loops, and KinematicLoop can subsequently read from it.

###Using the DataMap
During RosettaScripts parsing, most classes (other than movers and filters) are read in by a DataLoader and placed in the DataMap. This allows other classes (movers/filters, etc.) to access them by referencing them by name in their tags.
As an example, ResidueSelectors are stored in the DataMap under the category "ResidueSelector". When the RosettaScripts parser encounters the RESIDUE_SELECTORS block of a RosettaScript, the ResidueSelectorLoader instantiates each of the selectors defined in that block and stores them in the DataMap using the function add( "ResidueSelector", <name of selector>, <OP to selector>). When a tag later references that selector i.e. using the option residue_selectors="x,y,z", we can then retrieve the appropriate selectors using the DataMap's function  

###Adding new top-level RosettaScripts blocks
To add a new top-level subelement of the ROSETTA_SCRIPTS element, there are three major requirements:

1. As with any RosettaScripts element, all elements you wish to contain in this block must have parse_my_tag and provide_xml_schema functions.
2. The class you wish to contain in this element must have a factory and registrator, and each subclass must have a creator.
3. You must create a DataLoader class. These are currently found in protocols/jd2/parser. **Note that when RosettaScripts is transitioned to jd3, this may change.** 

Each DataLoader defines the name of its corresponding top-level block (e.g. CONSTRAINT_GENERATORS), parses all of the subtags using the corresponding class's parse_my_tag function, and stores them in the DataMap. **Note:** Make sure that 1) if any other classes store members of your parent class in the data map, they use the same category name and 2) you use the same category name within the DataMap that other classes are expecting. For example, if you stored a residue selector under the "residue_selectors" category, other classes would not be able to access it since they would be expecting to find it in the "ResidueSelector" category.

Movers
------

### Mover Requirements

In order to be supported under the Parser scheme, a Mover class (any class that derives from the Mover base class) must implement some additional methods:

- 
  ```cpp
void parse_my_tag (
        utility::tag::TagCOP,
        protocols::moves::DataMap &,
        protocols::filters::Filters_map const &,
        protocols::moves::Movers_map const &,
        core::pose::Pose const & );
  ```
  This method is responsible for configuring the mover from the given XML tag (i.e. the TagCOP).  This typically involves using `tag->getOption()` and `tag->getTags()` to get information from specific options and subtags.  The three maps (data, filters, movers) provide information on other tags that have been defined in the same script.  This allows one mover to call another, or several movers to share a Loop, or things like that.  The pose that the rosetta script will be applied to is also provided.

- 
  ```cpp
static void provide_xml_schema(
        utility::tag::XMLSchemaDefinition & xsd );
  ```
  This is a static method responsible for declaring what options and subtags the movers understands.  Rosetta uses this information to find typos and errors before starting the protocol (which is much preferable to encountering them after the protocol has been running for hours) and to print informative error messages about them.  You can find documentation on how to implement this method [here](https://wiki.rosettacommons.org/index.php/XMLSchemaFAQ).  As of June 2017, however, that documentation is pretty incomplete, so your best bet is to copy code from a mover that does something similar to what you want and modify it as necessary.

- 
  ```cpp
MoverOP fresh_instance( ) const;
  ```
  This method is responsible for returning an uninitialized copy of the mover.  It's pretty simple to implement.  If your mover is called `MyMover`, `fresh_instance()` should look like this:
  ```cpp
return protocols::moves::MoverOP( new MyMover );
  ```
- 
  ```cpp
MoverOP clone( ) const;
  ```
  This method is responsible for returning a duplicate of the mover.  This is different from `fresh_instance()` in that the returned copy should be configured in exactly the same way as the original.  Furthermore, this copy should be a "deep-copy", which means that any changes to the original should not be reflected in the copy.

  This method is usually very challenging to implement correctly.  You need to copy every attribute that affects how the mover behaves (which is typically all of them).  For any attributes that are pointers (typically most of them), you need to instantiate a new copy of the object being pointed to and copy over all of it's attributes (to make a deep copy).  Sometimes the attribute in question will have its own `clone()` method that will do this for you, but sometimes you have to be more creative.

  The `clone()` method is closely related to the copy constructor and the assignment operator (`operator=`), so its a good idea to try to reuse some code between three these methods.

Note that the function signatures for `parse_my_tag()` and the other functions should match the ones from the Mover base class exactly (a common mistake is to forget the `const` after the argument list), otherwise the derived method will not be called.

#### Documenting your mover

Since RosettaScripts allows you to put Movers together in ways that have not been tried before there are a few things you **NEED** to answer when documenting your mover:

-   General description of what the mover does
-   Example: This is meant as an example of how to construct a Mover in RosettaScripts and how to describe all of the options that it takes. This outline was decided upon at Post-RosettaCon11-Minicon.
-   XML code example:

  ```
<MyMover 
    name="&string" 
    bool_option=(1 &bool) 
    int_option=(50 &int) 
    string_option=(&string) 
    real_option=(2.2 &Real) 
    scorefxn=(default_scorefxn &string) 
    task_operations=(&string,&string,&string)
/>
  ```
-   What the tags do:
  -   **bool\_option** describes how a boolean tag is made. Default is true.
  -   **int\_option** describes how an integer tag is made. Let's say this represents \# of cycles of a loop to run, so the range would have to be \> 0.
  -   **real\_option** describes how to a Real option tag is made.
  -   **string\_option** is an example of how a string tag is made.

-   What options must be provided?
    
    For example let's say that we need to pass a value to string\_option or the protocol will not not run, you would include something like this:

    -   string\_option="/path/to/some/file" needs to be defined to avoid mover exit.

    This requirement should also be reflected in `provide_xml_schema()`.

-   Expected input type:

    Does this mover expect a certain kind of pose (protein/DNA, 2 chains, monomer)

-   Internal TaskOperations:
    
    Are there default TaskOperations (RestrictToInterface for example) that this mover uses, is there a way to override them?

-   FoldTree / Constraint changes

    Describe if/how the mover modifies the input (or default) FoldTree or Constraints

-   If the mover can change the length of the pose say so.

Your mover's documentation should be placed in `scripting_documentation/RosettaScripts/Movers/movers_pages` and linked from the main mover page [[here|Movers-RosettaScripts]]. See [[How to write documentation]] for more details.

### Getting Parameter data

The `parse_my_tag()` function can obtain parameters specified in the XML script using the provided TagCOP object (which we'll assume is called `tag`). Two functions are particularly useful:

-   `tag->hasOption( "name" );`

    Return true if the XML file contains the "name=value" option.

-   `tag->getOption<type>( "name", default );`

    Return the value in the "name=value" option, and attempt to cast it to the given type.  If the option isn't present, return the default instead.  To make this more concrete, consider the following tag:
    
    ```xml
    <MyMover cycles=0/>
    ```

    For this tag:

    - `tag->getOption<int>( "cycles" )` returns `0`
    - `tag->getOption<std::string>( "cycles" )` returns `"0"`
    - `tag->getOption<core::Real>( "temp", 1.0 )` returns `1.0`

#### Score Functions

Obtaining the scorefunction is of particular note. The name specified for a score function parameter can be obtained via:

-   `tag->getOption<std::string>( "scorefxn", "score12" );`

Reference to the score function object itself can then obtained through the DataMap:

-   `data.get< ScoreFunction * >( "scorefxns", scorefxn_name_string );`

Alternatively, one can use the `parse_score_function()` convenience function in `protocols/RosettaScripts/util.hh`.

#### Task Objects

If your mover takes as input a packer task, you likely want to observe the directives in the \<TASKOPERATIONS\> section of the XML file. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]].)

A `parse_task_operations()` convenience function is provided for this purpose in `protocols/RosettaScripts/util.hh`. It parses the TagCOP and DataMap appropriately, and returns an owning pointer to an appropriately constructed TaskFactory object.

### Registering Movers with the Parser

Finally, you need to inform the Rosetta Scripts machinery about the existence of your Mover by creating corresponding MoverCreator and MoverRegistrator classes.  Both these tasks pretty much just require filling in some boiler-plate.

The MoverCreator class defines three methods:

-   `virtual moves::MoverOP create_mover() const;`

    Return a pointer to a new instance of the corresponding Mover.

-   `static std::string mover_name();`

    Return the unique string which will identify the mover in the XML file.

-   `virtual std::string keyname() const;`

    Calls and passes through the return value of mover\_name().

The MoverCreator usually has it's own `*.hh` file, but shares a `*.cc` file with its mover.  The easiest way to write this code is to copy it from another mover in the same namespace as yours and to change the names as appropriate.

Once you have a MoverCreator, you need to include it in `src/protocols/init/init.MoverCreators.ihh`.  Just copy one of the existing lines and correct the name.  Then create a MoverRegistrator from your MoverCreator in `src/protocols/init/init.MoverRegistrators.ihh`.  Again, you can just copy one of the existing lines and correct the names.  Note that references to the mover itself or the mover's header file should not be present these `*.ihh` files - only the lightweight MoverCreator (and corresponding minimal header file) should be referenced.

Filters
-------

Requirements are all the same as of Mover, with one exception that the Pose object passed to apply() is non-mutable. The method shall return true when the pose passes a filtering test, and false otherwise.

TaskOperations
--------------

[[TaskOperations|TaskOperations-RosettaScripts]] that are specified in utility::Tag scripts in order to be utilized by Movers require careful (but relatively simple) implementation of virtual functions, a Creator class, and load-time registration in an init.cc file.

As of trunk revisions r34048, r34052, and r34063, DockDesignParser no longer owns its own TaskOperationFactory. There is now a singleton factory that lives at core::pack::task::operation::TaskOperationFactory. Also, protocols no longer need to manually register TaskOperations with this factory. Instead, TaskOperations are registered with the factory at "init" time (core/init.cc,protocols/init.cc,devel/init.cc) via Creator and Registrator classes. Creators are helper classes that make the TaskOperationFactory aware of how to create different flavors of TaskOperations. This way the TaskOperationFactory can store very-low-weight Creator classes, and only makes specific actual TaskOperations upon demand. This saves time, memory, and I/O. See the core/pack/task/operation/ directory and protocols/init.cc for examples of how these classes are implemented and cooperate.

"protocols" TaskOperations live in src/protocols and should be registered in protocols/init.cc (not in core). Some very general classes may be placed in core/pack/task/operation/, but this should only be done if they are widely used and do not introduce significant new dependencies into the core::pack namespace. Also, do not directly register or include headers for derived classes in any Factory classes.

These same principle apply to ResFilter and ResLvlTaskOperation classes, which are implemented in the same way TaskOperations.

TaskOperations may implement their own parse\_tag method to parse user-defined options.

THIS PAGE UNDER CONSTRUCTION
----------------------------

and subject to significant change due to current refactoring

##See Also

* [[A note on parsing residue selections in movers and filters]]: Notes on making your mover/filter compatible with reference poses
* [[Development Documentation]]: The development documentation home page
* [[RosettaScripts]]: Wiki page for RosettaScripts, the Rosetta XML interface
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Writing an app]]: Instructions for writing C++ executables
* [[Using the ResourceManager|ResourceManager]]
