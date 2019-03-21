-- This file is just for hints.
-- Don't edit this file unless you are comfortable resolving merge conflicts, since we may add hints in the future
-- Instead copy and paste what you want into your homework
module Lang4Hint where

import Data.Map (Map)-- for env
import qualified Data.Map as Map

import Reader
import Lang4(Ast(..),Env)

-- unlike Lang3 there is no way to set a Var!

-- but a getVar function is still helpful
getVar :: String -> Reader Env Integer
getVar v = undefined -- use the "ask" function, or the constructor 

-- for the Let case:

-- There is a standard reader function that I forgot to include called "local"
-- it runs functions under a modified local environment
local :: (r -> r) -> Reader r a -> Reader r a
local changeEnv comp  = Reader (\e -> runReader comp (changeEnv e) )

-- so your Let case would look like

eval :: Ast -> Reader Env Integer
-- ...
eval (Let v val bod) = 
  do val' <- eval val
     local (Map.insert undefined undefined) (eval undefined)

-- you can also use the Reader constructor directly
eval (Let v val bod) = 
  do val' <- eval val
     Reader (\env -> runReader (eval undefined) (Map.insert undefined undefined env))



-- some examples
ex = Let "x" (LiteralInt 2 `Plus` LiteralInt 2) (Var "x" `Mult` LiteralInt 5 )
       
-- run your monad like this
ex' = runReader (eval ex) Map.empty
