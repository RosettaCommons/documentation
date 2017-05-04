# Release Notes

<!--- BEGIN_INTERNAL -->
## _Rosetta 3.9 (internal notes)_

_(This section in italics should remain hidden from the public wiki.)_

* _N-methylated amino acids likely to end up here_ (VKM)
* _"Best practices" movers, such as the AddHelixSequenceConstraints mover, should likely end up here. (VKM)_
 * That actually made it in 3.8, but SML didn't add it to the notes (unclear if stable)

<!--- END_INTERNAL -->

## Rosetta 3.8
###New RosettaScripts XML
The XML supporting RosettaScripts has been totally refactored.  Rosetta now validates input XML files against an "XML Schema", and can better determine at the start of a run if all XML options are legal and functional.  The XML reader can now pinpoint errors much more specifically and offers more helpful error messages. 

You can now also get commandline help for XML-enabled classes with the -info flag; e.g. ```-info PackRotamersMover``` and a blank, formatted template rosetta script by running the `rosetta_script` application without giving the `-parser:protocol` option.  

A consequence of this refactoring is that pre-Rosetta3.8 XML scripts are usually no longer legal XML - we offer a tool to convert the old style, pseudo-XML into the current format at tools/xsd_xrw/rewrite_rosetta_script.py (this is in the tools toplevel folder, not the main code folder).  The vast majority of classes have complete documentation; when you find one that does not, complain to (doc feedbacks email) and let us know!

###JD3
A new Job Distributor, JD3, is ready for use.  This is mostly invisible to end users, but will allow more complex protocols to be crafted instead of as multi-step and multi-app instructions.  Look forward to cool JD3-enabled apps in future releases.

###support for more PDBs
Although most improvements were in Rosetta3.7, we continue to improve the fraction of unmodified PDBs Rosetta can handle.  (Don't worry - we've always been able to handle canonical protein well - but we are doing an ever-improving job with strange stuff like the GFP fluorophore, chemically concatenated ligands, glycans, RNA, etc).

###Cxx11 builds
Rosetta turned on Cxx11 features in its C++.  This deprecates the compatibility of a lot of older compilers. See <https://www.rosettacommons.org/docs/latest/build_documentation/Cxx11Support