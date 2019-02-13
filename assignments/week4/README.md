# HW2 Due 2/19

## Code Part
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week4` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* No tests are posted yet
* In Lang3 if you define one variable in terms of something undefined, there should be no effect (the state shouldn't change) and the result is undefined.  For instance `x := y` in the state `{x -> 3}` should result in `(Nothing,{x -> 3})`
* In any Lang problem, when there is any abiguity in which order to evaluate:  evaluate left to right. For instance `print(2); print(5)` should have `2` before `5`.

### REPL hints
* `:load` or `:l` will change the module you are inspecting
* `:reload` or `:r` will reload the file.  Do this often!
* `:type` or `:t` will tell you the type of an expression
* `:quit` or `:q` will leave the repl

### Submit (similar to [week1](../week1))
1. run the tests by running ```cabal new-test``` 
1. run ```git status``` to make sure git is ok
1. run ```git commit -a -m "haskell is fun"``` to make a commit to your laptop
1. run ```git pull upstream master``` to get the latest tests
1. run the tests by running ```cabal new-test``` 
1. run ```git push``` to submit your commit to your private gitHub acount
1. check that you can see your solutions on the website for your private repo

