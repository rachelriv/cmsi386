4)
```c
double *a[n]; /* an array of n pointers to doubles */
double (*b)[n]; /* a pointer to an array of n doubles */
double (*c[n])(); /* an array of n pointers to functions that return doubles */
double (*d())[n]; /* a function returning a pointer to an array of n doubles */
```
5) If I was a compiler, I would feel really worried about getting stuck into some kind of an infinite loop while
typechecking the expression. I'd feel less worried if I could detect cycles in the type dependency graph.

7) The stack may have been cleared upon starting the application. Thus, every time foo() is called the
new activation record ends up exactly where the old one was. In addition, many languages, like C, also initialize arithmetic types to positive/unsigned zero if they are not assigned to a value. (See <a href="http://c0x.coding-guidelines.com/6.7.8.html">C coding guidelines</a> and <a href="https://stackoverflow.com/questions/1597405/what-happens-to-a-declared-uninitialized-variable-in-c-does-it-have-a-value">this stackoverflow post</a>). This behavior is nondeterministic though since
on other systems the stack may have not been initialized or cleared. Therefore, you cannot count on any
specific behavior to be consistent.

8) Shallow binding just traverses up until it finds the nearest variable that corresponds to the name. With shallow binding, the following happens in the main part of the script:

Line 1:
`setX(0); foo(setX, printX, 1); printX();`

* `setX(0)` sets the global `x` to 0.
* All calls to `setX` and `printX` within foo use the localized `x`. Thus, when foo is invoked in this line, the localized `x` is set to 1 and 1 is printed.
* `printX()` refers to the global `x`, which has been set to 0. Thus, 0 is printed.
Output after the first line is executed: 10

Line 2:
`setX(0); foo(setX, printX, 2); printX();`

* `setX(0)` sets the global `x` to 0.
* When foo is invoked in this line, the localized `x` is set to 2 and 2 is printed.
* `printX()` refers to the global `x`, which has been set to 0. Thus, 0 is printed.
Output after the second line is executed: 1020

Line 3:
`setX(0); foo(setX, printX, 3); printX();`
* `setX(0)` sets the global `x` to 0.
* When foo is invoked in this line, the localized `x` is set to 3 and 3 is printed.
* `printX()` refers to the global `x`, which has been set to 0. Thus, 0 is printed.
Output after the third line is executed: 102030

Line 4:
`setX(0); foo(setX, printX, 4); printX();`
* `setX(0)` sets the global `x` to 0.
* When foo is invoked in this line, the localized `x` is set to 4 and 4 is printed.
* `printX()` refers to the global `x`, which has been set to 0. Thus, 0 is printed.
Output after the fourth line is executed: **10203040**

Deep binding binds the environment at the time the procedure is passed as an argument. This is applicable when we pass `setX` and `printX` as arguments. When `setX` and `printX` are passed as arguments, `x` refers to the global `x`. With deep binding, the following happens in the main part of the script:

Line 1:
`setX(0); foo(setX, printX, 1); printX();`
* `setX(0)` sets the global `x` to 0.
* In `foo`, the local `x` is set to 1. Thus, 1 is printed.
* `printX()` refers to the global `x`, which has been set to 0. Thus, 0 is printed.
Output after the first line is executed: 10

Line 2:
`setX(0); foo(setX, printX, 2); printX();`

* `setX(0)` sets the global `x` to 0.
* In `foo`, the global `x` is set to 2 since `setX` refers to the global `x`. The localized `x` is not set, so some implementation-specific garbage is printed. (We'll represent this with a question mark).
* `printX()` refers to the global `x`, which has been set to 2. Thus, 2 is printed.
Output after the second line is executed: 10?2

Line 3:
`setX(0); foo(setX, printX, 3); printX();`

* `setX(0)` sets the global `x` to 0.
* In `foo`, the localized `x` is set to 3. However, the `printX()` refers to the global `x`, which is 0. Thus, 0 is printed.
* `printX()` refers to the global `x`, which is still 0. Thus, 0 is printed.
Output after the third line is executed: 10?200

Line 4:
`setX(0); foo(setX, printX, 4); printX();`
* `setX(0)` sets the global `x` to 0.
* In `foo`, the global `x` is set to 4 and since `printX()` refers to the global `x`, 4 is printed.
* `printX()` refers to the global `x`, which was just set to 4. Thus, 4 is printed.
Output after the fourth line is executed: **10?20044**

9) In early Fortran implementations, the compiler would place the value of the literal 2 somewhere in memory. Every time the compiler would then see a 2, it would have to go fetch whatever was in the previously assigned memory address for the literal 2. However, the earlier implementation of Fortran allowed the programmer to even change constants. In this code, the value in the memory address assigned originally assigned for the literal 2 was changed.
Current Fortran compilers still pass by reference, but make a copy of literals/constants and pass references to the _copies_.

10) call by value: 1,2,3,4;
    call by value-result: 2,2,2,4;
    call by reference: 2,2,3,4;
    call by name: 2,2,3,3

