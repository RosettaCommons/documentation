ResourceManager
===============

The ResourceManager facilitates accessing external data resources from
within a protocol. In conjunction with a protocol's job distributor, the
ResourceManager manages the lifecycle of data, from retrieval with a
ResourceLocator, initialization with a ResourceLoader
and usage through the ResourceManager interface and
release when it is no longer needed. The ResourceManager also
facilitates specializing the OptionSystem for specific jobs.

Further documentation can be found at [[ResourceManager Details]].

ResourceLocator
===============

A **ResourceLocator** is responsible for accessing a resource inside of
a datastore such as a file, database, or serialization stream. Once
initialized a ResourceLocator acts as a map from **LocatorTag** to
**ResourceStream**, where the LocatorTag type represents an identifier
for the resource inside of the datastore and is *typedef*ed to a
*string*. The *ResourceStream* is a container for an **std::istream**.

FileResourceLocator
-------------------

The FileResourceLocator LocatorTag represents the filename and the
ResourceStream represents the contents of the file.

ResourceLoader
==============

A '*ResourceLoader* is responsible for constructing a Resource object
from an instance of a ResourceStream and an instance of a
ResourceOptions.

PoseFromPDBLoader
-----------------

Create a Pose object from a PDB file.

LoopsFileLoader
---------------

Create a LoopsFileData from a LoopsFile.

Interface
=========

(To be documented.)

##See Also

* [[ResourceManager Details]]
* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Application Documentation]]: Information on existing Rosetta apps
* [[RosettaScripts]]: Instructions for writing RosettaScripts, the Rosetta XML interface
* [[Using the job distributor|jd2]]
* [[RosettaEncyclopedia]]: Detailed descriptions of concepts in Rosetta.
* [[Running Rosetta with options]]: Instructions for running Rosetta executables


<!--
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager
Resource Manager ResourceManager -->