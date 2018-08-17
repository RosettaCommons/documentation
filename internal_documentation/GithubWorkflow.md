#Github Workflow for Rosetta


[[_TOC_]]

##Executive Summary

We use a common github repository, [[RosettaCommons|http://github.com/rosettacommons/main]], as our primary development repository. 
Within this repo we utilize the [[github flow|https://guides.github.com/introduction/flow/index.html]] branching model for collaborative development, and expect all developers to contribute to the project via topic branches and pull requests. 
New developers should join the [[RosettaCommons|https://github.com/rosettacommons]] organization and seek out help via the [[rosetta-devel|https://groups.google.com/forum/#!forum/rosetta-devel]] mailing list for general questions, or pull-request discussions for questions related to coding issues.

To be clear on terms: GIT is a distributed version control system that you install on your computer to manage the Rosetta code you are developing/compiling/using locally.  GITHUB is a website that offers a friendly interface to add communication features around the git codebase (so we can strive together to improve it) and tools to pull together the code, the test server, etc. 


##Workflow for using git

(This section is almost entirely things you do on your computer, most of which will work offline (except for the occasional git command that talks to the server)).

###What is git?

Git is a widely used, fast, flexible and robust distributed source control management (SCM) system. 
Unlike centralized SCM solutions like subversion, each working copy of the code is a full-fledged repository. 
Each repository contains the complete history of the project, including branches from the main development line, which is typically called "master".  
The revision history in a repository is represented as a graph -- specifically, as a directed acyclic graph (DAG).  When a revision is committed to a repository, it is saved as a node in a with an edge indicating the previous revision.  A "branch" is a named revision at the terminal vertex of a DAG; the branch name always references the most recent revision in a branch.  Non-terminal revisions can be named using [[tags|http://git-scm.com/book/en/Git-Basics-Tagging]].  Each branch can be traced back to the root vertex and thus each branch can be thought of as a possible, reasonable trace through the revision history.  An interesting effect of this design is that all paths through the history (i.e. all branches) are equally valid. 
The "master" branch, by convention, is the one we think of as the official branch, what we would call "trunk" in SVN.

A common metaphor used to describe the structure of a git repository is the hydra.  There are many heads (branches), but there is only one body (repository).  At any one time, only one branch can be "checked out."  The files in that branch can be examined and edited exactly as you would expect to edit them.  You'll make your modifications, you'll commit them to your checked-out branch, and then, if you check out another branch, all of the modifications you made to your first branch will disappear from the source tree. 
Now, if you are accustomed to developing Rosetta using subversion, you may have adopted the habit where each development task you're working on is done in a separate working copy checked out from `https://svn.rosettacommons.org/source/trunk/rosetta`. 
Each of these working copies represents a single revision and you typically develop in them and commit back to trunk when done (and not until you're done). 
In git, there is no need for separate copies of Rosetta for each of your development tasks. 
Instead, you would create multiple branches off of the master branch, and you could develop in these branches and commit to them and switch between them without needing to have multiple repositories. 
At any point as you're developing, you can push your branches to GitHub, protecting your work should your hard drive fail and allowing you to easily share your branches with collaborators. 
When you are ready to share your project with everyone, you merge your branch into the "master" branch and push it to GitHub. 
The complete history of your branch is preserved and remains grouped together.

In a git repository, the branch state is "global."  That is, if you're in `rosetta/rosetta_source/src/core/scoring` on branch `a` and you switch to another branch, `b`, then the contents of `main/source/src/core/pack` will also be updated to branch `b`'s state.  Git will not leave the code in `core/pack` unchanged based on the directory you were in when you issue your change-branch command.

Branching and merging is the preferred development pattern in git, and because these operations occur in the local repository, and because git was designed specifically with branching and merging in mind, they are very fast.

####Taking it further
* [[Give git a try|http://try.github.io/levels/1/challenges/1]]
* Go [[here|http://git-scm.com/about]] to learn more about git.  Note that SCM stands for source control management.
* If you can't help but think about git in terms of subversion, you may need a [[reeducation|http://hginit.com/00.html]]

###Getting started
* New developers, or those that have not had their Github account set up with access to RosettaCommons repositories,  should visit  [[NewNewDevelopersPage (which is on the media wiki)|https://wiki.rosettacommons.org/index.php/NewNewDevelopersPage]]. On that page, there are instructions on how to set up a GitHub account, requesting permission from the Rosetta Manager and signing the developers' agreement.
* If you are new to the Rosetta community, you will need some of the standard [[Rosetta external dependencies|Build-Documentation]] like a compiler, etc.
* Even if you are converting from SVN, you will need [[git|https://help.github.com/articles/set-up-git]].
* You will need to set up SSH keys for use with GitHub. You can find instructions for this [[here|https://help.github.com/articles/generating-ssh-keys]]. Note that id_rsa.pub and id_dsa.pub can be used interchangeably at this point, although the instructions use id_rsa.pub.
* You will need to pre-accept GitHub's RSA key fingerprint by following [[the last step of the SSH instructions|https://help.github.com/articles/generating-ssh-keys]].



* Use the get_rosetta.sh script to setup.   The command: 
```
 curl -OL https://raw.github.com/RosettaCommons/rosetta_clone_tools/master/get_rosetta.sh && bash get_rosetta.sh
```
:will download main (source, tools and database), tools and demos.  It will also configure these repositories to add some useful aliases, hooks and a commit message template. Follow the instructions when prompted.  "wget https://raw.github.com/RosettaCommons/rosetta_clone_tools/master/get_rosetta.sh" will also work for Linux systems that default to wget not curl, but get_rosetta.sh itself depends on curl. If your mac complains because your curl doesnt know the https protocol, then you can update it (sudo port install curl +ssl ).

If the curl command above fails (at the time of writing, there was an SSL certification issue), try this instead:
``` 
curl -kL https://raw.github.com/RosettaCommons/rosetta_clone_tools/master/get_rosetta.sh > get_rosetta.sh && bash get_rosetta.sh 
```


###Recommended Workflow

We use the "github flow" development model, which bases development on independent "feature branches" which are merge to a single "master" branch via pull requests. The goal of this model is to maintain a stable <code>master</code> via ≈ code review, automated testing, and collaborative development.

Begin by reviewing the following resources:

* [[Github Flow Overview|https://guides.github.com/introduction/flow/index.html]]
* [[Github Flow Rationale|http://scottchacon.com/2011/08/31/github-flow.html]]
* [[Github Pull Request Help|https://help.github.com/categories/63/articles]]

This development model can be distilled into five simple rules:

1. Anything in the master branch is deployable.
    Any code pushed to master should be considered "final quality" code, ready for use by others. It should be, to the best of your abilities, build completely, pass all automated tests, and be free of bugs.

2. Create descriptive branches off of master.
    All development work should be performed in named feature branches off the master branch. 

3. Push to named branches constantly.
    As code is feature branches does not need to be "final quality", you should constantly push your work to appropriate feature branches.

4. Open a pull request at any time.
    Constantly seek out peer review and automated testing by opening pull requests from your feature branches. Open pull requests before your code is ready to merge for review early in development.

5. Merge only after pull request review.
    Ensure that your topic branch both passes automated testing and has sign-off from another developer before merging the pull request into the master branch.

A basic development flow following these guidelines would proceed as:

* For new development, create a branch from the currently checked out revision: 
`git personal-tracked-branch BRANCHNAME`
This command will create a branch in your local repository named BRANCHNAME and a remote branch named `<github_username>/BRANCHNAME`.  The newly created branch will then be checked out. 

* If the branch you wish to contribute to already exists on the github server:
`git checkout <github_username>/BRANCHNAME`
If your local repository is up to date ("git fetch origin"), this will create a local branch that will track the remote branch.

* Commit your code to your branch. See the [[Git-Guide|http://rogerdudler.github.io/git-guide/]], [[GitReady|http://gitready.com/]] and [[Git Book|http://git-scm.com/doc]] for assistance. 
When you commit the commit message template will be opened in your git editor. 
Fill out the template, save the file and exit. 
If you want to change the git editor, use `git config --global core.editor "EDITOR_NAME"`.

* Push your branch regularly to github so that it is backed up and available to others.
`git push origin <githubusername>/BRANCHNAME`
If you want to push everything (all the branches in your repository) and you only have one remote configured (this is the case unless you explicitly add another remote), you can just use
`git push`
**Note**: there are probably many cases where you do not want to push everything.  If you have not pulled from github, you may not have all the commits in other branches, and so if you try to run "git push," it will be rejected with the (distressing) comment that you should try the --force flag, i.e. "git push --force".  Do not try to push with the --force flag.  For more information on commands you should not use, check out [[this page|GitNoNoCommands]].
**Note**: If you're using git 1.8 or higher, "git push" will try to push only the branch you have checked out.
**Note**: After 5/13/2013, if you have updated your gitconfig, then git versions earlier than 1.8 should also push only the branch you have checked out.

* Open a [[pull request|pull-requests]] for your feature branch, merging from your branch to `master`.
Write a descriptive overview of your pull request when you open it, laying out the proposed changes, their rational, and your plan for implementing the changes. 
If your pull request is "behind" master and not ready to merge update your feature branch by merging the current master:
```
git fetch master
git checkout BRANCHNAME
git merge origin/master
git push origin
```
* Request review and testing for your branch
: Request review in your pull request by @ mentioning other developers with familiarity with the area in which you're working. This may be your mentors, other developers in your group, or developers external to your group.

When your pull request is "ready to merge" request automated testing by adding the pull request label "ready for testing". The test server will then build & test your branch and post back to your pull request with status updates.

* Close your pull request by merging to master. After you've received a "+1" from another developer and a clean build and test report from the testing server merge your pull request via Github's pull request interface. 
Explain any expected test changes or unexpected changes via the pull request comment interface and make sure the pull request description if up to date before closing.

###Common commands

* You can get a short help message on a command with "git <command> -h" and longer help with "git help <command>"

git status: list the tracked files that have changed and the set of visible files which git is not tracking

git add: stage a file to be committed

git commit: commit the files which have been staged using the git add command

git checkout: switch between branches

git clone: create a new repository that is virtually identical to an existing repository

git branch:
  git branch
show which branch you're currently in, or
  git branch <branchname>
create a new branch; read the section below on git personal-tracked-branch

###How to avoid committing files you do not mean to commit

For a start, never use
  git add -f
which forces the addition of files even if you have explicitly excluded them using .gitignore (below).

There are certain files we never want to commit to the repository. These may include compiled C++ object files and libraries, compiled Python bytecode files, passwords, IDE project files and text editor swap files, and OS-specific files such as .DS_Store directories on Macs. Like SVN, git has a method to prevent these files getting committed and pushed to the repository through the use of [[.gitignore files|https://help.github.com/articles/ignoring-files]].

A .gitignore file is a simple text file where each line specifies files to be excluded. Wildcards are allowed. For example, part of a .gitignore file may look like this:
  \*.pyc
  .idea/\*
  .DS_Store
.gitignore files can be created anywhere in the source tree and behave relative to their location. They are simple text files so if they should be applied to everybody then they need to be committed and pushed like any other file in the repository. *Note that the Rosetta source already has plenty of .gitignore files so you should only need to create them for your own app folders.*

git also has the notion of a [[Global .gitignore file|https://help.github.com/articles/ignoring-files#global-gitignore]]. This is a file that you can create for your user account on your workstation which will avoid you ever committing certain types of files. This is a really useful feature.

###Using Integration Tests (aka how to avoid breaking stuff on the test server)
Its best to run integration tests on your changes after merging them into master and before pushing them up to origin.

1) Develop stuff in your branch, making all the changes you like, adding files, committing to your branch, pushing those commits up to origin/your_branch

2) git checkout master

3) git pull

4) <generate ref integration test results>

5) git merge new_branch

6) <generate new integration test results>

###How to fix things (If you developed in the wrong branch)

Run a series of commands:

'git stash' will put changes in the working directory on the stash, you should get a clean working directory after that

'git (personal-tracked-)branch my_new_branch' creates a new branch

'git stash apply' grabs first item from the stash and applies it to working directory - you can also grab a different item (say number 3) on the stash using 'git stash apply stash@{3}'

you can now stage and commit your changes in your new branch


###Useful git aliases

These are installed in your .git/config file when you use the configure_rosetta_repo.sh script.

`git show-graph`: Print an ascii art representation of the current branch, with commit-ids and one sentance commit message summaries.  This is an alias to 
```
   log --graph --abbrev-commit --pretty=oneline
```

`git personal-tracked-branch`: Set up a new feature branch in your username namespace that tracks the remote.  The following command will create a branch called `<username>/test`:
` git personal-tracked-branch test`

`git tracked-branch`: Set up a new namespaced branch that tracks the remote.  The following command will create a branch called `group1/test`:
`git tracked-branch test group1`

###Working on multiple machines###

git is a distributed version control system, which means that no central repository is necessary.  As a result, it is possible to set one computer as a remote of another and collaborate without using github.

However, for several reasons we strongly recommend against this workflow.  Instead, you should use a "star shaped" topology, with github as a remote for all clones.  To sync data between machines, push and pull from github. 

There are a few reasons for doing this.   

1. data integrity - work performed on RosettaCommons projects should be backed up.  By pushing to and from github, you are insuring that
2. collaboration - by pushing your work to github, you make it possible for other users to tell that your work exists, which is critical in a collaborative community such as this one
3. workflow simplicity.  an A->B->C workflow is more complex to manage than an A->C, B->C workflow, as every node in the system has a path length of 1. There are entire categories of caveats to using git that do not exist if you stick to a star shape topology.

###Recommended tools

####ZSH

[[ZSH|http://en.wikipedia.org/wiki/Z_shell]]  is a powerful shell based on bash that provides a wide range of improvements to prompt display, scripting, and tab completion (among other things). 
The tab completion and prompt display features allow Zsh to display information associated with git repositories in the prompt, and tab complete git commands. [[oh-my-zsh|https://github.com/robbyrussell/oh-my-zsh/]] is a set of prompt themes and plugins that makes it easy to use these features.

####Git visualization tools
It can be very useful to visualize non-linear git history, which can become quite complex. Several tools have been developed to for this purpose, and the [[git website|http://git-scm.com/downloads/guis]] maintains a list for various platforms.

#####SourceTree
[[SourceTree|http://sourcetreeapp.com/]] is a free git tool for Mac OS X and Windows.  It offers GitHub integration and provides an intuitive interface for handling common git operations, searching the history and displaying commit diffs.

#####gitk
gitk is the "default" git visualization tools and is installed by default along with git and runs on Windows, Mac OS X and Linux. It provides a rudimentary interface for browsing and searching commit history.


###SVN / git equivalences

There are many commands in git which have identical names, however the functionality of these commands are frequently different. [[Git SVN Crash Course|http://git.or.cz/course/svn.html]] is a useful comparison of git and svn commands, offering rough equivalents in git to common svn operations.  Due to the fundamentally different nature of git and svn, the caveats and limitations associated with these equivalents are completely different.  For example, when copying a file in svn, using 'svn cp' instead of 'cp' is required, while the use of 'git cp' is optional. The [[Pro Git|http://git-scm.com/book]] ebook is a useful reference for those interested in the details of the basic git commands.

## Workflow for using GitHub

(This section is entirely about stuff you do on the github website.  None of this works without internet).

###A note about github forks

GitHub supports several different workflows for handling parallel development.  A popular approach in the open source community is to use the "fork and pull" model, where projects are forked and then merged using GitHub's pull requests.  To keep the Rosetta codebase from fragmenting, we ask that you DO NOT FORK the RosettaCommons repositories, but instead use the recommended branch-based workflow within the `RosettaCommons/main` repository.


##See Also

* [[Git Sometimes Commands]]: Other useful Git commands
* [[GitNoNoCommands]]: Git commands that you should **not** use with RosettaCommons repositories
* [[Reverting a commit]]: Case study for reverting a bad commit
* [[Development Documentation]]
* [[Pull Requests]]