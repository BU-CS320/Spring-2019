{-# LANGUAGE MultiParamTypeClasses #-}

module Main where

  --TODO: note for next year: use typeclasses for the conversion, and to give deffinitions of equality to existing data, so conversions are not needed
  -- quick check become very counter productive

  import Hw
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  
  main = defaultMain allTests
  
  allTests = testGroup "allTests" 
    [
      boolTest,
      natTest
    ]
  
  -- Utils 
  -- 

  -- This class defines an isomorphism between two types,
  -- we use this to link types in Hw to types in Prelude to make it easier to test
  class Iso a b where
    isoMap :: a -> b  -- isoMap will map HW to Prelude
    isoInverse :: b -> a  -- isoInverse is the inverse of isMap
    
  -- define the isomorphism between Hw.Bool and Prelude.Bool
  instance Iso Hw.Bool Prelude.Bool where 
    isoMap Hw.True = Prelude.True 
    isoMap Hw.False = Prelude.False
    isoInverse Prelude.True =  Hw.True 
    isoInverse Prelude.False = Hw.False
  
  instance Iso Hw.Nat Prelude.Integer where 
    isoMap Zero = 0
    isoMap (Succ n) = (isoMap n) + 1
    isoInverse 0 = Zero 
    isoInverse n 
      | n < 0 = undefined -- don't convert nagative number to Nat
      | n > 0 = Succ (isoInverse (n - 1)) 

  -- this function test a function by existing isomorphic function
  -- it feeds the testing function and the existing function with isomorphic parameters
  -- and their return should be also isomorphic:
  -- idea: if A isomorphic to B, and f: A -> A is isomorphic to g: B -> B
  --       then f(a) needs to be isomorphic to g(b)
  testOneArgFuncByIso :: 
    (Iso aI bI, Iso aO bO, Eq bO, Show bI, Show bO) => 
    String ->  -- the message for success
    (aI -> aO) ->  -- the function you implemented
    (bI -> bO) ->  -- the existing function that is isomorphic to your function
    aI ->  -- the input for the function you want to test
    TestTree 
  testOneArgFuncByIso sucMsg f g input = testCase sucMsg $ 
    assertEqual [] (isoMap . f $ input) (g . isoMap $ input)

  testTwoArgFuncByIso :: 
    (Iso aI1 bI1, Iso aI2 bI2, Iso aO bO, Eq bO, Show bO, Show aO, Show aI1, Show aI2) => 
    String ->  -- the message for success
    (aI1 -> aI2 -> aO) ->  -- the function you implemented
    (bI1 -> bI2 -> bO) ->  -- the existing function that is isomorphic to your function
    aI1 -> aI2 ->  -- the input for the function you want to test
    TestTree
  testTwoArgFuncByIso sucMsg f g input1 input2 = testCase sucMsg $ 
    assertEqual [] (isoMap (f input1 input2)) (g (isoMap input1) (isoMap input2))

  -- this function converts from our custom Bools to the standard Bools so we have a lot of automatic things already defined
  fromhwBoolToStandardBool :: Hw.Bool -> Prelude.Bool
  fromhwBoolToStandardBool Hw.True  = Prelude.True
  fromhwBoolToStandardBool Hw.False = Prelude.False

  -- this function converts from our custom Bools to the standard Bools so we have a lot of automatic things already defined
  fromStdBoolToHwBool :: Prelude.Bool -> Hw.Bool
  fromStdBoolToHwBool Prelude.True  = Hw.True
  fromStdBoolToHwBool Prelude.False = Hw.False
  
  -- this function converts from our custom Nats to the standard Integers so we have a lot of automatic things already defined
  fromNatToInteger :: Nat -> Integer
  fromNatToInteger Zero     = 0
  fromNatToInteger (Succ n) = 1 + (fromNatToInteger n)
  
  
  fromIntegerToNat :: Integer -> Nat
  fromIntegerToNat 0     = Zero
  fromIntegerToNat x = (Succ(fromIntegerToNat (x-1)))
  
  -- this function converts from our List to the standard List so we have a lot of automatic things already defined
  fromhwListToStandardList :: Hw.List a -> [a]
  fromhwListToStandardList Nil      = []
  fromhwListToStandardList (Cons x y) = x:fromhwListToStandardList y
  
  fromStandardListToHwList :: [a] -> Hw.List a 
  fromStandardListToHwList []     = Nil 
  fromStandardListToHwList ( x :  y) = Cons x  (fromStandardListToHwList y)
  
  
  fromtandardList2HwLsNat :: [Integer] -> Hw.ListNat
  fromtandardList2HwLsNat []      = NilNat
  fromtandardList2HwLsNat (x: y) = (ConsNat (fromIntegerToNat x) (fromtandardList2HwLsNat y))
  
  fromtandardHwLsNat2Ls :: Hw.ListNat -> [Integer]
  fromtandardHwLsNat2Ls NilNat      = []
  fromtandardHwLsNat2Ls (ConsNat x y) = (fromNatToInteger x ) :(fromtandardHwLsNat2Ls y)
  
  
  instance Eq Hw.Bool where
    Hw.True == Hw.True  = Prelude.True
    Hw.True == _  = Prelude.False
    Hw.False == Hw.False  = Prelude.True
    Hw.False == _  = Prelude.False
    
  instance Eq Hw.Nat where
    Hw.Zero == Hw.Zero  = Prelude.True
    (Succ x) == (Succ y)  = x == y
    _ == _  = Prelude.False
    
    
  instance  (Eq a) => Eq (Hw.List a) where
    Hw.Nil == Hw.Nil  = Prelude.True
    (Hw.Cons x xs) == (Hw.Cons y ys)  = (x == y) && (xs == ys)
    _ == _  = Prelude.False
  
  
  ------- Tests 
  
  ---- Test for Bool
  boolTest = testGroup "test for all the boolean functions"
    [
      notTest,
      andTest,
      orTest,
      xorTest
    ]
  
  -- not test
  notTest = testGroup "test not function" 
    [
      testOneArgFuncByIso ("testing not " ++ show input) 
       Hw.not Prelude.not input | input <- [Hw.True, Hw.False]
    ]

  -- and test
  correctAnd b1 b2 = fromStdBoolToHwBool (fromhwBoolToStandardBool b1 && fromhwBoolToStandardBool b2)
  andTest = testGroup "test and function"
    [
      testTwoArgFuncByIso ("testing and " ++ show b1 ++ " " ++ show b2) 
        Hw.and (&&) b1 b2
      | b1 <- [Hw.True, Hw.False], b2 <- [Hw.True, Hw.False]
    ]

  -- or test
  orTest = testGroup "test or function"
    [
      testTwoArgFuncByIso ("testing or " ++ show b1 ++ " " ++ show b2) 
        Hw.or (||) b1 b2
      | b1 <- [Hw.True, Hw.False], b2 <- [Hw.True, Hw.False]
    ]
  
  -- xor test
  xorTemp b1 b2 = (b1 || b2) && Prelude.not (b1 && b2)
  xorTest = testGroup "test xor function"
    [
      testTwoArgFuncByIso ("testing xor " ++ show b1 ++ " " ++ show b2) 
        Hw.xor xorTemp b1 b2
      | b1 <- [Hw.True, Hw.False], b2 <- [Hw.True, Hw.False]
    ]
  
  ---- Test for Nat
  natTest = testGroup "test for all nat function" 
    [
      basicNatTest,
      addTest,
      multTest,
      expTest,
      eqTest,
      neTest,
      ltTest,
      gtTest,
      leTest,
      geTest,
      isEvenTest,
      maxTest
    ]

  -- basic nat
  basicNatTest = testGroup "test basic nat definition"
    [
      testCase "test zero" $ assertEqual [] 0 (isoMap (Hw.zero::Hw.Nat)::Integer),
      testCase "test one" $ assertEqual [] 1 (isoMap (Hw.one::Hw.Nat)::Integer),
      testCase "test two" $ assertEqual [] 2 (isoMap (Hw.two::Hw.Nat)::Integer),
      testCase "test three" $ assertEqual [] 3 (isoMap (Hw.three::Hw.Nat)::Integer),
      testCase "test four" $ assertEqual [] 4 (isoMap (Hw.four::Hw.Nat)::Integer),
      testCase "test five" $ assertEqual [] 5 (isoMap (Hw.five::Hw.Nat)::Integer)      
    ]
  
  -- test addition
  addTest = testGroup "test add function"
    [
      testTwoArgFuncByIso  ("testing add " ++ show a1 ++ " " ++ show a2) 
        Hw.add ((+)::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]


  -- test mult
  multTest = testGroup "test mult function"
    [
      testTwoArgFuncByIso ("testing mult " ++ show a1 ++ " " ++ show a2) 
        Hw.mult ((*)::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]
  
  -- test exponential
  expTemp x y = (^) y x 
  expTest = testGroup "test exp function"
    [
      testTwoArgFuncByIso ("testing exp " ++ show a1 ++ " " ++ show a2) 
        Hw.exp (expTemp::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]

  -- test equality
  eqTest = testGroup "test eq function"
    [
      testTwoArgFuncByIso ("testing eq " ++ show a1 ++ " " ++ show a2) 
        Hw.eq ((==)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]

  -- test inequality
  neTest = testGroup "test ne function"
    [
      testTwoArgFuncByIso ("testing ne " ++ show a1 ++ " " ++ show a2) 
        Hw.ne ((/=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]

  -- test less than
  ltTest = testGroup "test lt function"
    [
      testTwoArgFuncByIso ("testing lt " ++ show a1 ++ " " ++ show a2) 
        Hw.lt ((<)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]

  -- test greater than
  gtTest = testGroup "test gt function"
    [
      testTwoArgFuncByIso ("testing gt " ++ show a1 ++ " " ++ show a2) 
        Hw.gt ((>)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]
  
  -- test less than equal
  leTest = testGroup "test le function"
    [
      testTwoArgFuncByIso ("testing le " ++ show a1 ++ " " ++ show a2) 
        Hw.le ((<=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]

  -- test greater than equal
  geTest = testGroup "test ge function"
    [
      testTwoArgFuncByIso ("testing ge " ++ show a1 ++ " " ++ show a2) 
        Hw.ge ((>=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]
  
  -- test even
  tempEven s = (s `mod` 2) == 0
  isEvenTest = testGroup "test isEven function"
    [
      testOneArgFuncByIso ("testing isEven " ++ show a1) 
        Hw.isEven (tempEven :: Integer -> Prelude.Bool)
        ((isoInverse::Integer -> Nat) a1)
      | a1 <- [1 .. 5]
    ]

  -- test max
  maxTemp x y 
    | x < y = y 
    | otherwise = x 
  maxTest = testGroup "test ge function"
    [
      testTwoArgFuncByIso ("testing max " ++ show a1 ++ " " ++ show a2) 
        Hw.max (maxTemp::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [1 .. 5], a2 <- [1 .. 5]
    ]
  
  