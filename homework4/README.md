1) __Goto__ is a statement found in many programming languages that performs a one-way transfer of control to another line of code, which is typically identified using a label [<a href="http://en.wikipedia.org/wiki/Goto">1</a>]. At the machine code level, a goto is a form of branch or jump statement. Though the use of goto was formally common, there has been considerable debate in academia and industry on the merits and use of goto statements.

Edsget Dijkstra, the man who became the iconic opponent of goto statements, wrote a famous letter in 1968 called _Go To Statement Considered Harmful_ [<a href="http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF">2</a>]. In the letter, Dijkstra discussed why the goto statement should be "abolished from all 'higher level' programming languages (i.e. everything except, perhaps, plain machine code)" [<a href="http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF">2</a>]. Dijkstra argued that goto statements complicate the task of analyzing and checking the correctness of programs. Though Dijkstra's influential letter made a compelling argument, not everyone shares his viewpoint. In Donald Knuth's _Structured Programming with go to Statements_, Knuth explored cases where eliminating goto statements did not really work [<a href="http://sbel.wisc.edu/Courses/ME964/Literature/knuthProgramming1974.pdf">3</a>]. Knuth asserted that goto statements are not the heart of the problem. According to Knuth, there has been "far too much emphasis on go to elimination" instead of "working directly for a qualitative goal like good program structure" [<a href="http://sbel.wisc.edu/Courses/ME964/Literature/knuthProgramming1974.pdf">3</a>].

Frank Rubin also disagrees with Dijkstra's beliefs. In 1987, Rubin published a criticism of Dijkstra's letter called _'GOTO Considered Harmful' Considered Harmful_ [<a href="http://cacm.acm.org/magazines/1987/5/10097-acm-forum/abstract">4</a>]. In this criticism, Rubin used the following example (rewritted by @rtoal in C) to argue in favor of the goto statement:
```c
int first_zero_row = -1;              /* assume no such row */
int i, j;
for (i = 0; i < n; i++) {             /* for each row */
    for (j = 0; j < n; j++) {         /* for each entry in the row */
        if (a[i][j]) goto next;       /* if non-zero go on to the next row */
    }
    first_zero_row = i;               /* went all through the row, you got it! */
    break;                            /* get out of the whole thing */
    next: ;
}                                     /* first_zero_row is now set */
```

Rubin recognized that there is a manner in which one could write this program without the use of a goto (rewritten here in C)http://ideone.com/KMPnuH :
```c
int j;
int i = 0;
int first_zero_row = -1;
do {
    j = 0;
    while (j < n && a[i][j] == 0) j++;
    i++;
} while (i < n && j < n);
if (j >= n){
    first_zero_row = i - 1; // went one too far
}
```
The problem with this solution is that it is very hard to read. I was forced to get out a paper and pen and go through a few iterations of the algorithm myself before I fully understood what was going on. Thus, I think that Rubin's argument is compelling since the solution with the goto statement is much more intuitive.

It seems as if goto statements may be appropriate for languages like C that do not have more powerful constructs (e.g. labeled loops). Most modern languages, however, _do_ have these powerful constructs. This makes this type of situation much easier to program. Examples in Java and JavaScript can be found below (Note: These examples make use of `return` statements, which Rubin seemed to have forgotten to use in his argument):

```java
//Java
row: for (int i = 0; i < n; i++){
    col: for(int j = 0; j < n; j++){
        if(a[i][j] != 0) {
            continue row;
        }
        return i;
    }
    return -1;
}
```
```javascript
// JavaScript
row: for (var i = 0; i < n; i++){
    col: for (var j = 0; j < n; j++){
        if(a[i][j] !== 0){
            continue row;
        }
        return i;
    }
    return -1;
}
```
Python, however, does not support labeled loops. There was a proposal to include named loops in python <a href="https://www.python.org/dev/peps/pep-3136/">PEP3136</a>, however, it was rejected with an explanation <a href="https://mail.python.org/pipermail/python-3000/2007-July/008663.html">here</a>. It was rejected on the basis that code so complicated to
require this feature is very rare. However, if you wanted to accomplish this in Python, you could still do so without a goto. Python has a cool `all` function that returns `True` if all elements of the iterable are `True`. Since zero is falsy in Python, this function can easily be used in order to create a solution in Python.
```python
# Python
for i, row in enumerate(a):
  if (all(row)): continue
  return i
return -1
```

All in all, it seems as if goto statements are really not needed for higher-level programming languages. I do, however, think that they may be acceptable in some cases in C since C does not have these nice, powerful language constructs.

4)
```c
double *a[n]; /* an array of n pointers to doubles */
double (*b)[n]; /* a pointer to an array of n doubles */
double (*c[n])(); /* an array of n pointers to functions that return doubles */
double (*d())[n]; /* a function returning a pointer to an array of n doubles */
```
5) If I was a compiler, I would feel really worried about getting stuck into some kind of an infinite loop while
typechecking the expression. I'd feel less worried if I could detect cycles in the type dependency graph.

7) The stack may have been cleared upon starting the application. In addition, many languages, like C, also initialize arithmetic types to positive/unsigned zero if they are not assigned to a value. (See <a href="http://c0x.coding-guidelines.com/6.7.8.html">C coding guidelines</a> and <a href="https://stackoverflow.com/questions/1597405/what-happens-to-a-declared-uninitialized-variable-in-c-does-it-have-a-value">this stackoverflow post</a>). Thus, the first time `foo()` is called, `i` could have been initialized to 0. Furthermore, every subsequent time `foo()` is called the
new activation record ends up exactly where the old one was. This could explain why on many systems the program will display repeatable behavior, printing 0 1 2 3 4 5 6 7 8 9. This behavior is nondeterministic though since
on other systems the stack may not clear the stack. Therefore, you cannot count on any
specific behavior to be consistent on different systems.

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

