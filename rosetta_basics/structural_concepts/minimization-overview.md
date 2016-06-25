#Minimization overview and concepts

Metadata
========
This document was written 3 Oct 2007 by Ian W. Davis and last updated 22 December 2015 by Vikram K. Mulligan.

Information was provided by Jim Havranek.

An introductory tutorial on minimization can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/minimization/minimization).

The relevant code is in core::optimization, especially the core::optimization::Minimizer class. 

Flavors of minimization in Rosetta
==================================

All minimization algorithms choose a vector as the descent direction, determine a step along that vector, then choose a new direction and repeat. Different ways of doing those things leads to differing efficiency, in terms of function evaluations and memory.

"linmin" is a **single step** steepest-descent algorithm with an exact line search. That is, the descent direction is the gradient of the energy function (vector of partial first derivatives), and the step is to the true (local) minimum of the function along that line.

Repeated invocations of linmin generally converge very slowly as compared to methods that approximate the second-derivative (Hessian) matrix that are described below.  For this reason, iterated invocation of linmin is not recommended for production runs.  However, for benchmarking or testing purposes, "linmin_iterated" invokes linmin repeatedly, re-calculating the gradient vector after each line search.  This is therefore a relatively pure steepest-descent algorithm, and it can serve as a fallback in cases in which Hessian approximations work poorly.  The "linmin_iterated" algorithm need only be called once, and will iterate internally.

Conjugate gradient minimization accumulates a small amount of information from prior steps, modifying the search direction to perform (somewhat) better than a pure steepest-descent algorithm. Rosetta++ included an implementation of FRPR (Fletcher-Reeves-Polak-Ribiere), but it hasn't been ported to Rosetta3 because no one used it.

Quasi-Newton methods accumulate more information from many iterations of the gradient of the energy function to approximate the second-derivative (Hessian) matrix (or, more accurately, its inverse). This information is used to modify the descent direction (after the first step) so that its no longer necessarily straight down the gradient, but the minimization converges (much) faster. In Rosetta, this is the "dfpmin" family of functions. Although named for the DFP (Davidon-Fletcher-Powell) update method, it in fact uses the BFGS (Broyden-Fletcher-Goldfarb-Shanno) update method, which is widely regarded as better. A limited-memory variant (L-BFGS) has also been recently added to Rosetta. (Previously it was not included as the cost of keeping the full N x N Hessian matrix (N = number of DOFs) in memory appeared not to be prohibitive, and Paul Tseng found the limited memory version gave worse solutions. The more recent implementation on modern machines improves performance, especially for Cartesian minimization.)

Unlike linmin, all the dfpmin/lbfgs algorithms are **multi step** algorithms, so they need only be called once to reach the (local) minimum of a function (and will iterate internally).

"dfpmin" uses an exact line search, and Jim says it requires \~10 function evaluations per line search.

"dfpmin_armijo" uses an inexact line search, where the step along the search direction only needs to improve the energy by a certain amount, and also make the gradient a certain amount flatter (but not necessarily reach the minimum). This ends up being significantly more efficient, as once it gets going only 2-3 function evaluations are needed per line search, and approximately the same number of line searches are needed as for the exact dfpmin.

"dfpmin_armijo_nonmonotone" uses an even less exact line search along the descent direction, so that the step need only be better than one of the last few points visited. This allows temporary *increases* in energy, so that the search may escape shallow local minima and flat basins. Jim estimates this is several times more efficient than the exact dfpmin.

"dfpmin_strong_wolfe" uses the More-Thuente line minimization algorithm that enforces both the Armijo and Wolfe conditions. This gives a better parabolic approximation to a minimum and can run a little faster than armijo.

"lbfgs_armijo" uses the L-BFGS minimizer implementation with the Armijo inexact line search conditions. 

"lbfgs_armijo_nonmonotone" uses the L-BFGS minimizer implementation with the even more inexact line search conditions.

"lbfgs_strong_wolfe" uses the L-BFGS minimizer implementation with the Wolfe conditions.

Recommendations
==============

Current recommendations are to use the lbfgs_armijo_nonmonotone minimizer, or one of the other lbfgs variants (c.f. Andrew Leaver-Fey). Previous recommendations were to use dfpmin\_strong\_wolfe or dfpmin\_armijo\_nonmonotone (c.f. Jim). The current implementation of L-BFGS appears to be equivalent to dfpmin in results, with improvements in runtime/memory performance.

Use of lbfgs-based minimizers is *highly* recommended for minimization in Cartesian coordinate space or for minimization with flexible bond lengths and angles, as the dfpmin variants give exceedingly bad performance. (A warning message will be printed if a poor choice of minimizer is given.)

The meaning of tolerance
========================

Rosetta has at least two kinds of "tolerance" for function minimization, "regular" (for lack of a better name) tolerance and absolute tolerance. "Regular" tolerance is *fractional* tolerance for the *value* of the function being minimized; i.e. a tolerance of 1e-2 means the minimum function value found will be within 1% of the true minimum value. Absolute tolerance is specified without regard to the current function value; i.e. an absolute tolerance of 1e-2 means that the minimum function value found will be equal to the actual minimum plus or minus 1e-2, period.

Minimizers use fractional tolerance by default. To invoke the use of the absolute tolerance variants, append "\_atol" to the end of the minimizer type. For example, to use the absolute tolerance version of the "lbfgs_armijo_nonmonotone" minimizer, use the minimizer type "lbfgs_armijo_nonmonotone_atol" instead.

[This discussion applies only to linmin_iterated, dfpmin, lbfgs and their variants. Other minimizers may have different notions of tolerance.]
