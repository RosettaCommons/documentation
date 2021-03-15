#Making a Pull Request

Rather than merging a branch directly into the master branch of the Rosetta main repository, any significant changes are now made using GitHub pull requests. 
These requests can (and should) be made long before the branch in question is ready to merge, as they provide a mechanism for developers to:
-	let other developers know what sorts of changes they are making, 
-	get feedback from other developers (particularly those who may be familiar with relevant areas of the code), and 
-	provide a simple and straightforward mechanism to ensure that the branch will not "break" the code via automatic testing through the [[testing server]].

Before making a pull request, a developer must first make a branch that is tracked on GitHub (see the [[GithubWorkflow]] page for more details).
All code should be committed to this branch.
To create a pull request, first go to the main GitHub page for the main repository and select your branch from the drop-down menu.
Clicking the button to the left of this menu will open a page comparing the branch to (by default) master, and a button will be available to create a pull request. 

When a pull request is made, all developers who are set to watch the repository will receive a notification. Developers are encouraged to review and comment on one anothers' pull requests.


##Pull Requests and the Testing Server

Once you have submitted a pull request for your branch, you can have it tested automatically using Rosetta's [[testing server]]. Once a pull request has been labeled "ready for testing", the testing server will automatically indicate whether the pull request can be automatically merged (i.e. it passes testing), whether the pull request causes integration test changes ("MERGE WITH CAUTION"), or whether the commit is not yet ready to merge.  When the pull request passes testing or causes integration test changes, a green button will become active, allowing any user to merge the pull request into master.  

##Tutorial

A tutorial is available as PDF slides [[https://drive.google.com/file/d/1NTTcCi_FilNuyq8w16tYbLHsc8JjVcP5/view?usp=sharing here]] and a recording should be available on the WinterRosettaCon 2021 wiki page. 


##See Also

* [[Development Documentation]]
* [[GitHubWorkflow]]
