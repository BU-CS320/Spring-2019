module OrderingTests where 

import TestBase
import Hw02 (intOrd, boolOrd, compareInteger, compareBool, Ordering)
import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, (@=?))
import Test.Tasty.QuickCheck as QC

---- Test for Integers ----
orderingTests = testGroup "tests for Ordering function" 
    [
    ]