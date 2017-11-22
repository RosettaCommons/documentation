This is a copy of a Slack conversation in which Andrew explains why Rosetta isn't on GPU and what it might take to get it there:

Steven Lewis [15:14] 
I know the core reason Rosetta is not on GPU is that our algorithms translate horribly to GPU’s requirements and it will be a huge amount of work to translate to GPU.  Has anyone ever written a long-form explanation of this?  Particularly with details on troublesome algorithms?  Tag @aleaverfay who is likely to know, and @weitzner who can ask Luki (who appears not to be on slack)


Andrew Leaver-Fay [09:28] 
@steven_lewis I think the long form explanation begins with a big sigh


[09:30] 
So GPUs. They don't support virtual functions -- they cannot support virtual functions -- because they need to know at compile time the resource requirements of every kernel they are going to execute. So the process of scoring a Pose with our existing score function has this dilemma:


[09:31] 
Do you score one term at a time, so that each term can launch its own kernel BUT so that each term is going to load the same residue-coordinate data into thread-local storage from global memory (at a lag of 100 cycles per load)


[09:35] 
or do you do load the residue-pair data into thread-local storage once and then evaluate all the terms on this residue pair BUT where this single kernel now includes every term in Rosetta (or some large fraction of them) and has an "if" check ahead of each term to make sure it's active -- and where this monolithic kernel is as different from object-oriented programming as you could possibly be and where it's not clear what data you need to load into thread-local storage to start because not every term needs the same data.


[09:37] 
Now, all scoring/derivative evaluation and atom-tree refolding needs to take place on the GPU -- it might be possible to run minimization on the CPU still where the GPU passes back the torsion-space gradient vector and the scores.

[09:38] 
But none of the scores can be evaluated on the CPU -- every term you want to evaluate needs to live on the GPU -- communicating back and forth between the two is too expensive


[09:38] 
So let's talk about constraints:


[09:38] 
constraints in Rosetta are marvelously flexible.


[09:38] 
You have the virtual Constraint class and the virtual Func class


[09:38] 
and you can combine any pair

[09:39] 
that becomes impossibly complicated on the GPU where you would maybe need to try and evaluate every N x M pair of N Constraint classes and M Func classes for every residue pair whether or not there are any constraints on it?


[09:40] 
So basically the "where do you even begin" problem is pretty daunting


[09:40] 
Now let's talk about code maintanence


[09:40] 
everything on the GPU is ugly. Fortran ugly.


[09:41] 
Your functions have 30 arguments and they are all arrays

Andrew Leaver-Fay [09:42] 
And we need to ensure that the version on the GPU exactly matches the version on the CPU


[09:42] 
so any time anyone edits the CPU version, they are also going to have to edit the GPU version


[09:43] 
and that means dozens of developers mucking around in the inner workings of incredibly sensitive code -- code where disturbing the precise layout of any object can produce an enormous slowdown


[09:45] 
Now, perhaps I am just being overly pessimistic


[09:47] 
Perhaps a spirited young graduate student with enough patience -- more than I have, let's say -- could sit down and work out score function evaluation on the GPU if it's their main project (I often find myself pulled left and right into different projects that keeps me from devoting 100% to a GPU project)


[09:47] 
The thing that perplexes me is that I have worked with many such graduate students / research scientists and every single one of them has given up without having gotten a single term working on the GPU.

(And I might grumble a bit that I have invested a lot of time in trying to train these graduate students on how Rosetta works, and that time investment paid no dividends)