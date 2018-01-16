#Step 1: Skeletons for creating the file

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

The first step of writing a file is to create it!
Let's put our job queen in `src/protocols/tutorial`.
Below I have pasted some skeletons that you can copy and paste.

`TutorialQueen.fwd.hh`:

```
// -*- mode:c++;tab-width:2;indent-tabs-mode:t;show-trailing-whitespace:t;rm-trailing-spaces:t -*-
// vi: set ts=2 noet:
//
// (c) Copyright Rosetta Commons Member Institutions.
// (c) This file is part of the Rosetta software suite and is made available under license.
// (c) The Rosetta software is developed by the contributing members of the Rosetta Commons.
// (c) For more information, see http://www.rosettacommons.org. Questions about this can be
// (c) addressed to University of Washington CoMotion, email: license@uw.edu.

/// @file protocols/tutorial/TutorialQueen.fwd.hh
/// @brief
/// @detailed
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

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Rosetta tests]]: Links to pages on running and writing tests in Rosetta
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms