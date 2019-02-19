{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveDataTypeable, DeriveGeneric #-}

module Lang0ParserTest where

-- import TestBase 
import Lang0 (Ast(..))
import Lang0Parser (parser)

import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, assertBool, (@=?))
import Test.Tasty.QuickCheck as QC
import GHC.Generics (Generic)
import Data.Typeable (Typeable)
import Test.QuickCheck.Arbitrary.Generic


-- TODO: move to base
deriving instance Generic Ast 
deriving instance Eq Ast 

instance Arbitrary Ast where
  arbitrary = genericArbitrary
  shrink = genericShrink
  

---- All Lang Test ----
lang0ParserTest = testGroup "Parser test"
    [QC.testProperty "show should match parse" $ ((\ x -> Just (x , "") == (parser $ show x)) :: Ast -> Bool)]
--TODO: check Lang0ParserHard