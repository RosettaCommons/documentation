#PeptiDerive application

Metadata
========

Authors: Nir London, Barak Raveh, Dana Movshovitz-Attias, Yuval Sadan, Orly Marcu, Ora Schueler-Furman

The documentation was last updated on Feb 23, 2015, by Yuval Sadan. Questions about this documentation should be directed to Ora Furman: (oraf@ekmd.huji.ac.il).

Code and Demo
=============

The PeptiDerive app may be found under `apps/public/analysis/PeptideDeriver.cc`. It uses JD2 to invoke the `PeptideDeriverFilter` class, defined in `protocols/analysis/PeptideDeriverFilter.hh`.

A unit test for this application is in `test/protocols/analysis/PeptideDeriverFilterTests.cxxtest.hh`.

PeptiDerive also comes as a [[RosettaScripts Filter flavor|Filters RosettaScripts#PeptideDeriver]].

References
==========

Original work published as:

London N., Raveh B., Movshovitz-Attias D., Schueler-Furman O. (2010) "Can self-inhibitory peptides be derived from the interfaces of globular protein-protein interactions?", Proteins. V 78, pp 3140–9.

Paper about ROSIE based server:

Sedan Y., Marcu O., Lyskov S., Schueler-Furman O. (2016) "Peptiderive server: derive peptide inhibitors from protein–protein interactions", NAR V 44(Web Server issue), pp W536–W541.


Purpose
=======

PeptiDerive is a simple application that derives from a given interface the linear stretch that contributes most of the binding energy (approximated as the score over the interface).


We have used this protocol in the past to evaluate the fraction of interfaces that could be inhibited by a peptide or a peptidomimetic. We found on two representative benchmarks that this amounts to around 50% of the interactions. Further simulations with FlexPepDock of some of the derived peptides indicate that they will assume a similar conformation when cut out to the conformation they adopt within the full protein. This does not really look at conformational entropy of course, it just evaluates the local stability (London, Raveh, Movshovitz-Attias & Schueler-Furman (2010). Can self-inhibitory peptides be derived from the interfaces of globular protein-protein interactions? Proteins, 78:314. doi:10.1002/prot.22785).
Also, for a set of solved structures of structures of small molecules that inhibit protein interactions in complex with their partner indicates that these target the same sites as identified by this simple protocol (the molecules come from in vitro screens, not drug design of course) (London, Raveh & Schueler-Furman (2013). Druggable protein–protein interactions—from hot spots to hot segments. Current Opinion in Chemical Biology. doi:10.1016/j.cbpa.2013.10.011)


Algorithm
=========

PeptiDerive uses a simple protocol for the selection and evaluation of protein-protein interface-derived peptides. Given the complex structure of an interaction between proteins A and B, a short minimization of the structure is performed using the Rosetta energy function to remove local clashes without changing the structure significantly. Then, a sliding window of amino acids, the length of which is determined by the user (e.g. a window of 10 amino acids), slides along the protein chain. Each fragment of the determined length is extracted from its protein context, termini charges are added, and then the interaction energy of this peptide with the other partner is estimated. The peptide that contributes the best interaction energy is selected to represent this interaction (the peptide can be located in either of the two protein partners).

A coarse estimate of binding energy is provided by evaluating the interface energy, defined as the energy of a peptide in complex with the protein partner compared with the energy of peptide and protein alone. The binding energy for a peptide derived from protein A to receptor protein B is calculated as

*<center>&Delta;&Delta;G<sub>A<sub>pep</sub>B</sub> = &Delta;G<sub>A<sub>pep</sub>B</sub> - &Delta;G<sub>A<sub>pep</sub></sub> - &Delta;G<sub>B</sub></center>*

The peptide that contributes the best *&Delta;&Delta;G<sub>A<sub>pep</sub>B</sub>* value is selected to represent this interaction. The relative contribution of this peptide to the total binding energy is obtained by comparing its binding energy to the estimated binding energy of the full protein complex,

*<center>&Delta;&Delta;G<sub>AB</sub> = &Delta;G<sub>AB</sub> - &Delta;G<sub>A</sub> - &Delta;G<sub>B</sub></center>*

*<center>contribution to binding energy &prop; &Delta;&Delta;G<sub>A<sub>pep</sub>B</sub> / &Delta;&Delta;G<sub>AB</sub></center>*

This rough estimate is used for filtering of candidate inhibitory peptides.

*Note: documentation for filtering and modeling cyclic peptides is pending.*

Limitations
===========

*Documentation pending.*

Input Files
===========

The program expects a multi-chain PDB file.

To avoid parsing problems, make sure your PDB file is made up of only `ATOM` and `TER` records, i.e. no heteroatoms (HETATM) are included, and that the occupancy column is filled (no double conformations or 0.00 occupancy).

To use phosphorylated residues, make sure that:

  * they are named correctly (i.e. `TYR`/`SER`/`THR` and not `PTR`/`SEP`)
  * modified residue coordinates (as well as the phosphates) are included as `ATOM` records (rather than `HETATM`)

Below you can find an example as to how a phospho-serine should look like:

    ATOM   5776  N   SER B  10     -19.024  43.939 120.740  1.00  0.00
    ATOM   5777  CA  SER B  10     -20.442  43.615 120.653  1.00  0.00
    ATOM   5778  C   SER B  10     -20.869  42.699 121.792  1.00  0.00
    ATOM   5779  O   SER B  10     -20.125  41.804 122.194  1.00  0.00
    ATOM   5780  CB  SER B  10     -20.750  42.972 119.314  1.00  0.00
    ATOM   5781  OG  SER B  10     -22.089  42.569 119.219  1.00  0.00
    ATOM   5782  P   SER B  10     -22.461  41.858 117.817  1.00  0.00
    ATOM   5783  O1P SER B  10     -24.008  41.465 117.873  1.00  0.00
    ATOM   5784  O2P SER B  10     -21.536  40.564 117.675  1.00  0.00
    ATOM   5785  O3P SER B  10     -22.170  42.912 116.653  1.00  0.00


Options
=======

Note: this section was added for convenience, but may be out-dated. It's best to also look at the [[full options list]], to make sure you're looking at the most updated listing of options.

| Option name         | Type           | Description                                                  | Default |
|---------------------|----------------|--------------------------------------------------------------|---------|
| `pep_lengths`       | list of numbers | Length(s) of derived peptides                                | 10      |
| `skip_zero_isc`     | true/false     | Makes derivation go faster by skipping peptides with 0 interface score | true |
| `dump_peptide_pose` | true/false     | Output pose with peptide cut out (best one for each chain pair) | false |
| `dump_cyclic_poses` | true/false     | Output each cyclic peptide pose (those that are modeled; which is determined by -optimize_cyclic_threshold) | false |
| `dump_prepared_pose` | true/false    | Output each receptor-partner pose as PeptiDerive sees it, i.e. after preparation (minimization and disulfide detection) | false |
| `dump_report_file`  | true/false     | Send PeptideDeriver output to a file (<input_name>.peptiderive.txt) | true |
| `restrict_receptors_to_chains` | list of characters | Only use chains listed here as receptors. When empty, consider all chains. | empty  |
| `restrict_partners_to_chains` | list of characters | Only use chains listed here as partners. When empty, consider all chains. For each receptor-partner pair, a peptide is derived from the partner. | empty |
| `do_minimize` | true/false | Perform minimization before everything. | true |
| `optimize_cyclic_threshold` | real number | Value of peptide interface score percent of total isc from which to optimize cyclic peptide | 0.35 |
| `report_format`             | string      | The format of the report. Either `basic` (easily parsable format) or `markdown` (pretty, readable, but verbose format). | `markdown` |

Tips
====

*Documentation pending*

Expected Outputs
================

Depending on the value of the `report_format` option, PeptiDerive outputs in one of two formats

Markdown
--------

Markdown output is readable and self-explanatory. This is what we recommend for single-structure (or several-structure) runs.

Note that numbering of residues is sequential, as opposed to author numbering. For the *Disulfide info* column contents format, see the *Basic* format description for `disulfide_info`.


Basic
-----

The `basic` report format is stripped down of almost all descriptive elements, but it's easily parsable and is currently what we use for bulk runs.

The output is in the following format:

```
> chain_pair: receptor= [receptor_chain_id] partner= [partner_chain_id] total_isc= [total_interface_score]
>> peptide_length: [sliding_window_length]
[entry_type] [seq_res_num] [peptide_interface_score] [disulfide_info]
```

  - `total_interface_score` is the *&Delta;&Delta;G<sub>AB</sub>* of the complex (see [[Algorithm|PeptiDerive#Algorithm]], above).
  - `entry_type` is

    - `0` for a sliding window entry (one per residue, except for the last *N* ones, where *N* is the sliding window size)
    - `1` to signify the best (linear) scoring peptide for the current chain pair and sliding window length
    - `2` to signify the best cyclic scoring peptide (ditto)

  - `seq_res_num` is the sequential residue numbers for this chain (as opposed to author numbering)
  - `peptide_interface_score` is the *&Delta;&Delta;G<sub>A<sub>pep</sub>B</sub>*
  - `disulfide_info` is a string describing the residues for a putative cyclic peptide, if one was determined to be relevant, and - if it was modeled (depending on whether the relative linear score is above the `optimize_cyclic_threshold`) - the interface score of the cyclic peptide. *Better documentation for this is pending.*

In the future, we're hoping to create a `FeatureReporter` to allow aggregation of output to a database.

##See Also

* [[Analysis applications | analysis-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
