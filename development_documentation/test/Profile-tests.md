#Profile tests

Rosetta's profile tests, is a system to track both runtime and memory use on an application scale.
Profile tests, living in `Rosetta/main/source/tests/profile/`, were very similar to [[integration tests]], except that they were testing runtime and memory use instead of the actual output.
By by tracking peak memory use and CPU time over revisions, developers could see if code was becoming more efficient or less efficient and also see if application have a memory leak (if memory consumption over time is increase then it is sure sign that application does not properly free memory on each iteration). Because of later it is recommended that profile test run at least a few iteration of protocol.

In general for each new Rosetta App the new profile test should be added.

##See Also
* [[Back to Rosetta Tests|development_documentation/test/rosetta-tests]]