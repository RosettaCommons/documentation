#basic::Tracer class reference

General idea
============

All output messages have channel + priority level assign to them. User can dynamically, in run time specify command line options to mute/unmute specific/all channels and to change level of output.

Example of usage:

```
#include <basic/Tracer.hh>
...
using basic::T;
using basic::Error;
using basic::Warning;
...
static basic::Tracer TR( "core.io.pdb.file_data" );
static basic::Tracer TR2( "core.io.pdb.file_data" , t_fatal);
...
void my_function()
{
    // using pre-created Tracer object
    TR << "my_function begin..." << std::endl;

    // using named priority levels:
    TR.Fatal << "Some Fatal Error here..." << std::endl;
    TR.Error << "Some Error here... " << std::endl;
    TR.Warning << "Warning message... " << std::endl;
    TR.Info << "Info message... " << std::endl;
    TR.Debug << "Debug message... " << std::endl;
    TR.Trace << "Trace message... " << std::endl;
    TR << "regular output with default priority" << std::endl;

    // changing default priority level of tracer object
    TR.priority(t_warning) << "Now default priority is t_warning." << std::endl;
    TR(t_fatal) << "Now default priority is t_fatal." << std::endl;

    // print debug messages without creating Tracer object, useful if you need to output to custom channel.
    T( "SomeChannelName" ) << "Just a message..." << std::endl;

    // Specifying priority:
    T( "ChannelA" , 100) << "Message with priority 100" << std::endl;
}
```

It is possible output some stl and utility data type directly. Currently we have support std::vector, [[utility::vector1|vector1]] and std::map. Here the example of usage:

```
std::vector<int> A;
A.push_back(1); A.push_back(2); A.push_back(3); A.push_back(5);
utility::vector1<int> B;
B.push_back(10); B.push_back(20); B.push_back(30); B.push_back(45);
std::map<int, std::string> M;
M[1]= "one" ; M[2]= "two" ; M[3]= "1+2" ;
T( "Demo" ) << "vector:" << A << " vector1:" << B << " map:" << M << "\n" ;
```

Which will produce output:

```
Demo: vector:[1, 2, 3, 5, ] vector1:[10, 20, 30, 45, ] map:{1:one, 2:two, 3:1+2, }
```

Controlling Tracer output from command line
===========================================

unmute all channels - default behavior, the same as just './a.out'

`./a.out -unmute all`

mute all channels, unmute ChannelA and ChannelB

`./a.out -mute all -unmute ChannelA ChannelB`

mute ChannelA and ChannelB

`./a.out -mute ChannelA ChannelB`

Set priority of output messages to be between 0 and 10

`./a.out -out:level 10`

disable output of channels names
* setting the level to 999 will show all tracers, useful when debugging!

`./a.out -chname off`

Note: channels name work as hierarchical name: if you mute 'core.scoring' - that will effectively mute all channels starting with core.scoring i.e: core.scoring.count\_pair, core.scoring.dunbrack, ... etc. The same logic apply to unmute.

Naming of the channels.
=======================

Name tracer channel according to your file path. For example file core/io/pdb/file\_data.cc should have Tracer channel named as 'core.io.pdb.file\_data'. That way Tracer channels would reflect namespaces for a code plus a file name.

If you need to create tracer with custom channel names - just add your custom name after dot in the end, for example:

```
static basic::Tracer TR( "core.io.pdb.file_data.some_fancy_name_here" );
```


##See Also

* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page