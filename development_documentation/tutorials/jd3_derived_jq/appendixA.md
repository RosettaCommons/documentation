#Appendix A: Let the user define their own score function in &lt;Common>

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 10: Outputting Results|outputting_results]]

[[Appendix B: Let the user define individual score functions in &lt;Job>|appendixB]]

[[_TOC_]]

##Plan

Perhaps we want the user to be able to define the name of the weights file
we use for our score function in the &lt;Common> block of the job definition file:

```xml
<JobDefinitionFile>
  <Common>
    <MyScoreFunction weights_file_name="ref2015.wts"/>
  </Common>

  <Job>
    ...
  </Job>
</JobDefinitionFile>
```

To do this, we need to declare this `MyScoreFunction` element in `append_common_tag_subelements()`
and parse it in `parse_job_definition_tags()`.

##Code Additions

###New includes

.hh file:
```c++
#include <utility/tag/XMLSchemaGeneration.fwd.hh>
#include <utility/tag/XMLSchemaValidation.fwd.hh>
#include <core/scoring/ScoreFunction.fwd.hh>
```

.cc file:
```c++
#include <utility/tag/XMLSchemaGeneration.hh>
#include <utility/tag/XMLSchemaValidation.hh>
#include <utility/tag/Tag.hh>
```

###Additions to Header File

`parse_job_definition_tags()` should already be in your .hh file from [[Step 2|creating_the_job_dag]],
so we just need to declare `append_common_tag_subelements()` in the `protected` section.

```c++
void
append_common_tag_subelements(
        utility::tag::XMLSchemaDefinition & xsd,
        utility::tag::XMLSchemaComplexTypeGenerator & ct_gen
) const override ;
```

We also want to add this static function for XML reasons:

```c++
static std::string common_subelement_mangler( std::string const & name ){
        return "common_tutorial_job_queen_" + name + "_complex_type";
}
```

Let' also add a new private data member to hold the score function
```c++
core::scoring::ScoreFunctionOP sfxn_;
```

###Small additions to .cc file

We want to initialize the new `ScoreFunctionOP` to 0:

```c++
//Constructor
TutorialQueen::TutorialQueen() :
        StandardJobQueen(),
        num_input_structs_( 0 ),
        node_managers_( 0 ),
        job_genealogist_( 0 ),
        sfxn_( 0 )
{}
```

We also want to edit `complete_larval_job_maturation()` so that we use the new score function:

```c++
moves::MoverOP mover = 0;
runtime_assert( sfxn_ );
core::scoring::ScoreFunctionOP sfxn = sfxn_;
core::pose::PoseOP pose = 0;
```

###append_common_tag_subelements()

```c++
void
TutorialQueen::append_common_tag_subelements(
        utility::tag::XMLSchemaDefinition & xsd,
        utility::tag::XMLSchemaComplexTypeGenerator & ct_gen
) const {

        using namespace utility::tag;

        XMLSchemaAttribute weight( "weights_file_name", XMLSchemaType ( xs_string ),
                "Weights file name (please include .wts at the end)" );
        weight.is_required( true );

        XMLSchemaComplexTypeGenerator sfxn_ct_gen;
        sfxn_ct_gen
                .element_name( "MyScoreFunction" )
                .description( "Defines the weights file to be used for this protocol" )
                .add_attribute( weight )
                .complex_type_naming_func( & common_subelement_mangler )
                .write_complex_type_to_schema( xsd );

        XMLSchemaSimpleSubelementList sfxn_list;
        sfxn_list.add_already_defined_subelement( "MyScoreFunction", & common_subelement_mangler );
        ct_gen.add_ordered_subelement_set_as_required( sfxn_list );

}
```

###parse_job_definition_tags()

```c++
void
TutorialQueen::parse_job_definition_tags(
        utility::tag::TagCOP common_block_tags,
        utility::vector1< standard::PreliminaryLarvalJob > const & prelim_larval_jobs
){
        num_input_structs_ = prelim_larval_jobs.size();

        utility::vector0< utility::tag::TagCOP > const & subtags = common_block_tags->getTags();
        runtime_assert( subtags.size() == 1 );
        utility::tag::TagCOP my_score_function_tag = subtags[ 0 ];
        runtime_assert( my_score_function_tag->getName() == "MyScoreFunction" );

        std::string const weights_file_name = my_score_function_tag->getOption< std::string >( "weights_file_name" );
        sfxn_ = core::scoring::ScoreFunctionFactory::create_score_function( weights_file_name );
        runtime_assert( sfxn_ );
}        
```

##Up-To-Date Code

###TutorialQueen.hh

###TutorialQueen.cc


##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms