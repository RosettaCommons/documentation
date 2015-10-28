#GitNoNoCommands

##Commands to avoid 

Git is incredibly powerful, giving you tools to do very, very complicated things. It is also very efficient.  Combined, git gives you the freedom to chop of limbs and to do so very quickly.  The worst thing you can do with git is try out new commands to see if they do what you're hoping to have happen.  We recommend only executing a git command if you're absolutely sure what will happen.  Below is a collection of git commands and flags that are particularly dangerous and ones which we recommend you never use.


###Git rebase

Git rebase is a command that is typically used for linearizing commit history. given the following revision history:

<pre>
A---B---C---D <master>
     \
      \_E___F <feature>
</pre>

the commands

<pre>
git checkout master
git rebase feature
</pre>

will result in the following commit history:

<pre>
A---B---C---D <master>
             \
              \_E___F <feature>
</pre>

There are circumstances when rebases are useful, however if a rebase is performed, every user who has cloned the repository must be aware of the rebase before they pull, or duplicated commits and inconsistent history can occur.  To avoid these problems, do not use git rebase or git pull --rebase with Rosetta git repositories.  Having a non-linear revision history is a feature of git, rather than something to be avoided. 

###--force

by default, any commit being pushed must be a child (and not a parent) of an existing commit. 

In other words, if the history of the remote repository is:

<pre>
A---B---C---D <master>
</pre>

you can push a commit E, like this:

<pre>
A---B---C---D---E <master>
</pre>

but you cannot push changes to commits A, B, or C.

The push  --force command disables the check that rejects changes to A, B and C, effectively allowing history to be rewritten. 

This flag is sometimes necessary if large amounts of unnecessary binary data are committed, however, it is a very dangerous command as it rewrites history, and thus requires that the entire community be aware of its use.  If you have reason to suspect that a push --force operation is necessary, email the list to confirm.  This command is very rarely necessary and can be avoided.

Note that
  git add --force
may also have undesirable effects such as adding otherwise ignored files. These files are usually ignored for a good reason.

###--squash

git merge --squash branch_name will merge branch_name into the currently checked out branch, and combine all of the commits in branch_name into a single "squashed" commit. This might appear desirable as it makes the commit history "neater".  However, git handles large numbers of small commits very well, and the test server only tests the merge commit to master, and none of the intermediate commits, so squashing commits is not necessary. If you do not squash your commits, debugging is easier, as the complete granular history of the development is maintained.  Additionally, there are circumstances in which applying squash to previously pushed commits can result in inconsistent history, and for this reason you should not use it with rosetta repositories. 

###filter-branch

git filter-branch is a powerful command for modifying the contents of previous commits.  it allows the commit history to be rewritten arbitrarily, files can be removed or moved, commits can be deleted or moved.  As a result, git filter-branch causes commit IDs to change, resulting in inconsistent history.  It is very useful when reorganizing a repository, but should not be used with RosettaCommons repositories. 

###replace

git replace is typically used for modifying the topology of a repository.  It allows one commit to be replaced by another commit, making it possible to add merge commits between commits which have been previously made. It can result in inconsistent history, and thus should not be used with RosettaCommons repositories.


##See Also
* [[GithubWorkflow]]: Typical Github workflow for Rosetta developers
* [[Git Sometimes Commands]]: Other useful Git commands
* [[Pull Requests]]: How to make a pull request through Github