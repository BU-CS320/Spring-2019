module SetTests where 

import TestBase
import Set as S hiding (Set)
import Hw02 hiding (insert)
import Data.List
import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, (@=?))
import Test.Tasty.QuickCheck as QC

---- Test for Sets ----
setTests = testGroup "tests for Set functions" 
    [

		]
		