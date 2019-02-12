module StudentTests where 

import TestBase
import Data.Typeable
import Hw02 hiding (Maybe, List, Student)
import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, (@=?))
import Test.Tasty.QuickCheck as QC

---- Test for Integers ----
studentTests = testGroup "tests for Student functions" 
    [
    -- check isCS, mkCSsthdent
        QC.testProperty "for all id, year, whether takes cs320 or not, if we make a cs student, he/she shoube be a cs student" $ 
            \id year cs320 -> id >= 0 && year >= 0 QC.==> isCs (mkCsStudent id year cs320),
    -- check getBuid
        QC.testProperty "for all id, if we made a cs student, his/her id must be the same as input" $ 
            \id year cs320 -> id >= 0 && year >= 0 QC.==> getBuId (mkCsStudent id year cs320) == id,
    -- check getYear
        QC.testProperty "for all year, if we made a cs student , his/her year must be the same as input" $ 
            \id year cs320 -> id >= 0 && year >= 0 QC.==> getYear (mkCsStudent id year cs320) == year,
    -- check makeMathStudent
        QC.testProperty "for all year, if we made a cs student , his/her year must be the same as input" $ 
            \id year cs320 -> id >= 0 && year >= 0 QC.==> getYear (mkMathStudent id year cs320) == year,
        QC.testProperty "or all id, if we made a cs student, his/her id must be the same as input" $ 
            \id year cs320 -> id >= 0 && year >= 0 QC.==> getBuId (mkMathStudent id year cs320) == id
    -- -- check coolest student
    --     QC.testProperty "for all lists of students, coolest should return the first student who chose cs320" $ 
    --         \list -> coolestStudent list == coolestStudentTest list,
    -- -- check group project
    --     QC.testProperty "for all pairs in group project, each pair in the result should be exactly a math student and a cs student" $ 
    --         \list -> checkPairList (groupProject list)  == True

    ]