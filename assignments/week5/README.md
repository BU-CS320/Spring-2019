# HW4 Due 2/25
Due Monday at midnight to accommodate your midterm

## Analytical  Part
not yet posted
## Code Part
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week5` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* No tests are posted yet
* Because of the way Ord depends on Eq, you will get errors if you have `instance Eq a => Eq ...` but no `instance Ord a => Ord ...`, this is just haskell trying to be helpful
* `instance (AllTheThings a, AllTheThings b) => AllTheThings (a,b)` is harder than expected, we plan to post a hint soon
* For `instance HasExample [a] where` remember that lists can be empty
* We plan to post a video on the parsing part

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
