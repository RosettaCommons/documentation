#core::fragment::picking\_old User's Guide.

Metadata
========

This document was last edited 20090331. The original author was Yih-En Andrew Ban.

Introduction
============

`       core::fragment::picking      ` was conceived as both a set of routines for picking fragments from the Vall fragment library within Rosetta, as well as a framework for writing new fragment pickers. Please note that the design is somewhat under flux and it's likely the API will change as the Rosetta community continues to evolve the code.

This document is roughly organized in reverse order from concrete to abstract, e.g. common user tasks involving the Vall picker within `       core::fragment::picking::vall      ` will be described first, and the abstract concepts within `       core::fragment::picking::concepts      ` used to implement a picker will be described last. Please note that unless indicated, most of the code in this document is to demonstrate the available interfaces and method calls and may lack some of the additional structure necessary to actually compile and perform a valid function. This means that directly copying and pasting the code snippets will likely not work.

Picking fragments from the Vall.
================================

A VallLibrary object stores the Vall data, and the default instance is accessed by a call to the `       get_Vall      ` method of FragmentLibraryManager. This will read the Vall file contained in the Rosetta database directory specifiable by the command line option "-in:file:vall". As of 20090323, the default file is "filtered.vall.dat.2006-05-05".

The set of classes used to actually pick the fragments revolves around the VallLibrarian. This class runs through the data in VallLibrary, uses a collection of VallFragmentGen to define the length and type of fragments, and then scores those fragments using a collection of VallFragmentEval. The following annotated snippet of code from core/fragment/picking/vall/util.cc illustrates this breakdown:

```
// pick fragments from the Vall by a given secondary structure string
core::fragment::FragDataList
pick_fragments_by_ss(
  std::string const ss, // secondary structure string composed of 'H', 'E', 'L', or 'D'
  core::Size const top_n // return the top 'n' fragments
)
{
  using eval::IdentityEval;
  using gen::LengthGen;

  // get the default Vall data
  VallLibrary const & library = FragmentLibraryManager::get_instance()->get_Vall();

  // the librarian used to evaluate all fragments in VallLibrary
  VallLibrarian librarian;

  // Use default fragment extent generator that creates a continuous
  // fragment of the length of the secondary structure string, e.g. 9-mer.
  // Multiple fragment extent generators may be added.
  librarian.add_fragment_gen( new LengthGen( ss.length() ) );

  // Use a fragment evaluator class called IdentityEval that scores
  // a fragment by it's secondary structure and/or amino acid string.
  // Multiple evaluator classes may be added; the scores will be
  // accumulated into a single score value.
  librarian.add_fragment_eval( new IdentityEval( ss, 1.0, true ) );

  // score all fragments in the library and store in a sorted list
  librarian.catalog( library );

  // return the top 'n' scoring fragments in a FragDataList
  return librarian.top_fragments( top_n );
}
```

Fragment generation.
====================

The `       VallLibrarian      ` uses classes derived from `       VallFragmentGen      ` to generate fragment extents to be evaluated. The basic operation is to pass a `       VallFragmentGen      ` two `       VallResidueIterator      ` , one that points to where the fragment should start and one that points just past the last possible position of the fragment (i.e. the last position in a `       VallSection      ` ). The basic sketch of a class deriving from `       VallFragmentGen      ` is as follows:

```
class MyGen : public VallFragmentGen {

public: // following methods are required

  virtual
  VallFragmentGenOP clone() const;

  // Extent is typedef'd within VallFragmentGen.
  // In this method, implementer must make sure to set the boolean
  // public member data Extent::valid.  If valid is 'true', then
  // the Librarian will pass the fragment to its evaluators.  If
  // 'false' the fragment will be skipped.
  virtual
  Extent operator()( VallResidueIterator extent_begin, VallResidueIterator section_end ) const;

};
```

`       operator()      ` is used to generate the fragment extent and returns a new `       Extent      ` describing the start and stop of the fragment. An `       Extent      ` is a plain data struct with one convenience function, `       distance()      ` , to compute the length of the fragment. The public member data of an `       Extent      ` is as follows:

```
struct Extent {

public: // member data

  // points to the beginning of the fragment
  VallResidueIterator begin;

  // points just past the end of the fragment.
  VallResidueIterator end;

  // If this is 'true', Librarian will pass this fragment extent
  // to be evaluated using its collection of VallFragmentEval.
  // If 'false', Librarian will skip it.
  bool valid;

};
```

Available fragment generators.
------------------------------

As of 20090331, the list of available fragment generators in `       core::fragment::picking::vall::gen      ` is:

- **LengthGen**
   * Generate fragment of a particular length.

- **SecStructGen**
    * Generate fragment of a particular length and required secondary structure.

Fragment evaluation.
====================

Fragment evaluation is performed via classes derived from `       VallFragmentEval      ` . An `       Extent      ` is passed in and evaluated, and the scores are accumulated in a `       VallFragmentScore      ` object. The methods for properly deriving from VallFragmentEval are as follows:

