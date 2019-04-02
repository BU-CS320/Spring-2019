module LangParserTest where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, assertBool, testCase)
import Test.Tasty.QuickCheck


import ParserMonad

import Lang
import LangParser



-- data Ast = And Ast Ast | Or Ast Ast | Not Ast
--          | Plus Ast Ast | Minus Ast Ast | Mult Ast Ast | Div Ast Ast
--          | ValInt Integer
--          | ValBool Bool


--          | If Ast Ast Ast
--          | Let String Ast Ast
--          | Lam String Ast --TODO a little redundent
--          | App Ast Ast
--          | Var String -- TODO: this could also be a val
--          | Nil
--          | Cons Ast Ast
--          deriving (Show, Eq)


--TODO: move the generator to a shared place

instance Arbitrary Ast where
    arbitrary = sized arbitrarySizedAst

arbitrarySizedAst ::  Int -> Gen Ast
arbitrarySizedAst m | m < 1 = do i <- arbitrary
                                 b <- arbitrary
                                 node <- elements [ValInt i, ValBool b, Nil]
                                 return $ node
arbitrarySizedAst m | otherwise = do l <- arbitrarySizedAst (m `div` 2)
                                     r <- arbitrarySizedAst (m `div` 2)
                                     str <- elements ["x","y","z"]
                                     ifast <- arbitrarySizedIf m
                                     node <- elements [And l r, Or l r, Not l,
                                                       Plus l r, Minus l r, Mult l r, Div l r,
                                                       Cons l r,
                                                       ifast,
                                                       Let str l r,
                                                       Lam str l,
                                                       App l r,
                                                       Var str
                                                      ]
                                     return node

-- it would be better if every branch were built like this so the balance would be maintained
arbitrarySizedIf ::  Int -> Gen Ast
arbitrarySizedIf m = do b <- arbitrarySizedAst (m `div` 3)
                        t <- arbitrarySizedAst (m `div` 3)
                        e <- arbitrarySizedAst (m `div` 3)
                        return $ If b t e

unitTests =
  testGroup
    "Lang3Test"
    [instructorTests
     -- TODO: your tests here!!!
	 ]

instructorTests = testGroup
      "instructorTests"
      [
      testProperty "parse should return the same AST when fully parenthisized" $ ((\ x -> Just (x , "") == (parse parser $ fullyParenthesized x)) :: Ast -> Bool),
      testProperty "parse should return the same AST when pretty printed" $ ((\ x -> Just (x , "") == (parse parser $ prettyShow x 0)) :: Ast -> Bool),
      --TODO: same for show
      testCase "example eval, assign also returns it's value" $ assertEqual []  3 $ 3

      ]

-- Mult (Var "z") (Or Nil (ValBool True))



-- prop_one :: Integer -> QuickCheck.Result
-- prop_one _ = MkResult (Just True) True "always succeeds" False [] []


-- TODO: your tests here!!!
-- TODO: Many, many more example test cases (every simple thing, many normal things, some extreame things)
-- TODO: add a generator, can then test more advanced language properties
-- TODO: you should always be able to parse show (when the var names aren't too bad)