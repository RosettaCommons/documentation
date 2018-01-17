#Step 1: Skeletons for creating the file

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 2|creating_the_job_dag]]

[[_TOC_]]

##Plan

The first step of writing a file is to create it!
Let's put our job queen in `src/protocols/tutorial`.
Below I have pasted some skeletons that you can copy and paste.

Let's also add the following to one of the protocols.*.src.settings files.

```
        "protocols/tutorial" : [
                "TutorialQueen",
        ],
```


##TutorialQueen.fwd.hh

```c++
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.fwd.hh
/// @author Jack Maguire, jack@med.unc.edu


#ifndef INCLUDED_protocols_tutorial_TutorialQueen_FWD_HH
#define INCLUDED_protocols_tutorial_TutorialQueen_FWD_HH

#include <utility/pointer/owning_ptr.hh>

namespace protocols {
namespace tutorial {

class TutorialQueen;
typedef utility::pointer::shared_ptr< TutorialQueen > TutorialQueenOP;
typedef utility::pointer::shared_ptr< TutorialQueen const > TutorialQueenCOP;

} //tutorial
} //protocols

#endif
```

##TutorialQueen.hh

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
/// @author Jack Maguire, jack@med.unc.edu


#ifndef INCLUDED_protocols_tutorial_TutorialQueen_HH
#define INCLUDED_protocols_tutorial_TutorialQueen_HH

#include <protocols/tutorial/TutorialQueen.fwd.hh>
#include <protocols/jd3/standard/StandardJobQueen.hh>

namespace protocols {
namespace tutorial {

class TutorialQueen: public jd3::standard::StandardJobQueen {

public:

	//constructor
	TutorialQueen();

	//destructor
	~TutorialQueen() override;

};

} //tutorial
} //protocols

#endif
```

##TutorialQueen.cc

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
/// @author Jack Maguire, jack@med.unc.edu

#include <protocols/tutorial/TutorialQueen.hh>

static basic::Tracer TR( "protocols.tutorial.TutorialQueen" );

using namespace protocols::jd3;

namespace protocols {
namespace tutorial {

//Constructor
TutorialQueen::TutorialQueen() :
    StandardJobQueen()
{}

//Destructor
TutorialQueen::~TutorialQueen()
{}

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