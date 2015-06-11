#utility::io Namespace Reference

File stream I/O classes, primarily for compressed data.

Detailed Description
--------------------

The utility::io package provides file stream i/o classes that support gzip-compressed or uncompressed data file i/o through a unified interface so that the same stream i/o operations can be applied regardless of whether the file is compressed or not. They use a modernized version of the zipstream system created by Jonathan de Halleux for the gzip i/o.

The izstream class handles stream input of gzip and uncompressed files. The izstream interface is very similar to std::ifstream except that files with names ending in ".gz" will be opened as gzip compressed files and izstream will try to open other files as gzip files with a .gz appended to the name before opening them as uncompressed files with the specified name.

The orstream class provides the interface for the stream output classes. A hierarchy is needed for output to allow std::endl outputs to gzip files to be intercepted and replaced by non-flushing newlines (since gzip files can't be flushed until closed) while providing a mechanism for predefined stream channels like std::cout to continue to support flushing. The ocstream class is used to support general ostreams and provides predefined ocstream output "channels" cout, cerr, and clog that wrap the corresponding channels in namespace std. Functions written to the abstract orstream interface can work with ozstreams, general ostreams, or predefined ocstream channels.

bzip2 support can be readily added to this system if desired.

##See Also

* [[Utility namespace|namespace-utility]]
  * [[utility::factory|namespace-utility-factory]] **NO LONGER EXISTS**
  * [[utility::keys|namespace-utility-keys]]
  * [[utility::options|namespace-utility-options]]
* [[Src index page]]: Description of Rosetta library structure and code layout in the src directory
* [[Rosetta directory structure|rosetta-library-structure]]: Descriptions of contents of the major subdirectories in the Rosetta `main` directory
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Development Documentation]]: The main development documentation page