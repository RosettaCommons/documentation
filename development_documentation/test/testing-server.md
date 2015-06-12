#Testing Server

TODO: This page is a work in progress cobbled together from private emails and should be re-written in a more presentable form.

The testing server can be found at [[http://benchmark.graylab.jhu.edu/]]. 
It was designed to automatically test pull requests to master prior to merging with master. 
Furthermore, specific revisions from any branch can be tested. 
Ultimately, the test server should limit the frequency of breaking master.
See [[Running-Tests-on-the-Test-Server]] for full detail on how to use the testing server.

######Comments on Revisions
It is now possible to add comments on any acknowledged revision. 
To add a comment, simply login with your github account and type your comment text. 
While posting you can also select 'notify the list' check box if you want notification of this comment to be sent not only to the author of revision and people who have already commented on this particular revision but to the mailing list associated with this branch (rosetta-log list in case of master branch). 
You can also delete your existing comments (you need to be logged in) by pressing the X button on top-right of your comment. 

Comments are an excellent way to pseudo-amend bad commit messages!
Our GitHub repositories only accumulate history and do not allow rewriting of history, so if you pushed some revision with a wrong/empty/merge commit message there is no way to undo this action. 
Instead, use the comment feature to supply additional information for future records, or just communicate with the other developers:

![developer comment example](images/developer_comment_test_server_example.jpg)

##See Also

* [[Integration tests]]: General information on Rosetta's integration tests
 * [[Running Tests on the Test Server]]: Instructions for using the testing server
* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]
* [[RosettaEncyclopedia]]
* [[Glossary]]