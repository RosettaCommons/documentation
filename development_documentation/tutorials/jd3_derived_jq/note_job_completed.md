#Step 7: Note Job Completed

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 6: Maturing Larval Jobs|maturing_larval_jobs]]

[[Step 8: Completed Job Summary|completed_job_summary]]

[[_TOC_]]

##Plan

Once a job is done running, the job distributor will call two methods:
`note_job_completed()`, which tells the master queen how many results the job had,
followed by a call to `completed_job_summary()` for every result.
Both of these functions are overloaded,
however (as of the date this was written) one of the two `note_job_completed()` overloads is never called.

This step handles the first function and [[Step 8|completed_job_summary]] takes care of `completed_job_summary()`.

##Code Additions

###Additions to Header File

We need to add two overrides to the `public` section.
The first one never gets used so let's just add an assert.

```c++
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
```

###note_job_completed()
We can offload this work to the [[Node Managers|node_managers]]
and [[JobGenealogist|larval_jobs]], so most of the code below is
for the sake of figuring out which dag_node the job came from.
```c++
void TutorialQueen::note_job_completed(
        jd3::LarvalJobCOP job,
        jd3::JobStatus status,
        core::Size nresults
) {
        core::Size const global_job_id = job->job_index();

        core::Size dag_node = 0;
        core::Size local_job_id = global_job_id;

        if( global_job_id <= node_managers[ 1 ]->num_jobs() ) {
                dag_node = 1;
        } else if ( global_job_id > node_managers[ 3 ]->job_offset() ) {
                dag_node = 3;
                local_job_id = global_job_id - node_managers[ 3 ]->job_offset();
        } else {
                dag_node = 2;
                local_job_id = global_job_id - node_managers[ 2 ]->job_offset();
        }

        if ( status != jd3_job_status_success ) {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, 0 );
                job_genealogist_->note_job_completed( dag_node, local_job_id, 0 );
        } else {
                node_managers_[ dag_node ]->note_job_completed( global_job_id, nresults );
                job_genealogist_->note_job_completed( dag_node, local_job_id, nresults );
        }

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