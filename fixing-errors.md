# Fixing Errors

## How to address errors in Rosetta 

It happens even to experienced Rosetta developers. You set up a Rosetta run, hit run on you job, and ... the run fails. No output, no useful results, just a cryptic error message (if you're lucky). What do you do now?

## Steps to debugging your run.

Check your commandline.
- Any missing?

Check your input files.
- Are they correct?

Check your directories. 
- Do they exist?

Don't use tildes.
- Shell expansion.

## Steps to debugging Rosetta

Rosetta is not perfect

Check the assumptions the protocol makes.
- One chain/two chain/red chain/blue chain?
- Number of residues, etc.

Run under a debugger - advanced usage.

## Common error messages and how to address them

#### Assertion Error

These are put in by developers for developers. They're put in under the assumption that they should never be encountered during production runs. Normally they mean that one of the assumptions the protocol makes has been violated.

The sense of the check is inverted.

An error with an `assert( seqpos > 0 )` message means that seqpos is **not** greater than zero.

#### Segfault

Segmentation faults (segfaults) are one of the hardest errors to debug. They're most often caused by a Rosetta developer assuming something about your system that they shouldn't have. (e.g. that the protein will always be a single chain, that you don't have any disulfides in the protein, or ) 

Do check that all your inputs are correct and that there aren't any obvious errors in your configuration. Also, the extra error checking in debug mode (e.g. relax.linuxgccdebug) can often change a segfault into an assertion error. Often though, figuring out the cause of a segfault requires running Rosetta under a debugger and developer attention.

Take heart, though. Ideally, Rosetta should never result in a segfault. At the very least the developer should have done error checking and printed out an interpretable error message. If you encounter a segfault, please submit a bug report to either the Rosetta bug tracker <https://bugs.rosettacommons.org> or to the Rosetta forums <https://www.rosettacommons.org/forum>.
