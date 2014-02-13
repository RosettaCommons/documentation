## Coding Conventions
To improve development of protocols using the membrane framework, I am including some additional development guidelines to maintain the design and style throughout. 

Rosetta also has its own set of coding conventions which can be found here: [RosettaCommons Coding Conventions](https://wiki.rosettacommons.org/index.php/Coding_conventions)

### General Dos/Dont's
* If adding a new membrane resource, manage it with a resource loader/io class. Do not independently call it but load it through membrane conformation. 
* If using a custom fold tree topology, load the default membrane fold tree and then modify. Maintain all membrane and embedding residues added in initialization. 
* Do not use virtual residues for additional membrane/embedding definitions. These are **not** the same - see [[Membrane Residue Types]] page for more info. 
* If overriding the startstruct with a membrane protein, call the membrane protein factory in the top level apply function and use the resulting pose as the startstruct. **Do not** overwrite the starting structure created by JD2. 
* You should only need to #include MembraneProteinFactory, MembraneConformation, and/or anything in `core/membrane/properties`. If you are including anything else in the core/membrane namespace, you are most likely using the framework incorrectnly. 

### Extending the Definition of a Membrane Protein
A membrane protein in Rosetta is defined such that it contains a membrane residue, an embedding residue for every chain, and further definitions regarding kinematics, conformation, and properties of the fold tree. If you feel this definition should be extended, consider the following: 

* Is this property general? Or does it only have to do with my specific task? 
* How well does this property generalize to edge case proteins (example - membrane and non membrane chain poses)

If you have considered all of these, go ahead - add it. 

### Style Additions
* Include all Required doxygen tags in header: @file, @brief, @details, @note MembraneCode, and @author - consistent with all other code in the membrane framework. 
* Class definitions **must** contain custom copy constructor definitions. 

## Testing
_All_ classes must be unit tested and pass the mpframework integration test. If you are extending the definition of a membrane protein (see conventions above), then add an invariant for it in the mpframework integration test app. This entire code base was rigorously unit tested to ensure that your code could be correctly unit tested so respect the community and write the test And lets be honest, you don't want to be 'that guy' who broke the code because you forgot to add tests. 

### Unit Testing
The membrane framework is maintained using the following unit tests: 
* EmbedDefIOTests
* EmbedDefLoaderTests
* EmbedSearchParamsOptionsTests
* EmbedSearchParamsLoaderTests
* EmbedSearchParamsIOTests
* LipsFileIOTests
* LipoFileLoaderTest
* SpanFileIOTests
* SpanFileLoaderTests
* LoadAllResourcesTest
* GeometryUtilTest
* MembraneResiduesTest
* EmbeddingFactoryTest
* MembraneConformationTest
* MembraneProteinFactoryTest

### Integration Testing
The membrane framework is maintained by the following integration tests. 
* mpframework_integration