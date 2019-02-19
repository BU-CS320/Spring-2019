# HW3 Due 2/19

## Code Part
### Instructions
* To get the assignment run ```git pull upstream master``` in your homework directory
* `cd` into the `week4` directory, run `cabal new-repl`
* Fill in the bodies of the undefined functions and data
* DO NOT CHANGE THE TYPE SIGNATURES!

### Notes
* tests posted
* for dot product you should return 0 when two list have different dimension, but we will not test the case that two lists have different dimension
* for addAllList if the input is empty then you should return empty list, but we will not test the case that the input is empty.
* When defining Eq on Map, maps are equal when they have the exact same key value pairs
* For the `TypeProblems` you may not "cheat" by cuasing an error either directly or inderectly.  For instance `head []` will recieve no credit since it crashes.
* For the `TypeProblems` you may give any answer that is consistent with the type specified.  You do not need to give a term that has the most general given type.  For instace: if asked for a term of type `Bool -> Bool`, both `\ b -> not b` and `\ x -> x` will get full credit.
#### Langs
* In Lang3 if you define one variable in terms of something undefined, there should be no effect (the state shouldn't change) and the result is undefined.  For instance `x := y` in the state `{x -> 3}` should result in `(Nothing,{x -> 3})`
* In any Lang problem, when there is any abiguity in which order to evaluate:  evaluate left to right. For instance `print(2); print(5)` should have `2` before `5`.
* `-- hint use lookup` should have been `-- hint use Map.lookup and Map.insert`
* If it is possible to fail in a language, propogate the failure as soon as possible.  For example, when bad is not in the state `x := bad; 2+2` in lang 3 should return `(Nothing,{})`
#### Additional Specs of Map.hs
- `insert`: O(log n)
- `toList`: O(n), return a list that is sorted from smallest to the largest
- `fromList`: O(n), the last element should be put into the tree first, and then the second last element. That is the root of your Tree should always be the last element of your input list.
- `size`: O(n)
- `member`: O(log n)
- `lookup`: O(log n)
- `delete`: O(log n), you can search for how to delete a node in a BST. Here is a good tutorial: https://www.geeksforgeeks.org/binary-search-tree-set-2-delete/. 
  - Hint: you will need to use lots of pattern matching.
  - Hint: make a helper function.
- `update`: O(log n)
- `union`: for input map of size n1 and n2, the complexity should be O(n1)
- `filter`: O(n), don't turn it into a list and then do it. 
  - Hint: if you want to do it efficiently you need to reuse some of the code in `delete`.
- `==`: O(n), two set are equal iff they contain the same elements.
  - Note: the time complexity of `==` on list is O(n). But order matters in equality of list, for example `[1, 2]` is not equal to `[2, 1]`
- `fmap`: O(n).

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
