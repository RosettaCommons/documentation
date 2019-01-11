#Appendix A: Let the user define their own score function in &lt;Common>

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 10: Outputting Results|outputting_results]]

[[Appendix B: Let the user define individual score functions in &lt;Job>|appendixB]]

[[_TOC_]]

##Reading

[[XML Job definition files|https://wiki.rosettacommons.org/index.php/JD3FAQ#XML_Job_definition_files]]

[[The job definition file structure|https://wiki.rosettacommons.org/index.php/JD3FAQ#StandardJobQueen:_The_job_definition_file.27s_structure]]

[[Defining an XML Schema for a job definition file|https://wiki.rosettacommons.org/index.php/JD3FAQ#StandardJobQueen:_Defining_an_XML_Schema_for_a_job_definition_file]]

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

Elements are added to the `XMLSchemaComplexTypeGenerator` in the form of a `XMLSchemaSimpleSubelementList`.
We only have one element that we want to add to this list: a complex type named "MyScoreFunction"
with an attribute named "weights_file_name" of string type.

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

```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.hh
/// @author Jack Maguire, jackmaguire1444@gmail.com


#ifndef INCLUDED_protocols_tutorial_TutorialQueen_HH
#define INCLUDED_protocols_tutorial_TutorialQueen_HH

#include <protocols/tutorial/TutorialQueen.fwd.hh>
#include <protocols/jd3/standard/StandardJobQueen.hh>
#include <protocols/jd3/JobDigraph.fwd.hh>
#include <protocols/jd3/dag_node_managers/NodeManager.fwd.hh>
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.fwd.hh>
#include <protocols/jd3/LarvalJob.hh>
#include <protocols/jd3/JobGenealogist.fwd.hh>
#include <protocols/jd3/pose_outputters/PoseOutputSpecification.hh>

#include <utility/tag/Tag.fwd.hh>
#include <utility/tag/XMLSchemaGeneration.fwd.hh>
#include <utility/tag/XMLSchemaValidation.fwd.hh>

#include <core/scoring/ScoreFunction.fwd.hh>

namespace protocols {
namespace tutorial {

class TutorialQueen: public jd3::standard::StandardJobQueen {

public:

        //constructor
        TutorialQueen();

        //destructor
        ~TutorialQueen() override;

        jd3::JobDigraphOP
        initial_job_dag()
        override;

        void
        parse_job_definition_tags(
                utility::tag::TagCOP common_block_tags,
                utility::vector1< jd3::standard::PreliminaryLarvalJob > const &
        ) override;

        std::list< jd3::LarvalJobOP > determine_job_list(
                Size job_dag_node_index,
                Size max_njobs
        ) override;

        void note_job_completed(
                core::Size,
                jd3::JobStatus,
                core::Size
        ) override {
                runtime_assert( false );
        }

        void note_job_completed(
                jd3::LarvalJobCOP job,
                jd3::JobStatus status,
                core::Size nresults
        ) override;

        void completed_job_summary(
                core::Size job_id,
                core::Size result_index,
                jd3::JobSummaryOP summary
        ) override;

        void completed_job_summary(
                jd3::LarvalJobCOP job,
                core::Size result_index,
                jd3::JobSummaryOP summary
        ) override {
                completed_job_summary( job->job_index(), result_index, summary );
        }

        std::list< jd3::JobResultID >
        job_results_that_should_be_discarded() override;

        std::list< jd3::output::OutputSpecificationOP > jobs_that_should_be_output() override;

protected:
        void init_node_managers();

        void count_num_jobs_for_nodes_1_and_2 (
                core::Size & num_jobs_for_node_1,
                core::Size & num_jobs_for_node_2
        );

        jd3::LarvalJobOP get_next_larval_job_for_node_1_or_2( core::Size node );

        jd3::LarvalJobOP get_next_larval_job_for_node_3();

        jd3::JobOP
        complete_larval_job_maturation(
                jd3::LarvalJobCOP larval_job,
                utility::options::OptionCollectionCOP job_options,
                utility::vector1< jd3::JobResultCOP > const & input_job_results
        ) override ;

        void
        append_common_tag_subelements(
                utility::tag::XMLSchemaDefinition & xsd,
                utility::tag::XMLSchemaComplexTypeGenerator & ct_gen
        ) const override ;

        static std::string common_subelement_mangler( std::string const & name ){
                return "common_tutorial_job_queen_" + name + "_complex_type";
        }

private:
        core::Size num_input_structs_;

        utility::vector1< jd3::dag_node_managers::SimpleNodeManagerOP > node_managers_;
        jd3::JobGenealogistOP job_genealogist_;

        std::map< jd3::JobResultID, jd3::output::OutputSpecificationOP > pose_output_specification_for_job_result_id_;

        core::scoring::ScoreFunctionOP sfxn_;
};

} //tutorial
} //protocols

#endif        
```

###TutorialQueen.cc

```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.cc
/// @author Jack Maguire, jackmaguire1444@gmail.com

#include <protocols/tutorial/TutorialQueen.hh>
#include <protocols/tutorial/TutorialJob.hh>

#include <protocols/jd3/JobDigraph.hh>
#include <protocols/jd3/dag_node_managers/NodeManager.hh>
#include <protocols/jd3/dag_node_managers/SimpleNodeManager.hh>
#include <protocols/jd3/LarvalJob.hh>
#include <protocols/jd3/JobGenealogist.hh>
#include <protocols/jd3/standard/StandardInnerLarvalJob.hh>
#include <protocols/jd3/standard/MoverAndPoseJob.hh>

#include <protocols/moves/Mover.hh>
#include <protocols/relax/FastRelax.hh>
#include <protocols/minimization_packing/MinPackMover.hh>
#include <protocols/minimization_packing/MinMover.hh>

#include <utility/pointer/memory.hh>
#include <utility/tag/XMLSchemaGeneration.hh>
#include <utility/tag/XMLSchemaValidation.hh>
#include <utility/tag/Tag.hh>

#include <basic/Tracer.hh>

#include <core/pose/Pose.hh>
#include <core/scoring/ScoreFunction.fwd.hh>
#include <core/scoring/ScoreFunctionFactory.hh>


static basic::Tracer TR( "protocols.tutorial.TutorialQueen" );

using namespace protocols::jd3;
using namespace protocols::jd3::standard;

namespace protocols {
namespace tutorial {

//Constructor
TutorialQueen::TutorialQueen() :
        StandardJobQueen(),
        num_input_structs_( 0 ),
        node_managers_( 0 ),
        job_genealogist_( 0 ),
        sfxn_( 0 )
{}

//Destructor
TutorialQueen::~TutorialQueen()
{}

JobDigraphOP
TutorialQueen::initial_job_dag() {
        //you need to call this for the standard job queen to initialize
        determine_preliminary_job_list();
        init_node_managers();

        job_genealogist_ = utility::pointer::make_shared< JobGenealogist >( 3, num_input_structs_ );

        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 );
        dag->add_edge( 2, 3 );
        return dag;
}

std::list< jd3::LarvalJobOP >
TutorialQueen::determine_job_list (
        core::Size job_dag_node_index,
        core::Size max_njobs
) {
        std::list< jd3::LarvalJobOP > job_list;

        for( core::Size ii = 1; ii <= max_njobs; ++ii ){
                jd3::LarvalJobOP next_job;
                if( job_dag_node_index == 3 ){
                        next_job = get_next_larval_job_for_node_3();
                } else {
                        next_job = get_next_larval_job_for_node_1_or_2( job_dag_node_index );
                }
                if( next_job == 0 ) {
                        return job_list;
                } else {
                        job_list.push_back( next_job );
                }
        }

        return job_list;
}


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

void
TutorialQueen::init_node_managers(){
        using namespace jd3::dag_node_managers;

        core::Size num_jobs_for_node1( 0 ), num_jobs_for_node2( 0 );
        count_num_jobs_for_nodes_1_and_2( num_jobs_for_node1, num_jobs_for_node2 );

        core::Size const num_results_to_keep_for_node1 = num_jobs_for_node1 / 2; //Let's keep half of the results
        SimpleNodeManagerOP node1 = utility::pointer::make_shared< SimpleNodeManager >(
                0, //Job offset
                num_jobs_for_node1,
                num_results_to_keep_for_node1
        );

        core::Size const num_results_to_keep_for_node2 = num_jobs_for_node2 / 3; //Let's keep half of the results
        SimpleNodeManagerOP node2 = utility::pointer::make_shared< SimpleNodeManager >(
                num_jobs_for_node1, //Job offset
                num_jobs_for_node2,
                num_results_to_keep_for_node2
        );

        core::Size const num_jobs_for_node3 = num_results_to_keep_for_node1 + num_results_to_keep_for_node2;
        core::Size const num_results_to_keep_for_node3 = num_jobs_for_node3; //Let's keep/dump all of the results
        SimpleNodeManagerOP node3 = utility::pointer::make_shared< SimpleNodeManager >(
                num_jobs_for_node1 + num_jobs_for_node2, //Job offset
                num_jobs_for_node3,
                num_results_to_keep_for_node3
        );

        node_managers_.reserve( 3 );
        node_managers_.push_back( node1 );
        node_managers_.push_back( node2 );
        node_managers_.push_back( node3 );
}

void
TutorialQueen::count_num_jobs_for_nodes_1_and_2(
        core::Size & num_jobs_for_node_1,
        core::Size & num_jobs_for_node_2
) {
        num_jobs_for_node_1 = 0;
        num_jobs_for_node_2 = 0;

        //vector has 1 element for each <Job> tag
        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();

        for( standard::PreliminaryLarvalJob const & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job.inner_job );
                num_jobs_for_node_1 += pose->chain_sequence( 1 ).length();
                num_jobs_for_node_2 += pose->chain_sequence( 2 ).length();
        }
}

jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_1_or_2( core::Size node ) {
        //This is written very ineffeciently, but it will do for the scope of the tutorial
        runtime_assert( node == 1 || node == 2 );

        if( node_managers_[ node ]->done_submitting() ) {
                return 0;
        }

        //each job has 2 indices:
        //a local one, which tracks its index within its dag node
        //a global one, which is unique accross the entire program
        core::Size const local_job_id = node_managers_[ node ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ node ]->job_offset() + local_job_id;
        core::Size counter = local_job_id;

        utility::vector1< standard::PreliminaryLarvalJob > const & all_preliminary_larval_jobs = preliminary_larval_jobs();
        core::Size pose_input_source_id = 0;

        //This part is not directly JD3-related, it's just a matter of finding the pose that we need for this specific job
        for( standard::PreliminaryLarvalJob const & pl_job : all_preliminary_larval_jobs ){
                core::pose::PoseOP pose = pose_for_inner_job( pl_job.inner_job );
                ++pose_input_source_id;

                core::Size const nres_in_chain = pose->chain_sequence( node ).length();
                if( nres_in_chain > counter ){
                        counter -= nres_in_chain;
                } else {
                        break;
                }
        }
        debug_assert( pose_input_source_id <= all_preliminary_larval_jobs.size() );

        //These can be recycled between larval jobs
        //So in reality, you will probably choose to store this somewhere and use it again the next time this method is called
        //(you will have to change the arguments accordingly)
        //jd3::InnerLarvalJobOP inner_ljob =
        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob, 1, global_job_id );

        job_genealogist_->register_new_job (
                node,
                global_job_id,
                pose_input_source_id
        );

        return ljob;
}

jd3::LarvalJobOP
TutorialQueen::get_next_larval_job_for_node_3(){

        using namespace protocols::jd3;

        if( node_managers_[ 3 ]->done_submitting() ) {
                return 0;
        }

        core::Size const local_job_id = node_managers_[ 3 ]->get_next_local_jobid();
        core::Size const global_job_id = node_managers_[ 3 ]->job_offset() + local_job_id;

        core::Size const num_results_for_node1 = node_managers_[ 1 ]->results_to_keep().size();
        core::Size const node_of_parent = ( local_job_id > num_results_for_node1 ? 2 : 1 );

        jd3::JobResultID parent_result;
        if( node_of_parent == 1 ){
                parent_result = node_managers_[ 1 ]->get_nth_job_result_id( local_job_id );
        } else {
                core::Size const num_results_for_node2 = node_managers_[ 2 ]->results_to_keep().size();
                core::Size const result_index = local_job_id - num_results_for_node1;
                if( result_index > num_results_for_node2 ){
                        return 0;
                }

                parent_result = node_managers_[ 2 ]->get_nth_job_result_id( result_index );
        }

        job_genealogist_->register_new_job(
                3,
                global_job_id,
                node_of_parent,
                parent_result
        );

        core::Size const pose_input_source_id = job_genealogist_->input_source_for_job( 3, global_job_id );

        jd3::standard::StandardInnerLarvalJobOP inner_ljob =
                create_and_init_inner_larval_job( 1, pose_input_source_id );

        LarvalJobOP ljob = utility::pointer::make_shared< LarvalJob >(
                inner_ljob,        1, global_job_id );

        return ljob;
}

JobOP
TutorialQueen::complete_larval_job_maturation(
        LarvalJobCOP job,
        utility::options::OptionCollectionCOP,
        utility::vector1< JobResultCOP > const & input_job_results
) {
        if ( num_input_structs_ == 0 ) {
                initial_job_dag();
        }

        standard::StandardInnerLarvalJobCOP standard_inner_larval_job
                = utility::pointer::static_pointer_cast< const standard::StandardInnerLarvalJob >( job->inner_job() );

        core::Size const global_job_id = job->job_index();

        moves::MoverOP mover = 0;
        runtime_assert( sfxn_ );
        core::scoring::ScoreFunctionOP sfxn = sfxn_;
        core::pose::PoseOP pose = 0;

        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ){
                //This job belongs to node 1
                //local_job_id = global_job_id;
                mover = utility::pointer::make_shared< relax::FastRelax >();
                pose = pose_for_inner_job( standard_inner_larval_job );
        } else if( global_job_id <= node_managers_[ 1 ]->num_jobs() + node_managers_[ 2 ]->num_jobs() ) {
                //alternatively you could have used:
                //else if( global_job_id <= node_managers_[ 3 ]->job_offset() )

                //This job belongs to node 2
                //local_job_id = global_job_id - node_managers_[ 2 ]->job_offset();
                mover = utility::pointer::make_shared< minimization_packing::MinPackMover >();
                pose = pose_for_inner_job( standard_inner_larval_job );
        } else {
                //This job belongs to node 3
                //local_job_id = global_job_id - node_managers_[ 3 ]->job_offset();
                mover = utility::pointer::make_shared< minimization_packing::MinMover >();

                //We created this larval job and pose result so we know that there should be exactly 1 result and that result is a standard::PoseJobResult
                runtime_assert( input_job_results.size() == 1 );
                standard::PoseJobResult const & result1 = static_cast< standard::PoseJobResult const & >( * input_job_results[ 1 ] );
                pose = result1.pose()->clone();
                runtime_assert( pose );
        }

        TutorialJobOP tjob = utility::pointer::make_shared< TutorialJob >();
        tjob->set_pose( pose );
        tjob->set_sfxn( sfxn );
        tjob->set_mover( mover );

        return tjob;
}

void TutorialQueen::note_job_completed(
        jd3::LarvalJobCOP job,
        jd3::JobStatus status,
        core::Size nresults
) {
        core::Size const global_job_id = job->job_index();
        core::Size dag_node = 0;

        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ) {
                dag_node = 1;
        } else if ( global_job_id > node_managers_[ 3 ]->job_offset() ) {
                dag_node = 3;
        } else {
                dag_node = 2;
        }

        if ( status != jd3_job_status_success ) {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, 0 );
                job_genealogist_->note_job_completed( dag_node, global_job_id, 0 );
        } else {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, nresults );
                job_genealogist_->note_job_completed( dag_node, global_job_id, nresults );

                if ( dag_node == 3 ) {
                        standard::StandardInnerLarvalJobCOP inner_job =
                                utility::pointer::dynamic_pointer_cast< standard::StandardInnerLarvalJob const > ( job->inner_job() );
                        utility::options::OptionCollectionOP job_options = options_for_job( *inner_job );
                        for ( core::Size ii = 1; ii <= nresults; ++ii ) {
                                output::OutputSpecificationOP out_spec = create_output_specification_for_job_result( job, *job_options, ii, nresults );
                                pose_output_specification_for_job_result_id_[ jd3::JobResultID( global_job_id, ii ) ] = out_spec;
                        }
                }

        }

}

void TutorialQueen::completed_job_summary(
        core::Size global_job_id,
        core::Size result_index,
        jd3::JobSummaryOP summary
) {

        core::Size dag_node = 0;
        if( global_job_id <= node_managers_[ 1 ]->num_jobs() ) {
                dag_node = 1;
        } else if ( global_job_id > node_managers_[ 3 ]->job_offset() ) {
                dag_node = 3;
        } else {
                dag_node = 2;
        }

        standard::EnergyJobSummary const & energy_summary =
                static_cast< standard::EnergyJobSummary const & >( * summary );

        node_managers_[ dag_node ]->register_result(
                global_job_id,
                result_index,
                energy_summary.energy()
        );

}

std::list< jd3::JobResultID >
TutorialQueen::job_results_that_should_be_discarded(){
        std::list< jd3::JobResultID > list_of_all_job_results_to_be_discarded;

        for ( core::Size dag_node = 1; dag_node <= 3; ++dag_node ) {
                std::list< jd3::JobResultID > job_results_to_be_discarded_for_node;
                node_managers_[ dag_node ]->append_job_results_that_should_be_discarded( job_results_to_be_discarded_for_node );

                for ( jd3::JobResultID const & discarded_result : job_results_to_be_discarded_for_node ) {
                        job_genealogist_->discard_job_result( dag_node, discarded_result );

                        if( dag_node == 3 ){
                                pose_output_specification_for_job_result_id_.erase( discarded_result);
                        }
                }

                list_of_all_job_results_to_be_discarded.splice(
                        list_of_all_job_results_to_be_discarded.end(),
                        job_results_to_be_discarded_for_node );
        }

        return list_of_all_job_results_to_be_discarded;
}

std::list< jd3::output::OutputSpecificationOP >
TutorialQueen::jobs_that_should_be_output() {
        std::list< output::OutputSpecificationOP > jobs_to_be_output;
        if ( ! node_managers_[ 3 ]->all_results_are_in() ) {
                return jobs_to_be_output;
        }

        utility::vector1< jd3::dag_node_managers::result_elements > const & all_results = node_managers_.back()->results_to_keep();
        for ( jd3::dag_node_managers::result_elements const & res_elem : all_results ) {
                output::OutputSpecificationOP res_elem_os = pose_output_specification_for_job_result_id_.at(
                        jd3::JobResultID ( res_elem.global_job_id, res_elem.local_result_id )
                );
                //If you wanted, now would be the time to re-number the output indices of this specification
                jobs_to_be_output.push_back( res_elem_os );
        }
        return jobs_to_be_output;
}

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

} //tutorial
} //protocols
```

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms
