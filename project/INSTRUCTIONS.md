# Project Instructions
* Milestone 1: **4/23/19**
  * Create a group repo, and summarize your plans in the readme. 
  * Completion is worth 5pts/100.
* Milestone 2: 4/29/19
  * Details TBA
  * Completion is worth 5pts/100.
* Final Deadline: 5/3/19
  * Completion is worth 90pts/100.
## Getting Started
* Read [Before You Begin](BEFORE.md)
* Come up with a language name/team name among your group
* Follow this [Link](https://classroom.github.com/g/potVpRHi) to create/Join a group repo.  Even if you are working alone.
* Like in [Week 1](../assignments/week1#setup-your-local-repository) you will need to checkout the new repository! 
  * ```cd``` into the newly created directory 
  * You always want to take advantage of the latest corrections to the assignments and shared tests so we will add the main repository as a source
    * In your terminal type ```git remote add upstream https://github.com/BU-CS320/Spring-2019.git```
    * check that it worked by typing ```git remote -v```.  You should see see the line ```upstream https://github.com/BU-CS320/Spring-2019.git (fetch)```
    * You always want to keep your assignment up to date by running ```git pull upstream master```, do that now
  * check the status of your repo: ```git status```


	
## Requirements
This will acount for 60/100 of the points.

Many of the requirements are flexible, for instance if you want to use Java-style comments instead of the Haskell's style or use Python's `and` instead of `&&` talk to Mark. 

### Required ("Vanilla") Features
New features which need to be added beyond your week 10 code:
* Additional syntax for lists  (for example ```[1,2,3]```)
* Single and multiline comments (for example ```x+ 7 -- this is a comment``` and ```x+ {- this is a multi-line comment-} 7```)
* Support for logging
  * a `print` keyword 
  * a sequencing infix operator `;`
* Implement a static check that takes in an `Ast` and warns when a variable is used when not declared. For instance  `\ x -> y + 10` should warn something like "y is not in scope".  This will not be part of your parser or interperter(eval), but should be implemented in a seperate `check` function.
* Add support for the following types of data: floats, characters, strings, lists, and pairs (tuples with two elements)
* You must write a suite of hunit-style tests for your code to verify its correctness; there will be a lecture about this on Wednesday 4/24.
* Add support for the infix operators and functions in the tables below
  * all operators and functions should report a sensible error message when applied incorrectly.  For example `[0,1] !! 10` should return an error like "can't get element 10 from a 2 element list" and `7 !! 10` should return "7 is not a list"
<p>In general, the precedence, associativity, and default meaning should be as in <a href="https://self-learning-java-tutorial.blogspot.com/2016/04/haskell-operator-precedence.html">Haskell</a>. But there
is one important exception: the precedence for application should follow the last homework (application is the lowest
precedence) rather than a very high precedence (as in Haskell). This is a matter of taste perhaps, but it makes
things a little easier in terms of implementation to make application have low precedence. Otherwise, you can follow
the Haskell rules. </p>
<pre>  
Infix Operators 

    +     Add operator                              -- these three operators will be overloaded but require both operands to be the same type. 
    -     Subtract/negate operator                  -- this is overloaded to also be a unary minus function (see below)
    *     Multiply operator
    /     Floating-Point Division operator          -- note: exponentiation and division operators will NOT be overloaded 
    //    Integer Division operator  )
    ^     Floating-Point Exponentiation operator 
    **    Integer Exponential operator
    %     Modulus (remainder after integer division
    &&    And operator
    ||    Or operator
    ==    Equal operator                             -- relational operators will be overloaded,                   
    /=    Not-equal operator                         -- but both operands must be the same type                    
    <     Less-than operator                         -- these four operators only need to compare integers and floats  
    <=    Less-than-or-equal operator                
    >=    Greater-than-or-equal operator
    >     Greater-than operator
    \     Lambda operator
    :     Cons operator
    ->    Function mapping operator in lambda abstraction
    ++    List/string concatenation operator  
    !!    List indexing operator
    ;     Separator
	
	
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
    fst
    snd
  

Miscellaneous

    [ and ]    List constructors, "," as separator
    ( and )    Tuple constructors, "," as separator
    ' and '    Literal char constructors
    " and "    String constructors
    --    Start of comment line (ignore everything until the next newline)
    {-    Start of multi-line comment
    -}    End of multi-line comment
	
	       

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
* You can start with your implementation for the last homework and simply add these operators in their appropriate places by consulting the <a href="https://self-learning-java-tutorial.blogspot.com/2016/04/haskell-operator-precedence.html">Haskell refference</a>. 
* You should modify the `EnvUnsafe` monad code to include logging (the `Writer` monad) using a `print` expression, as we did in a previous homework (because we will be adding the print and separator from [lang2](../assignments/week7/src/lang/Lang2.hs))
* You should provide an `eval` function to evaluate expressions in the `Ast` into a suitable result type analogous to `EnvUnsafe Env  Val` from the last homework; it should use your modified monad.
* Start early!

### Additional ("Mix-In") Features
This will acount for 30/100 of the points.  Listed point totals are aproxomate and may change.

You will be graded based on hunit test cases that you will provide us (unless specified otherwise)

Professor Snyder will give a lecture on types and type checking on Monday 4/22, and on testing on Wednesday 4/24, and may try to sneak in a lecture on the IO monad as well. Or a video.....

"Simple" additions
* 5pt add an infix function composition operator `(.)`.  So you may write `f . g` instead of `\x -> f (g x)`
* 5pt make lambdas support multiple argumnets.  So you may write `\x y z -> x` instead of `\x -> \ y -> \ z -> x`
* 5pt add multiple sequential definitions to `let` with.  So you may write `let x = 4, y = x + 5, z = y in z * 2` instead of `let x = 4 in (let y = x + 5 in (let z = y in z * 2))`
* 5pt letrec

Modules
* 15pt top level mutually recursive function definitions. You may want to add a top level operator "=" (without a let). 
* 10pt A language feature to import a "file" of definitions. [*](#medium)

Parser enhancments
* 10pt add error reporting to the parser monad, your parser should fail with clear context specific error messages.
* 5pt parser calculates the line and character where it failed.
* 10pt scope based on indentations like in haskell and python[*](#medium)

Usability
* Pattern matching [*](#medium)
  * 5pt case ... of expressions for the integers, bools
  * 5pt nested pattern matching that allows lists, and tuples
  * 5pt build pattern matchin into lambda expressions with at least lists and tuples.
* User-defined data types
  * 5pt definition and contructors 
  * 5pt pattern-matching [*](#medium)
  * 10pt typechecking
* 5pt A Read-Eval-Print loop, so that users can work interactively with your language, including preloading a 
      Prelude-like initialization file, and the ability to load files interactively. You would need to learn about the IO monad (start with Chapter 10 in Hutton).

Static Checking
* 5pt Warn when a var is intruduced but never used
* 15pt Checking simple types, where every variable has a type annotation
* 20-30pt  Advanced type checking: Bidirectional, Hindly-milner, or dependently typed [**](#difficult)

Mutable state
* 10pt Dynmamically scoped mutable state[*](#medium)
* 20-30pt Lexically scoped mutable state[**](#difficult)

Misc
* 10pt Add a warning (as in the Ok monad presented in lecture) to the monad, and flag appropriate conditions which
are not errors, but cause concern (e.g., you defined a variable or function but then didn't use it).
* 5-15 pt Overloaded operators and constants, automatic type conversion (as in Java or Python) [*](#medium)

Additionally you can get points by using engineering best practices
* 5pt Writeing a quickcheck generator and shrinker for your Ast and using it to test your parser
* 5pt Writing clear Haddock style comments and generating the html documentation
* 5pt Setting up Continuous Integration on your github repo[*](#medium)


You can implement as many features as you want but you cannot score above a 100

There are many other features, small and large, which could be imagined (orderings on lists? array types? n-ary tuples? conversion between prefix and infix? lazy evaluation? compilation[**](#difficult)?   The list goes on and on.....).  Please talk to Mark if you have creative ideas!  Some things are very challenging, and may change the language specification drasticly: these need to be aproved by Mark before the first milestone, and may require additional work by the 2nd milestone.

<a name="medium">*</a> Mark needs to aprove before Before Milstone 2

<a name="difficult">**</a> This is challenging, Mark needs to aprove before Before Milstone 1



