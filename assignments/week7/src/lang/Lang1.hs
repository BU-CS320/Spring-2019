module Lang1 where


data Ast =
    LiteralInt Integer
  | Plus Ast Ast
  | Div Ast Ast
  | Sub Ast Ast
  | Mult Ast Ast

-- hint: use do notation from the built in monad on Maybe
eval :: Ast -> Maybe Integer
eval = undefined

-- show the fully parenthesized syntax
instance Show Ast where
  show (LiteralInt i) = show i
  show (l `Plus` r) = "(" ++ (show l) ++ " + " ++  (show r) ++ ")"
  show (Div l r) = "(" ++ show l ++ " / " ++ show r ++ ")"
  show (l `Sub` r) = "(" ++ (show l) ++ " - " ++  (show r) ++ ")"
  show (l `Mult` r) = "(" ++ (show l) ++ " * " ++  (show r) ++ ")"
