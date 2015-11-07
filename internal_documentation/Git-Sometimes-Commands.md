#Git Sometimes Commands

##Help

In addition to searching the web with Google and the like, git comes with several help commands

* *git <command> -h* : Give a short help overview of a given command
* *git help <command>* : Give an in depth discussion of a given command (equivalent to a man page)

##Deleting a branch
If your branch is fully merged and complete and you're done with it, you can delete it:
```
 git branch -d smlewis/rosetta_scales
 git push origin --delete smlewis/rosetta_scales
```

The first commit deletes it locally, and the second deletes it remotely. The first will fail if you have unmerged changes.

##Reverting commits

Occasionally a faulty commit will be pushed to the GitHub repository.  Git allows commits to be deleted, which is perfectly fine when you are working in your personal repository with commits that have not been shared.  However, after the commits have been shared (pushed), deleting a commit results in repositories having divergent history.  This is where git revert comes in.  Git revert can revert a revision, multiple revisions or even a range of revisions.

Reverting a revert is a bit more tricky, as git revert doesn't actually remove the reverted commits from the source history. Instead, it makes a new commit that simply reverses the changes that those commits make. This means that to git, the original changes have already been merged, and "remerging" the changes doesn't reinstate the changes. Instead, you normally have to revert the revert. See [[this document (external link)|https://www.kernel.org/pub/software/scm/git/docs/howto/revert-a-faulty-merge.txt ]] for more details.

####Examples
<pre>git revert SHA1</pre>
Revert the changes in the revision with the ID SHA1

<pre>git revert HEAD~3</pre>
Revert the fourth most recent revision in your branch.

<pre>git revert first-revision..last-revision</pre>
Revert the changes made by each revision in the range including the specified revisions.

When reverting multiple revisions the changes will be saved as a single new revision in git's history. More information can be found [[here (external link)|http://git-scm.com/docs/git-revert]].

####Longer Example

[[Reverting a commit - a case study (media wiki)|https://wiki.rosettacommons.org/index.php/Reverting_a_commit_-_a_case_study]]

##More useful git commands that can come in handy

(Note on what goes in here.  Try to make each section comprehensive such that it contains a description of what the command does as well as describing a few of the scenarios (maybe in a useful scenarios bulleted list -- people can add to it) for when you might want to use this command.)

Each of these commands is fully documented with a man page.  For example, to view the documentation for git log: 
<code>man git-log</code>.  The descriptions below are brief summaries rather than complete documentation. 

###git log
Git log displays a chronological list of the commits in the current branch, with the most recent commits first. 
```
   git log
```
shows commitID, author information, date, and the commit message. 

###git diff

Git diff shows the difference between two versions of a file in the repository.
```
  git diff
```
shows the differences between the current modifications to the working directory and HEAD  
```  
  git diff <filename>
```     
shows the differences between the specified filename in the working directory and HEAD
```     
  git diff <branchname>
```  
shows the differences between the current modifications to the working directory and branchname
```
   git diff <commit> <commit>
```      
shows the differences between two specified commit ids

###git reset

git reset is used to reset the contents of the current working directory to a given revision, and also reset HEAD to that revision.  it can be used to effectively "undo" commits
```
   git reset --soft
```
reset the last commit made to this branch, stage changes. 
```
   git reset --mixed
```
reset the last commit made to this branch, unstage changes. 
```
   git reset --hard
```
reset the last commit made to this branch, discard changes
```
   git reset --hard commit_id
```
reset to commit_id, discard all commits after commit_id.

###git blame

git blame is similar to svn blame, it can be used to determine the last commit which modified each line of a file. 
```
   git blame <filename>
```

###git init

git init is used to create a NEW empty repository.  When run, git init will create a git repository in the current working directory. Checked out repositories from github are already repositories, and they do not need to use this command.
```
   git init
```
##Changing a commit log for a commit you've already made

`git commit --amend` will allow you to modify the commit message of the most recent commit.  Doing this will change history, so you must run it prior to pushing your commit. 
```
   git commit --amend
```
###git bisect

git bisect is a tool for identifying the commit responsible for introducing some error into the code base.   To begin, check out a commit in which the error you are interested in exists, and run
```
   git bisect start
```
to begin bisecting.  Now, mark the current commit as bad
```
   git bisect bad
```
and then mark the last known commit in which the error does not exist
```
   git bisect good commit_id
```
There must be a path between the marked good and bad commits.  

As soon as you do this, git will begin performing a binary search.  It will check out some commit between the bad and good commits.  When it has done this, perform whatever tests you need, and mark the commit bad or good.  After several iterations of this process, you will be left with the first bad commit. 

When you are done and want to clean up:
```
   git bisect reset
```
Git bisect has a lot of useful functionality, [[see here (external link)|https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html]] for complete documentation. 

###git cherry-pick

git cherry-pick is used to copy commits.  
```
   git cherry-pick commit_id
```
will copy the contents of commit_id to a new commit on the current branch.  The copied commit will have a new commit_id, and the original is left unchanged. 
```
  git cherry-pick commit_id_1..commit_id_2
```
will copy a range of commits. 

cherry-picked commits are applied similarly to diff patches, with most of the caveats associated with applying patches.  If conflicts exist, you will be prompted to resolve the manually. 

###git stash

git stash is used to temporarily remove the current set of changes from a working directory.  This is useful if you begin making changes and realize you want to be making them in a different branch.  A typical use of git stash is:
```
   git stash
   git checkout correct_branch
   git stash pop
```
Which will remove the changes, change branches and then place the changes back in the working directory.  
```
   git stash list 
```
will list the currently stored stashes, multiple stashes can be stored at once. 

###git diff-tree

git diff-tree outputs the objects in the repository modified by a specific git commit.    it is run like
```
   git diff-tree commit_id
```
and outputs a series of lines like
```
   :100644 100644 85b4ffc6fa9206d6a066b961ba82d3e548f2a2d0 2f1140edf342bbe06ea0ed45a319b04a18c88450 M	rosetta_source/src/pilot_apps.src.settings.all
```
where the fields are
```
   old_file_permissions new_file_permissions old_object_id new_object_id modification_type file_name
```
where modification type indicates addition, deletion, modification, etc. 

###git remote

a git repository can have multiple remotes.   to list the current remotes:
```
   git remote -v
```
to add a new remote 
```
   git remote add remote_name remote_path
```
to delete a remote
```
   git remote rm remote_name
```
###git merge-base

git merge-base shows the most recent common ancestor of two commits, for use in merging.  Can be used to determine when a branch was created
```
   git merge-base commit_1 commit_2
```

###git reflog

the reflog is a log of previous positions of HEAD.  
```
   git reflog
```
will output a ist of the previous HEAD positions.  This is a useful command for recovering commits which were lost with git reset --hard or by deleting branches.  The git reflog is only kept for the past few days. 

###git gc

git gc performs garbage collection on the repository.  It packs objects by performing delta compression, removes duplicate objects, and purges un-needed objects and commits.  It is run automatically when the amount of unpacked data reaches certain thresholds and is ordinarily unecessary.  you can run it yourself by performing 
```
   git gc
```
###git diff-index

git diff-index is similar to git diff-tree, except it compares a given commit to the contents of the current index.  it is run like
```
   git diff-index commit_id
```
###git prune

git prune (or git prune remote origin ) will delete all of the local references to remote branches that have been deleted on github. 
```
   git remote prune origin
```
Detailed Explanation: When git downloads a branch (pull, fetch etc) it downloads all of the references to branches in that repository. When someone deletes a remote branch, even though the branch is gone, git still has the reference. 

Git prune origin will go through all of your local references and delete those that no longer exist on the remote on github. This is a safe operation as long as you are not using a branch that has been deleted from the remote. To see which references will be deleted, you can run: 
```
   git remote prune origin --dry-run
```
###git merge -X ours/theirs

`git merge -X theirs [sha-1/branch]` will merge the sha-1 or branch into the current branch.  In the case of theirs, if any conflicts arise it will take the whole file of the specified[sha-1/branch].  If ours is used, it will take our current branch.  This can be incredibly useful if you have already merged in another branch, and want to apply that merge commit to the current branch - for example if you have multiple sub-branches of the same project.  There are a multitude of other uses for this as well.  Example of merging a particular commit from another branch into the current branch, taking the files of the other commit:
```
    git merge -X theirs other_branch_commit_sha-1
```

##See Also

* [[GithubWorkflow]]
* [[GitNoNoCommands]]
* [[Pull Requests]]
* [[Development Documentation]]