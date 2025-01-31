# RosettaEvolutionaryLigand (REvoLd)

# Purpose

RosettaEvolutionaryLigand (REvoLd) is an evolutionary algorithm to efficiently sample small molecules from fragment-based combinatorial make-on-demand libraries like Enamine REAL. It has been designed to optimize a normalized fitness score based on RosettaLigand, but can be used with any RosettaScript. Within 24 hours it can bring you from knowing nothing about potential ligands to a list of promising compounds. All you need is an input structure as a target, the combinatorial library definition and some idea about where the binding site is.

REvoLd is typically run multiple times with independent starts to sample the chemical space better. Each run finds different low-energy binders. A single run samples between 1,000 and 4,000 ligands. Depending on your available hardware and time, I suggest 10 to 20 runs.

# Reference

[[Preprint paper|https://arxiv.org/abs/2404.17329]]

# Input

REvoLd requires a single protein structure as target. Additionally, you need the definition of the combinatorial space to sample from. This requires two files, one defining reactions and one defining reagents (or fragments and rules how to link them). They can be obtained under a NDA from vendors like Enamine or from any other source including self made. The definition consists of two white-space separated files with header lines including the following fields:

1. reactions: reaction_id (a name or number to identify the reaction), components (number of fragments participating in the reaction), Reaction (smarts string defining the reaction or fragment coupling)

2. reagents: SMILES (defining the reagent), synton_id (unique identifier for the reagent), synton# (specifiyng the position when applying the SMARTS reaction, [1,...,components]), reaction_id (matching identifier to link the reagent to a reaction)

# Command Line Options

# Example

# Results

# Algorithm Description

# vHTS Option

# Evolutionary Script

