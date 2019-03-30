# LoopAnalyzerFilter
*Back to [[Filter|Filters-RosettaScripts]] page.*
## LoopAnalyzerFilter

This Filter calls [[LoopAnalyzerMover]] to compute a bunch of loop-specific metrics.  You can also try [[GeometryFilter]].

```xml
<LoopAnalyzerFilter name="&string" use_tracer="(&bool)" loops_file="(&string)" >
    <Loop start="(&int)" stop="(&int)" cut="(&int)" skip_rate="(0.0 &real)" rebuild="(no &bool)"/>
</LoopAnalyzerFilter>
```

- loop: You can pass the loop(s) in as a subtag(s).
- loops_file: You can pass the loops in as a loop file.
- use_tracer: if false, store results in the PoseExtraScores / DataCache for output at the end of the run.  If true, print results to a [[Tracer|Glossary#tracer]] object.

Remaining documentation is with the underlying code, [[LoopAnalyzerMover]].