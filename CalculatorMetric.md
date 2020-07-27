# CalculatorMetric
*Back to [[Filters|Filters-RosettaScripts]] page.*
## CalculatorMetric

[[include:simple_metric_CalculatorMetric_type]]

Combine one or more other real metrics in a semi-arbitrary equation. The equation is a standard mathematical expression using operators +-\*/\^ (caret is exponentiation) with standard operator precedence (when in doubt, use parenthesis).

Case sensitive variables can be defined using subtags, either with a simple metric, as a constant, or as a value stored in the pose. The value of the variable is determined only once, and the same value is used for all instances of the variable in the equation. Variables can also be defined within the equation itself, with the syntax "name = expression ;", with the terminal semicolon. The last entry must be the non-assignment expression to which the filter will evaluate to.

For convenience, several functions are defined as well:

ABS(), EXP(), LN(), LOG()/LOG10(), LOG2(), LOG(a,b), SQRT(), SIN() COS(), TAN(), R2D(), D2R(), MIN(...), MAX(...), MEAN(...), MEDIAN(...)

The function names are case insensitive. LOG(a,b) is the base b logarithm of a, trigonometric functions are in radians, R2D() and D2R() are functions to convert radians to degrees and vice versa, and MIN/MAX/MEAN/MEDIAN can take any number of comma separated values.

Example:

    <CalculatorMetric name="test" equation="t1 = exp(-E1/kT); t2 = exp(-E2/kT); t1/( t1 + t2 )" >
          <Var name="E1" metric="bound" />
          <Var name="E2" metric="altbind" />
          <Value name="kT" value="0.6" />
    </CalculatorFilter>

CAVEAT: The parsing of the equation is a little touchy and black-box at the moment. Diagnostic error messages are poor at best. I'd recommend starting with a simple equation and working your way up (bad equations should be detected at parse-time.)

## See also

* [[CalculatorFilter]]

