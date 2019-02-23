{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveDataTypeable, DeriveGeneric #-}

module EqTest where

    import Prelude hiding (List(..), Pair(..),Maybe(..),Either(..),)
    import TestBase
    import Test.Tasty (defaultMain, testGroup)
    import Test.Tasty.HUnit (assertEqual, assertBool, testCase)
    import Test.Tasty.QuickCheck as QC
    import Test.QuickCheck.Arbitrary.Generic
    import GHC.Generics (Generic)

    eqTest = testGroup "Test for Eq" [
        listTest,
        maybeTest,
        pairTest,
        eitherTest,
        idTest,
        triTest
        ]
            
    -- List
    listTest = testGroup "Test equal List" [

      QC.testProperty "Eq Reflexivity List a == List a = True" $ 
         \m -> m == (m :: List Integer),
      
      QC.testProperty "Eq Symmetry List (x==y) == (y==x)" $ 
         \x y -> ((x:: List Integer) == (y :: List Integer)) == (y==x),
    
      QC.testProperty "Eq Transitivity List if x==y and y==z then x==z" $ 
         \x y z -> if (((x:: List Integer)==(y :: List Integer)) && (y==(z :: List Integer))) == True
                   then (x==z) == True
                   else ((x==z) && (x==y)) == False,
    
      QC.testProperty "Eq Substitutivity List if a == b, then f a == f b" $ 
         \x y -> if ((x :: List Integer) == (y :: List Integer)) == True
                 then ((f x) == (f y)) == True
                 else ((f x) == (f y)) == False,

      QC.testProperty "Eq Negation List x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x :: List Integer) == (y:: List Integer))          
      ]

    f :: List Integer -> List Integer
    f Nil = (Cons 1 Nil)
    f (Cons a b) = Cons 1 ((Cons a b))

    fb :: List Bool -> List Bool
    fb Nil = (Cons False Nil)
    fb (Cons a b) = Cons False ((Cons a b))


    maybeTest = testGroup "Test equal Maybe" [

      QC.testProperty "Eq Reflexivity Maybe a == Maybe a = True" $ 
         \m -> m == (m ::  Maybe Integer),
      
      QC.testProperty "Eq Symmetry Maybe (x==y) == (y==x)" $ 
         \x y -> ((x::  Maybe Integer) == (y ::  Maybe Integer))==(y==x),
              
      QC.testProperty "Eq Transitivity Maybe if x==y and y==z then x==z" $ 
         \x y z -> if (((x::  Maybe Integer)==(y ::  Maybe Integer)) && (y==(z ::  Maybe Integer))) == True
                   then (x==z)==True
                   else ((x==z) && (x==y)) ==False,
    
      QC.testProperty "Eq Substitutivity Maybe if a == b, then f a == f b" $ 
         \x y -> if ((x ::  Maybe Integer) == (y ::  Maybe Integer)) == True 
                 then ((f2 x) == (f2 y)) == True
                 else ((f2 x) == (f2 y)) == False,

      QC.testProperty "Eq Negation Maybe x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x ::  Maybe Integer) == (y::  Maybe Integer))          
      ]

    f2 ::  Maybe Integer ->  Maybe Integer
    f2  Nothing =  Nothing
    f2 ( Just a) =  Just (a+1)
    
    --
    pairTest = testGroup "Test equal Pair" [

      QC.testProperty "Eq Reflexivity Pair a == Pair a = True" $ 
         \m -> m == (m :: Pair Integer Integer),
      
      QC.testProperty "Eq Symmetry Pair (x==y) == (y==x)" $ 
         \x y -> ((x:: Pair Integer Integer) == (y :: Pair Integer Integer)) == (y==x),
    
      QC.testProperty "Eq Transitivity Pair if x==y and y==z then x==z" $ 
         \x y z -> if (((x:: Pair Integer Integer)==(y :: Pair Integer Integer)) && (y==(z :: Pair Integer Integer)))
                   then (x==z)==True
                   else ((x==z)&&(x==y))==False,
    
      QC.testProperty "Eq Substitutivity Pair if a == b, then f a == f b" $ 
         \x y -> if ((x :: Pair Integer Integer) == (y :: Pair Integer Integer)) 
                 then ((f3 x) == (f3 y)) == True
                 else ((f3 x) == (f3 y)) == False,

      QC.testProperty "Eq Negation Pair x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x :: Pair Integer Integer) == (y:: Pair Integer Integer))          
      ]

    f3 :: Pair Integer Integer -> Pair Integer Integer
    f3 (Pair a b) = Pair (a+1) (b+1)
    
    --
    idTest = testGroup "Test equal Id" [

      QC.testProperty "Eq Reflexivity Id a == Id a = True" $ 
         \m -> m == (m :: Identity Integer),
      
      QC.testProperty "Eq Symmetry Id (x==y) == (y==x)" $ 
         \x y -> ((x:: Identity Integer) == (y :: Identity Integer)) == (y==x),
    
      QC.testProperty "Eq Transitivity Id if x==y and y==z then x==z" $ 
         \x y z -> if (((x:: Identity Integer)==(y :: Identity Integer)) && (y==(z :: Identity Integer)))
                   then (x==z)==True
                   else ((x==z)&&(x==y))==False,
    
      QC.testProperty "Eq Substitutivity Id if a == b, then f a == f b" $ 
         \x y -> if ((x :: Identity Integer) == (y :: Identity Integer)) 
                 then ((f4 x) == (f4 y)) == True
                 else ((f4 x) == (f4 y)) == False,

      QC.testProperty "Eq Negation Id x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x :: Identity Integer) == (y:: Identity Integer))          
      ]

    f4 :: Identity Integer -> Identity Integer
    f4 (Identity a) = Identity (a+1)

--
    eitherTest = testGroup "Test equal Either" [

      QC.testProperty "Eq Reflexivity Either a == Either a = True" $ 
         \m -> m == (m ::  Either Integer Integer),
      
      QC.testProperty "Eq Symmetry Either (x==y) == (y==x)" $ 
         \x y -> ((x::  Either Integer Integer) == (y ::  Either Integer Integer)) == (y==x),
    
      QC.testProperty "Eq Transitivity Either if x==y and y==z then x==z" $ 
         \x y z -> if (((x::  Either Integer Integer)==(y ::  Either Integer Integer)) && (y==(z ::  Either Integer Integer)))
                   then (x==z)==True
                   else ((x==z)&&(x==y))==False,
    
      QC.testProperty "Eq Substitutivity Either if a == b, then f a == f b" $ 
         \x y -> if ((x ::  Either Integer Integer) == (y ::  Either Integer Integer)) 
                 then ((f5 x) == (f5 y)) == True
                 else ((f5 x) == (f5 y)) == False,

      QC.testProperty "Eq Negation Either x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x ::  Either Integer Integer) == (y::  Either Integer Integer))          
      ]

    f5 ::  Either Integer Integer ->  Either Integer Integer
    f5 ( Left a) =  Left (a+1)
    f5 ( Right b) =  Right (b+1)

    --
    triTest = testGroup "Test equal Trival" [

      QC.testProperty "Eq Reflexivity Trival a == Trival a = True" $ 
         \m -> m == (m :: Trival Integer),
      
      QC.testProperty "Eq Symmetry Trival (x==y) == (y==x)" $ 
         \x y -> ((x:: Trival Integer) == (y :: Trival Integer))==(y==x),
              
      QC.testProperty "Eq Transitivity Trival if x==y and y==z then x==z" $ 
         \x y z -> if (((x:: Trival Integer)==(y :: Trival Integer)) && (y==(z :: Trival Integer))) == True
                   then (x==z)==True
                   else ((x==z) && (x==y)) ==False,
    
      QC.testProperty "Eq Substitutivity Trival if a == b, then f a == f b" $ 
         \x y -> if ((x :: Trival Integer) == (y :: Trival Integer)) == True 
                 then ((f6 x) == (f6 y)) == True
                 else ((f6 x) == (f6 y)) == True,

      QC.testProperty "Eq Negation Trival x /= y = not (x == y)" $ 
         \x y -> (x /= y) == not ((x :: Trival Integer) == (y:: Trival Integer))          
      ]

    f6 :: Trival Integer -> Trival Integer
    f6 NoA = NoA

