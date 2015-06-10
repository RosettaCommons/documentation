Rosetta's *integration tests* are a set of testing tools that test short protocol runs before and after changes to the code, and compare the protocols' output to check for unexpected changes. 
They are useful for determining whether code behavior **changes** but not whether it is *correct*. 
The tests live in `Rosetta/main/tests/integration`: the main repository, but not directly with the code.




A note on the name
-------------------
They are [[integration tests|https://en.wikipedia.org/wiki/Integration_testing]] in the software testing sense in spirit, but [[regression tests|https://en.wikipedia.org/wiki/Regression_testing]] in their actual functionality.