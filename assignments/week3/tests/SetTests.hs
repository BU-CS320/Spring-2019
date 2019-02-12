module SetTests where 

import TestBase
import Set as S hiding (Set)
import Data.Set 
import Hw02 hiding (List, length, (!!))
import Data.List
import Test.Tasty (testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase, (@=?))
import Test.Tasty.QuickCheck as QC

---- Test for Sets ----
setTests = testGroup "tests for Set functions" 
    [
        setTestEmpty,
        setTestSingleton,
        setTestSingletonMember,
        setTestFromList,
        setRepeatTest,
        setSizeTest
    ]

--test if the empty set size is zero
setTestEmpty = QC.testProperty "Empty set should have size 0" $ 0 == S.size (S.empty intOrd)


--test if the singleton list is size one 
setTestSingleton = QC.testProperty "The size of the singleton list should be one" $ 1 == S.size (S.singleton Hw02.intOrd 1)

--test if the member of a singleton list is the same as the one added
setTestSingletonMember = QC.testProperty "The elem of a singleton list m should be the same as the one being inserted n" $ S.member 1 (S.singleton intOrd 1)

--test memeber by turning a list into a set 
setTestFromList = QC.testProperty "for all lists l, if l is turned into a set s, then all elements in s should be from list l and returned as a list in ascending order" $
    \l -> l2p (S.elems (S.fromList Hw02.intOrd l)) == Data.Set.elems (Data.Set.fromList (l2p l))

--test for repeat elements
setRepeatTest = QC.testProperty "for all list l and integer i, we insert element of index i into the set created by l, the set should not change" $ 
    \l -> let setFromL = S.fromList Hw02.intOrd l in (S.insert ((l2p l) !! 0) setFromL) == setFromL
                
--test size compare size of student set vs Data.Set
setSizeTest = QC.testProperty "for all sets s, the size of the set should be the same as the size of the set in the built in Data.Set module" $
    \l -> S.size (S.fromList Hw02.intOrd l) == toInteger (Data.Set.size (Data.Set.fromList (l2p l)))





--translate from List to Prelude
l2p :: List a -> [a]
l2p Nil = []
l2p (Cons x xs) = x:(l2p xs)


