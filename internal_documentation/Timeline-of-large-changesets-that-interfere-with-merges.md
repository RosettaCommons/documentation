This is meant to serve as a list of large changesets (and their timestamps) that are likely to interfere with merges.  In the case where you make a branch in January, there's a big change done across the codebase in March, and you want to merge back to master in April, you may end up with merge conflicts.  Often the "large changesets" are done semi-automatically (with ```sed``` or something), so this would be a good place to document what was done and approximately how to duplicate it on an independent branch to smooth out merging.

Add stuff at the top so that you can see the most recent stuff first.

[See also this list on the mediawiki-wiki.](https://wiki.rosettacommons.org/index.php/RecentChanges)

##ResidueType split.
* [GitHub PR](https://github.com/RosettaCommons/main/pull/3770) (fair amount of discussion - click to uncollapse comments to see all)
* Changes/merge conflicts need to be addressed manually. (Sorry, no sed line.)
* ResidueType class split into three classes: ResidueTypeBase, ResidueType and MutableResidueType.
* Anything that modifies ResidueType should now be using MutableResidueType instead.
* The ResidueTypeSet and Pose (and most other things) will still be using the (non-modifiable) ResidueType object.
* Most non-modifying usage of ResidueType is the same. Except:
    * the VD/ED accessors are no longer present on ResidueType, use name or index access instead
    * the Atom and Bond objects are no available through ResidueType. Access data directly on ResidueType instead
        * e.g. `residue_type.atom(ii).ideal_xyz()` -> `residue_type.ideal_xyz(ii)`


##core::graph to utility::graph
* [github {huge changeset, don't click}](https://github.com/RosettaCommons/main/commit/7b5bf62fea4002c0f3e30412a459b69c95078bca?w=1)
* [test server](http://test.rosettacommons.org/revision?id=58908&branch=master)
* How to fix: ```sed -i "s/core::graph/utility::graph/g"``` as necessary?

##pose.total_residue() to pose.size()
* [github (huge changeset, don't click)](https://github.com/RosettaCommons/main/commit/dba6351aa665ff0d3eff950a670078170661bf31?w=1)
* [test server](http://test.rosettacommons.org/revision?id=58904&branch=master)
* sed, but you don't really have to, the old total_residue wasn't deprecated fully.  I guess the other accessor was?

##Cxx11 modernizations
* [[cxx11-merge]]