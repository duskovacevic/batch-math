# batch.math

This library allows windows batch scripts to make use of floating point arithmatic and basic mathematical functions.

As windows batch does not have hardware support for floating points this library implements a software floating point type.

This library is not intended for any practical use and there are no plans to make it more performant nor accurate.

Performance nor accuracy of this library is not the main objective and instead it's an excercise of exploring how floating point arithmetic is done by computers and how to derive corresponding arithmetic, trigonometric, hyperbolic and exponential functions.

This math library writen in pure batch in order to impose real restictions of **no hardware support** for floating point arithmatic.

But in addition batch allows for:
- 32 bit integer values
- Support for bitwise operators
- Basic support for defining functions, manipulating strings and storing variables

To make coding simpler the batch files are split up per function, with basic preprocessing done with Python to allow insertion of constants, better logging and file concatination. 

## Make use of the library
If you would like to try the library for yourself there are two modes of operation:
- Running from a command line
- Running from a batch file

### Command line example

```batch
.\output\math.cmd :sin 1.0

1.0,0.841470971064330760
```

> [!NOTE]
> The output returns both the input value and result.

### From a batch file

```batch
set math=.\output\math.cmd

:: Convert string input into a float type
call %math% x = :set 1.0

:: Call sin function
call %math% y = :sin %x%

:: Covert float type to string
call %math% result = :to_string %y%

echo %result%

0.841470971064330760
```

## Build and test

In order to produce the output batch file either:
- Run a build command in VS code
- Or run

```shell
python ./build.py
```

To run tests against the library either:
- Run a test command in VS code
- Or run

```shell
python ./tests/test.py
```

Tests will execute all mathematical functions over a range of values and produce a CSV output as well as a plot graph of function vs input. 

> [!WARNING]
> The tests will take a very long time to run.

![Sin(x)](/output/plots/sin.jpg)