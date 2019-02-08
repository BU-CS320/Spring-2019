# HW2 Due 2/11
## Analytical Part
Anylitical part availible [@331](https://piazza.com/class/jr9fgrf7efv7j0?cid=331)
## Code Part
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week3` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Submit (similar to [week1](../week1))
1. run the tests by running ```cabal new-test``` 
1. run ```git status``` to make sure git is ok
1. run ```git commit -a -m "whoo hoo I'm done with HW"``` to make a commit to your laptop
1. run ```git pull upstream master``` to get the latest tests
1. run the tests by running ```cabal new-test``` 
1. run ```git push``` to submit your commit to your private gitHub acount
1. check that you can see your solutions on the website for your private repo

### Notes
* There was a typo in the type signature of `keepEvens` it should read `keepEvens :: List Integer ->  List Integer`.  We have not changed the source file to make merge conflicts easier.  We do not plan on grading the question but encourage you to try it as practice. [@282](https://piazza.com/class/jr9fgrf7efv7j0?cid=282)
* You need to install `tasty-quickcheck` to run the test cases.
* For fib, you might need to find a efficient definition, 
otherwise the tests may timeout.
* For the `zip` function match as mainy pairs as possible, you may stop when either list is empty [@299](https://piazza.com/class/jr9fgrf7efv7j0?cid=299)
* Make sure your editor uses spaces instead of tabs, or you will likely get annoying parse errors.
* We have not finished releasing test code yet
* You may always add your own helper functions and helper data!
#### 9:05 lab
The gcd implementation we went over may have had a small bug.  Make sure your finction is defined in the conventional way so `gcd 0 x = 1` and `gcd x 0 = 1`

### REPL hints
* `:load` or `:l` will change the module you are inspecting
* `:reload` or `:r` will reload the file.  Do this often!
* `:type` or `:t` will tell you the type of an expression
* `:quit` or `:q` will leave the repl

### ```git``` issues
If you are having ```git``` issues, run ```git status``` and post on piazza for help.

## Further Reading
* Read about Haskell modules: https://www.haskell.org/tutorial/modules.html
* [Null References: The Billion Dollar Mistake](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare)
