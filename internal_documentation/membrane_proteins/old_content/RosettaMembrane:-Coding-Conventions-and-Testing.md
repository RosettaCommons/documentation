The membrane framework was designed to be a general platform for protocols to use in modeling membrane proteins. Therefore, in further developing the framework it is important to maintain generality and important design decisions. The information below is geared toward this. 

Rosetta also has its own set of coding conventions which can be found here: [RosettaCommons Coding Conventions](https://wiki.rosettacommons.org/index.php/Coding_conventions)

## Coding Conventions

### General Dos/Dont's
* **Adding a New Membrane Data Resource**: Manage all membrane data resources with the resource manager. This generally requires adding a resource loader, resource IO, resource options, and fallback options to `src/core/membrane/io`. Do not independently load the resource - load it through membrane conformation. 
* **Membrane Residue Types**: Use membrane residue types (derived virtual types) and not virtual residues to define membrane parameters. Membrane residue types and virtual residue types are **not** the same!! 
* **Loading a Membrane Protein**: If overriding the starting structure provided in #apply(pose), call the membrane protein factory and use the new pose throughout.**Do not** overwrite the starting structure created by JD2. 
* You should only need to #include MembraneProteinFactory, MembraneConformation, and/or anything in `core/membrane/properties`. If you are including anything else in the core/membrane namespace, you are most likely using the framework incorrectnly. 

### Extending the Definition of a Membrane Protein
A membrane protein in Rosetta is defined such that it contains a membrane residue, an embedding residue for every chain, and further definitions regarding kinematics, conformation, and properties of the fold tree. If you feel this definition should be extended, consider the following: 

* Is this property general? Or does it only have to do with my specific task? 
* How well does this property generalize to edge case proteins (example - membrane and non membrane chain poses)

These considerations are to prevent adding properties that would prohibit the use of the framework with new protocols. TLDR - add definitions with caution. 

### Style Additions
* Include all Required doxygen tags in header: @file, @brief, @details, @note MembraneCode, and @author - consistent with all other code in the membrane framework. 
* Class definitions **must** contain custom copy constructor definitions. 

## Testing

_All_ classes must be unit tested and pass the mpframework integration test. This code base was unit tested such that all components are covered by test - therefore failing to write the test will reduce the quality of unit tests someone already wrote. Just write the test please :D

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