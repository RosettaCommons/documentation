#AssemblyScorers

AssemblyScorers are used by the various AssemblyMovers to evaluate constructed Assemblies. Below is a list of currently implemented scorers. AssemblyScorers are a subtag to AssemblyMovers and are listed inside a AssemblyRequirements tag.

For an example of using a AssemblyScorers, see the [[AssemblyMover]] page.

[[_TOC_]]

###MotifScorer
A requirement that checks the residues of the assembly against one another to make sure there are no clashes. This requirement takes two options: ```maximum_clashes_allowed```, and ```clash_radius```. To disallow all clashes within 5 Angstroms, the tag would look like:

```xml
<ClashRequirement maximum_clashes_allowed="0" clash_radius="5" />
```