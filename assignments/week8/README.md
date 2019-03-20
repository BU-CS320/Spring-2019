# Week8 Due 3/26


## Analytical  Part
not yet posted
## Code Part
You are responsable for State, Lang3, Reader, Lang 4, and all the parsers.
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week8` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* no tests are posted yet
* As before, Lang3 should evaluate left to right, and assignment retuns the value assigned.  For insatance `(x := 2) + x` should eval to `4`

### Submit (similar to [week1](../week1))
1. run the tests by running ```cabal new-test``` 
1. run ```git status``` to make sure git is ok
1. run ```git commit -a -m "haskell is fun"``` to make a commit to your laptop
1. run ```git pull upstream master``` to get the latest tests
1. run the tests by running ```cabal new-test``` 
1. run ```git push``` to submit your commit to your private gitHub account
1. check that you can see your solutions on the website for your private repo

### REPL hints
* `:load` or `:l` will change the module you are inspecting
* `:reload` or `:r` will reload the file.  Do this often!
* `:type` or `:t` will tell you the type of an expression
* `:quit` or `:q` will leave the repl
