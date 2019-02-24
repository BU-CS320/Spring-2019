module OrdTest where
    import Prelude hiding (List(..), Pair(..),Maybe(..),Either(..),)
    import TestBase
    import Test.Tasty (defaultMain, testGroup)
    import Test.Tasty.HUnit (assertEqual, assertBool, testCase)
    import Test.Tasty.QuickCheck as QC
    import Test.QuickCheck.Arbitrary.Generic
    import GHC.Generics (Generic)

    ordTest = testGroup "Test for Ord" [
        listTests,
        pairTests,
        maybeTests,
        eitherTests,
        identityTests,
        trivialTests
        ]
    
    listTests = testGroup "Test for list datatype" [
        QC.testProperty "Ord Transitivity List; if x <= y && y <= z = True, then x <= z = True" $ 
            \x y z-> if (x:: List Integer)<=(y::List Integer) && y<=(z::List Integer)
                     then x<=z
                     else True, --not $ (x<=y) && (x<=z),
            
        QC.testProperty "Ord Reflexivity List; x<=x" $
            \x -> (x::List Integer)<=x,
            
        QC.testProperty "Ord Antisymmetry List; if x <= y && y <= x = True, then x == y = True" $
            \x y-> if (x::List Integer)<=(y::List Integer) && y<=x 
                   then x==y
                   else not $ x==y
        ]
    
    pairTests = testGroup "Test for pair datatype" [
            QC.testProperty "Ord Transitivity Pair; if x <= y && y <= z = True, then x <= z = True" $ 
                \x y z-> if (x:: Pair Integer Integer)<=(y::Pair Integer Integer) && y<=(z::Pair Integer Integer)
                         then x<=z
                         else True,--not $ (x<=y) && (x<=z), 
                
            QC.testProperty "Ord Reflexivity Pair; x<=x" $
                \x -> (x::Pair Integer Integer)<=x,
                
            QC.testProperty "Ord Antisymmetry Pair; if x <= y && y <= x = True, then x == y = True" $
                \x y-> if (x::Pair Integer Integer)<=(y::Pair Integer Integer) && y<=x 
                       then x==y
                       else not $ x==y
        ]
        
    maybeTests = testGroup "Test for maybe datatype" [
            QC.testProperty "Ord Transitivity Maybe; if x <= y && y <= z = True, then x <= z = True" $ 
                \x y z-> if (x:: Maybe Integer)<=(y::Maybe Integer) && y<=(z::Maybe Integer)
                         then x<=z
                         else True, 
                
            QC.testProperty "Ord Reflexivity Maybe; x<=x" $
                \x -> (x::Maybe Integer)<=x,
                
            QC.testProperty "Ord Antisymmetry Maybe; if x <= y && y <= x = True, then x == y = True" $
                \x y-> if (x::Maybe Integer)<=(y::Maybe Integer) && y<=x 
                       then x==y
                       else not $ x==y
        ]
    
    eitherTests = testGroup "Test for either datatype" [
            QC.testProperty "Ord Transitivity Either; if x <= y && y <= z = True, then x <= z = True" $ 
                \x y z-> if (x:: Either Integer Integer)<=(y::Either Integer Integer) && y<=(z::Either Integer Integer)
                         then x<=z
                         else True,
                
            QC.testProperty "Ord Reflexivity Either; x<=x" $
                \x -> (x::Either Integer Integer)<=x,
                
            QC.testProperty "Ord Antisymmetry Either; if x <= y && y <= x = True, then x == y = True" $
                \x y-> if (x::Either Integer Integer)<=(y::Either Integer Integer) && y<=x 
                       then x==y
                       else not $ x==y
        ]
    identityTests = testGroup "Test for Identity datatype" [
            QC.testProperty "Ord Transitivity Identity; if x <= y && y <= z = True, then x <= z = True" $ 
                \x y z-> if (x:: Identity Integer)<=(y::Identity Integer) && y<=(z::Identity Integer)
                         then x<=z
                         else True, 
                
            QC.testProperty "Ord Reflexivity Identity; x<=x" $
                \x -> (x::Identity Integer)<=x,
                
            QC.testProperty "Ord Antisymmetry Identity; if x <= y && y <= x = True, then x == y = True" $
                \x y-> if (x::Identity Integer)<=(y::Identity Integer) && y<=x 
                       then x==y
                       else not $ x==y
        ]
    
    trivialTests = testGroup "Test for Trival datatype" [
            QC.testProperty "Ord Transitivity Trival; if x <= y && y <= z = True, then x <= z = True" $ 
                \x y z-> if (x:: Trival Integer)<=(y::Trival Integer) && y<=(z::Trival Integer)
                         then x<=z
                         else True, 
                
            QC.testProperty "Ord Reflexivity Trival; x<=x" $
                \x -> (x::Trival Integer)<=x,
                
            QC.testProperty "Ord Antisymmetry Trival; if x <= y && y <= x = True, then x == y = True" $
                \x y-> if (x::Trival Integer)<=(y::Trival Integer) && y<=x 
                       then x==y
                       else not $ x==y
        ]
        