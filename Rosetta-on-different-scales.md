Rosetta is a very hungry program in terms of computer time.
This is partly because protein modeling is about the [[hardest problem|http://xkcd.com/1430/]] we know.
It is partly because Rosetta is largely written by professional biophysicists who are less experienced at software engineering and totally inexperienced with [[optimizing|https://en.wikipedia.org/wiki/Program_optimization]] algorithms for speed.
(That said, the [[inner loops|https://en.wikipedia.org/wiki/Inner_loop]] really are quite optimized by people who knew what they were doing!)

This page talks about Rosetta in terms of both `nstruct`—the Rosetta flag to control the **n**umber of **struct**ures generated—and the computer time needed to generate those structures.
Ideally, one always runs enough models to answer their modeling question.
In the real world, experimenters are constrained by computer time.
Additionally, the question of how many nstruct are necessary is heuristic and specific to the problem.
This document attempts to address in a harder sense how many nstruct models one wants for different types of experiments (and why!), and in a softer sense approximately how much computer time we are talking about.
The [[results analysis|Analyzing-Results]] page also addresses the issue.

![Diagram: log scale in nstruct Rosetta protocols](uploads/nstruct_scale.png "log scale in nstruct Rosetta protocols")

The diagram sketches out 