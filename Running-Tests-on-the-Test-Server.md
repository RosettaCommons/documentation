Rosetta's [[testing server]] allows you to schedule custom tests, in addition to automatically testing your code after a merge to `master`. This is very useful for running tests with remote/RosettaCommons resources instead of your poor overburdened laptop.

Submitting arbitrary revision, branch or pull-request for testing
=================================================================

Now you can visit http://benchmark.graylab.jhu.edu/submit (or click the link 'Submit' at Benchmark web site) and submit your commits for testing. To do that you need enter either git-sha1, name-of-the-branch or pull-request-id number. After clicking arrow button testing server will query GitHub for commit info and if it was able to find it present commit information and list of tests that could be scheduled for this revision. If you used branch-name testing server will use current head of the specified branch and for pull request it will not use a single commit but merge between base and target brach and display git sha1 that will be used for merges:


	After you select tests that you want to run, you can click 'Run tests for this commits' to schedule selected tests. When choosing tests please avoid running ones that you don't really need. And especially be careful when using 'select all' button since some tests could take considerable time to run. When debugging a particular test it is probably a good idea to run just this particular test intend of whole set which will reduce load on server and reduce server turnaround time. Also, for your convenience there is green button 'select standard tests' that will select standard test set that we schedule for each new revision of the master branch.

	After scheduling tests Testing server will take you to revision page on which results will appear. Additionally it will send you commit acknowledgment email containing link to result page and when testing complete will notify you of the results. 

	Regression tests such as integration or score tests scheduled that way will have their results compared to latest successful run of the same test from master branch. This effectively allows you to get an idea of what tests will change when you merge this commit to the master branch.


Automatic testing of Pull Requests 
==================================
When your pull request (for any branch, not necessary master) is almost ready to merge it is a good idea to test it before merging to avoid breaking any tests. Testing server is now capable of automatically tracking and testing each push to the branch associated with currently open pull request. All you need to do is to mark this pull request with 'ready for testing' label. To do this open your pull request page on GitHub and click on 'labels' in upper right part of the page and select 'ready for testing' label:



	After this is done Testing Server will automatically schedule current pull request merge as well as all consequent merges. If you want to instruct Testing Server to stop tracking this particular pull request simply remove 'ready for testing' label.

	After Testing Server scheduled tests run the merge button on your pull request should change to the 'pending state' and 'Details' link will take you to revision page on benchmark web site:


	As soon as pull-request tests are finished Testing Server will post results back to GitHub along with a short message. And each tested commit in pull request will have either green check mark or red cross depending of test results. You can also hover over this icon with cursor to display message associated with this merge or click icon to view revision page with test results on Benchmark website:



	Also, depending of tests results the merge button on your pull request will now turn red if there are any broken tests:



	Or merge button will become green if all is good:



Canceling scheduled tests
=========================
If you happened to schedule the wrong tests or pushed a few revisions in a row to your pull request branch you might want to cancel scheduled tests that are no longer relevant (for example because newer revision of same branch is already scheduled for testing as well). You can cancel all scheduled tests for a given revision (only for non master branch) on revision web page or you can cancel individual tests on test web page. To do so press red 'cancel all queued test' button. Similarly you can re-queue all or individual tests later with white 'queue canceled test' button. 


Testing of custom branches
==========================
It is now possible to instruct testing server to track any custom branch from our GitHub main repository and run custom set of tests for each push in a similar way we do this for master and some other branches. This will allow you to monitor code difference, states of build tests and regression tests changes for each push. If you happen to work on a project for which this seems appropriate for example a project involving multiple developers working on the same protocol or just want to track your lab branch - please let me know and I will add your branch to tracking list.