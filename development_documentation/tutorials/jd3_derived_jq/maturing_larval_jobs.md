#Step 6: Maturing Larval Jobs

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 5: Writing a Job Class|tutorial_job]]

[[Step B|TODO]]

[[_TOC_]]

##Plan

We have already [[created larval jobs|larval_jobs]] and [[created our TutorialJob class|tutorial_job]],
so now we can write the method that matures larval jobs into TutorialJobs.

To get the jobs, the job distributor will call `mature_larval_job()`.
This is a virtual function so we can override it if we want;
however, the `StandardJobQueen` does a lot of the work for us in its override of `mature_larval_job()`.
Instead, we want to override `complete_larval_job_maturation()`.
This method is called at the end of `StandardJobQueen::mature_larval_job()` and allows our derived queen to mak the finishing touches to the job.

Also, this will be the first time the job queen will be called on the worker nodes!
This means we need to do all of the initialization we did on the head node in [[Step 2|creating_the_job_dag]].
I recommend starting a call to `complete_larval_job_maturation()` with a check to see if the queen has been initialized yet.
If the check fails, call `initial_job_dag()`.

##Code Additions

###Additions to Header File

Let's declare the override of `complete_larval_job_maturation()` in the `protected` section of the header.
```c++
jd3::JobOP
complete_larval_job_maturation(
        jd3::LarvalJobCOP larval_job,
        utility::options::OptionCollectionCOP job_options,
        utility::vector1< jd3::JobResultCOP > const & input_job_results
) override ;        
```

### New includes in the .cc file

```c++
#include <protocols/tutorial/TutorialJob.hh>
#include <protocols/jd3/standard/StandardInnerLarvalJob.hh>
#include <protocols/jd3/standard/MoverAndPoseJob.hh>

#include <protocols/moves/Mover.hh>
#include <protocols/relax/FastRelax.hh>
#include <protocols/minimization_packing/MinPackMover.hh>
#include <protocols/minimization_packing/MinMover.hh>
```

###Initialize num_input_structs_ to zero
We should be initializing all of our data to 0 in the constructor anyways, but now we have more incentive to do so.
We can check to see if `num_input_structs_` is 0 at the beginning of `complete_larval_job_maturation()`.
If it is 0, then we know we need to initialize().
```c++
//Constructor
TutorialQueen::TutorialQueen() :
        StandardJobQueen(),
        num_input_structs_( 0 ),
        node_managers_( 0 ),
        job_genealogist_( 0 )
{}
```

###complete_larval_job_maturation()
```c++
JobOP
TutorialQueen::complete_larval_job_maturation(
        LarvalJobCOP job,
        utility::options::OptionCollectionCOP job_options,
        utility::vector1< JobResultCOP > const & input_job_results
) {
        if ( num_input_structs_ == 0 ) {
                initial_job_dag();
        }

        standard::StandardInnerLarvalJobCOP standard_inner_larval_job
                = utility::pointer::static_pointer_cast< const standard::StandardInnerLarvalJob >( job->inner_job() );

        if ( !job_options ) {
                //job_options = options_for_job( standard_inner_larval_job );
        }

        core::Size const global_job_id = job->job_index();

        moves::MoverOP mover = 0;
        core::scoring::ScoreFunctionOP sfxn = core::scoring::ScoreFunctionFactory::create_score_function( "ref2015.wts" );
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