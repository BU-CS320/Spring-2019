# Week8 Due 3/26


## Analytical  Part
http://www.cs.bu.edu/fac/snyder/cs320/Homeworks%20and%20Labs/hw.week8.pdf

Hints on the YT channel: https://www.youtube.com/watch?v=GpqSS075bQM&t=30s

## Code Part
You are responsible for State, Lang3, Reader, Lang 4, and all the parsers.
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week8` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* Some simple examples and test cases:  [ReaderTest](src/ReaderTest.hs)
* Comprehensive tests soon....
* As before, Lang3 should evaluate left to right, and assignment retuns the value assigned.  For insatance `(x := 2) + x` should eval to `4`
* Some hint files have been added [Lang3Hint](src/lang/Lang3Hint.hs), [Lang4Hint](src/lang/Lang4Hint.hs), [Lang1ParserHint](src/parser/Lang1ParserHint.hs)


There were some small typos:
in Lang2.hs
```
showFullyParen (Print b)         = "print(" ++ show b ++ ")"
```
should be
```
showFullyParen (Print b)         = "print(" ++ showFullyParen b ++ ")"
```

in Lang3.hs

```
showFullyParen (Assign v b)      = "(" ++ v ++ " := " ++ show b ++ ")"
```
should be
```
showFullyParen (Assign v b)      = "(" ++ v ++ " := " ++ showFullyParen b ++ ")"
```


### Submit (similar to [week1](../week1))
1. run the tests by running ```cabal new-test``` 
1. run ```git status``` to make sure git is ok
1. run ```git commit -a -m "please don't remove these instructions"``` to make a commit to your laptop
1. run ```git pull upstream master``` to get the latest tests
1. run the tests by running ```cabal new-test``` 
1. run ```git push``` to submit your commit to your private gitHub account
1. check that you can see your solutions on the website for your private repo

### REPL hints
* `:load` or `:l` will change the module you are inspecting
* `:reload` or `:r` will reload the file.  Do this often!
* `:type` or `:t` will tell you the type of an expression
* `:quit` or `:q` will leave the repl
