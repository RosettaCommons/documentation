#The Workbench UI application

Author: Sergey Lyskov

Application purpose
===================
Provide means to submit Rosetta cluster jobs from Mac/Linux desktop client


Download
========
To use this application you will need to download latest build for supported platforms could be downloaded from http://graylab.jhu.edu/download/ui/archive/ui/ (ask in [#ui RosettaCommons Slack channel](https://rosettacommons.slack.com/messages/C449T2QSJ/details/) for credentials) and unpack archive on your desktop machine.

Setup
=====
When running application for the first time open `Preferences` menu (command-,) and setup Rosetta Cloud user name and password and preferred PDB viewer. (if you do not have Rosetta Cloud account yet - ask for one [#ui RosettaCommons Slack channel](https://rosettacommons.slack.com/messages/C449T2QSJ/details/) )

Overview
--------
Workbench application allow you to submit Task which consist from list of individual Rosetta jobs runs for particular Rosetta version. Each job will be run sequentially from left-most-tab to right-most tab and all previous job guarantee to be finished before next job started.

Rosetta Version
---------------
Rosetta version could filed in TaskSubmit dialog could take following values:
* Name of the branch, like `master`. In this case back-end process will use somewhat recent build for this branch (or compile the most recent version for this branch if no previous build is available). Build used will guarantee to be not older then a five-days old.
* Name of then branch with colon at the end, like `release:`. In this case back-end with always use the _latest_ available commit for specified branch.

* Git SHA1, like `bdd325a0ef3d5d53deef57c12be5ebc859c47304`. In this case back-end will try to build specified revision.


Directory Structure of Task during HPC run
------------------------------------------
When submitted Task started all input files will be places into `input/` directory. So for example, if you provided `my-pdb.pdb` file in you input file set then it could be references in your flag file as `input/my-pdb.pdb`. Output of previously completed jobs will be placed into `<job-name>/` dir. So when you submit multi-stage Task with stages named as `1`, `2`, `3` you cold access results of previously completed jobs as `1/result-of-job-1-file.extension`, `2/result-of-job-2-file.extension`, `3/result-of-job-3-file.extension`.


Tips
====
- to view PDB file in specified PDB viewer right-click on file then select `open` from pop-up menu or double click on a file
- to open ScoreFile plot for `*.score` files: right click on file then select `open` from pop-up menu or double click on a file. In ScoreView you can select which score term to use on X/Y axes, hover over points to view individual scores and double click on point to open particular decoy in your PDB viewer.
- to save particular file(s) to disk: select file(s) then right-click on selection and choose `save-as`
- to export all Task files into directory use `export all files` button on TaskView page
- to change run order of Jobs use mouse to click on job-tab and drag it into desired position