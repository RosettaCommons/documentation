# Rosetta:MSF: a modular framework for multi-state computational protein design


## Metadata
MSF initially has been developed and used in 2015 to design retroaldolase enzymes.

Send questions to Samuel Schmitz (Samuel.Schmitz@vanderbilt.edu)

## References
The enzyme design multistate design alogirthm was published under the following title:

Löffler P, Schmitz S. et al. Rosetta:MSF: a modular framework for multi-state computational protein design. PLOS Comp. Biol. 2017 Jun 12; pmid: 28604768. doi: 10.1371/journal.pcbi.100560

## Available applications based on MSF
* `msf_ga_enzdes`: GeneticAlgorithm based enzyme design on multiple states
* `msf_ga_scripts`: GeneticAlgorithm based design on multiple states. The design step is customizable via RosettaScripts.

## Purpose

The MSF is a protocol aims to ease the development of new multisate design protocols. A number of classes provide a framework to sample solutions (here: sequences) and pass these solutions to MPI Nodes which evaluate the solutions.
The first implementation of MSF `msf_ga_enzdes` is taking up the genetic algorithm based approach of MPI_MSD. MPI Nodes are executing an enzdes based enzyme design protocol.
MSF was developed with high flexibility in mind to replace single components easily, like the genetic algorithm or the custom MPI based job distribution system.
Using MSF the `enzdes` protocol for enzyme has been extended with multistate design capability. MSF has been developed for multistate design enabled enzyme design and is using an genetic algorithm to sample the sequence space.
Thus, the resulting application is called `msf_ga_enzdes`.

