#Step 5: Writing a Job Class

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 4: Creating Larval Jobs|larval_jobs]]

[[Step 6: Maturing Larval Jobs|maturing_larval_jobs]]

[[_TOC_]]

##Reading

[[Job::run()|https://wiki.rosettacommons.org/index.php/JD3FAQ#Job::run.28.29]]

##Plan

Now we are going to create the classes that the larval jobs will be matured into.
Let's call this class `TutorialJob` ([[see here for skeleton|skeletons]]).

The job for this tutorial is relatively simple.
We are going to have a `MoverOP`, a `ScoreFunctionCOP`, and a `PoseOP` as data members.
Inside the virtual functoin `run` (which is the only function besides the constructor that the job distributor will call),
we will apply the mover to the pose and score the pose with the scorefunction.

##Code Additions

###Additions to Header File

We need these private data members. We should also create getters and setters for them (see below in the up-to-date code).
```c++
core::pose::PoseOP pose_;
core::scoring::ScoreFunctionCOP sfxn_;
moves::MoverOP mover_;
```

### New inclusions in the .hh file
```c++
#include <core/pose/Pose.fwd.hh>
#include <core/scoring/ScoreFunction.fwd.hh>
#include <protocols/moves/Mover.fwd.hh>
```

### New inclusions in the .cc file
```c++
#include <core/pose/Pose.hh>
#include <core/scoring/ScoreFunction.hh>
#include <protocols/moves/Mover.hh>

#include <protocols/jd3/JobResult.hh>
#include <protocols/jd3/JobSummary.hh>
#include <protocols/jd3/standard/MoverAndPoseJob.hh>

#include <utility/pointer/memory.hh>
```

###run()

This method is sort of like Mover::apply().
Every Job class needs it, and it is the only method this is called by the job distributor.

In our case, we want our job to apply the mover to the pose and score the result.
The score will be reported as a `jd3::standard::EnergyJobSummary` and the pose will be reported as a `jd3::standard::PoseJobResult`.

You can make your own derived classes of `JobSummary` and `JobResult`.
If you do, make sure that you make them
[[serializable|https://wiki.rosettacommons.org/index.php/SerializationFAQ]].

```c++
jd3::CompletedJobOutput TutorialJob::run() {
        runtime_assert( pose_ );
        runtime_assert( sfxn_ );
        runtime_assert( mover_ );

        jd3::CompletedJobOutput output;
        mover_->apply( *pose_ );
        core::Real const score = sfxn_->score( *pose_ );

        jd3::JobSummaryOP summary( utility::pointer::make_shared< jd3::standard::EnergyJobSummary >( score ) );
        jd3::JobResultOP result( utility::pointer::make_shared< jd3::standard::PoseJobResult >( pose_ ) );
        output.job_results.push_back( std::make_pair( summary, result ) );

        output.status = jd3::jd3_job_status_success;
        return output;
}
```

##Up-To-Date Code

###TutorialJob.hh
```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialJob.hh
/// @author Jack Maguire, jackmaguire1444@gmail.com


#ifndef INCLUDED_protocols_tutorial_TutorialJob_HH
#define INCLUDED_protocols_tutorial_TutorialJob_HH

#include <utility/pointer/ReferenceCount.hh>
#include <protocols/tutorial/TutorialJob.fwd.hh>

#include <protocols/jd3/CompletedJobOutput.hh>
#include <protocols/jd3/Job.hh>
#include <protocols/jd3/LarvalJob.fwd.hh>

#include <core/pose/Pose.fwd.hh>
#include <core/scoring/ScoreFunction.fwd.hh>
#include <protocols/moves/Mover.fwd.hh>

namespace protocols {
namespace tutorial {

class TutorialJob : public jd3::Job {

public:

        //constructor
        TutorialJob();

        //destructor
        ~TutorialJob();

        jd3::CompletedJobOutput run() override;

public:

        inline void set_pose( core::pose::PoseOP pose ) {
                pose_ = pose;
        }

        inline core::pose::PoseCOP pose() const {
                return pose_;
        }

        inline void set_sfxn( core::scoring::ScoreFunctionCOP sfxn ) {
                sfxn_ = sfxn;
        }

        inline core::scoring::ScoreFunctionCOP sfxn() const {
                return sfxn_;
        }

        inline void set_mover( moves::MoverOP mover ) {
                mover_ = mover;
        }

        inline moves::MoverCOP mover() const {
                return mover_;
        }

private:
        core::pose::PoseOP pose_;
        core::scoring::ScoreFunctionCOP sfxn_;
        moves::MoverOP mover_;
};

} //tutorial
} //protocols

#endif        
```

###TutorialJob.cc
```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialJob.cc
/// @brief
/// @detailed
/// @author Jack Maguire, jackmaguire1444@gmail.com

#include <protocols/tutorial/TutorialJob.hh>

#include <basic/Tracer.hh>

#include <core/scoring/ScoreFunction.hh>
#include <core/pose/Pose.hh>
#include <protocols/moves/Mover.hh>

#include <protocols/jd3/JobResult.hh>
#include <protocols/jd3/JobSummary.hh>
#include <protocols/jd3/standard/MoverAndPoseJob.hh>

#include <utility/pointer/memory.hh>

static basic::Tracer TR( "protocols.tutorial.TutorialJob" );

namespace protocols {
namespace tutorial {

//Constructor
TutorialJob::TutorialJob()
{}

//Destructor
TutorialJob::~TutorialJob()
{}

jd3::CompletedJobOutput TutorialJob::run() {
        runtime_assert( pose_ );
        runtime_assert( sfxn_ );
        runtime_assert( mover_ );

        jd3::CompletedJobOutput output;
        mover_->apply( *pose_ );
        core::Real const score = sfxn_->score( *pose_ );

        jd3::JobSummaryOP summary( utility::pointer::make_shared< jd3::standard::EnergyJobSummary >( score ) );
        jd3::JobResultOP result( utility::pointer::make_shared< jd3::standard::PoseJobResult >( pose_ ) );
        output.job_results.push_back( std::make_pair( summary, result ) );

        output.status = jd3::jd3_job_status_success;
        return output;
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
