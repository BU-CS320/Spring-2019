{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

module Main where


import Hw
import Test.Tasty (defaultMain, testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))

main = defaultMain allTests

allTests = error "you downloaded the assignment before tests were posted, try 'git pull upstream master' to see if the tests are posted now"