MSF comes with a modular class system to support the following features:
* Management of multiple structures (states) (with unique design and repack shells for `enzdes`)
* A custom MPI communication protocol was introduced with the class `MPIControl`
* An *optimization module* searching the sequence space (default: `genetic_algorithm`)
* An *evaluation module* which allows users to apply arbitrary protocols on single states with a given sequence (`enzdes` and ~~`anchored_design`~~)
* An application framework acting as glue between the *optimization* and *evaluation* module
* Support for programmable fitness function (<b>D</b>ynamic<b>A</b>ggregate<b>F</b>itnessFunction - DAF - taken from *multistate_design*/**MPI_MSD** protocol returning a cummulative score of all states for each sequence. DAF allows easy realization of positive and negative design.

`msf_ga_enzdes` has successfully been used to design retroaldolase enzymes on multiple states and increase the design quality of the resulting enzymes.

## Algorithmic desciption of msf_ga_enzdes
From a user's perspective: `msf_ga_enzdes` takes `X` states ("conformations") of an enzyme bound to an ligand with one theozyme description for them all.
The design process happens using a genetic algorithm (GA), which samples sequences for the **design shell** of the enzyme.
The enzyme design algorithm is identical to the `enzdes` application. The design shell sequence however is forced to the sequence provided by the genetic algorithm.
Every sequence is scored using the cummulative enzdes score over all states. This cummuative score can be user-defined by the `DynamicAggreagetFunction` introduced by `mpi_msd` application. 
The app `msf_ga_enzdes` exposes all program options of the `mpi_msd`'s genetic algorithm as well as `enzdes` application to the user and can be treated as a combined application.

With a GA population size `P`, generations `G`, and states `X`, the total number of Jobs `J` is about `J=(G+1) * P/2 * X` with a slight variance caused by the GA.
A reasonable amount of MPI nodes to be allocated to yield high cpu usage would be `T+1` with `T` equal to `J` or a smaller number which can divide `J` without remainder.
> Note **T+1**: Allocate 1 additional MPI node for the master process!

For details, please refer to the `Rosetta:MSF` publication (program options in the supplement) and `mpi_msd`, `enzdes` documentation/publications.
Please take a look at msf_ga_enzdes integration test for a multistate design retroaldolase enzymde design on the 1A53 scallfold as described in the `Rosetta:MSF` publication.

## Developer's guide
### Description of the architecture of MSF using the example `msf_ga_enzdes` 
Following chapters will highlight main software concepts of the`multistate_framework` protocol.
The usage of abstract interface classes will be discussed using the implementation written for `msf_ga_enzdes`. 
### Application framework and MPI communication
MSF does not necessarily require MPI due to its modular architecture and MSF applications can be realized without MPI.
Nevertheless, this paragraph will discuss the architecture of the application framework at the example of its MPI variant: `MPIApplication`.
A simple application framework handles the initialization of all modules in the framework.
The main loop `MPIApplication::exec()` will execute the **optimizer** (here: Genetic Algorithm) in the MPI master node (node 0).
All slaves are responsible for **evaluation** (here: enzdes).

> To alter the MPI master/slave behavior, you will find yourself deriving from the application class and overwrite its behavior with a few lines of code.

The application will only handle abstract interface classes for the evaluation and optimization components which operate independently from GA and enzdes.
The MPI implementation of these abstract components however will then execute an **evaluation protocol** and an arbitrary algorithm for optimization.

> If you decide to keep the default behavor (letting the master node optimize and the slaves evaluate) but want to change how to optimize
> re-implementing the evaluation and optimization component interfaces and pass it to the existing MPIApplication class.
> Passing your new logic is made simple by using the Allocation system described in the paragraph below.

With `msf_ga_enzdes` the **optimizer component** executes `ParrallelGeneticAlgorithm`, which is Andrew Leaver-Fay's `genetic_algorithm::GeneticAlgorithm` class extended to use MSF's `MPIControl`.
Instead of just calling the `genetic_algorithm::FitnessFunction`, it communicates with the MPI Nodes, which execute the application's **evaluator component** part.
Therefore `ParallelGeneticAlgorithm` (executed by the master MPI Node) defines the details of the MPI master/slave architecture.
Using `MPIControl`, the status of each job is tracked (`busy`, `idle`) and not yet evaluated sequences are sent to `idle` nodes.
The poll interval is by default **75ms** and the computational demand of the master node is minimal and can easily be run in the background.
High utilization of each node could be achieved in a computation cluster by allocating ```N+1``` MPI nodes, while ```N``` cpu cores are available.

### Easy and quick modification of existing parts for customized algorithms: The Allocators

The previous paragraph discussed the main execution loop of the application framework and two important interface classes, the **evaluation component** and **optimization components**.
As elaborated earlier, MSF comes with a fully functional enzyme design application.
To modify the alogrithm and reuse the existing code for custom purposes one typically wants to reuse the whole algorithm but only change parts of it.
For this purpose, the Allocator system consisting of the classes `Allocator` and `Allocable` was introduced.
Briefly, classes which inherit `Allocable` can be used as entry points for customization by derivation.
At the time of writing, the following classes inherit `Allocable`:

* GeneticAlgorithm (GA)
* Entity (represents a sequence of the GA)
* OptimizationComponent
* EvalutaionComponent
* EvaluationInterface
* EnzdesProtocol
* State
* GAFitnessFunction
* Node (MPIControl's representation of an MPINode) 

Typically, an application defines **pools** which are instances of `Allocator` responsible to construct a distinct class derived from `Allocable`.
During instantiation, a derived type may be specified. 


```c++

int main(int argc, char** argv) {
    /* Here, ParallelGeneticAlgorithm will create an instance of GAFitnessFunction.
     * This application uses the derived type MPIGAResfileFitnessFunction, which writes resfiles to disk and communicates with slave Nodes */
    auto pool = GAFitnessFunction::getPool<MPIGAResfileFitnessFunction>();
    
    /* To not introduce more global static variables than nesessary, pools have to be passed through the protocol */
    OptimizationComponent->setGAFitnessFunction(pool);
}

```

> Note: `Allocable` classes cannot be created with `operator new`, instead its **pool** is required to instantiate them 

Somewhere inside the protocol (the developer of the new protocol does not need to worry anymore), `ParallelGeneticAlgorithm` or other users of this class can construct the requested type via
```c++
GAFitnessFunction::construct(pool); // Construct the instance without parameters. The pool is required.
```
The Allocator system supports different constructors with arguments by template specialization. For an example, please browse the code for `GANode.hh` taking an integer as argument.

> At the moment, the Allocators simply allocate one single instance per call on the heap (using `operator new`).
> Changing this behavior for each Allocable class independently is simple by specializing the construct template for the class accordingly. 
> This way it is possible to adapt the memory management for each class depending on its use (reusing of already allocated memory).
> However, no plans exist at the moment to realize this.

