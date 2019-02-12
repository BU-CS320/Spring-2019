module OrderingTests where 

import TestBase 
import Hw02 hiding (List)
import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, (@=?))
import Test.Tasty.QuickCheck as QC

---- Test for Integers ----
orderingTests = testGroup "tests for Ordering function" 
    [
    -- check sort
        QC.testProperty "for all lists of Integers, sort the list should return a sorted list" $ 
            \list -> isSorted (sort Hw02.intOrd list) == True,
        QC.testProperty "for all lists of Bool, sort the list should return a sorted list" $ 
            \list -> isSorted (sort Hw02.boolOrd list) == True,
        QC.testProperty "for all lists of Integers, sort the list twice should return the same result as sort it onece" $ 
            \list -> (sort Hw02.intOrd . sort Hw02.intOrd $ list) == (sort Hw02.intOrd list),
        QC.testProperty "for all lists of Bool, sort the list twice should return the same result as sort it onece" $ 
            \list -> (sort Hw02.boolOrd . sort Hw02.boolOrd $ list) == (sort Hw02.boolOrd list),
    -- check insert
        QC.testProperty "for all lists of bools l and bool b, if inserted b to the sorted l, the result is still sorted" $ 
            \list b -> isSorted . insert Hw02.boolOrd b $ sort boolOrd list,  
        QC.testProperty "for all lists of integers l and integer n, if inserted n to the sorted list, the result is still sorted" $ 
            \list n -> isSorted . insert Hw02.intOrd n $ sort intOrd list,
        QC.testProperty "for all lists, if inserted an element to the list, the length of the list + 1" $ 
            \list -> len (insert Hw02.boolOrd True list) == ((len list) + 1)

    ]
compareTests = testGroup "tests for compare function" 
    [
    -- check compareInteger
        QC.testProperty "for all Integer a and b, a < b, compreInteger should return Lessthan" $ 
            \a b -> a < b QC.==> Hw02.compareInteger a b == LessThan,
        QC.testProperty "for all Integer a and b, a == b, compreInteger should return EqualTo" $ 
            \a b -> a == b QC.==> Hw02.compareInteger a b == EqualTo,
        QC.testProperty "for all Integer a and b, a > b, compreInteger should return GreaterThan" $ 
            \a b -> a > b QC.==> Hw02.compareInteger a b == GreaterThan,
    -- check compareBool
        testCase "for a == False and b == True, compareBool should return Lessthan" $ 
            assertEqual [] (Hw02.compareBool False True) LessThan,
        testCase "for a == True and b == True, compareBool should return EqualTo" $ 
            assertEqual [] (Hw02.compareBool True True) EqualTo,
        testCase "for a == False and b == False, compareBool should return EqualTo" $ 
            assertEqual [] (Hw02.compareBool False False) EqualTo,
        testCase "for a == True and b == False, compareBool should return GreaterThan" $ 
            assertEqual [] (Hw02.compareBool True False) GreaterThan
    -- check StudentOrd
        -- QC.testProperty "for all student1 and student2, student1.id < student2.id, the order of these two students should be student1 < student2" $ 
        --     \(Student id1 year1 inCourse1) (Student id2 year2 inCourse2) -> id1 < id2 QC.==> (app studentOrd) (Student id1 year1 inCourse1) (Student id2 year2 inCourse2)  == LessThan,
        -- QC.testProperty "for all student1 and student2, student1.id == student2.id, the order of these two students should be student1 == student2" $ 
        --     \(Student id1 year1 inCourse1) (Student id2 year2 inCourse2) -> id1 == id2 QC.==> (app studentOrd) (Student id1 year1 inCourse1) (Student id2 year2 inCourse2)  == EqualTo,
        -- QC.testProperty "for all student1 and student2, student1.id > student2.id, the order of these two students should be student1 > student2" $ 
        --     \(Student id1 year1 inCourse1) (Student id2 year2 inCourse2) -> id1 > id2 QC.==> (app studentOrd) (Student id1 year1 inCourse1) (Student id2 year2 inCourse2)  == GreaterThan




    ]

len :: List a -> Integer
len Nil = 0
len (Cons _ li) = 1 + len li

isSorted :: (Ord a) => List a -> Bool 
isSorted Nil = True 
isSorted (Cons n Nil) = True 
isSorted (Cons h t@(Cons h' t')) 
    | h <= h' = isSorted t 
    | otherwise = False

app :: Hw02.Ordering a -> (a -> a -> Comparison)
app (Ordering ord) = ord
