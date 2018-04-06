#Coding Conventions and Examples

Rosetta 3 (formerly MiniRosetta) is an object-oriented implementation of Rosetta that has been rewritten in C++ from the ground up by a core team of developers. These guidelines are intended to help new (andeveld to remind old/current) Rosetta developers to learn, maintain, and improve the reliability, clarity, and performance of the code while we continue its development and modernization. 


##Conventions
###Copyright Header
The Rosetta Commons copyright header is required for every source code *file* in Rosetta. Do not make modifications. The header you should use for all C++ source files is:
```
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington UW CoMotion, email: license@uw.edu.
```

###Coding Guidelines
####General
* [[Namespaces (media wiki link)|https://wiki.rosettacommons.org/index.php/Namespace_example]] are used to wrap associated classes that make up a conceptual component. **Namespaces in Rosetta are expected to match the directory hierarchy** (*i.e.*, code in namespace `core::scoring` can be found in the directory `src/core/scoring` &mdash; `src` is not part of the namespace hierarchy,) and *vice versa*. (All code in `src/core/scoring/Blah.[cc,.hh,.fwd.hh]` must live inside namespace `core::scoring`).

* **Avoid raw pointers.**
  * Raw pointers tend to produce overly complex data ownership rules that, when not followed, lead to memory leaks or dangling references. Smart pointers instead ensure that objects delete themselves if and only if all other objects have stopped pointing to them. A smart pointer exists as two components: an object with a reference count, and a pointer that modifies this reference count each time it is modified. When a smart pointer is pointed at an object, it increments that object's reference count. When it is set to point away from that object later, it decrements the reference count. When an object's reference count reaches 0, it deletes itself.
  * The weakness of an owning-pointer scheme (in comparison to a garbage collection scheme like Java's) is that circular references can produce memory leaks. For example, if object A points to B and object B points to A &mdash; and nothing else points to either of them &mdash; then the two objects will not delete themselves, though they are no longer accessible to the rest of the program.
  * To overcome this problem, Rosetta 3 uses two kinds of smart pointer: [[owning pointers]] (a.k.a. "OP") or [[access pointers]] (a.k.a. "AP"). Owning pointers increment reference counts; access pointers do not. Owning pointer use should be restricted to pointing downward in an permanence hierarchy; access pointers should point upwards or sideways in that heirarchy. Consider two clases &mdash; class `Collection` and class `Object`, where a `Collection` points to many `Object`s and `Object`s point upward to the `Collection` in which they are contained. The `Collection` should hold [[owning pointers]] to `Object`s, and `Object`s should hold an access pointer to their `Collection`.
  * More information on how to using Owning Pointers correctly in Rosetta can be found here: [[How to use pointers correctly]]

* **Avoid [[C-style arrays (media wiki link) |https://wiki.rosettacommons.org/index.php/C-style_array_examples]].** Especially avoid writing to C-style `char` arrays with the `scanf` family of functions. This invariably introduces buffer overflow bugs that can hide unnoticed and are hard to track down. Instead, use `std::string` buffers and C++ stream i/o. `scanf` has also been found to be a security weakness (due to "stack smashing").

* **Use [[include guards (media wiki link) |https://wiki.rosettacommons.org/index.php/Include_guards_example]] in all header files.** The include variables defined should be named `INCLUDED_namespace(*_subnamespace)_filename(_FWD)_HH` for consistency, *e.g.*:
 ```#define INCLUDED_core_scoring_EnergyMap_HH```

* **Use [[assertions (media wiki link)|https://wiki.rosettacommons.org/index.php/Assertion_example]] to test for events that should not occur for any normal program inputs and operations**: function pre- and post-conditions, object invariants, divisions by zero, and so forth.
  * Similarly, use `PyAssert()`s to prevent PyRosetta from segment faulting.

* **Use `if` blocks to test for errors that could happen in normal program operation.** Errors should generate useful reports that include the values of relevant variables.

* **Fix everything that causes a legitimate compiler warning on any platform.**
** Click here to view a [[List of Common Warnings and How to Avoid Them|Common Errors]].

* **No code duplication.**
  * Do not rewrite protocols others have already written.
  * Do not define your own value for pi &mdash; use the one defined in the [[`numeric` library|namespace-numeric]].

* **If you declare a public function, you have to define it** (preferably in a `.cc` file).
** Undefined private member functions (*e.g.*, private constructor, copy constructor, *etc.*) are OK.

####Class Structures
* **Add three files for each class**:
  *  a `.cc` file,
  * a `.hh` file, and
  * a `.fwd.hh` file. (See [[File Inclusion|Coding-Conventions#File-Inclusion]] below for details about what to include in each file.)

#####Member data
* All persistent data must live as member data of a class.  **No global data.** (See [[Global Data in Rosetta]] ).

* All data must be private; **protected data is forbidden.**
  * If derived classes need to have read access to private data, compose accessor functions.
  * If derived classes need to have write access to private data, write mutators.

* **Make sure every piece of member data for a class is copied in its copy constructor and assignment operator (`operator=`).**

* If you add data to a class, and that class has user-defined copy constructors or assignment operators, **be sure your new data is copied** inside of those methods.

#####Member functions
* **Member functions should be "const correct"** (See [[`constant`|Coding-Conventions#const]] below). If they do not change their object, they should be declared const; if they do, leave off the `const` at the end of the function to implicitly declare them non-const.

* **Any base class with virtual functions must have a virtual destructor.**

* **Any derived class that overrides a virtual function from a base class must use the C++11 `override` identifier** to allow the compiler to catch unintended differences between the base class function signature and the derived class function signature.  Less important: the community stylistic convention is to omit the `virtual` identifier in the derived class function override when the `override` identifier is used.  The most important thing is to use the `override` keyword, though -- this is functional, not merely stylistic. (_New as of 6 April 2018_.  For more on what `override` does and why it's useful, see <a href="https://blog.smartbear.com/development/use-c11-inheritance-control-keywords-to-prevent-inconsistencies-in-class-hierarchies/">this blog post</a>.)

* **Pass objects into methods by reference and not by value** &mdash; except when the intent is to make a copy of the object. If the object does not change, pass it as a const reference. Passing objects by value also requires additional, unwanted `#includes` in header files (See [[File Inclusion|Coding-Conventions#file-inclusion]] below).

* **Pass primitive data types by value and not by reference when they are strictly input parameters.** Pass by non-const reference if the methods are intended to change the values held in the input parameters. (*E.g.*, `void max( int first, int second, int & answer );`). Passing primitives by reference is slower than passing by value.

* Check that polymorphic methods are correctly overridden in derived classes. **Function signatures for polymorphic methods must match exactly.**

* If a class includes owning pointers to other objects, **explicitly define the destructor, copy-constructor, and assignment operator** (`operator=`) in the `.cc` file. (See the [[FAQ]] for more details.) Don't let the compiler do it for you. If you create any constructor, it prevents the default constructor from being synthesized. Class designers should always say exactly what the class should do and keep the class entirely under control. If you do don't want a copy-constructor or `operator=`, declare them as private.

* **Watch for long member function definitions.** Complicated functions with too many lines are difficult and expensive to maintain &mdash; and they are difficult to expand upon. Break up long member functions into several smaller member functions.

* **Watch for long argument lists.** Function calls then become difficult to write, read, and maintain. Instead, try to move the member function to a class where it is more appropriate and/or pass objects in as arguments &mdash; *e.g.*, if a function needs to know several things about a rotamer, (its chi angles, the way those chi angles were produced, the amino acid type, the chi bins, *etc.*,) wrap all of those individual pieces of data into a `Rotamer` object. Then a single parameter (a `Rotamer const &` perhaps) may be passed to the function instead of many.

#####Inheritance
* **Define OP typedefs for classes in their corresponding `.fwd.hh` files. (See explanation about owning pointers in [[#General.|Coding-Conventions#General]] above.) **Note**: It is no longer necessary for classes to be derived from ReferenceCount. See [[How to use pointers correctly]] for information on the new pointer system.
** Dynamically allocated objects must be put into owning pointers at the time of their allocation.

* **Avoid multiple inheritance.**

* **Don't use protected inheritance.** Private inheritance can be a useful alternative to containment, but we generally prefer containment.

####File Inclusion
Why does file inclusion matter? Compilation speed &mdash; and sometimes, the ability to compile at all! Reckless #inclusion produces long build times when compiling from scratch and long re-build times after making modifications. The majority of development is thus spent compiling and recompiling; you waste your time and the valuable time of your colleagues with bad #inclusion practices.(Consider that Rosetta++, because of its circular `#include`s, could not be compiled on any BlueGene machines without a special modification to the BlueGene compiler.)
* PREFACE: Class forward declarations belong in .fwd.hh files.
  * A forward declaration of a class 
  `class MyClass;`
  Within the .fwd.hh file, forward declare the class(es) and, if they derive from utility::pointer::ReferenceCount, typedef the owning pointers and const-owning pointers with OP and COP suffixes:
<pre>
namespace core{
namespace scoring {
class MyClass;
typedef utility::pointer::owning_ptr< MyClass > MyClassOP;
typedef utility::pointer::owning_ptr< MyClass const > MyClassCOP;
}
}
</pre>

* PREFACE: Class declarations belong in .hh files
  * Here, a class is declared and a member function is declared, but not defined. 
<pre>class MyClass { 
public: 
    void set_int( int input_int ); 
private: 
    int my_int_; 
};</pre>
* PREFACE: Class member function definitions belong in .cc files – except those methods inlined for speed.  When in doubt, put function definitions in .cc files.
  * Here, a member function is defined
<pre>
void MyClass::set_int( int input_int ) { 
    my_int_ = input_int; 
}</pre>
  * Acceptable member function definitions for .hh files:
    * non-virtual accessors (getters) that return primitive data types (e.g. Size, Real)
    * non-virtual mutators (setters) that modify primitive data types
    * non-virtual accessors that return references to data members held in smart pointers -- methods that get or set a smart pointer must be defined in the .cc file
* Files are to be #included with full paths using angle brackets (<, >) and not with quotes.  Scons will add -Idirectory flags to the compiler command line.
* If a function takes as input a reference or a constant reference to class X, then the declaration file should #include <X.fwd.hh> and should not #include <X.hh>
* Avoid #include of .hh files in other .hh files.
  * If you are only using an OP or a COP, only include the fwd.hh header
  * Exception: if  classY derives from class X, then Y.hh must #include <X.hh>
  * Exception: if class Y contains class X, then Y.hh must #include <X.hh>
    * It is prefereable that class Y contain an owning pointer to X (an XOP) instead of an X.  If containment is handled through owning pointers, then Y can get away with #include'ing X.fwd.hh
* No cyclic #inclusion amongst libraries.  We maintain a directed-acyclic graph (DAG) structure.  See [[below|Coding-Conventions#Library Dependencies]].  
* STL containers (std::list, std::map, std::string, etc.) cannot be portably forward declared but including <set> and <map> can greatly slow down build times. Using a wrapper class that accesses the std::set or std::map through a pointer can insulate your code from those headers: contact a support person for help on this.
  * STL did provide one very useful forward declaration file: iosfwd.  If your class has io functionality, then in your class' .hh file, you can #include <iosfwd> instead of #including <iostream>. For example, the following class could use iosfwd:
<pre> YourClass const & operator << ( std::iostream &, YourClass const & ) )</pre>

##### \#include Organization 
Your \#includes should not appear in random order, or alphabetical order, or the order you decided you needed them for the file.  Ideally, they should be organized.  This organization applies to headers in .cc or .hh files, although in .hh files you should have .fwd.hh inclusions, not .hh inclusions.  Count on approximately 5 groupings:
* "// Unit Headers" - These are headers which declare the things this file defines.  In other words, A.cc includes A.hh here.  
* "// Package Headers" - These are closely related headers, within a subdirectory of core at least.  For example, a packer-related header might have the PackerTask here.  
* "// Project Headers" - This is where loose headers from all over the core project go (scorefunction, packer, pose, whatever).  
* "// Utility Headers" - Put things from the utility library here, as well as tracers and the option system.  
* "// Numeric Headers" and "// ObjexxFCL Headers"- Things from the eponymous libraries; sometimes combined with Utility Headers.
* "// C++ headers" - things from the C++ standard library like <string> or <map>

#####Library Dependencies 
Cyclic inclusion complicates the code and build system and slows compiling.  The code is separated into discrete libraries, which compile independently (and more quickly than they would otherwise).  Code in any given library may only #include headers from the same library, or a lower-level library.  
[[flow-chart and overview of the different libraries | https://www.rosettacommons.org/docs/wiki/development_documentation/code_structure/src-index-page]] 

In order from lowest to highest, the libraries are (with examples of familiar code):
* Lowest-level: external libraries with little or no modification allowed (ObjexxFCL, zlib) (Boost, except being all headers it does not compile independently)
* Lower-level: utility (vector1, [[owning pointers]], [[options system|namespace-utility-options]], utility_exit())
* Low-level: [[numeric|namespace-numeric]] (random number generator, [[xyzVector]])
* Mid-level: core ([[scoring|namespace-core-scoring]], pose, packer) (this is where most of the things we think of as Rosetta functionality are)
* High-level: protocols ([[movers|Mover]], monte carlo, fully developed code)
* Higher-level: devel (high-level stuff under development, which will move to protocols as it matures; the use of this library for Rosetta development has been discontinued in favor of the GitHub Pull Request workflow)
* Highest-level: apps (all executables, thus not really library) (as an aside, applications not in apps/pilot should not inherit from devel)

####Naming 
* **`CamelCase` for class names**

* **`box_car` with underscores separating words for variable names**

* **`box_car` with underscores for namespaces & directories**

* **`box_car_` with underscores and one trailing underscore for class member variables**

* Class definition files must be named after their classes &mdash; *e.g.*, `class PackerTask` is forward declared in `PackerTask.fwd.hh`.



####Const 
*  When declaring variables to be const: first state the type of a variable, then state its const status. E.g. Size const my_constant( 4 );  There is a difference between a pointer to a constant (e.g. Size const *), a constant pointer (Size * const) and a constant pointer to a constant (Size const * const).  To distinguish these three, const must come after the type.
* Member functions that do not change the data inside a class should be declared const.  Accessors should be const so long as they do not return non-const references to the data they contain.
  * Remember, the function signature for a class member function depends on the const status of the object, and member functions may be overloaded based on a difference of const:
  * e.g. 
<pre>
class MyClass { 
    public: int my_int() 
        const { 
           return my_int_; 
        } 
        int & my_int { 
           return my_int_; 
        } 
    private my_int_ 
}; </pre>
An instance of this class may be passed to a function as a const & with the wonderful guarantee that its internal data will not be modified within that function.  The compiler will prevent calls to the non-const my_int() function!
* Data members that are updated in a lazy fashion (e.g. retrieving xyz coordinates from a Conformation causes a lazy refold() evaluation)  should be declared "mutable" so that they may be modified in const methods.
* Data members that do not change over the lifetime of a class should be declared const, and must be initialized in their constructors.

#### Precision and `typedef`s
* **Do not use raw literals for numeric values:** `0.0` *vs.* `Real( 0.0 )` 

* **Primitive variables should be declared using the `typedef`s defined in `core/types.hh`.**
  * Use the types `Real`, `Distance`, `DistanceSquared`, or `Size`, *etc.*
  * Do not use `double`, `float`, or `int`.
    * Exceptions can be made for `int` &mdash; but ask.
    * Do not use `float` &mdash; do not `typedef` to `float`. Double precision computations yield better minimizations.
      * Exceptions can be made for static data from large, low-precision databases (*e.g.* Dunbrack rotamer library), though high-precision computations from these low-precision objects must still be performed.

* **`typedef`s for owning pointers should be placed in the same namespace as the class the owning pointers are templating.**

* **`typedef`s for `typedef`s may be (publicly) declared inside class scope,** but should not be made outside of class scope.
** The following is OK:
<pre>
// This is OK
namespace protocols { 
namespace movers { 
class MyMover { 
public: 
    typedef scoring::ScoreFunctionOP ScoreFunctionOP; 
}; 

}
}</pre>
The following is NOT OK! It produces name ambiguity and compiler errors
<pre>
// This is NOT OK!
namespace protocols { 
namespace movers { 
typedef scoring::ScoreFunctionOP ScoreFunctionOP; 
class MyMover { 
   … 
}; 

}
}
</pre>

####Using
*  Do not make “using namespace X” declarations outside of class scope in header files
   * In particular, do not make "using namespace core" declarations in headers.  If this declaration comes before the inclusion of zstream headers (as it usually would), then a call to a zlib init function at src/utility/io/zipstream.hpp:332 instead tries to link against core::init, and compilation fails.  (This may work on compiler versions earlier than gcc 4.2, but it's still wrong!)
* “using namespace X” may be declared anywhere within a .cc file, though it is preferable to declare them within function bodies

####Casts
* Use static_casts for converting between numeric types (floats and doubles, floats and ints) instead of c-style casts.  Exceptions are currently made for int to Size casts where c-style casts are acceptable.
  * (float) 6.0 // C-style
  * float (6.0) // C-style #2
  * static_cast< Real > ( 6.0 ); // C++-style
  * static_cast< int > ( 6.5 ); // this will floor to the closest integer, and it's obvious
  * int( 6.5 ); // this is harder to find
* When downcasting (casting from a high-level class to one that inherits from that class), use a static_cast in the code, but make a dynamic cast within an assert statement.  
  * Dynamic casts are generally slow
  * Debug builds will test that the downcast succeeds.
  * e.g.
```
symm_something( core::Conformation const & conf ) 
{

   // first assert the dynamic cast
   assert( dynamic_cast< core::conformation::symmetry::SymmetricConformation const * >( &conf ) );

   core::conformation::symmetry::SymmetricConformation const & 
      symmcomf = static_cast< core::conformation::symmetry::SymmetricConformation const & >
      ( conf );
}
```
A convenience function that perform the dynamic_cast assertions is provided to simplify this task
```
utility::down_cast< Bar * >( foo ); // returns a pointer to a Bar instance
```
:* If you are down casting an access_ptr or an owning_ptr, you can use the following function, which is available if you've included the owning_ptr or access_ptr headers
```
utility::pointer::down_pointer_cast< Bar >( foo ); // returns a BarOP
```

#### C++11 Features
* Use of `auto` is strongly encouraged in `for` loops.
* Use of `auto` elsewhere is allowed, but it is strongly preferred that the type of the variable can be induced from code _within the same function_.

#### Thread Safety
* (See the discussion on global data [[ here |Global-Data-in-Rosetta]])
* Never use non-const static data in any method.  Constant static data is ok.  If you don’t know what static data is, don’t declare anything to be static.
* Our multi-threading model is:
  * no more than one thread per pose;
  * no more than one thread per ScoreFunction;
  * no more than one thread per EnergyMethod;
  * several threads for Potential classes (e.g. RamachandranPotential). 
* Classes that read database data should be shared between threads -- you only want one Dunbrack library in memory!  Classes that need to hold data about a particular Pose or a particular ScoreFunction in internal member data (as opposed to on the stack) should not be shared between threads (e.g. the EtableEnergy class holds the fa_atr, fa_rep, and fa_sol weights during batch rotamer-pair energy evaluations in the packer.)

####Creepy Language Features
* **Do not use goto ever.** C++ allows it, we do not.
* **Do not use macros** except for controlling compilation with #ifdefs
* **Do not use post-increment operators.**  i++ is a post increment operator for variable i.  ++i is a pre-increment operator.  If i = 5, then ++i would set i to 6 and return 6.  i++ would set i to 6 and return 5.  my_array[ ++i ] would return a different value than my_array[ i++ ]. To avoid confusion, do not use post-increment operators.  ++ operators mainly appear in for loops. In for loops, increment with ++loop_counter.

####Style
#####Semi-colons
* Do not add excess semi-colons.  Semi-colons are not needed after for-loops or function bodies.  Excess semi-colons following function bodies are flagged as errors by some compilers:
<pre>
for ( Size ii = 1; ii <= 10; ++ii ) {
    std::cout << ii << “ “;
}; // this semi-colon is unnecessary. 
class MyClass : public utility::pointer::ReferenceCount{
    MyClass : my_int_( 0 ) {}; // this semi-colon is unnecessary
    void my_function() {
        ++my_int;
    }; // this semi-colon is unnecessary. 
}; // This semi-colon is absolutely neccessary.
</pre>

* Label all virtual functions in derived classes as virtual, even though their virtual status is controlled by the base class declaration.

#####Spaces

* Add spaces to have a 'lighter' appearance of the code
  * add spaces after keywords
  * add spaces after punctuation (semicolon, comma)
  * add spaces before and after binary operators: (<<,>>,+,-,*,||,&&,==)
  * add spaces after paranthesis
Examples:
<pre>
for ( Size ii = 1; ii <= 10; ++ii ) {  // this is correct spacing
    std::cout << ii << “ “;
}
if ( i == 2 ) { // this is correct spacing 
}
std::cout << "this string" << " should be written to output" << std::endl; // this is correct spacing


// now examples with incorrect spacing
for( core::Size i=linker_start_; i<=linker_end_; ++i ) {//missing space after keyword
}
for(Size j=start;j<=end;++j) { //missing space after keyword, missing space after parenthesis, missing space after semicolon
}
if ( i==2 ) { // missing spaces around operator
}
std:cout<<"this string"<<" should be written to ouput"<<std::endl; // missing spaces around << 
</pre>

#####End-of-line Characters

* **Use only line feed characters** (Unix standard), not carriage return and line feed characters (DOS standard), **at the end of each line.** If you edit code on a Windows machine, be sure to set your editor  to the correct line ending format.

#####Indentation
* **Use tabs to indent on the beginning of a line,** not spaces.
  * (Python code should use spaces)

* Use spaces, not tabs, after the first non-whitespace character on a line.  Spaces may be used to align statements on successive lines. Do not try to line up the first non-whitespace character of one line with some non-whitespace character other than the first non-whitespace character on the line above by combining tabs and spaces.

* **Indent one additional tab per nested level.**

* **Indent one additional tab when function arguments must be wrapped beyond the first line.**

* **Indent two additional tabs when `for` loop declarations must be wrapped beyond the first line,** (*e.g.*, when iterator classes have long names).

* **Do not indent for namespace nesting.**

* **Do not indent for raw scoping.**

* **`public:` and `private:` labels inside classes should be indented to the same level as the class itself.**

#####Comparisons
* Many C++ compilers allow `and` and `or` written in English.  Some do not.  In C++, always use `&&` and `||`.

####Output
* Write output to Tracers.
* Name tracers according to namespace and class:
  * e.g. protocols.moves.MyMover

####Using command-line options
* Constructors are not allowed to access command-line options directly, and must call a member function to do so.
* Member functions may only access options if they also have the following properties:
  * Their name ends in "_options"
  * They do no use any non-public member variables/functions (NOTE TO SELF: ENFORCE THIS W/ SCRIPTS)
* Existing cases where non-member (i.e. ordinary) functions still access options are deprecated as it makes programatic control of the function behavior difficult, and are expected to disappear (wish written on September 2010).

####Others
* **Remove trailing whitespace from source before committing it.**

* **Remove unused variables and functions;** if functions are left for debugging purposes, comment about this.

* **Conditional checks should happen inside the called function rather than in the calling function** when possible. This helps keep things a bit more modular and also ensures that your function has no bad side effects if someone calls it but forgets to check for the essential condition. For example: 
Instead of
 `if ( condition_exists ) my_function();`
 use
`my_function();`
where `my_function` begins with
      `if ( !condition_exists ) return;`

* **Every new file should have the Emacs mode information, copyright information, and the Doxygen information &mdash; including file name and author name &mdash; at the top of it.** (You also can copy it from similar file.)

* Don't use the `<cstdio>` functions, such as `printf()`. **Learn to use "io streams"** instead; they are type-safe and type-extensible.

* **Don't use the form `MyType a = b;` to define an object.** This one feature is a major source of confusion because it calls a constructor instead of the `operator=`. For clarity, always be specific and use the form `MyType a(b);` instead.

####Supporting Windows Visual Studio
* do not use "read" as a function name.  The VS compiler does not like it.
* do not use "interface" as a variable name.  This is a keyword used by VS.

####Supporting BOINC + Paths
* use utility::io::izstream (instead of std::ifstream) and utility::io::ozstream (instead of std::ofstream) for reading and writing files.
* izstream is where -in:path option is used, so by loading files using izstream, everyone benefits from path control as well.

###Commenting Guideline
The comment blocks at the beginning of Rosetta functions have been  formatted to be compatible with the [[http://www.stack.nl/~dimitri/doxygen/Doxygen]] auto-documentation program.

#### Comment Format
* All functions should be at least documented with the `@brief` Doxygen command.
  * **Use `@brief` inside header files** (`.hh` files) where the function is declared.
  * **Use `@details` in implementation files** (`.cc` files) where the function is defined.
  * Example:
<pre>
 /// @brief finds the correct fold for every protein sequence
void fold_protein( std::string const & sequence );
</pre>

####General Note
* Doxygen reads in "///" comments. Currently, it is set up to ignore comments within the function bodies (regardless of how many slashes they begin with). Additionally, the entire comment block must have  at least 3 slashes, otherwise doxygen may skip part of the block.
* The doxygen commands begin with "@". It is important to leave a space between the command and the slashes (use "/// @brief" not "///@brief"
* Doxygen does not use the newlines from the source file. You need to add an explicit "\n" to get a  carriage return in the html.

####Commands Introduction
* **@brief**  Follow this with a short line or two about the function. Note: Only things up until the first empty "///" line or next "@" command will be placed after the function name at the top of the html page.
* **@param**  The function parameters can be specified as: @param, @param[in], @param[out], or @param[in,out]. Follow with the parameter name and a short description. Do not put a dash before the parameter name (it does not look as good).
* **@return** (if needed)
* **@remarks** Put more information here that does not seem to belong in the detailed section. Exactly what differentiates such things is left to the aesthetic tastes of the programmer.



####Doxygen Notes (See Doxygen Tips)
* Doxygen reads in [[configuration parameters|http://www.stack.nl/~dimitri/doxygen/config.html]] from a "Doxyfile". (Called Doxyfile in the Rosetta++ CVS).
* The index.html page is generated from comments in doxygen.h
* Graphs are generated with the dot program from the [[graphiz|http://www.graphviz.org/]] package. (The path of which is specified in the Doxyfile.) The line and box colors are described [[here|http://www.stack.nl/~dimitri/doxygen/diagrams.html]].

###Debugging Output Guidelines
* Use [[basic::Tracer|tracer]] for your main debug IO. Tracer output is buffered and because of that it is required to explicitly instruct Tracer object to flush output. To do that call Tracer::flush() member function or end your message with std::endl (it will call flush() function after new line symbols is send).
* Do not commit code containing direct output to std::cout and std::cerr in to libraries code base (core, protocols, devel). Unless you planing to terminate program abnormally (i.e:utility_exit(...)) because of the hard error. In that case you can use cerr output to provide additional information for your error messages.
* Name tracer channel according to your file path. For example file core/io/pdb/file_data.cc should have Tracer channel named as 'core.io.pdb.file_data'. It is possible that in some circumstances channel with different name can be used - ask.
* If you need to create tracer with custom channel names - just add it after namespaces.filename, for example:
` core.scoring.constraints.EnzConstraintIO.custom_fancy_name_for_channel `
*  Try to minimize amount of output produced with level core::util::t_info and above. By default output your messages with level t_debug or lower. Use higher levels only if you think that your message will be informative to the others.
* Avoid printing data to tracers in inner loops.  Even if the tracer is muted and the message is not sent to the screen, the creation and destruction of the strings which are sent to the tracer can slow down the code tremendously.
* To output message with pre-defined priority use Tracer object proxy data members: TR.Fatal, TR.Error, TR.Warning, TR.Info, TR.Debug, TR.Trace.
* It is advisable to keep keep name of the main file Tracer object similar to other main tracers in different files. Current recommended example is:
```
  /// Tracer instance for this file
  static basic::Tracer TR("core.io.pdb.file_data");
```
----

##Coding Templates
The following templates can assist in learning the coding conventions. They also will save you a lot of time. Please add your own Rosetta 3 coding-convention-compliant templates to list below, which is organized by IDE and file type.

###Eclipse
#### Headers (.hh) 
* [[Generic class forward header file template for Eclipse (media wiki)|https://wiki.rosettacommons.org/index.php/Generic_class_forward_header_file_template_for_Eclipse]]
* [[Generic class header file template for Eclipse (media wiki)|https://wiki.rosettacommons.org/index.php/Generic_class_header_file_template_for_Eclipse]]
* [[Mover class header file template for Eclipse (media wiki)|https://wiki.rosettacommons.org/index.php/Mover_class_header_file_template_for_Eclipse]]

####Source Files (.cc)
* [[Generic class source file template for Eclipse|https://wiki.rosettacommons.org/index.php/Generic_class_source_file_template_for_Eclipse]]
* [[Mover class source file template for Eclipse|https://wiki.rosettacommons.org/index.php/Mover_class_source_file_template_for_Eclipse]]
* [[Pilot application source file template for Eclipse|https://wiki.rosettacommons.org/index.php/Pilot_application_source_file_template_for_Eclipse]]

## [[Integration Test|integration-tests]] Guidelines
* run integration tests *before* commiting any code
* make sure that no unexpected changes result from your code
* break down large commits into smaller parts if possible 
if you have a large commit that also changes a number of integration tests
it is hard for others to see that the integration test changes are all expected and not 
pathological. Hence, it is good practice to break down such commits into parts. Ideally you can 
isolate the lines/files that cause integration test changes and commit them independently from the remaining code-changes that leave the integration tests invariant.

##Unit Test Guidelines
* Build and run unit test *before* committing any code.
* If your changes break tests - fix them after ensuring that results are correct. If you can't fix some of the test/not sure if results correct, contact developer (or mini list) responsible for this test and ask for help.

##Rosetta 3 Coding FAQ
* I'm getting really frustrated, because I updated my version of Rosetta, and now it won't compile my demo directory.
  1. For compiling codes in apps/pilot:
     1. Create directory src/apps/pilot/ekellogg/
     2. Copy your_demo_file.cc to this directory
     3. Assuming your code is in devel, add 'devel' and  'pilot_apps' to tools/build/user.settings
     4. Add 'devel' to src/pilot_src.settings
     5. Now try scons bin/your_demo_file
  2. For Compiling codes in demo: it's still possible to compile demo/ files, but it requires your changing a scons-related file.
     1. In Rosetta/tools/build, look for a user.settings file.
     2. If there is no user.settings file, copy the user.settings.template file and name it user.settings.
     3. Within the "appends" option, add "demo" as a directory to build. It should look like this:
```
  settings = {
     "user" : {
          "prepends" : {
          },
          "appends" : {
                  "projects" : { "src" : [ "devel", "demo"  ], },
          },
          "overrides" : {
          },
          "removes" : {
          },
       }
   }
```

##Useful links
To deal with the formatting problem we could use a code beautifiers like...

* [[Artistic Style|http://astyle.sourceforge.net/astyle.html]]
* [[Great Code|http://sourceforge.net/projects/gcgreatcode/]]
* [[Gnu Indent|http://www.gnu.org/software/indent/]]
* [[Uncrustify|http://uncrustify.sourceforge.net/]]

To Speed up code...
* [[Simple tips to optimize code|http://www.tantalon.com/pete/cppopt/asyougo.htm]](Ex: always pass string by reference)

##See Also

* [[Rosetta database conventions|Database-Conventions]]
* [[Python coding conventions for Rosetta]]
* the [[List of things you should check before committing your code|before-commit-check]]
* [[Rosetta overview]] to know about Rosetta 3
* [[Tutorials for developers|devel-tutorials]]
* [[List of Common Warnings and How to Avoid Them|Common-Errors]]
