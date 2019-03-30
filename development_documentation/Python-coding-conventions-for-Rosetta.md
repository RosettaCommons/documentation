#Python Coding Conventions for Rosetta

As more and more code is written in Python &mdash; both [[PyRosetta]] protocols and [[other accessory scripts|Tools]] &mdash; it will be good to have a consistency and quality to our code. This page presents a list of guidelines and conventions for writing Python code in the Rosetta community.

This page is modeled after the C++ coding conventions; for the list of those conventions, see: [[Coding Conventions]].

If not otherwise stated, the Python style guidelines presented in [[PEP 8|http://www.python.org/dev/peps/pep-0008/]] should be followed.


[[_TOC_]]


##Conventions
###File Layout
All Python code should have the following general file layout:
* Header
* Imports
* Constant Definitions
* Class & Method Definitions
* Main Body

####Header
#####Shebang
If the Python code is a script, include the following line, including the path to Python:
```
#!/usr/bin/env python
```
Note that, if present, this line must be the very first line in the file, before the copyright header, docstring, or additional comments.

#####Copyright Notice
The Rosetta Commons copyright header is required for every source code *file* in Rosetta. Do not make modifications. The header you should use for all `.py` files is:
<pre>
# (c) Copyright Rosetta Commons Member Institutions. 
# (c) This file is part of the Rosetta software suite and is made available under license. 
# (c) The Rosetta software is developed by the contributing members of the Rosetta Commons. 
# (c) For more information, see http://www.rosettacommons.org. Questions about this can be 
# (c) addressed to University of Washington CoMotion, email: license@uw.edu. 
</pre>

#####Main Docstring
Immediately below the copyright notice block comments should go the "docstring" for the <code>.py</code> file. (See more on [[documentation|Python-coding-conventions-for-Rosetta#documentation]] below, including how [[Doxygen|http://www.stack.nl/~dimitri/doxygen/]] reads Python comments.) This text should be opened and closed by a triplet of double quotes (<code>"""</code>). 

Include headers such as "Brief:", "Params:", "Output:", "Example:", "Remarks:", "Author:", ''etc''. 

**Example:**
<pre>
"""Brief:   This PyRosetta script does blah.

Params:  ./blah.py <input_filename>.pdb <#_of_decoys>

Example: ./blah.py foo.pdb 1000

Remarks: Blah blah blah, blah, blah.

Author:  Jason W. Labonte

"""
</pre>

####Imports
<code>import</code> statements come after the header and before any constants.

* **Import only one module per line**:
<code>import rosetta</code>
<code>import rosetta.protocols.rigid</code>
not
<code>import rosetta, rosetta.protocols.rigid</code>

  *  It is OK to import multiple classes and/or methods from the same module on the same line:
<code>from rosetta import Pose, ScoreFunction</code>

* For really long Rosetta namespaces, **use namespace aliases**, *e.g.*:
<code>import rosetta.protocols.loops.loop_closure.kinematic_closure as KIC_protocols</code>

* **Avoid importing <code>*</code> from any module**. With large libraries, such as Rosetta, this is a waste of time and memory.

* **Group <code>import</code> statements in the following order** with comment headings (*e.g.*, <code># Python standard library</code>) and a blank line between each group:
  1. Python standard library modules
  2. Other, non-Rosetta, 3rd party modules
  3. Rosetta modules (by namespace)
  4. Your own custom Python modules

* **<code>rosetta.init()</code> belongs in the main body of your script,** not in the imports section. (See [Main Body](#main-body) below.)

####Constants & Module-Wide Variables
Module-wide constants and variables should be defined next, after the imports.

* **Constants should be named in <code>ALL_CAPS_WITH_UNDERSCORES</code>.** (See [Naming Conventions](#naming-conventions) below.)

* **Avoid using the <code>global</code> statement anywhere in your code.** All constants should be treated as read-only.

* **Do not define your own mathematical constants.** Use the ones found in the Python <code>math</code> module.

####Class & Method Definitions
Classes and exposed methods should come next in the code.

* **Add two blank lines between each class and exposed method.**

* **Add one blank line between each class method.**

* **Docstrings for classes and methods are indented _below_ the class/method declaration as part of the definition.**

* **Group non-public methods together, followed by shared methods.** Non-public methods should also be prefixed with (at least) a single underscore. (See [Naming Conventions](#naming-conventions) below.)

* For methods, **if there are too many arguments in the declaration to fit on a single line, align the wrapped arguments with the first character of the first argument**:
<code>def take_pose_and_apply_foo_to_its_bar_residue_n_times(pose, foo,</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bar, n):</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;"""Apply foo to the bar residue of pose n times."""</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;pass</code>

####Main Body
* If your Python code is intended to be used as a script as well as a module, put
<code>if __name__ == "__main__":</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;rosetta.init()</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;my_main_subroutine(my_arg1, my_arg2)</code>
at the end of the file.

* If your Python code is intended to be a module only, do not include <code>rosetta.init()</code>. It should be in the main body of the calling script.

* If your Python code is intended to be a script only, do not include the <code>if __name__ == "__main__":</code> check.
  * (Although, it is probably smarter to write your code in such a way that other scripts can call its methods. You never know when you might want to re-use an awesome function.)

----

###Naming Conventions
As in Rosetta 3 C++ code, use the following naming conventions:
* **Use <code>CamelCase</code> for class names** (and therefore, exception names).
  * Derived classes should indicate in their name the type of class they are:
     * Exceptions should end in <code>Exception</code>, <code>Error</code>, or <code>Warning</code>, as appropriate.
     * Movers should end in <code>Mover</code> or <code>Protocol</code>.
     * Energy methods should end in <code>EnergyMethod</code>.
* **Use <code>box_car</code> with underscores separating words for variable and method names.**
  * Separate getter/accessor and setter functions should be prefixed with <code>get_</code> (or <code>is_</code> for functions returning a boolean).
  * Overloaded functions that perform both gets and sets do not need prefixes. (However, in Python, if you are simply accessing a public property of a class, you do not need to write a getter or setter; you may access &mdash; and set &mdash; the property directly, *e.g.*, <code>PyJobDistributor.native_pose = pose</code>.)

* **Use <code>box_car</code> with underscores for namespaces & directories**, *i.e.*, modules & packages.
  * For Python files, use <code>box_car</code> with underscores **even for modules containing only a single class**. (This differs from the C++ convention (*e.g.*, <code>Pose.cc</code>) and is because the filenames themselves become the namespace in Python.)

* It is OK to use capital letters within variable and method names for words that are acronyms or abbreviations, *e.g.*, <code>HTML_parser()</code>.
  * However, if the variable name consists exclusively of an acronym or abbreviation, *do not* capitalize it, *e.g.*, <code>url = "http://www.rosettacommons.org"</code>, not, <code>URL = "http://www.rosettacommons.org"</code>.

* Likewise, it is OK to use an underscore to separate an acronym or abbreviation from other words in class names, *e.g.*, <code>PyMOL_Mover</code>.

In addition, the following conventions are unique to Python code:
* **Use <code>ALL_CAPS</code> with underscores for constants.**

* **Use <code>_box_car</code> with a leading underscore for non-public methods and <code>_CamelCase</code> with a leading underscore for non-public classes.**
  * These will not be imported if one invokes <code>from module import *</code>.
  * Note that this is the opposite of the naming convention for C++.
  * Use a leading *double* underscore in a parent class's attribute to avoid name clashes with any sub-classes.

* **Use <code>box_car_</code> with a trailing underscore only to avoid conflicts with Python keywords**, *e.g.*, <code>class_</code>.

* **Never use <code>__box_car__</code> with leading and trailing double underscores;** that is reserved for special Python keywords, *e.g.*, <code>__init__</code>.

* **Avoid one-letter variable names.** A descriptive name is almost always better.
  * One-letter variables are fine for mathematical variables or indices, *e.g.*, <code>x, y, z, i, j, k</code>.
  * Never use the characters l, O, or I as one-letter variable names, as they are easily confused with 1 and 0.

* **Use <code>self</code> as the name of the first argument for class methods...**
  * ...unless it is a static class method &mdash; in which case use <code>cls</code>.

----

###Programming Guidelines
####Methods
* Python automatically passes objects into methods by reference and not by value. Thus, **there usually is not a need to return an object that was passed and then modified** by the method.
  * Python automatically passes primitive types into methods by value.

* As in C++, **conditional checks should happen inside the _called_ method rather than in the calling method** when possible. This helps keep things a bit more modular and also ensures that your method has no bad side effects if someone calls it but forgets to check for the essential condition. For example: 
Instead of
<code>if condition_exists:</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;my_method()</code>
use
<code>my_method()</code>
where <code>my_method()</code> begins with
<code>if not condition_exists:</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;return</code>

####Classes & Objects
* **Avoid multiple inheritance.**

* All custom exceptions should inherit from <code>Exception</code>. **Do not use string exceptions.** (They were removed in Python 2.6. See [Exception Handling](#exception-handling) below.)
  * As with any class, include a docstring. (See [[Documentation|Python-coding-conventions-for-Rosetta#documentation]] below.)

* **Check the type of arguments passed to a Python class method if it is possible that that method could be called from both Python and C++.**
<!--TODO Check if this is still true -->
  * When Rosetta 3 code calls a Python method (such as a custom mover being called by a Rosetta 3 mover container), the arguments are passed as access pointers (AP), which must be converted to raw pointers (with the <code>get()</code> method) for Python to use them.
  * When Python calls a Python method, the arguments are passed by reference.
  * To avoid this issue, check the type of any object arguments passed; if they are APs, call <code>get()</code>. For example:
<code>class MyMover(rosetta.protocols.moves.Mover):</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;def apply(self, pose):</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if isinstance(pose, rosetta.core.pose.PoseAP):</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pose = pose.get()</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pass</code>

  * (For convenience, a "dummy" <code>get()</code> method has been added to <code>Pose</code> that returns the instance of the <code>Pose</code>, so that one can use <code>pose = pose.get()</code> without checking its type first. However, it would be impractical to add a <code>get()</code> method to every class in Rosetta that one might wish to use in PyRosetta, so check the type!)

* **Be careful not to say <code>pose = native_pose</code> when you really mean <code>pose.assign(native_pose)</code>.** The former creates a shallow copy; the latter a deep copy.

####Comparisons
* **For comparisons to singletons (<code>True</code>, <code>False</code>, <code>None</code>, a static class) use <code>is</code> not <code>==</code>**.
  * &hellip; Except you should not need to ever write <code>if is_option_on is True:</code>; write <code>if is_option_on:</code> instead.
  * Likewise, use <code>if not is_option_on:</code>.
  * **Be careful!** Only use <code>if variable:</code> for booleans; <code>if variable is not None:</code> is safer. (Some container types, *e.g.*, can be false in a boolean sense.)
     * &hellip;So use <code>if not list:</code> in place of <code>if len(list) == 0:</code>.

* Don't write <code>if x < 10 and x > 5:</code>; **simplify this to <code>if 5 < x < 10:</code>.**

* **Use <code>!=</code> instead of <code><></code>** for consistency.

* **Use <code>if my_string.startswith("foo"):</code> and <code>if my_string.endswith("bar"):</code> instead of <code>if my_string[:3] == "foo":</code> and <code>if my_string[-3:] == "bar"</code>. Besides the fact that the former is *way* easier to read, it's safer.

* **Use <code>if isinstance(object, rosetta.core.pose.Pose):</code>;** do not use <code>if type(object) is rosetta.core.pose.Pose:</code>.

####Command-Line Options
* **Use the module [[argparse|http://docs.python.org/library/argparse.html#module-argparse]], not [[optparse|http://docs.python.org/library/optparse.html?highlight=optparse#optparse]].** <code>optparse</code> was deprecated and replaced in Python 2.7, and <code>argparse</code> does all the same things.

####Exception Handling
* **Use <code>if</code> and <code>try/except</code> blocks to test for errors that could happen in normal program operation.** Errors should generate useful reports that include the values of relevant variables.
  * Your errors should be classes that inherit from <code>Exception</code>. (See [Classes](#classes) above.)

* **Use <code>raise HugeF_ingError("Oh, crap!")</code>, instead of <code>raise HugeF_ingError, "Oh, crap!"</code>.** (This makes it easier to wrap long error messages. Plus, it's going away in Python 3.0.)
  * Never write <code>raise "Oh, crap!"</code>; that already went away in Python 2.6.

* **Keep the number of lines tested in a <code>try</code> block to the bare minimum.** This makes it easier to isolate the actual problem.
  * (Remember, you can add an <code>else</code> or a <code>finally</code> afterwards.)

* **Avoid naked <code>except</code> clauses.** They make it more difficult to isolate the actual problem.
  * If you have a good reason, at least use <code>except Exception:</code>, which is better than <code>except:</code> because it will only catch exceptions from actual program errors; naked <code>except</code>s will also catch keyboard and system errors.
  * You can also catch multiple exceptions with the same <code>except</code> clause, *e.g.*, <code>except HugeF_ingError, SneakyError:</code>.

####PyRosetta-Unique Methods
* If you need to instantiate a particular Rosetta <code>vector1_<of_type></code> container for use in a Rosetta function, if possible, **use PyRosetta's <code>Vector1()</code> constructor function,** which takes a list as input and determines which <code>vector1_<of_type></code> is needed.
For example, instead of:
<code>list_of_filenames = utility.vector1_string()</code>
<code>list_of_filenames.extend(["file1.fasta", "file2.fasta", "file3.fasta"])</code>
use:
<code>list_of_filenames = Vector1(["file1.fasta", "file2.fasta", "file3.fasta"])</code>

* **Use <code>pose_from_sequence()</code>** instead of <code>make_pose_from_sequence()</code>. (The former has &omega; angles set to 180&deg; automatically.)

####Miscellaneous
* **Write <code>a += n</code>, not <code>a = a + n</code>.**
  * Likewise, use <code>a -= n</code>, <code>a *= n</code>, and <code>a /= n</code>.

* **Use list comprehensions.** They are beautiful.
  * For example, instead of:
<code>cubes = []</code>
<code>for x in range(10):</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;cubes.append(x**3)</code>
or:
<code>cubes = map(lambda x: x**3, range(10))</code>
use:
<code>cubes = [x**3 for x in range(10)]</code>
(Lambda functions are super cool, but the second example is far less readable than the third; if you have a <code>lambda</code> inside a <code>map</code>, you should be using a list comprehension instead.)

  * You can also use <code>if</code> to limit the elements in your list:
<code>even_cubes = [x**3 for x in range(10) if x**3 % 2 == 0]</code>

* **Use <code>with</code> when opening files.** Context management is safer, because the file is automatically closed, even if an error occurs.
For example, instead of:
<code>file = open("NOEs.cst")</code>
<code>constraints = file.readlines()</code>
<code>file.close()</code>
use:
<code>with open("NOEs.cst") as file:</code>
<code>&nbsp;&nbsp;&nbsp;&nbsp;constraints = file.readlines()</code>

----

###Documentation

####Docstrings
[[Doxygen|http://www.stack.nl/~dimitri/doxygen/]] can autodocument Python code in addition to C++ code, but in the case of Python, it simply reads the <code>__doc__</code> attribute of every module, class, and method. This is why it is crucial to put all class and method docstrings indented *below* the declaration line. Otherwise, they will not be stored in the proper <code>__doc__</code> variable. (In Python,...
<pre>
class MyClass():
    """This is my class.
    It is great.
    
    """
</pre>
...is equivalent to...
<pre>
class MyClass():
    __doc__ = "This is my class.\nIt is great.\n\n"
</pre>

* **Always use double quotes for docstrings.** While Python recognizes both <code>"""</code> and <code>'''</code>, some text editors only recognize the former.

* **All classes and methods must contain a docstring with at least a brief statement** of what the class or method is or should do, respectively.
  * The first sentence of the docstring contains this "brief".
     * It should fit on one line.
     * It should be on the same line as the opening <code>"""</code>.
     * If it is the only line in your docstring, put the closing <code>"""</code> on the same line.
     * For classes, it should be a descriptive/indicative sentence, *e.g.*, <code>"""This class contains terpene-specific ligand data."""</code>
     * For methods, it should be an imperative sentence, *e.g.*, <code>"""Return True if this ligand is a sesquiterpene."""</code>
  * Separated by a blank line, further details of the class or method's implementation should follow, particularly describing key methods (for classes) and key arguments and what is returned (for methods).
  * While not required, it is encouraged that you include an example.
     * If you want really great examples, make them compatible with Python's [[doctest|http://docs.python.org/library/doctest.html?highlight=doctest#doctest]] module.
  * It is also helpful to include a "See also" list.
  * End the docstring with a blank line and then the closing <code>"""</code>.

* Docstrings for scripts should be written to serve also as the script's help/usage message.
  * &hellip;unless you are using the [[argparse|http://docs.python.org/library/argparse.html#module-argparse]] module, in which case, use it to generate help/usage messages.

* Docstrings for modules should list all public classes and methods that are exported by the module.

* Document a class's constructor in the <code>__init__()</code> method's docstring, not in the class's docstring.

####Comments

* **Comments should usually be complete sentences.**
  * Use proper grammar, capitilization, and punctuation.
  * Use two spaces between sentences.
  * Never change the case of a variable mentioned in a comment, even if the first word of a sentence.

* **Use block comments to talk about the code immediately following the comments.**
  * Don't use docstrings to substitute for block comments.

* **Use inline comments (sparingly) to clarify confusing lines.**

----

###Coding Style
As mentioned at the top of this page, when it doubt, follow [[PEP 8|http://www.python.org/dev/peps/pep-0008/]].

####Indentation
* **Use 4 spaces to indent,** not tabs.
  * (C++ code should use tabs.)

* **Indent 4 spaces per nested level.**

* **Indent 4 additional spaces when method arguments must be wrapped beyond the first line.**
  * ...Or use spaces to align the arguments.
  * Example 1:
<pre>
def take_pose_and_apply_foo_to_its_bar_residue_n_times(
        pose,
        foo,
        bar,
        n):
    """Applies foo to the bar residue of pose n times."""
    pass
</pre>
Example 2:
<pre>
def take_pose_and_apply_foo_to_its_bar_residue_n_times(pose, foo,
                                                       bar, n):
    """Applies foo to the bar residue of pose n times."""
    pass
</pre>

####Spaces in Expressions & Statements
While there are numerous different styles for using spaces in argument lists and expressions in C++, [[PEP 8|http://www.python.org/dev/peps/pep-0008/]] recommends the following (and provides many examples):

* **Do not put spaces around parentheses, brackets, or curly braces.**

* **Do not put spaces before commas, colons, or semicolons.**

* **Put one space around operators.**
  * Exception: do not put spaces around <code>=</code> if used as part of a keyword argument or default value assignment in a method call or declaration, respectively.
  * Do not use more than one space, such as to line up values when variable names have different lengths.
  * In mathematical formulae, it is OK to not use spaces with operators of higher priority, *e.g.*, <code>y = a*x**2 + b*x + c</code>.

####Miscellaneous
* **Limit lines to a maximum of 79 characters.**
  * Python knows to continue lines that have not closed their parentheses, brackets, or curly brackets yet. Use this to your advantage.
  * If you must use <code>\</code> to wrap lines, do so after any operators.

* **Do not put semicolons at the end of lines.**

* **Do not use semicolons to combine multiple lines.**
  * Similarly, do not put the body of a block statement on the same line as the statement itself; indent.

----

##Example Code##

[to be added later&hellip; ~ [[labonte|https://wiki.rosettacommons.org/index.php/User:Labonte]] 20:56, 31 Aug 2012 (PDT)]

----

##See Also
* [[Coding Conventions]] for Rosetta C++ code
* [[PEP 8 &mdash; Style Guide for Python Code|http://www.python.org/dev/peps/pep-0008/]]
* [[PEP 20 &mdash; The Zen of Python|http://www.python.org/dev/peps/pep-0020/]]
* [[PEP 257 &mdash; Docstring Conventions|http://www.python.org/dev/peps/pep-0257/]]
