#Common Errors and How To Avoid Them

* For comparisons of signed and unsigned variables, the problem is most often that you incorrectly used an `int` when you should have used `Size`, per our conventions.
  * If you need a negative number, you *still* should not be using `int`; use `SSize`.
  * If you don't fix the root problem, you can always cast, but in that case, follow the conventions and use `static_cast<int>()`, not `(int)()`.

* The default initialization of a char:
`char foo = char(0)`, which is the same as `char foo = char()`.

* To "unhide" a virtual overloaded function, use `using` to add the original function to the scope of the derived class:
```
class parent {
public:
    void foo(int);
};

class child : public parent {
public:
    using parent::foo;

    void foo(float);
};
```

* To fix an unused parameter warning, simply remove the variable name from the declaration:
```
void foo(char bar);
```
to:
```
void foo(char /*bar*/);
```
or (better, if you never intend to use `bar` in the implementation of `foo`):
```
void foo(char);
```

>>>>>>> 39737bef0814ff5f067e725d7984346053b2f888
* To compare a "non-pointer" with `NULL`, use `get()` on the `OP`.

* To avoid "foo will be initiallized after bar" warnings, initialize in the same order as the private data is listed in the `.hh` file.

* If you can't use `core::Size` to fix a type comparison warning (because you are lower than `core`), use `platform::Size` instead.

* Code like this:
```
foo = R"bar(
        var1, var2
    )";
```
should be changed to this:
```
foo = "bar(\n"
    "    var1, var2\n"
    ")";
```

* To fix ```ignoring return value of 'int foo(bar)', declared with attribute warn_unused_result [-Wunused-result]``` surround the function with an `if` block, *e.g.*:
```
if (system(command_line.c_str()) == -1) {
    TR.Error << "Shell command failed to run!" << std::endl;
}
```

* Use preprocessor directives &mdash; such as `#ifndef NDEBUG` or `#ifdef PYROSETTA` to enable code to only be used in certain compile modes. This allows one to avoid unused variable warnings that only occur in certain build modes. For example, the following code avoids an unused parameter warning and functions differently if Python is available:
```
void
PhenixInterface::setAlgorithm(
#ifdef WITH_PYTHON
        std::string algo)
#else
        std::string /*algo*/)
#endif
{
#ifdef WITH_PYTHON
    algo_ = algo;

    // nuke the target evaluator
    if (target_evaluator_) {
        Py_DECREF(target_evaluator_);
        target_evaluator_ = NULL;
    }
#else
    utility_exit_with_message( "ERROR!  To use crystal refinement compile Rosetta with extras=python." );
#endif
}
```

* `void*` functions throw `no return statement in function returning non-void [-Wreturn-type]` warnings.
 `void*` is a pointer to a function that returns `void`.  Since we have no function to return, return a `NULL` pointer.

* chars cannot be appended to strings with `+`.  To append a char to a string, you must cast it first.  (I suggest using `std::string(1, my_char)`.)

* ints cannot be appended to strings with `+` either.  To append an int to a string, you must cast it first.  (I suggest using `boost::lexical_cast<std::string)(my_int)`.)


##See Also

* [[Development Documentation]]
* [[Build Documentation]]
* [[Scons Overview and Specifics]]: Detailed information on the Scons compiling system
* [[FAQ]]