```
// sample fragment evaluator
class MyEval : public VallFragmentEval {

public: // the following are required

  virtual
  VallFragmentEvalOP clone() const;

  virtual
  bool eval_impl( Extent const & extent, VallFragmentScore & fs ) {
    // accumulate the score, e.g.
    fs.score += the_score;
  }

public: // the following are optional

  virtual
  void pre_catalog_op( VallLibrary const & );

  virtual
  void post_catalog_op( VallLibrary const & );

};
```

The work of evaluating the fragment defined by the `       Extent      ` goes in the `       eval_impl      ` method. `       eval_impl      ` only needs to evaluate the fragment and nothing else, operations such as storing the necessary Extent data are automatically taken care of by the base class. Two optional methods are defineable, `       pre_catalog_op      ` and `       post_catalog_op      ` , that will be called by the VallLibrarian during `       VallLibrarian::catalog      ` . These are run before and after the actual scoring, respectively. They exist so that the fragment evaluator may, for example, print a status message or gather statistics over the VallLibrary before scoring.

The `       VallFragmentScore      ` struct accumulates the score within a single value and also has a convenience function, `       distance      ` , that returns the length of the fragment. The public member data is as follows:

```
struct VallFragmentScore {

public: // member data

  // NOTICE: The proper values for these two iterators are already
  // stored by the base class VallFragmentEval, DO NOT set them
  // inside the 'eval_impl' method when deriving from VallFragmentEval.
  VallResidueConstIterator extent_begin;
  VallResidueConstIterator extent_end;

  // The cumulative score.  Add to this number inside
  // 'eval_impl()' of your evaluator.
  Real score;

};
```

Available fragment evaluators.
------------------------------

As of 20090331, the list of available fragment evaluators in `       core::fragment::picking::vall::eval      ` is:

- **IdentityEval**   
    * Comparison against secondary structure and/or amino acid string.

- **EnergyEval**
    * Inserts the fragment into a Pose and evaluates a given ScoreFunction. Useful for evaluating chainbreak, constraints, etc.

The layout of VallLibrary.
==========================

From lowest to highest level:

-   VallResidue stores the data for a single residue corresponding to a single line in the Vall database file
-   a collection of VallResidue makes up a VallSection
-   a collection of VallSection makes up a VallLibrary

All publically accessible iterators returned by data structures within the VallLibrary satisfy the RandomAccessIterator concept. A single VallResidue stored in VallLibrary can be directly accessed by a combination of two indices, the position of it's VallSection in the library and the 1-based index of the position of the residue within that section:

```
// assuming: VallLibrary library;
// 1-based indexing for both indices

// access into the library
VallResidue const & residue = library[ section_index ][ position_index ];

// retrieving indices
residue.section_index();
residue.position_index();
```

Accessing the scores, position indices, and length of a fragment after VallLibrarian::catalog().
------------------------------------------------------------------------------------------------

After scoring the fragments in the Vall, it may be desirable to access the score objects so that, for example, the information about the fragments may be saved to file. The access interface is as follows:

```
// assuming: VallLibrary library;
//           VallLibrarian librarian;
using VallLibrarian::Scores;

librarian.catalog( library );

// grab reference to the scores
Scores const & scores = librarian.scores();

// run through scores
for ( Scores::const_iterator s = scores.begin(), se = scores.end(); s != se; ++s ) {
  // It is therefore possible to get the indices of the
  // VallResidues, e.g.:

  // index of the first residue's section within the library
  s->extent_begin->section_index();

  // index of the first residue within its section
  s->extent_begin->position_index();
}
```

Implementing a new fragment picker.
===================================

Fragment picking is abstracted into a set of concepts defined within `       core::fragment::picking::concepts      ` . A Library is organized as follows:

1.  Library is composed of Books
2.  a Book is composed of Pages

Using the implementation of VallLibrary inside `       core::fragment::picking::vall      ` as a concrete example:

1.  VallLibrary (Library) is composed VallSections (Books)
2.  a VallSection (Book) is composed of VallResidues (Pages)

Classes in `       concepts      ` demonstrate and define the interface for a class satisfying said concepts. Some classes are useable within a concrete implementation and others are not; this is marked appropriately at the top of each class. For convenience, we also provide the listing here. Classes useable within a concrete implementation are:

-   Book
-   Extent
-   Library

Demonstration classes not useable within a concrete implementation are:

-   Bookmark
-   ExtentEvaluator
-   ExtentGenerator

A Librarian runs through the Pages of Library's Books and operates as follows:

1.  generate an Extent of pages using ExtentGenerator
2.  evaluate the Extent using ExtentEvaluator
3.  file a Bookmark storing the results of the evaluation

The Librarian class within `       concepts      ` provides a concrete implementation of these operations, and should be used as the base class to implement new Librarians. Using the implementation of VallLibrarian inside `       core::fragment::picking::vall      ` as a concrete example:

1.  generate a fragment Extent (an extent of VallResidues) using VallFragmentGen (ExtentGenerator)
2.  evaluate the fragment using VallFragmentEval (ExtentEvaluator)
3.  file a VallFragmentScore (Bookmark) storing the results of the evaluation

To be continued...

## See Also

* [[New fragment picker | app-fragment-picker]]: the new fragment picker.
* [[fragment-file]]: fragment files
* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.