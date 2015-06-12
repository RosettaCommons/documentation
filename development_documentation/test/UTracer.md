#UTracer - A tool for simplifying writing unit tests

UTracer is an object similar to core::util Tracer (see [[Tracer]] documentation page for more info). It main purpose is to capture user output, compare output with previously saved version and save new version in to `._tmp_` file. In addition UTracer object can be used to capture output of specified channels inside core or protocols lib and compare this outputs to a file version.

Creating UTracer object
=======================

Create a `UTracer` object and supply the name of the file to which output will be compared. For example:

```
UTracer UT("MyDir/MyFile.u");
```

will create `UTracer` object that will compare all output going in to it to a content of a file "MyDir/MyFile.u". You should probably have the tracer file residing in the same directory as your test set, and **please** use a `.u` extension for it.

While running, the most recent UTracer output will be saved to a file with the same location you specified, with a `._tmp_` suffix, e.g. `MyDir/MyFile.u._tmp_`.

Running for the first time
==========================

You most likely don't have a `.u` file ready in advance.

The straight-forward way to create one for future unit tests, is to:

  1. create an empty `MyDir/MyFile.u` file in the `test` directory.
  2. add the file location to the appropriate `<module>.test.settings` file (also in the `test` directory), as part of the `testinputfiles` list (at the bottom of the file).
  3. build and run your unit test (e.g. `scons cat=test && test/run.py -d ../database -1 MyTest`)
  4. after the unit test completes (it will fail, since your reference file is empty), a `build/test/.../MyDir/MyFile.u._tmp_` file will be generated (`...` depends on your platform and compiler). Copy it over your empty `test/MyDir/MyFile.u`.
  5. build and run your unit test again and make sure it completes successfully.

Repeat steps 4 and 5 when you need to update your UTracer file because of expected code changes.

Using UTracer object
====================

To use UTracer object simply send output to it using '\<\<' C++ operator. In additional to handling standard build-in C++ type it is possible to serialize vector, vector1 and map's type. For example:

```
UTracer UT("MyFile.u");
Real a,b,c;
vector<Real> va;
vector1<Real> v1a;
map<String, Real> map_string_real;
...
UT << "Some strings... \n";
UT << "Some numbers:" << a << b << c << "\n";
UT << "Vector type:" << va << "\n";
UT << "Vector1 type:" << v1a << "\n";
UT << "map type:" << map_string_real << "\n";
```

Note: As with Tracer object symbol `\n` should be used for a new line, instead of using `std::endl` line symbol.

Controlling precisions of UTracer comparison
=============================================

Currently only float point number can be compared with a specified precisions. It is possible to specify precisions in two ways: absolute and relative.

1. Specifying absolute precisions
----------------------------------

Simply calling `UTracer & delta(double absolute_delta)` will set current acceptable delta for float numbers. Default delta for a new UTracer object is 1e-200. Example:

```
UTracer UT("MyFile.u");
Real a,b,c;
UT.abs_tolerance(.001) << a; // a will be compared with precisions .001
UT.abs_tolerance(.01) << b; // b will be compared with precisions .01
UT.abs_tolerance(.1) << c; // b will be compared with precisions .1
```

2. Specifying relative precisions
---------------------------------

For specifying relative precisions use `UTracer & relative(double relative_precision)`. When UTracer compare using ralative precision it convert it first to a absolute delta value using this function: `delta = (original_value + new_value)/2. * relative_precision`. Where `original_value` and `new_value` is a value read from `.u` file and value serialized to UTracer. Example:

```
UTracer UT("MyFile.u");
Real a,b,c;
UT.rel_tolerance(.001) << a; // a will be compared with relative precisions .001
UT.rel_tolerance(.01) << b; // b will be compared with relative precisions .01
UT.rel_tolerance(.1) << c; // b will be compared with relative precisions .1
```

3. Specifying relative and absolute precisions
----------------------------------------------

It is possible to effectively use absolute and relative precision in the same time. If both precisions are specified effective delta will be calculated as maximum from absolute and relative delta. Suppose we have an array of values ranged from 0 to 100 that we want compare following way: all values should not be different from the original by more then 5% and in the same time we would like to consider value equal if they both below .1 in absolute value. Using UTracer we can do this following way:

```
UTracer UT("MyFile.u");
Vector<Real> v;
...
UT.abs_tolerance(.1).rel_tolerance(.05); // set absolute precision as .1
// and set relative precision as 5%
for (i=0; i < v.size(); i++) {
    UT << v[i];
}
```

Trick: to compare integer number with a precision convert them first to double, and then use UTracer functions 'delta' and 'relative' to compare.

Using of UTracer to compare output of specified channels inside core/protocols libs
===================================================================================

It is also possible to use UTracer to monitor and compare output of other Tracer channels. This sometimes can be very useful to test libraries inner parts. For example suppose that we have MyMover class that we want to write unit test for. And value that we want to test generated as local variables in apply() member function and did not saved as a class members. To test such values we can do the following:

1.  In MyMover member function apply output this values to a special Tracer channel:

    ```
    MyMover::apply(...) {
        core::util::Tracer test_TR("protocols.moves.MyMover.test");
        ...
        test_TR << "Test value 1:" << test_value_1 << "\n";
        test_TR << "Test value 2:" << test_value_2 << "\n";
    }
    ```

2.  In unit test function, before starting testing MyMover class: create UTracer class and redirect core channel "protocols.moves.MyMover.test" to that UTracer object using static Tracer function `set_ios_hook(VTracerOP tr, std::string monitoring_channels_list);`. So file MyMoverTest.cxxtest.hh can have something like:

    ```
    test_MyMover() {
        VTracerOP UT = new UTracer("<somepath>/.../MyMover.u");
        core::util::set_ios_hook(UT, "protocols.moves.MyMover.test core.scoring" );
        ...
        MyMover mm(...); // creating MyMover object
        ...
        mm.apply(...); // inside apply function test_value_1 and test_value_2 will be outputted to channel 'protocols.moves.MyMover.test' and in turn redirected to our UT object.
        ...
        core::util::set_ios_hook(0, "" ); // stopping redirection.
    }
    ```

##See Also
* [[Unit Test|unit tests]] overview/philosophy
* [[Running unit tests|run-unit-test]]
* [[Writing unit tests|writing-unit-tests]]
* [[UMoverTest|mover-test]], a tool for unit testing Mover classes

* [[Testing home page|rosetta-tests]]
* [[Development documentation home page|Development-Documentation]]