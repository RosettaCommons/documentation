#Step 2: Creating the Job DAG

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Back to Step 1|skeletons]]

[[Forward to Step 3|TODO]]

[[_TOC_]]

##Plan

I tried to contrive a queen that would require a non-linear [[job dag|JD3]].
There are several ways to create a dag that would fit our needs, let's go with something like this:

DAG Node 1: Designs a negatively-charged residue on chain 1's side of the interface

DAG Node 2: Designs a posatively-charged residue on chain 2's side of the interface

DAG Node 3: Relax the interface

```
1------> 3
    /
2--/
```

This is admittedly a silly way to do things because the negatively-charged residues found in node 1 are not present when sampling posatively-charged residues in node 2.
In practice, you might do something like this instead:

```
1 -> 2 -> 3
```

But can we just play along with the first DAG?
My creativity is not what it used to be.

##initial_job_dag()

To create the job DAG, we need to override `initial_job_dag()`, as shown below.
This function is a wolf in sheep's clothing because it looks like a simple getter.
It is the first method called by the job distributor after construction and handles almost all of the initialization for the job queen.

Luckily, you only have to worry about inintializing the parts of the job queen that you write.
The standard job queen takes care of itself if you call `determine_preliminary_job_list()` (which I recommend to be the very first line of `initial_job_dag()`).
`determine_preliminary_job_list()` will call the virtual function `parse_job_definition_tags()` that we will address in [[Step X|TODO]].

##Code

Just FYI: I left off some of the info at the tops and bottoms of the pages.

###TutorialQueen.hh

```
#include <protocols/tutorial/TutorialQueen.fwd.hh>
#include <protocols/jd3/standard/StandardJobQueen.hh>
#include <protocols/jd3/JobDigraph.fwd.hh>

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
};

} //tutorial
} //protocols
```

###TutorialQueen.cc

```
#include <protocols/tutorial/TutorialQueen.hh>
#include <protocols/jd3/JobDigraph.hh>
#include <protocols/jd3/JobDigraph.hh>

#include <utility/pointer/memory.hh>

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

JobDigraphOP
MRSJobQueen::initial_job_dag() {
        //you need to call this for the standard job queen to initialize
        determine_preliminary_job_list();

        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 );
        dag->add_edge( 2, 3 );
        return dag;
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