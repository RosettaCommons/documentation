# Fixing Errors

## How to address errors in Rosetta 

It happens even to experienced Rosetta developers. You set up a Rosetta run, hit run on you job, and ... the run fails. No output, no useful results, just a cryptic error message (if you're lucky). What do you do now?

## Finding the error message.

The first step to fix your run errors is to locate the relevant diagnostic error messages. Rosetta prints error messages to the tracer (the text which gets printed to standard output or the terminal). If you have muted the tracer output with command line flags, the first step is to re-run the protocol with the tracers unmuted to get the full diagnostic outputs.

From the voluminous output that Rosetta produces, look for lines with "warning" and "error" messages. Warnings are messages about conditions which are not necessarily bad, but can indicate that closer attention is needed. "Errors" indicate conditions which are highly suspect and likely need to be fixed. Although the error which brought down the run is printed at the very end of tracer output, sometimes there are warning messages printed earlier which indicate conditions which will cause problems later. — Look at all warnings and errors printed to get an idea as to what might be going wrong.

## Steps to debugging your run.

#### Check your command line.

Take a look at the command line you used to launch Rosetta. Do you have all the options you need? Are any missing? Does every option which takes values have the correct number of values?Are all the file names specified correctly? Do you have the correct paths relative to directory you're running in? (Try using absolute paths rather than relative paths.) If you have an options file, check the options listed there as well. Are you using hyphens at the beginning of the options or are they en-dashes or em-dashes?

#### Check your input files.

Are your input files in the correct format? Are you passing PDB files to an option expecting a silent file, or a FASTA file to an option expecting a Grishin-format alignment file?

Check the alignment and spacing of contents. Are you using spaces or tabs to indent? (Mixing both is usually bad.) Certain formats like PDB are column-based: each entry must be a certain number of characters from the beginning of the file. Others are whitespace separated: each entry is separated from the others with one or more spaces or tabs.

Check the line endings of your files. Windows machines use a different style of line ending from Linux and MacOS machines. Using a file that was edited (or passed through) a Windows machine can cause issues due to the slightly different line endings. The program `dos2unix` is able to handle converting files to the Unix-like standard. 

Check for other hidden (non printable) characters, or other non-standard characters. Rosetta generally expects all files to contain only printable ASCII characters and whitespace. Using a word processor instead of a text editor to edit files can mean that special characters (smart quotes, em-dashes, etc.) can be inserted. The command `grep '[^[:graph:][:blank:]]' <filename>` can be useful to see which lines, if any, have inappropriate characters. 

#### Check your directories. 

Rosetta will not create directories if they do not already exist. If you're outputting into a directory, check that the directory exists before Rosetta is started.

#### Watch out for shell expansions (particularly "~").

Certain things like wild cards and the tilde home directory shortcuts are handled by the shell, not by Rosetta. Passing them directly to Rosetta, say in an options file, will not work as Rosetta does not know how to expand them. If Rosetta prints a "cannot find file" with a tilde or wild card character in the filename, you will need to expand those characters to the full path manually.

## Steps to working around Rosetta bugs.

Rosetta is not perfect. While Rosetta has been tested to work under a number of conditions, there are a number of known and unknown bugs in Rosetta. The following are techniques to work around the bugs in Rosetta.

#### Check the assumptions the protocol makes.

Most of the bugs in Rosetta are related to the implicit assumptions the protocol makes about the systems it works on. For example, a docking protocol might assume that a pose only has two chains, or a structure prediction protocol assumes that a structure doesn't have any non-protein residues.

Take a close look at the documentation and examples for the protocol you're using. How do the examples differ from the system you're using? 

Relevant points of conflict include (but are not limited to):
* Number of residues
* Number of chains
* Chain labeling (A/B/C)
* Presence and number of ligands
* Presence of DNA or RNA
* Symmetric/asymmetric systems
* Membrane vs. non-membrane systems
* Additional constraints or score types

The cause of your error may be related to using a type of system the protocol wasn't tested with. This doesn't mean that the protocol can't be run with your system (although it might). It just means that you may need to experiment heavily with the parameters you use to determine what changes need to be made to accommodate your system. You may also wish to post a question to <https://www.rosettacommons.org/forum> to see if people there can help.

#### Examine the traceback.

Often the exact error message that is printed is obscure. By looking at the traceback that is printed by Rosetta and the path through the code which resulted in them, you can gain insight into what is wrong.

For example, if the functions which yielded the error involve "silentfile_reader" or the like, there can be an issue with reading in a silent file.

## Common error messages and how to address them

#### ERROR: Value of inactive option accessed:

The program is expecting you to have passed an option, which wasn't present in the command line or options file. Add the listed option to the command line with the appropriate value for your system.

#### Assertion Error

These are put in by developers for developers. They're put in under the assumption that they should never be encountered during production runs. Normally they mean that one of the assumptions the protocol makes has been violated.

Keep in mind that the test which is printed is the test which has *failed*. For example, `ERROR: 0 < seqpos` means that seqpos was **not** greater than zero.

#### Segfault

Segmentation faults (segfaults) are one of the hardest errors to debug. They're most often caused by a Rosetta developer assuming something about your system that they shouldn't have. (e.g. that the protein will always be a single chain, that you don't have any disulfides in the protein, or ) 

Do check that all your inputs are correct and that there aren't any obvious errors in your configuration. Also, the extra error checking in debug mode (e.g. relax.linuxgccdebug) can often change a segfault into an assertion error. Often though, figuring out the cause of a segfault requires running Rosetta under a debugger and developer attention.

Take heart, though. Ideally, Rosetta should never result in a segfault. At the very least the developer should have done error checking and printed out an interpretable error message. If you encounter a segfault, please submit a bug report to either the Rosetta bug tracker <https://bugs.rosettacommons.org> or to the Rosetta forums <https://www.rosettacommons.org/forum>.


##See Also

* [[Running Rosetta with options]]
* [[MPI]]: Information about running Rosetta in MPI mode
* [[Troubleshooting Rosetta development|Common errors]]