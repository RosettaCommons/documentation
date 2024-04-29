#GitHub Workflow for Rosetta


[[_TOC_]]

##Executive Summary

We use a common GitHub repository, [[RosettaCommons/rosetta|http://github.com/RosettaCommons/rosetta]], as our primary development repository. This contains the Rosetta source code, as well as accessory parts which are tightly coupled to the state of the source code (e.g. the tests and the database). In addition to this primary repository, we also use a number of other repos as "submodules" within the primary repository, which contain components which are either loosely coupled to the source code, or which are too large to reasonably be stored in the primary repository.

For working with the Rosetta repositories, we use a fork-and-PR model. Each developer creates their own fork of the Rosetta repository, in which they make their changes. Once they have something they want to contribute back to main Rosetta, they open a "Pull Request" (PR) on the GitHub interface with the branch containing their code improvements. This PR gets reviewed, and if it passes quality and administrative checks it will be merged back into the main Rosetta codebase.

To be clear on terms: GIT is a distributed version control system that you install on your computer to manage the Rosetta code you are developing/compiling/using locally.  GITHUB is a website that offers a friendly interface to add communication features around the git codebase (so we can strive together to improve it) and tools to pull together the code, the test server, etc. 

##Workflow for using git

(This section is almost entirely things you do on your computer, most of which will work offline (except for the occasional git command that talks to the server)).

###What is git?

Git is a widely used, fast, flexible and robust distributed source control management (SCM) system. 
Unlike centralized SCM solutions like subversion, each working copy of the code is a full-fledged repository. 
Each repository contains the complete history of the project, including branches from the main development line, which is typically called "main".  
The revision history in a repository is represented as a graph -- specifically, as a directed acyclic graph (DAG).  When a revision is committed to a repository, it is saved as a node with an edge indicating the previous revision.  A "branch" is a named revision at the terminal vertex of a DAG; the branch name always references the most recent revision in a branch.  Non-terminal revisions can be named using [[tags|http://git-scm.com/book/en/Git-Basics-Tagging]].  Each branch can be traced back to the root vertex and thus each branch can be thought of as a possible, reasonable trace through the revision history.  An interesting effect of this design is that all paths through the history (i.e. all branches) are equally valid. 
The "main" branch, by convention, is the one we think of as the official branch, what we would call "trunk" in SVN.

A common metaphor used to describe the structure of a git repository is the hydra.  There are many heads (branches), but there is only one body (repository).  At any one time, only one branch can be "checked out."  The files in that branch can be examined and edited exactly as you would expect to edit them.  You'll make your modifications, you'll commit them to your checked-out branch, and then, if you check out another branch, all of the modifications you made to your first branch will disappear from the source tree. 
In git, there is no need for separate copies of Rosetta for each of your development tasks. 
Instead, you would create multiple branches off of the `main` branch, and you could develop in these branches and commit to them and switch between them without needing to have multiple repositories. 
At any point as you're developing, you can push your branches to GitHub, protecting your work should your hard drive fail and allowing you to easily share your branches with collaborators. 
When you are ready to share your project with everyone, you merge your branch into the `main` branch and push it to GitHub. 
The complete history of your branch is preserved and remains grouped together.

In a git repository, the branch state is "global."  That is, if you're in `rosetta/rosetta_source/src/core/scoring` on branch `a` and you switch to another branch, `b`, then the contents of `main/source/src/core/pack` will also be updated to branch `b`'s state.  Git will not leave the code in `core/pack` unchanged based on the directory you were in when you issue your change-branch command.

Branching and merging is the preferred development pattern in git, and because these operations occur in the local repository, and because git was designed specifically with branching and merging in mind, they are very fast.

####Taking it further
* [[Give git a try|http://try.github.io/levels/1/challenges/1]]
* Go [[here|http://git-scm.com/about]] to learn more about git.  Note that SCM stands for source control management.

###Getting started

* You need a GitHub account to work with the Rosetta codebase. If you don't have one already, you can get one for free at <https://github.com/> by clicking the button in the upper right.
    * When picking an account name, we recommend a "professional" sounding one -- your GitHub user name will be listed on all your GitHub-related communications. (But don't worry too much about your funky username if you already have an established GitHub account.)
    * Please fill out your [GitHub profile](https://github.com/settings/profile) with full name and affiliation (institution & lab).
    * Under [Emails](https://github.com/settings/emails), uncheck "Keep my email address private", so the Rosetta testing server can properly link your account to your contributions.
* We highly recommend using SSH keys for working with GitHub repos. You can find instructions for this [[here|https://help.github.com/articles/generating-ssh-keys]]. Note that id_rsa.pub and id_dsa.pub can be used interchangeably at this point, although the instructions use id_rsa.pub.
    * You will need to pre-accept GitHub's RSA key fingerprint by following [[the last step of the SSH instructions|https://help.github.com/articles/generating-ssh-keys]].
* People contributing code will need to sign either the [developer agreement]() (for members of a RosettaCommons member lab) or the [Contributor Licensing Agreement](insert link) before their PRs can be accepted.
    * Members of RosettaCommons labs should consult the internal wiki for more details on getting set up as a RosettaCommons member. (Ask other lab members for the website and login info.)
* You will need some of the standard [[Rosetta external dependencies|Build-Documentation]] like a compiler, etc.

####Obtaining Rosetta.

_Note: With the new repository scheme, the old rosetta_clone_tools script is no longer useful._

If you just want to download and use Rosetta, you can obtain it from the [release pages](https://www.rosettacommons.org/software/license-and-download), or you can clone it directly from the main Rosetta repository:

        git clone git@github.com:RosettaCommons/rosetta.git   # Uses SSH
 
However, if you are doing any development with Rosetta you will likely want to clone from your own fork - see below.


###Recommended Workflow

With the publicly accessible Rosetta repository, we're using the now-standard Fork-and-PR model for development. The benefits of this model is that it's standard for many Open Source projects, so there's plenty of documentation out there for it. (See the [GitHub Documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests) for a start.) It also allows potential contributions by people who aren't members of the RosettaCommons, and who do not have write access to the Rosetta repositories.

A basic development flow would proceed as follows:

1. Create a Fork of the Rosetta repository into your own userspace
    
2. Clone your forked repo into a local repository
    If you already have a local clone of the RosettaCommons/rosetta repo, you can convert it to reference your fork (see below).

3. Create a development branch in your local repository
    Your fork is your own personal workspace, so feel free to name your branch whatever you want -- you do not need to namespace it with your GitHub username
    Just keep in mind that the branch name will be visible to others when you eventually make a PR

4. Code, Code, Code
    Make your changes in the local repository

5. Create tests for your new code
    Run the tests locally. Also check the existing tests to make sure you didn't accidentally break anything.

6. Push your branch to your GitHub fork
    Your changes will stay within your fork until you release them, so feel free to stash whatever you like there.

7. Repeat 4-6 until your branch is ready

8. Open a PR against the Main RosettaCommons/rosetta repo using the GitHub interface
    A PR is your way of giving back your code changes to the community.

9. Your PR will be reviewed by other members of the RosettaCommons
    Reviewers are checking for bugs you may have missed, issues with code quality, and other potential issues with the code. 
    The goal is to "peer review" your code and get it into a "publishable" state.
    Another thing they'll check for is that you've signed the developer or contributor licensing agreement.

10. If your PR passes review, it will get merged.
    Only someone with write access to the main RosettaCommons/rosetta repo can push the merge button - you don't do it yourself, another person will do it for you.

#### Create a Fork

To create a fork, go to <https://github.com/RosettaCommons/rosetta> and click the "Fork" button in the upper right. (See [GitHub documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) for more)

NOTE: The Rosetta license allows you to make Forks through the GitHub website, and interact with those forks on your local machine. The license does not permit (publicly) re-hosting the Rosetta repositories on other websites. Do not re-host Rosetta on other services (Gitlab, Bitbucket, etc.)

#### Cloning your fork

Once you have a fork, you can clone from your own copy of Rosetta

        git clone git@github.com:GITHUB_USERNAME/rosetta.git   # Uses SSH
        
The difference between cloning from the primary RosettaCommons version and your forked version is simply which repo is listed as `origin` in your local clone. You can change that later:

        git remote add upstream git@github.com:RosettaCommons/rosetta.git  
        git remote set-url origin git@github.com:GITHUB_USERNAME/rosetta.git

(The first command may be useful even if you've originally cloned your fork.)

#### Create a development branch in your local repo

Unless you have a particular revision you want to start with, we recommend creating your branch off of the `main` branch

        git checkout -b <BRANCH_NAME> origin/main

You can substitute whatever branch name you want. But it likely should be descriptive, as the branch name will be visible to others when you eventually make a PR.

Note the above command will create the branch based on what the local repo thinks the state of origin/main is. 
This may or may not be up-to-date, depending on when you last updated.

In particular, your GitHub fork does not automatically keep up to date with the primary RosettaCommons/rosetta repository.
If the `main` branch of your fork is behind the `main` branch of RosettaCommons/rosetta, when you go to the GitHub webpage for your fork (https://github.com/GITHUB_USERNAME/rosetta), 
there should be a banner near the top telling you "This branch is XYZ commits behind RosettaCommons/rosetta:main", and giving you a "Sync Fork" button.
Pressing this button will update the GitHub version of your fork's `main` branch with the updated state of the RosettaCommons/rosetta `main` branch.

After you've done this, you can update the local version of `origin/main` by running:

        git fetch origin

Then you should be able to checkout or merge the `origin/main` branch.

#### Code Code Code

See the [[RosettaAcademy]] documentation for more help on working with the Rosetta codebase, as well as how to compile Rosetta.

#### Create Tests

Making tests for your new feature or bug fix will help with maintenance and making sure things don't break in the future. See the [[RosettaAcademy]] documentation for more help on writing tests.

Additionally, you'll want to run the existing tests locally to make sure you didn't inadvertently break something. See [[Development Documentation]] for more info on how to run tests locally.

#### Push your changes

You likely only have write access to your fork of Rosetta, and not the primary RosettaCommons/rosetta repository. So when you push, you'll need to push to your fork, and not the primary repo. 
Luckily, if you've set things up properly (see "Cloning your fork" above), your fork should be listed as the `origin` remote.

        # For the first time (-u sets the upstream reference for subsequent pushes)
        git push -u origin

        # Subsequent times
        git push

#### Repeat

As you develop - particularly if it's a long-running branch - the Rosetta `main` branch will likely accrue changes, some of which may conflict with your changes.
Your eventual PR won't be mergeable unless you fix up these conflicts.
To do so you'll want to update the state of `main` in your fork repo and the state of `origin/main` in your local repo with the updated state of `main` on RosettaCommons/rosetta.
See the information in "Create a development branch in your local repo" on how to do this.

Once you've fetched down all the information, you should be able to merge your branch with the updates.

        git merge origin/main

Then you'll need to resolve the merge conflicts (if any) and commit the changes.

* Don't worry about the branch history. We're using a squash-merge system for the RosettaCommons/rosetta repo. 
Whenever your PR gets merged, all the complex history of the branch will get squashed into a single commit.

#### Open a PR

Once you're done with your changes (or at the very least are complete enough for reasonable feedback), you can open a PR. See the [GitHub documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/] for more details.

*Don't open "in-progress" PRs against the main RosettaCommons/rosetta repo.* To keep the reviewing interaction with PRs somewhat clean, please wait until your PR is "ready to review". -- Your fork is a private workspace, and contains all the functionality of the main RosettaCommons/rosetta repo. If you wish to have draft or placeholder PRs, you can always change the dropdowns and open a PR against the GITHUB_USERNAME/rosetta:main branch, which should keep the PR local to your branch. Once it's ready to go, don't merge, but instead make a new PR with the branch against RosettaCommons/rosetta:main. Alternatively, you can also use the "project" feature of GitHub to keep track of in-progress work.

Generally, there will be a banner on the webpage for your fork (https://github.com/GITHUB_USERNAME/rosetta) whenever you've pushed new commits to a branch which will allow you to open a PR for that branch. Alternatively, if you go to that webpage and find the branch of interest in the dropdown box, there should be a "Contribute" button which will allow you to open a Pull Request.

*Important Points when Opening a PR*

At the top of the PR submission page there are some dropdown boxes which show the repositories and branches involved.
The "base repository" and "base" (what you're merging into) should likely default to RosettaCommons/rosetta:main, but double check to make sure things are going where you expect.

For the Title, enter something descriptive, which properly summarizes the intent of the PR. Potential reviewers may choose or choose not to review your PR based on if they think the title is relevant to them.
*In particular, the default of the branch name is _rarely_ useful.*

For the Description, please be succinct but descriptive about the content of the PR. Particularly, keep in mind that the person eventually merging the PR will almost certainly use the description box (e.g. copy-paste) to create the merge commit message. With our use of squash-merges, this means that the contents of the description box may be the only persistent record of what these changes were about. Note that the description is editable later. It's worth keeping the main description up-to-date as the PR changes.

Please leave the "Allow edits by maintainers" box checked. We generally leave the PR author to change their own PR, but being able to quickly tweak something that needs tweaking but doesn't necessarily need a back-and-forth to get you to change it is helpful.

If you know someone who might be a relevant reviewer, feel free to add them. (But keep in mind they might not be able to, due to being busy.)

Consult the Labels drop-down and add any you think are relevant. Only users with appropriate permissions on the repository (e.g. certain members of RosettaCommons) can apply labels. 

#### Review and merging

Once you open a PR a RosettaCommons developer will review your code, to check for obvious bugs, to check for various quality standards, and to make sure administrative things are properly in order. (See [[reviewertemplate]] for one take on it.) The primary goal is to ensure that code that makes it to RosettaCommons/rosetta:main is "final quality" code, ready for use by others. It should, to the best of our abilities, build completely, pass all automated tests, and be free of bugs.

Note that while only certain authorized RosettaCommons developers can actually merge code, we welcome and encourage reviews by people who aren't authorized to push the merge button.
The attention of people who have merging authority is limited, and if others can help with the "prep work" in the early stages of PR review, that leaves more time for the people who can merge to handle the final merging bit.

##### Legal/Administrative issues

One important thing that will be checked is if you've properly signed the Developer Agreement or the Contributor Licensing Agreement. As Rosetta is also distributed commercially, we need to make sure we have the proper rights to do so. The Developer and Contributor Licensing Agreements make sure we're squared away.

* The Developer Agreement is for people who are members of RosettaCommons labs. Consult the RosettaCommons internal wiki for more information. (Ask other lab members or your PI for the website and login info.)
* The [Contributor's Licensing Agreement](INSERT LINK) is for people who are not members of RosettaCommons. It basically asserts that you are properly authorized to contribute the code you are contributing, and that you do not have any legal objections for the RosettaCommons to redistribute that code as part of the Rosetta software package, including under its commercial use license.

(Note that while the Contributor's Licensing Agreement allows RosettaCommons to distribute your contributed code, you still retain rights to it, and can redistribute and relicense it on your own, provided it does not contain any pre-existing RosettaCommons code. See the text of the Contributor's Licensing Agreement (CLA.md in the root directory of Rosetta) for exact details.)

Another legal thing checked is to make sure that no code incompatible with the Rosetta License is merged. Existing in both non-commercial use only and commercial use forms, the Rosetta license is incompatible with the licenses of certain other software packages. In particular, licenses with terms incompatible with "non-commercial use only" restrictions or those with "share alike" provisions, like the GPL (GNU Public License), are incompatible with Rosetta and code with such licenses cannot be combined with the Rosetta software. *This restriction includes any redistribution of the combined package, including posting such combination to a GitHub fork.* (Note this restriction doesn't come from the Rosetta License -- it's principally a violation of the license for the GPL'ed software.)

##### Testing

Part of the review process will be to queue tests onto the test server (<https://benchmark.graylab.jhu.edu/>) and make sure there are no inadvertent breakages of the tests. If any tests come back with issues - including ones you didn't intend to change - you'll likely be asked to track down the issues and make sure the branch is fixed.

If you anticipate tests changing, it's worth mentioning that in the pull request description.

##### Merging

Once your code passes all checks, and tests cleanly, your PR will get merged into RosettaCommons/rosetta:main  
Only RosettaCommons members with write access to the RosettaCommons/rosetta repo can do this merge, so instead of you doing it yourself, someone else will push the merge button for you.

To keep the (already too large) repository at a manageable size, we use a squash merge system. This means that each PR will be re-written automatically by the GitHub interface to consist of a single commit with all of the changes. One implication is that all the commit messages in your branch history will no longer be available from the history of the RosettaCommons/rosetta:main branch. Instead, a new commit message summarizing the entire PR will be made. To make sure that message is as accurate as possible, please keep the PR description up-to-date and accurate about the content of the PR. The person merging the PR will use the PR description for the new commit message.

### Submodules

Rosetta uses submodules extensively for bits which are not tightly coupled with the main Rosetta source code as well as things which would be too bulky or awkward to include within the main Rosetta repository itself.

Submodules are separate repositories that can be subdirectories of existing repositories. Submodules are in a 'detached head' state, meaning they belong to a specific commit to which the HEAD pointer is not updated when other people push to main. Quick example: `Rosetta/tests/scientific` is in the `rosetta` repository and the `data` directory in there is it's own submodule. The contents of `data` are not automatically updated when pulling from main (using `git pull`). Instead, you need to update the contents of the directory with one of the `git submodule` commands (for example, `git submodule update --init --recursive`). 

**Question**: I always update all submodules using `git submodule update --init --recursive` but I actually only use the scientific data one and don't care about all of the other ones (maybe `tools`). How can I keep the others in whatever state they are at a certain point and not touch them without them constantly showing up as changes in git status? How do you do that? What's the workflow and the commands?

**Rocco's answer**: The short answer is don't init modules you don't need. You can update modules specifically by giving their path (e.g. `git submodule update --init -- tests/scientific/data/` to just update the scientific benchmark data one.). If you already have a module init-ed, you can remove the contents to cause git to ignore it. (e.g. `rm -r source/src/python/PyRosetta/binder/*` if you don't do any PyRosetta building, and don't want binder changes to show up on your pulls. Note: that's a plain `rm` and NOT a `git rm`). An empty working directory for a submodule will act like a "no changes" signal for git. If you do want it later, you can always do a `git submodule update --init -- source/src/python/PyRosetta/binder/`. The data for the submodule is stored externally to the working directory, so it's actually not that heavy-weight to do the rm/init.)

There are a number of Rosetta dependencies which are distributed as submodules, and which are needed for compilation. For convenience sake (and to avoid having to submodule update everything), there's a utility script at `Rosetta/source/update_submodules.sh` which automatically updates submodules needed for compilation. This script should be automatically called as part of the compilation process. (Note, though, that this means if you have unstaged changes to compilation-dependent submodules they may be overwritten.)

#### Modifying submodules

One of the quirks of working with submodules is that the state of the submodule is represented as a fixed SHA1, and the repository is listed with a specific URL. In particular, the submodules are listed for URLs against the RosettaCommons version of the submodule repository. This should work if you just fork the primary rosetta repository, and aren't making any changes in the submodule contents. -- If you are interested in changing the contents of a submodule, then it gets a little more involved. 

One thing to keep in mind is that the contents of the .gitmodules file are only used when you run `git submodule update --init`. Once the submodule is "inited", the submodule functions like any other git repository. This means you can add a different remote (e.g. your fork) and then interact with that remote "like normal". The only complication is that the primary `rosetta` repo has to be updated to point to the new state of the submodule in a different PR than the PR which updates the submodule.

So if you have changes to a submodule:

1. First make a fork of the submodule repository, if you haven't already.
    If you already have, click the "Sync fork" button to get any updates.

2. Do the normal `git submodule update --init -- SUBMODULE_DIR` to checkout the submodule into your copy of Rosetta.

3. Change into the submodule directory
    While you are in your submodule directory, any git command will apply to the submodule repository, not the primary `rosetta` repository.

4. Add your fork as a remote repository (e.g. `git remote add fork git@github.com:GITHUB_USERNAME/SUBMODULE_NAME.git` )
    You don't have to (shouldn't) change the .gitmodules file to point to your fork.
    The addresses there are only used to init the submodule, and when developing you want both the official repo and the fork to be available.

5. Make a new branch for your changes, based on the current state of the submodule (e.g. `git checkout -b BRANCHNAME`)

6. Make your changes to the submodule and commit them like you normally would (with `git add` and `git commit`).

7. While in the submodule directory you can push your branch to your fork of the submodule repository (e.g. `git push -u fork`)

8. Change directory back into the primary rosetta repo.
    A `git status` should show that there are new commits in the submodule directory.

9. Add the changes to the submodule directory to a new branch in the primary rosetta repository, and push it to your fork of the rosetta repo.
    See instructions above. Test locally as much as you need to.

10. When you're ready to make a PR, first make a PR within the submodule repository, against the `main` branch of the RosettaCommons version of the submodule repository.
    
11. Only after you've made a PR to the submodule, make a second PR for your `rosetta` repository branch, as above.
    When writing your PR description, be sure to cross-reference your PRs for the submodule changes.
    Github will automatically recognize descriptions like "RosettaCommons/tools#14" as a cross-link to PR #14 in the RosettaCommons/tools repository.
    (You can check the "Preview" pane to check the linkage.)

GitHub doesn't really handle coordinating merging submodule changes with PRs. 
Additionally, since git identifies the submodule state with a combination of repository URL and SHA1, in order for things to work, we need the specified repository (RosettaCommons/submodule) to hold the proper SHA1 state (the version you submitted to your fork). This means that when merging we need to merge your submodule PR to the RosettaCommons submodule repo prior to merging the PR in the `rosetta` repo.

Note that testing of your `rosetta` PR will be broken until the submodule PR gets merged. Depending on how integral the changes you've made to the submodule are to testing, we may ask you to re-target your submodule PR against a development branch we'll create for you, rather than `RosettaCommons/submodule:main`. That way your changes can be merged to the RosettaCommons version of the submodule to permit proper testing, and if it's successful we can merge that developmental branch to `main` when we merge the branch in `rosetta`.

###Common Git commands

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

Its best to run integration tests on your changes before pushing them up to origin.

1) Develop stuff in your branch, making all the changes you like, adding files, committing to your branch, pushing those commits up to origin/your_branch

2) git checkout main

3) git pull

4) <generate ref integration test results>

5) git merge new_branch

6) <generate new integration test results>

###How to fix things (If you developed in the wrong branch)

Run a series of commands:

'git stash' will put changes in the working directory on the stash, you should get a clean working directory after that

'git checkout -b my_new_branch' creates a new branch

'git stash apply' grabs first item from the stash and applies it to working directory - you can also grab a different item (say number 3) on the stash using 'git stash apply stash@{3}'

you can now stage and commit your changes in your new branch


###Working on multiple machines###

git is a distributed version control system, which means that no central repository is necessary.  As a result, it is possible to set one computer as a remote of another and collaborate without using GitHub.

However, for several reasons we strongly recommend against this workflow.  Instead, you should use a "star shaped" topology, with GitHub as a remote for all clones.  To sync data between machines, push and pull from GitHub. 

There are a few reasons for doing this.   

1. data integrity - work performed on RosettaCommons projects should be backed up.  By pushing to and from GitHub, you are ensuring that
2. collaboration - by pushing your work to GitHub, you make it possible for other users to tell that your work exists, which is critical in a collaborative community such as this one
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

(This section is entirely about stuff you do on the GitHub website.  None of this works without internet).

###What is GitHub?
[[GitHub (wikipedia link)|https://en.wikipedia.org/wiki/GitHub]] is a website that:
1. remotely and securely hosts our git-enabled codebase
2. enables communications about said codebase

On point 1 - We need a way for our computers to communicate about what the code is.  Git means that everyone has a copy of all the branches, but we still need some way to get everyone's computer to communicate to share those branches.  Instead of having everyone run servers on their laptops constantly, we let GitHub centralize the process.

On point 2 - We need a way for ourselves to communicate about what the code is.  When one developer writes a new feature and wants to say "here is my new feature, I want to merge it into main, let's take a look at it" - GitHub lets us organize all that communication in ways that are tightly tied to the code under discussion.

###Pull Request (PR)

Because everyone is writing new code simultaneously, we can't all just merge to main whenever we feel like it.  Additionally, we need to make sure the test server gets run on code submissions for main.  Finally, we need to ensure that code added to main is bug-free and meets the coding conventions.  The Pull Request system helps us manage this.

Pull Requests are a formal statement of "I want to merge my branch into `main`".  You can't merge into main any other way.  The Pull Request interface will let the community reply "we want your code merged into main" or alternatively "your code needs some fixes before we merge it into main".  (Don't worry, there's no judgement on the latter statement.)  The community's reply is expressed through the PR Review system.

All code going into main goes through the Pull Request system to ensure the integrity of the codebase.

####Opening a Pull Request
If you have recently pushed your branch, GitHub will notice and give you a banner for "do you want to open a PR for your code?".  Otherwise, navigate to your branch in GitHub and there will be a button for opening a PR.

Once your PR is started, you will see a tab "conversation" which lists the commits in your PR and has places for comment boxes, and "files changed" which will show a diff view of the summary changes for your whole PR.  There are also controls on the right for setting labels and reviewers; that will come up again shortly.

####Pull Request Review - what to do before review
PR review means you are asking the community to take a good look at your code.  It's a little like inviting us over to your house for a party in your code.  Before you throw a party you probably want to tidy the house up a little first:

0. Write code with good documentation and unit tests that obeys the coding conventions - these are the sorts of problems reviewers will be looking for, and the fewer problems there are the easier it is for all involved.

1. Small PRs are better!  Submitting small PRs regularly will lead to fast and easy reviews.  If the reviewer can spend 15 minutes or less reviewing, they'll do it as a quick break from some other work.  If it's hundreds of lines and requires 2 hours to review, they have to block it out as a real chunk of their work for the day.

2. Separate refactoring and file moves from code content changes.  GitHub will show moved files as a file deletion + file creation, leading to huge numbers of changed lines.  If you have a moved file of 300 lines and can honestly say "this is just a file move with no substantive changes" (file paths, tracer names - those are not substantive) then your reviewer can mostly skip it.  If you mix real code changes in with big file moves, the reviewer has to wade through the whole file looking for your changes.

3. Run the tests first!  If the test server is going to reject your code anyway, work with it first before spending human developer time on the problem.  The `90_standard_tests` label can be applied to show the test server that you are ready for it to look at your code.  You should generally wait for a clean test status before requesting review.

4. Run the beautifier first!  Technically this is already in "run the tests first", but it's worth reiterating.  The beautifier introduces large numbers of whitespace-only changes to your code.  Reviewers usually leave their comments tied to specific lines of code.  GitHub assumes any change to a line of code that occurs post-review will invalidate (or fix) a reviewer comment - so if you get review first then beautify, GitHub will hide all your reviewers' comments. You can run the beautifier locally with the `tools/python_cc_reader/beautify_changed_files_in_branch.py` script.

####PR Review - how to get a review
Once you have gotten a green slate from the test server, and you've reviewed your own code for issues, you are ready for an external review.
* Apply the `ready_for_review` label in GitHub.
* If you know a few folks who are interested in your code, either because it's code they've worked on or because it's a shared scientific interest, you can request their review in the controls over on the right of your PR.
* If you don't know who would be a good reviewer - post on rosetta-devel or slack asking for a review, and someone will come along to pick it up.
* If you are having real trouble getting a reviewer - open a discussion on rosetta-devel or slack.  The problem might be that the PR is too large and nobody wants to spend 3 days reviewing it; in that case setting up a teleconference call with a reviewer or two will speed things up enormously (you can review code 10x faster with the author walking you through it).

####What to expect from your review
* Probably you will get rejected at first.  That's fine, basically all code has at least one thing wrong with it, you'll be able to fix it and get approval.
* Expect the community to gently point out:
** Bugs in your code
** Poorly commented code
** not-up-to-standard code, like missing `const &`s
** highly inefficient code
** code with no tests

####What to do as a reviewer
* Make sure the code does not break anything - look at the tests.  Also make sure the new code HAS tests to prove it works.  Checking that the test exists and looks right is much easier than reading functions line by line and mentally compiling them.
* Do demand changes for problems in the code (see the list above)
* Do suggest improvements for readability, stability, and documentation
* Do demur on being a reviewer if you have a conflict of interest or if you feel the urge to engage in personal attacks
* Do feel free to not review a request that is not in an area of interest or expertise for you as a reviewer
* Do not add feature requests to PRs - "this PR should also handle my case X" - those should usually be pushed to future PRs.  (This is a fuzzy grey line).
* Do not mix arguments about scientific merit with arguments about the code itself - PR review is not the appropriate venue.

####What to do once your code is reviewed
* Broadly, fix the problems identified by your reviewer.  Once those changes are pushed and the test server re-approves, ping your reviewer to let them know so they can re-review and turn the X into a checkmark.
* If you feel the review is going wrong or you are being treated unfairly, you can and should bring it to the attention of your adviser.

##See Also

* [[Git Sometimes Commands]]: Other useful Git commands
* [[GitNoNoCommands]]: Git commands that you should **not** use with RosettaCommons repositories
* [[Reverting a commit]]: Case study for reverting a bad commit
* [[Development Documentation]]
* [[Pull Requests]]
