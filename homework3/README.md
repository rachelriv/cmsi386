## Problem 1
```
                   %=

                 /    \

              ||       ^

             /  \     / \

          >=     y   7   &

        /    \          / \

     >=       *        6   p

    /  \     /  \

   =    m   !    ~

  / \       |    |

 a   3      &    6
            |
            4
```
## Problem 2

(a)

The programmer was probably trying to return the object `{x: 5}`, 
but since JavaScript inserts a semicolon automatically after a
return followed by a newline, the code returns undefined. This
code consists of two statements, the first statement is a [return](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/return) statement, which returns `undefined` since the expression is omitted. The second is a never-reachable [block](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/block) statement
with a [label](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label) `x` that evaluates 5.

Python assumes that each physical line corresponds to a [logical line](https://docs.python.org/2/reference/lexical_analysis.html#logical-lines). Since statements cannot cross logical line boundaries except where NEWLINE is allowed by the syntax, the equivalent Python code would return `None`, since a [return statement](https://docs.python.org/2/reference/simple_stmts.html#the-return-statement) with no expression to evaluate will substitute `None`. The statement containing the dictionary `{'x': 5}` will never
be evaluated.

(b)

The programmer was probably expecting the second newline to end the
declaration/initialization of `a`, but in fact, the code is 
initializing `a` to be `b +
b(4+5).toString(16)`. This will get us a `TypeError` because `b` is not a
function.

Again, Python assumes that each physical line corresponds to a logical line (see previous answer). Thus, the second newline _would_ end the declaration/initialization of `a`.


(c)

The programmer probably thought that the first newline ended the
declaration/initialization of `place`, but `place` was intialized to
`"mundo"["Hola", "Ciao"].forEach(...)`. The [comma](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comma_Operator) operator evaluates each
of the operands and returns the value of the last operand. The code is
equivalent to `"mundo"["Ciao"]...`. `"mundo"["Ciao"]` evaluates to 
`undefined`. This throws a `TypeError` because you cannot invoke the
function `forEach` on `undefined`.  

Again, Python assumes that each physical line corresponds to a logical line (see answer 2a). Thus, the second newline _would_ end the declaration/initialization of `a`.


(d)

The programmer probably thought she was just declaring a variable named
`sayHello` and initializing it to a function that alerts "Hello", and 
creating an anonymous closure that alerts "Goodbye". She probably expected
that only "Goodbye" would get alerted because that closure would be
immediatedly executed. However, what the code is actually doing is initializing
`sayHello` to a function alerting "Hello" with an argument. That argument
is evaluated and it alerts "Goodbye" *first*, before evaluating to
undefined. Next, `sayHello` is executed with the argument `undefined`,
and "Hello" is alerted next. 

In Python, there is really no equivalent, since functions 
cannot be immediately invoked. However, if this were possible, newlines
are significant, and the initialization of `sayHello` would end when the
programmer would expect it to. 

## Problem 3 

```c
void staticBreakingFunction(unsigned int foo) {
    int bar = 0;
    if (foo == 0) {
        bar++;
    } else {
        staticBreakingFunction(--foo)
    }
    printf("%d\n", bar);
}

int main() {
    staticBreakingFunction(5);
    return 0;
}
```

## Problem 4

For static scoping
```
1
1
2
2
```
In static scoping, the second execution of `setX()` within the second function
changes the global x to two.

For dynamic scoping
```
1
1
2
1
```
In dynamic scoping, the second execution of `setX()` changes the local variable
`x` to `2`, since the current binding for a name is the one most recently
encountered in execution.

## Problem 5 

Prefix: `/ + _ b sqrt * * 4 a c * 2 a`

Postfix: `b _ 4 a * c * sqrt + 2 a * /`

Yes, we need special unary negation, because we can only get away with no
parentheses if each operator has fixed arity. Since the minus (`-`) symbol could
have one or two operands, it is ambigious. Set the underscore (`_`) to be the
unary negator. Interestingly enough, GNU Emacs uses the same choice. 

## Problem 6 

```python
a = 1
b = 1
c = 0
d = 1
def f(b):
  global c
  c+=1
  return 0
a + f(b) - c * d
```

If we have Java style defined evaluation order, there is left to right ordering, so `f(b)`
will be called, and thus `c` will be mutated before `c * d` will be called, and
the statement will be evaluated to `0`. 

If we have undefined ordering, we don't know which of the two would be evaluated
first, and different implementations could change the evaluation. Thus, the
expression could be evaluated to either `0` or `1`. 

## Problem 9
 
(a)

Not very efficient, because the `fringe` function constructs the entire
fringe for each tree when it gets called. 

(b)
 
```python
from itertools import izip_longest
def same_fringe(t1, t2):
  def next_fringe(tree):
    tree_children = tree.children
    if tree_children == []:
      yield tree
    else:
      for child in tree_children:
        next_fringe(child)
  
  t1_fringe = next_fringe(t1)
  t2_fringe = next_fringe(t2)
  for tree1_node, tree2_node in izip_longest(t1_fringe, t2_fringe, fillvalue=[]):
    # We know that tree_children cannot be '[]'. So use that as a filler if the
    # trees have a different length (they wouldn't be the same if that were the
    # case anyway.
    if tree1_node != tree2_node:
      return False
  
  return True
```
