# HW6 Due 3/19


## Analytical  Part
not yet posted
## Code Part
You are only responsible for the following files
BareBonesLast, PrinterMonad, Lang1, Lang2.
We have included a number of other files you can use to test (the parsers), that we plan to assign in future weeks (Lang3, Lang4), and that give hints (Lang0)

### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week7` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* no tests are posted yet
* A hint file has been added [Lang2Hint.hs](src/lang/Lang2Hint.hs)
* Watch the videos [Summary of first lecture on Monads](https://www.youtube.com/watch?v=i8E0G9S3ty0) , [Monad Lecture Code 2 Walk Through](https://www.youtube.com/watch?v=45eQyaKUxXY) , [Monad Lecture Code 1 walk through](https://www.youtube.com/watch?v=YKgVebCiDDg0)

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
