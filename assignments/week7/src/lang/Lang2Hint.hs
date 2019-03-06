-- This file is just for hints.
-- Don't edit this file unless you are comfortable resolving merge conflicts, since we may add hints in the future
-- Instead copy and paste what you want into your homework
module Lang2Hint where

import PrinterMonad
import Lang2(eval,Ast(..))


-- this is a monadic print function
print :: x -> PrinterMonad x ()
print x = PrinterMonad [x] ()


-- some examples
ex = Print (LiteralInt 2 `Plus` LiteralInt 5)
       `Plus` Print (LiteralInt 1 `Plus` LiteralInt 1)
	   
-- run your monad like this
ex' = runPrinterMonad (eval ex)