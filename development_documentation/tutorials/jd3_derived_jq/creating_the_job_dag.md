#Step 2: Creating the Job DAG

Author: Jack Maguire

[[Back to Walkthrough|jd3_derived_jq_home]]

[[Step 1: Code Skeletons|skeletons]]

[[Step 3: Node Managers|node_managers]]

[[_TOC_]]

##Reading

[[The_Role_of_the_JobDigraph|https://wiki.rosettacommons.org/index.php/JD3FAQ#The_Role_of_the_JobDigraph]]

[[More on the Digraph|https://wiki.rosettacommons.org/index.php/JD3FAQ#Communication_between_the_JobDistributor_and_the_JobQueen_via_the_JobDigraph]]

##Plan

I tried to contrive a queen that would require a non-linear [[job dag|https://wiki.rosettacommons.org/index.php/JD3FAQ#The_Role_of_the_JobDigraph]].
There are several ways to create a dag that would fit our needs, let's go with something like this:

DAG Node 1: Run mover A. Number of jobs is proportional to the number of residues in chain 1 (just to make it interesting).

DAG Node 2: Run mover B. Number of jobs is proportional to the number of residues in chain 2.

DAG Node 3: Merge results from 1 and 2 and run mover C.

```
1------> 3
    /
2--/
```

So each residue position on chain1 gets its own job in Node 1 and each position in chain 2 gets its own job in Node 2.
In reality, you would almost certainly just make this a 2-node dag `1->2` where the first node handles both chains.
I was hoping this tutorial would have a branched DAG and I was not creative enough to come up with a design case that was simple enough to use for a tutorial.
Let's just go with this.

##initial_job_dag()

To create the job DAG, we need to override `initial_job_dag()`, as shown below.
This function is a wolf in sheep's clothing because it looks like a simple getter, yet
it is the first method called by the job distributor after construction and handles almost all of the initialization for the job queen.

The standard job queen is initialized when you call `determine_preliminary_job_list()` (which I recommend to be the very first line of `initial_job_dag()`).
`determine_preliminary_job_list()` will call the virtual function `parse_job_definition_tags()`.
We will address this method in more detail in [[Appendix A|appendixA]],
but for now we can just use it to count the number of `<Job>` tags in the job definition file.

##Code

I left off some of the info at the tops and bottoms of the pages.

###TutorialQueen.hh

```c++
#include <protocols/tutorial/TutorialQueen.fwd.hh>
#include <protocols/jd3/standard/StandardJobQueen.hh>
#include <protocols/jd3/JobDigraph.fwd.hh>

#include <utility/tag/Tag.fwd.hh>

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

private:
        core::Size num_input_structs_;
};

} //tutorial
} //protocols
```

###TutorialQueen.cc

```c++
#include <protocols/tutorial/TutorialQueen.hh>
#include <protocols/jd3/JobDigraph.hh>

#include <utility/pointer/memory.hh>
#include <basic/Tracer.hh>

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
TutorialQueen::initial_job_dag() {
        //you need to call this for the standard job queen to initialize
        determine_preliminary_job_list();

	//the lone argument ( 3 ) is the number of nodes in the dag
        JobDigraphOP dag = utility::pointer::make_shared< JobDigraph >( 3 );
        dag->add_edge( 1, 3 ); //results of node 1 will be fed directly to node 3
        dag->add_edge( 2, 3 ); //results of node 2 will be fed directly to node 3
        return dag;
}

void
TutorialQueen::parse_job_definition_tags(
        utility::tag::TagCOP common_block_tags,
        utility::vector1< standard::PreliminaryLarvalJob > const & prelim_larval_jobs
){
        num_input_structs_ = prelim_larval_jobs.size();
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