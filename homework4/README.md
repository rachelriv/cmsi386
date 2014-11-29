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
new activation record ends up exactly where the old one was. This behavior is nondeterministic though since
on other systems the stack may have not been initialized or cleared. Therefore, you cannot count on any
specific behavior to be consistent.

8)


With shallow binding, all calls to setX and printX within foo use the localized x,
which is successively 1, 2, 3, and then 4. All calls to printX use the global x, which is 0.
The output with shallow binding is 10203040.

With deep binding, the direct calls refer to the localized x, because direct calls are simply
regular old calls and the basic dynamic scoping rules apply. The only time we ever care
about deep and shallow binding is when a subroutine is called through a reference. In this
problem we are passing setX and printX, which refer to a variable x. When we passed
them, x referred to the global x. So with deep binding, the parameters S and P will be
such that they will refer to the global x.
