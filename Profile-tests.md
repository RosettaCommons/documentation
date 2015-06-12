#Profile tests

Rosetta's profile tests, now deprecated, were a system to track both runtime and memory use on an application scale.
Profile tests, living in `Rosetta/main/source/tests/profile/`, were very similar to [[integration tests]], except that they were testing runtime and memory use instead of the actual output.
Any individual profile test run was of little use, but by tracking peak memory use and CPU time over revisions, developers could see if code was becoming more efficient or less efficient.
The system was never very populated (only 11 applications were tested), and the results are hard to interpret (no binary pass or fail). 
Due to lack of interest, and the problem of getting consistent performance on the heterogeneous backend to the current [[testing server]], profile tests were abandoned.