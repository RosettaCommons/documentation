#RosettaScripts Developer Guide

[[Return to RosettaScripts|RosettaScripts]]

*This page was modified in the Minicon 11 Wiki Update, but we didn't quite finish it for reasons of lack of time or knowledge. If you can finish it, please do!*

 Using RosettaScripts in its most basic sense involves organizing a workflow of [[Mover|Movers-RosettaScripts]] classes that are defined and parameterized in an XML-like scripting language that is read and processed into an arbitrary minirosetta protocol at runtime. The use of Filter classes is also used to further control protocol flow.

DataMap
-------

The DataMap is an internal structure for holding pointers to objects of arbitrary type. Each Mover's parse\_my\_tag() method has const access to the DataMap, and can recover pointers from it. This can be useful for communication between movers. For example, both the LoopFinder and KinematicLoop movers can get a common LoopsOP during parsing. At apply time the LoopFinder can fill the LoopsOP with loops, and KinematicLoop can subsequently read from it.

Movers
------

### Mover Requirements

In order to be supported under the Parser scheme, a Mover class (any class that derives from the Mover base class) must implement some additional methods. (These are virtual methods of the Mover base class that to be overwritten in the derived class.)

-   void parse\_my\_tag ( utility::tag::TagPtr const, protocols::moves::DataMap &, protocols::filters::Filters\_map const &, protocols::moves::Movers\_map const &, core::pose::Pose const & );
-   MoverOP fresh\_instance( ) const;
-   MoverOP clone( ) const;

Note that the function signatures for parse\_my\_tag and the other functions should match the ones from the Mover base class exactly (including const status), otherwise the derived method will not be called.

Documenting your mover

Since RosettaScripts allows you to put Movers together in ways that have not been tried before there are a few things you **NEED** to answer when documenting your mover:

-   General description of what the mover does
-   Example: This is meant as an example of how to construct a Mover in RosettaScripts and how to describe all of the options that it takes. This outline was decided upon at Post-RosettaCon11-Minicon.
-   XML code example:

```
<MyMover name="&string" bool_option=(1 &bool) int_option=(50 &int) string_option=(&string) real_option=(2.2 &Real) scorefxn=(default_scorefxn &string) task_operations=(&string,&string,&string)/>)
```

-   What the tags do:
-   **bool\_option** describes how a boolean tag is made. Default is true.
-   **int\_option** describes how an integer tag is made. Let's say this represents \# of cycles of a loop to run, so the range would have to be \> 0.
-   **real\_option** describes how to a Real option tag is made.
-   **string\_option** is an example of how a string tag is made.
-   What options must be provided?
-   For example let's say that we need to pass a value to string\_option or the protocol will not not run, you would include something like this:
-   string\_option="/path/to/some/file" needs to be defined to avoid mover exit.
-   Expected input type:
-   Does this mover expect a certain kind of pose (protein/DNA, 2 chains, monomer)
-   Internal TaskOperations:
-   Are there default TaskOperations (RestrictToInterface for example) that this mover uses, is there a way to override them?
-   FoldTree / Constraint changes:
-   Describe if/how the mover modifies the input (or default) FoldTree or Constraints
-   If the mover can change the length of the pose say so.

Your mover's documentation should be placed in `scripting_documentation/RosettaScripts/Movers/movers_pages` and linked from the main mover page [[here|Movers-RosettaScripts]]. See [[How to write documentation]] for more details.

### Getting Parameter data

The parse\_my\_tag function can obtain passed parameters through the passed TagPtr object. Two functions are relevant:

-   bool TagPtr-\>hasOption( "name" ); - Return true if the XML file contains the "name=value" parameter set
-   TagPtr-\>getOption\<type\>( "name", default ); - Returns, the value in the "name=value" parameter as the given type.

#### Score Functions

Obtaining the scorefunction is of particular note. The name specified for a score function parameter can be obtained via:

-   TagPtr-\>getOption\<std::string\>( "scorefxn", "score12" ); or similar

Reference to the score function object itself can then obtained through the DataMap:

-   data.get\< ScoreFunction \* \>( "scorefxns", scorefxn\_name\_string );

Alternatively, one can use the parse\_score\_function() convenience function in protocols/RosettaScripts/util.hh

#### Task Objects

If your mover takes as input a packer task, you likely want to observe the directives in the \<TASKOPERATIONS\> section of the XML file. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]].)

A parse\_task\_operations() convenience function is provided for this purpose in protocols/RosettaScripts/util.hh. It parses the Tag pointer and Datamap appropriately, and returns an owning pointer to an appropriately constructed TaskFactory object.

### Registering Movers with the Parser

Previously, movers needed to pass a unique name string to its parent's constructor in order to get correctly registered with the mover constructing machinery. This is no longer necessary.

The current registration is thorough MoverCreators, subclasses of protocols::moves::MoverCreator with three member functions (MoverCreators should be defined in a separate header file, but implementation of these functions is usually placed in the same .cc file as the mover):

-   virtual moves::MoverOP create\_mover() const;
-   virtual std::string keyname() const;
-   static std::string mover\_name();

An existing MoverCreator (such as GenericMonteCarloMoverCreator) can be used as reference, but briefly, create\_mover() returns a pointer to a new instance of the corresponding Mover, mover\_name() should returns the unique string which identifies the mover in the XML file, and keyname() calls and passes through the return value of mover\_name().

Finally, src/protocols/init.cc (or equivalent, if the mover is not under src/protocols) should be edited to add the new MoverCreator to the list of other MoverCreators. References to the Mover itself or the Mover's header file should not be present in init.cc - only the lightweight MoverCreator (and corresponding minimal header file) should be referenced.

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
