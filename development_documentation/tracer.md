<!-- --- title:  Tracer -->Tracer, tool for debug IO

General idea
============

All output messages have channel + priority level assign to them. User can dynamically, in run time specify command line options to mute/unmute specific/all channels and to change level of output.

Example of usage:

\#include \<core/util/tracer.hh\>

...

using core::util::T;

using core::util::Error;

using core::util::Warning;

...

static core::util::Tracer TR( "core.io.pdb.file\_data" );

static core::util::Tracer TR2( "core.io.pdb.file\_data" , t\_fatal);

...

void my\_function()

{

// using pre-created Tracer object

TR \<\< "my\_function begin..." \<\< std::endl;

// using named priority levels:

TR.Fatal \<\< "Some Fatal Error here..." \<\< std::endl;

TR.Error \<\< "Some Error here... " \<\< std::endl;

TR.Warning \<\< "Warning message... " \<\< std::endl;

TR.Info \<\< "Info message... " \<\< std::endl;

TR.Debug \<\< "Debug message... " \<\< std::endl;

TR.Trace \<\< "Trace message... " \<\< std::endl;

TR \<\< "regular output with default priority" \<\< std::endl;

// changing default priority level of tracer object

TR.priority(t\_warning) \<\< "Now default priority is t\_warning." \<\< std::endl;

TR(t\_fatal) \<\< "Now default priority is t\_fatal." \<\< std::endl;

// print debug messages without creating Tracer object, useful if you need to output to custom channel.

T( "SomeChannelName" ) \<\< "Just a message..." \<\< std::endl;

// Specifying priority:

T( "ChannelA" , 100) \<\< "Message with priority 100" \<\< std::endl;

}

It is possible output some stl and utility data type directly. Currently we have support std::vector, [[utility::vector1|vector1]] and std::map. Here the example of usage:

std::vector\<int\> A;

A.push\_back(1); A.push\_back(2); A.push\_back(3); A.push\_back(5);

[[utility::vector1\<int\>|vector1]] B;

B.push\_back(10); B.push\_back(20); B.push\_back(30); B.push\_back(45);

std::map\<int, std::string\> M;

M[1]= "one" ; M[2]= "two" ; M[3]= "1+2" ;

T( "Demo" ) \<\< "vector:" \<\< A \<\< " vector1:" \<\< B \<\< " map:" \<\< M \<\< "\\n" ;

Which will produce output:

Demo: vector:[1, 2, 3, 5, ] vector1:[10, 20, 30, 45, ] map:{1:one, 2:two, 3:1+2, }

Controlling Tracer output from command line
===========================================

\# unmute all channels - default behavior, the same as just './a.out'

./a.out -unmute all

\# mute all channels, unmute ChannelA and ChannelB

./a.out -mute all -unmute ChannelA ChannelB

\# mute ChannelA and ChannelB

./a.out -mute ChannelA ChannelB

\# Set priority of output messages to be between 0 and 10

./a.out -out:level 10

\# disable output of channels names

./a.out -chname off

Note: channels name work as hierarchical name: if you mute 'core.scoring' - that will effectively mute all channels starting with core.scoring i.e: core.scoring.count\_pair, core.scoring.dunbrack, ... etc. The same logic apply to unmute.

Naming of the channels.
=======================

Name tracer channel according to your file path. For example file core/io/pdb/file\_data.cc should have Tracer channel named as 'core.io.pdb.file\_data'. That way Tracer channels would reflect namespaces for a code plus a file name.

If you need to create tracer with custom channel names - just add your custom name after dot in the end, for example:

static core::util::Tracer TR( "core.io.pdb.file\_data.some\_fancy\_name\_here" );
