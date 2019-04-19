# Project Instructions
* Milestone 1: **4/23/19**
  * Join the Piazza group as organized by Prof Snyder
  * Create a group repo, and summarize your plans in the readme:
    * Which Additional Features you plan to do (tentative, can be changed)
    * Who has primary responsibility for what (should be approximately equal, and, again, can be changed)
  * Completion is worth 5pts/100.
* Milestone 2: 4/29/19
  * Details TBA
  * Completion is worth 5pts/100.
* Final Deadline: 5/3/19
  * Completion is worth 90pts/100.
## Getting Started
* Come up with a language name/team name among your group
* Follow this [Link](https://classroom.github.com/g/potVpRHi) to create/Join a group repo.  Even if you are working alone.
* Like in [Week 1](../assignments/week1#setup-your-local-repository) you will need to `git clone` the new repository! 
  * ```cd``` into the newly created directory 
  * You always want to take advantage of the latest corrections to the assignments and shared tests so we will add the main repository as a source
    * In your terminal type ```git remote add upstream https://github.com/BU-CS320/Spring-2019.git```
    * check that it worked by typing ```git remote -v```.  You should see see the line ```upstream https://github.com/BU-CS320/Spring-2019.git (fetch)```
    * You always want to keep your assignment up to date by running ```git pull upstream master```, do that now
  * check the status of your repo: ```git status```
* Read [Before You Begin](BEFORE.md)


	
## Requirements
This will acount for 60/100 of the points.

Many of the requirements are flexible, for instance if you want to use Java-style comments instead of the Haskell's style or use Python's `and` instead of `&&` talk to Mark. 

### Required ("Vanilla") Features
New features which need to be added beyond your week 10 code:
* Additional syntax for lists.  For example ```[1,2,3]```
* Single and multiline comments. For example ```x+ 7 -- this is a comment``` and ```x+ {- this is a multi-line comment-} 7```
* Support for logging
  * a `print` keyword 
  * a sequencing infix operator `;`
* Implement a static check that takes in an `Ast` and warns when a variable is used when not declared. For instance  `\ x -> y + 10` should warn something like "y is not in scope".  This will not be part of your parser or interperter(eval), but should be implemented in a separate `check` function which is executed between the parser and the evaluator. 
* Add support for the following types of data: floats, characters, strings, lists, and pairs (tuples with two elements)
* You must write a suite of hunit-style tests for your code to verify its correctnes; there will be a lecture about this on Wednesday 4/24.
  * You need a test group for each of the feature you implemented.
  * You need to have enough tests to convince us your code is correct by just looking at your tests, so make sure to cover all the edge case you can think of and every possible error
  * You can build on the test of week10, but you need to add more tests (not just for mix-ins, for vanilla as well).
* Add support for the infix operators and functions in the tables below
  * All operators and functions should report a sensible error message when applied incorrectly.  For example `[0,1] !! 10` should return an error like "Can't get element 10 from a 2 element list" and `7 !! 10` should return "7 is not a list"

In general, the precedence, associativity, and default meaning should be as in <a href="https://self-learning-java-tutorial.blogspot.com/2016/04/haskell-operator-precedence.html">Haskell</a>. But there
is one important exception: the precedence for application should follow the last homework (application is lower in
precedence) rather than a very high precedence (as in Haskell). This is a matter of taste perhaps, but it makes
things a little easier in terms of implementation to make application have low precedence. Otherwise, you can follow
the Haskell rules. The operators are listed below in classes (operators of the same precedence) in increasing order
of precedence, with associativity and other characteristics noted.  

<pre>  
Infix Operators (blank lines precedence classes, in increasing order, L associative except as noted)

    ;     Separator                                 -- lowest precedence, R associative
    
          Application                               -- function application (no operators, just a blank between expressions)
	
    :     List cons                                 -- R associative
    ++    List concatenation                        -- R associative
    
    +     Addition                                  -- these three operators will be overloaded but require both operands to be the same type. 
    -     Subtraction                               -- this is overloaded to also be a unary minus function (see below)
    
    *     Multiplication                         
    /     Floating-Point Division                   -- note: exponentiation and division operators will NOT be overloaded 
    //    Integer Division   
    %     Modulus (remainder after integer division)
    
    ^     Floating-Point Exponentiation             -- R associative
    **    Integer Exponential                       -- R associative

    &&    Boolean And  
    
    ||    Boolean Or 
    
                                                     -- relational operators are non-associative (can only be one in expression)
						     -- relational operators are overloaded for all types except functions
						     -- but both operands must be same type
						     -- relational operators are non-associative (only one per expression)
    ==    Equals                                                        
    /=    Not-equal                                                     
    <     Less-than                                  -- these four operators only need to compare integers and floats  
    <=    Less-than-or-equal                         
    >=    Greater-than-or-equal              
    >     Greater-than 
     
    !!    List indexing operator                     -- R associative
	  

Miscellaneous

    \ and ->   Lambda abstraction constructors
    [ and ]    List constructors, "," as separator
    ' and '    Char constructors
    " and "    String constructors
    --    Start of comment line (ignore everything until the next newline)
    {-    Start of multi-line comment 
    -}    End of multi-line comment

    Also include expressions defined by keywords, i.e., if-then-else, let-in, and print. 
    
Predefined Functions

    head
    tail
    elem                                           -- will only work on types where equaility makes sense, for instance: elem [\x -> x*0] (\y -> 0) should return an error
    map
    filter
    foldr
    ord     (char -> integer)
    chr     (integer -> char)
    float   (integer -> float)
    int     (float -> integer with truncation)

</pre>

In addition, all week 10 language features must still work:
* The parser must still work on week 10 examples (unless it would conflict with a new feature)
* Ast, Val must be `Show`able
* The `showFullyParen` and `showPretty` must be consistent with your parser (By "consistent" we mean that if you take an AST expression, pretty-print it, and then parse it, you should end up with the same AST)
* There is a `run` and `exec` function that behaves as expected.
* Continue to support integers, Booleans and curried function types (functions of one argument)
* The language constructs from last HW must still work: let, if-then-else, etc.
* Dynamic type-checking for expressions for all operators and predefined functions and for all types, and reporting of appropriate errors.

We recommend:
* You can start with your implementation for the last homework and simply add these operators in their appropriate places.  
* You should modify the `EnvUnsafe` monad code to include logging (the `Writer` monad) using a `print` expression, as we did in a previous homework (because we will be adding the print and separator from [lang2](../assignments/week7/src/lang/Lang2.hs))
* You should provide an `eval` function to evaluate expressions in the `Ast` into a suitable result type analogous to `EnvUnsafe Env  Val` from the last homework; it should use your modified monad.
* With project this size, good variable name and nice documentation will never be a waste of time. Write as much documentation as you can and also make your variable name as descriptive as possible.
* Start early!

### Additional ("Mix-In") Features
This will account for 30/100 of the points.  Listed point totals are approximate and may change.

You will be graded based on hunit test cases that you will provide us (unless specified otherwise)

Professor Snyder will give a lecture on types and type checking on Monday 4/22, and on testing on Wednesday 4/24, and may try to sneak in a lecture on the IO monad as well. And will sneak in a couple of videos...

"Simple" additions
* 5pt Add an infix function composition operator `(.)`.  So you may write `f . g` instead of `\x -> f (g x)`
* 5pt Make lambdas support multiple arguments.  So you may write `\x y z -> x` instead of `\x -> \ y -> \ z -> x`
* 5pt Add multiple sequential definitions to `let`.  So you may write `let x = 4, y = x + 5, z = y in z * 2` instead of `let x = 4 in (let y = x + 5 in (let z = y in z * 2))`
* 5pt Add `letrec` to make recursion more convenient. So you can write `letrec f = \ x -> if x == 0 then 1 else x * (f (x-1)) in f 5`.  Alternatively you may also add this functionality to `let`.  There will be a video about this issue shortly. 

Modules
* 15pt Top level mutually-recursive function definitions. You may want to add a top level operator `=` (without a `let`). 
* 10pt A language feature to import a "file" of definitions. [*](#medium)

Parser enhancments
* 10pt Add error reporting to the `Parser` monad, your parser should fail with clear context specific error messages.
* 5pt Parser which calculates the line and character where it failed for more precise error reporting.
* 10pt Scope based on indentations like in Haskell and Python[*](#medium)

Usability
* Pattern matching [*](#medium)
  * 5pt `case ... of` expressions for the integers and bools
  * 5pt Nested pattern matching that allows integers, bools, and lists.
  * 5pt Build pattern matching into lambda expressions for integers, bools, and lists.
* User-defined data types
  * 5pt Definitions and constructors 
  * 5pt Pattern-matching [*](#medium)
  * 10pt Typechecking
* 5pt A Read-Eval-Print loop, so that users can work interactively with your language, including preloading a 
      Prelude-like initialization file. You would need to learn about the IO monad (start with Chapter 10 in Hutton).

Static Checking
* 5pt Warn when a variable is introduced but never used
* 15pt Checking simple types, where every variable has a type annotation (lecture will be presented on this)
* 20-30pt  Advanced type checking: Bidirectional, Hindly-milner, or dependently typed [**](#difficult -- talk to Mark)

Mutable state
* 10pt Dynamically scoped mutable state[*](#medium)
* 20-30pt Lexically scoped mutable state[**](#difficult)

Misc
* 10pt Add runtime warnings to the monad, and flag appropriate conditions which are not errors, but cause concern (e.g., you defined a variable or function but then didn't use it, as in the Ok monad presented in lecture).
* 5-15 pt Overloaded operators and constants, automatic type conversion (as in Java or Python) [*](#medium)

Additionally you can get points by using engineering best practices
* 5pt Writeing a quickcheck generator and shrinker for your Ast and using it to test your parser
* 5pt Writing clear Haddock style comments and generating the html documentation
* 5pt Setting up Continuous Integration on your github repo[*](#medium)


You can implement as many features as you want but you cannot score above a 100

There are many other features, small and large, which could be imagined (orderings on lists? array types? n-ary tuples? conversion between prefix and infix? lazy evaluation? compilation[**](#difficult)?   The list goes on and on.....).  Please talk to Mark if you have creative ideas!  Some things are very challenging, and may change the language specification drasticly: these need to be aproved by Mark before the first milestone, and may require additional work by the 2nd milestone.

<a name="medium">*</a> Mark needs to aprove before Before Milstone 2. Might require some work on our end, for instance We might need to give you extra permissions in your repo for you to set up Continuous Integration.

<a name="difficult">**</a> This is challenging, Mark needs to approve before Milestone 1



