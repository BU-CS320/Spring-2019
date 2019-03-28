# Week9 Due 4/2


## Analytical  Part
There is no analytical homework this week. 
## Code Part
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week9` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* Automated tests have not been posted.
* As described in the hints, `show` must write labdas in the haskell style.  For instance the lambda term `(λx.x x) λx.x x` should show as `(\x -> x x) \x -> x x`.  The standard precidence and associativity rules apply.
* The parser should handle arbitrary lambda terms in the style above.


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
