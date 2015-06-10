Comparing Structures
====================

An essay by Charlie Strauss

In the course of using rosetta, often one wants to compare sets of
structures. There are different use cases that require different
strategies. Considerations include the following.

Are you comparing Experimental structures or model structures? Methods
like DALI and CE that work well for comparing Experimental structure but
perform very poorly on low resolution model structures, probably because
certain protein characterisitics they look for like hydrogen bonding and
perfect SS types are absent in model structures. The best choice for
model to experimental structure overlap is [Mammoth](http://dx.doi.org/10.1110/ps.0215902) (aka Mastodon).

Are you comparing models that all have the same sequence? Here there is
no alignment ambiguity. For structures that are close in RMSD, then RMSD
is a fairly good measure of simmilarity. When structures are poorly
overlapped large values of RMSD fail to be useful as a rank ordering of
simmilarity. A banded Distance Matrix Error works slightly better when
the RMSD is large. When the alignment is known, an even more robust
measure over large and small ranges is MaxSub, which looks for the
largest well-overlapped subset of the protein. Rosetta has a built in
mode that uses Mammoths version of the MaxSuB comparison measure. This
does not do the full mammoth procedure of attempting to discover the
alignment, but simply the MaxSub portion of Mammoth.

Are you comparing Models at high resolution? RMSD is pretty darn good as
a general measure.

Are you comparing models to structures of much different lengths?
Mammoth's E-value does a primitive but effective normalization of the
ratio of the isve of the maximal overlapped region to the length of the
proteins being compared. This number is fairly robust against protein
size variations, but hey nothing is perfect.

Do you want to know how to compare RMSD values in comparisons taken in
proteins of different lengths? For example, is overapping a two 30
residue proteins to an rmsd of 4 angstroms, more or less statistically
significant than overlapping two proteins of length 100 to 7 angstroms
resolution? There are a variety of ways to try to normalize these.
Skolnick has some useful suggestions. Mammoth has it's own built in. But
an extremely easy to grasp, quick and dirty measure is the RMS100
([http://www.proteinscience.org/cgi/content/full/10/7/1470](http://www.proteinscience.org/cgi/content/full/10/7/1470)).
This renormalizes any RSMD to the the value it would have if the
proteins were of length 100 and at the same level of statistical
significance. I reccommend using this before trying anything fancy.

What does it mean to compare two structures. Nearly everyone
misappreciates the subtely of this issue. The starting place for
thinking about this is that one wants to see how well one can overlap
two different structures. Usually this boils down to finding the maximal
number of superimposable residues at some level of accuracy.
Superimposable usually means the RMSD is less than some value, although
some methods like DALI use other measures that allow distortion. There
is an obvious dilemma over which is better, a longer overlap at low
resolution or shorter overlaped region at higher resolution. There's
also dillema's about whether long gaps should be allowed (which
increases random overlaps) or if local accuracy (SS structure) should be
weighted over global accuracy. There is the fact that when the alignment
is unknown, the problem is NP hard and one may not be able to solve for
the global optimim alignment for a given matching criteria. Finally,
there is problem of how to compare measures for proteins of different
lengths.

When the alignment is Known: besides RMSD and DME, the next more
sophisticated and widely used method is MaxSub. GDT is another measure
that finesses the tradeoff between high-resolution/large-numbers-of
residues, by using several different resolutions, computing the maximum
number of residues overlapped at each, and then forming a weighted
average these to a single number. When the alignment is unknown, some
popular methods are DALI, CE, SAL, and Mammoth. These try to discover
the optimal overlap.

 A key insight that seems to have eluded nearly all methods, aside from
Mammoth, is that finding the maximal superposition is not really the
question you sought to answer. What you really wanted to know is if two
proteins were structurally simmilar and there's more to that than
maximal superposition. In particular you dont really want to know the
number of overlapped residues since that varies according to the
criteira: more is not better. What matters is the statistical
significance of the result. It's very very frequently the case that one
algorithm will find abetter superposition than another on any given
protein. SAL for example tends to find the most of any overall but it
gets beat by others on some protiens. But what you really want is
something whose statistical significance score has low variance. That is
it is not useful to have a method that reports some rankable scalar
quality score for an overlap if the correlation between that score and
the true human generated comaprison is poor or has high variance. When
it has high variance it means you can't just consider the top-match as
being the best but must go way deep in your list of ranked matches to
have high confidence in the result. Tests have show that Mammoth is far
more coorelated with human rankings than other methods even though it
often reports lower number of "overlappable" residues. It's critical to
undersand this, and this is why I am strongly biased towards the Mammoth
measure. However if pure overlap measures are your only goal I reccomend
SAL. SAL is also especially good for comparative modeling. DALI is
slightly better at comparing two experimental structures.

