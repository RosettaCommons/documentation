#Reverting a Commit

Okay, so you made a mistake in merging your branch to master. Either you merged before it's ready, or you merged and things broke unexpectedly. What do you do now? Well, one way of handling it is to use "git revert" to remove your commit from master. 

If you used a pull request to merge your changes, simply go to the Github page for the closed pull request and find the "revert" button.

If you didn't use a pull request, or you only want to revert *part* of your merge, you can still do it manually. Here's an example of how to do it:

###Worked Example

We're going to be using git revert, but to do that, we'll need to know the SHA1 hashes of the commits. 56493 and 56494 are the test server identification numbers. We can go to  [[http://benchmark.graylab.jhu.edu/revisions]] to get the correspondence. So we either scroll down to find them, or we can go to `http://benchmark.graylab.jhu.edu/revision/master/<version_num>` to go directly to the commit. The SHA1 hash is listed in the "GitHub commit link". Note that we'll also need the mainline version for the version prior to the commit we're reverting.

<pre>
56494 - 199441208b2b2f2
56493 - 12a020b263aaafa
56492 - c4ba068409eef69
</pre>

(Note for git SHA1's you can shorten them as long as the shortened portion is unique in the repository.)

Now update the local repository:

<pre>
git checkout master
git pull
</pre>

Do a "git show" to make sure that your working directory is clean.

For safety, we'll do the reversion in a branch. As it's quick, we'll just do a local branch rather than the GitHub personal-tracked-branch

<pre>
git checkout -b kala_revert
</pre>

Now we revert. In git a revert is just a commit that reverses all the changes from a previous commit. Since we have multiple commits to revert, it's probably best to work backwards.

<pre>
git revert 199441208b2b2f2
</pre>

Note that this fails. The commit we're reverting is a merge, so we need to tell it which side of the merge is what we want to keep, and which side we want to revert. (Git treats each side of the merge more-or-less equivalently. It doesn't have a sense of "trunk" history)

<pre>
git help revert  
</pre>

This give a manual page for git revert. Reading it, we see that we need to supply the *parent* number of the parent we want to keep with the -m flag. Note that this is different from the SHA1 hash.

<pre>
git show 199441208b2b2f2
</pre>

This gives a summary of the commit. Note the line "Merge: d41f7cf 12a020b" at the top. This shows the merge parents. The previous mainline commit is 56493 or 12a020b263aaafa, which is the second number listed (remember SHA1s can be shortened), so it's the second parent.

<pre>
git revert 199441208b2b2f2 -m 2
</pre>

This does nothing. Why? Pull up a graphical representation of the commit tree

<pre>
gitk
</pre>

You can zoom to a particular commit by pasting the SHA1 hash into the SHA1 ID: field.

Looking at this, you can notice that there really isn't anything unique from this commit. It's a merge of two merges, each of which are merging the same two commits.  (both 12a020b263 and d41f7cf89348307 merge 5373993a3 and c4ba068409ee)

Okay, so reverting 56494 - 199441208b2b2f2 is effectively a no-op. Let's go on to the next commit. It's also a merge commit, so we need the parent again.

<pre>
git show 12a020b263aaafa # c4ba068 is parent 2
git revert 12a020b263aaafa -m 2

error: could not revert 12a020b... # [ONE LINE DESCRIPTION OF CHANGE]
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
</pre>

Oops. This give merge conflicts. This means that something being reverted also changed in commits since. Let's see what's changed.

<pre>
git status
</pre>

It looks like a problem with src/protocols/scoring/methods/pcsTs2/PseudocontactShiftTensor.hh: "deleted by them"

Let's look at what the differences between things are.

Changes from the commit we're reverting and the current master:

<pre>
git diff 12a020b263aaafa..origin/master -- src/protocols/scoring/methods/pcsTs2/PseudocontactShiftTensor.hh
</pre>

Changes which we're reverting (difference from the mainline parent and the commit):

<pre>
git diff c4ba068409ee..12a020b263aaafa -- src/protocols/scoring/methods/pcsTs2/PseudocontactShiftTensor.hh
</pre>

It looks like the commit we're reverting added the file, but minor edits were made since. We don't care about those, so we just delete the file (reversing the changes made by the commit we're reverting)

<pre>
git rm src/protocols/scoring/methods/pcsTs2/PseudocontactShiftTensor.hh
</pre>

While I'm at it, I should run update_options.sh to make sure everything's okay with the option system, as the option system issue is the main reason why we're doing the revert.

Do a "git status" to check things. And add the option updated files with "git add"

Now commit the revert.

<pre>
git commit
</pre>

This should pull up an editor window  (vim for me) which allows me to edit a clear, descriptive commit message.

Now I recompile, to make sure the revert didn't break anything. Running the integration tests and the unit tests at this point is also a very good thing to do as well.

It doesn't look like anything is broken, but if there were issues, I could always add additional commits. (For example, if there wasn't a merge conflict, I would have needed a second commit for the options updating.)

Okay, now I'm ready to submit the changes to GitHub.

<pre>
git checkout master
git pull
git merge kala_revert
</pre>

This should present an editor window which allows me to add a good, descriptive commit message. I want to spend time on this message, as it's the one that's going to be going out to the list, and will be what's shown for my changes on the test server.

As I had already made a good commit message, there's a shortcut to avoid writing it out again. Once I've saved a short, descriptive version, I can amend the commit message (since I haven't pushed it yet). And with the -C option, I can copy the commit message from a different commit (given by SHA1 or branch name).

<pre>
git commit --amend -C kala_revert
</pre>

Okay, before I push, I want to check my commit message.

<pre>
git log
</pre>

That very first message will be what will be shown regarding my changes when I push them. That's what's sent out to the list, and that's what's shown on the test server. I need to make sure I'm good with it. I notice I should add more information, so I amend the commit.

<pre>
git commit --amend
git log
</pre>

Once last "git status" to check that I didn't forget anything, and now I can do a "git push". I can then go to [[https://github.com/RosettaCommons/main]] to see if I was successful, and to check everything on the server is the way I want. It is, so I just wait for the test server to tell me if anything broke.

##Undoing a Revert

It turns out, that reinstating the changes you just reverted can be trickier than reverting them in the first place. See [[this document|https://www.kernel.org/pub/software/scm/git/docs/howto/revert-a-faulty-merge.txt]] for details.

A revert in git doesn't actually remove the reverted commits from the source history. Instead, it makes a new commit that simply reverses the changes that those commits make. The upshot is that if you have a branch based off one of those reverted commits, and try to re-merge them in, git thinks they've already been merged, and skips over them.

So to undo a revert, don't re-merge your changes. Instead, you'll want to revert the revert commit. 

If you did the revert through Github, you can simply use the revert button on for the pull request of the revert.

If you did the revert manually, the likely way you want to handle it is to make a clean branch off of master. In this branch, revert the revert you just made. Then also merge the branch which is based off of the old commits. Fix up the branch so that it compiles and the tests pass, and things look like they should. Then merge that branch back into master, check and push as normal.

You only have to revert the revert once, so if you have multiple such branches, the first gets the revert of the revert, but the subsequent ones can simply be merged like normal.

##See Also

* [[Git Sometimes Commands]]
* [[GithubWorkflow]]
* [[GitNoNoCommands]]