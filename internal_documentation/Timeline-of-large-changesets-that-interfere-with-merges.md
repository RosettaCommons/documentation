This is meant to serve as a list of large changesets (and their timestamps) that are likely to interfere with merges.  In the case where you make a branch in January, there's a big change done across the codebase in March, and you want to merge back to master in April, you may end up with merge conflicts.  Often the "large changesets" are done semi-automatically (with ```sed``` or something), so this would be a good place to document what was done and approximately how to duplicate it on an independent branch to smooth out merging.

Add stuff at the top so that you can see the most recent stuff first.

##core::graph to utility::graph
*[github {huge changeset, don't click}](https://github.com/RosettaCommons/main/commit/7b5bf62fea4002c0f3e30412a459b69c95078bca?w=1)
*[test server](http://test.rosettacommons.org/revision?id=58908&branch=master)
*How to fix: ```sed -i "s/core::graph/utility::graph/g"``` as necessary?