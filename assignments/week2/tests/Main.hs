{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

module Main where

  --TODO: note for next year: use typeclasses for the conversion, and to give deffinitions of equality to existing data, so conversions are not needed
  -- quick check become very counter productive

  import Hw
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  
  main = defaultMain allTests
  
  allTests = testGroup "allTests" 
    [
      boolTest
      , natTest
      , dayTest
      , monthTest
      , pointTest
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
  
  -- define the iso between Nat and a subset of integer
  instance Iso Hw.Nat Prelude.Integer where 
    isoMap Zero = 0
    isoMap (Succ n) = (isoMap n) + 1
    isoInverse 0 = Zero 
    isoInverse n 
      | n < 0 = undefined -- don't convert nagative number to Nat
      | n > 0 = Succ (isoInverse (n - 1)) 

  -- define the iso between Hw point and prelude point
  instance Iso Hw.Point (Integer, Integer) where 
    isoMap p = (isoMap . getX $ p, isoMap . getY $ p)
    isoInverse (x, y) = makePoint (isoInverse x) (isoInverse y)

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
    assertEqual [] (g . isoMap $ input) (isoMap . f $ input)

  testTwoArgFuncByIso :: 
    (Iso aI1 bI1, Iso aI2 bI2, Iso aO bO, Eq bO, Show bO, Show aO, Show aI1, Show aI2) => 
    String ->  -- the message for success
    (aI1 -> aI2 -> aO) ->  -- the function you implemented
    (bI1 -> bI2 -> bO) ->  -- the existing function that is isomorphic to your function
    aI1 -> aI2 ->  -- the input for the function you want to test
    TestTree
  testTwoArgFuncByIso sucMsg f g input1 input2 = testCase sucMsg $ 
    assertEqual [] (g (isoMap input1) (isoMap input2)) (isoMap (f input1 input2))

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
  
  ---- Test for Bool ----
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
  
  ---- Test for Nat ----
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
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]


  -- test mult
  multTest = testGroup "test mult function"
    [
      testTwoArgFuncByIso ("testing mult " ++ show a1 ++ " " ++ show a2) 
        Hw.mult ((*)::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]
  
  -- test exponential
  expTemp x y = (^) y x 
  expTest = testGroup "test exp function"
    [
      testTwoArgFuncByIso ("testing exp " ++ show a1 ++ " " ++ show a2) 
        Hw.exp (expTemp::Integer -> Integer -> Integer) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]

  -- test equality
  eqTest = testGroup "test eq function"
    [
      testTwoArgFuncByIso ("testing eq " ++ show a1 ++ " " ++ show a2) 
        Hw.eq ((==)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]

  -- test inequality
  neTest = testGroup "test ne function"
    [
      testTwoArgFuncByIso ("testing ne " ++ show a1 ++ " " ++ show a2) 
        Hw.ne ((/=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]

  -- test less than
  ltTest = testGroup "test lt function"
    [
      testTwoArgFuncByIso ("testing lt " ++ show a1 ++ " " ++ show a2) 
        Hw.lt ((<)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]

  -- test greater than
  gtTest = testGroup "test gt function"
    [
      testTwoArgFuncByIso ("testing gt " ++ show a1 ++ " " ++ show a2) 
        Hw.gt ((>)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]
  
  -- test less than equal
  leTest = testGroup "test le function"
    [
      testTwoArgFuncByIso ("testing le " ++ show a1 ++ " " ++ show a2) 
        Hw.le ((<=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]

  -- test greater than equal
  geTest = testGroup "test ge function"
    [
      testTwoArgFuncByIso ("testing ge " ++ show a1 ++ " " ++ show a2) 
        Hw.ge ((>=)::Integer -> Integer -> Prelude.Bool) 
        ((isoInverse::Integer -> Nat) a1)
        ((isoInverse::Integer -> Nat) a2)  
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]
  
  -- test even
  tempEven s = (s `mod` 2) == 0
  isEvenTest = testGroup "test isEven function"
    [
      testOneArgFuncByIso ("testing isEven " ++ show a1) 
        Hw.isEven (tempEven :: Integer -> Prelude.Bool)
        ((isoInverse::Integer -> Nat) a1)
      | a1 <- [0 .. 5]
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
      | a1 <- [0 .. 5], a2 <- [0 .. 5]
    ]
  
  ---- Test for Days ----
  -- implement Eq type class for DaysOfWeek
  deriving instance Eq DayOfWeek

  -- this is a helper function to calculate the day for next n days
  nextNDaysOf :: DayOfWeek -> Int -> DayOfWeek
  nextNDaysOf d n
    | n < 0 = undefined  -- do not support previous days
    | n == 0 = d 
    | n > 0 = nextNDaysOf (nextDay d) (n - 1)
  
  -- a list of all the posible days in week
  allPossibleDays :: [DayOfWeek]
  allPossibleDays = map (nextNDaysOf favoriteDay) [0..6]

  weekends :: [DayOfWeek]
  weekends = filter (isoMap . isWeekend) allPossibleDays

  -- the test for days
  dayTest = testGroup "testing all the function of DayOfWeek"
    [
      dayEqualityTest
      , weekendsTest
    ]

  -- all the days should be different from each other 
  dayEqualityTest = testGroup "test the equality of days"
    [
      testCase ("test equality of the " ++ 
        show n1 ++ "th day after favoriteDay and the " ++ 
        show n2 ++ "th day after favoriteDay")
      $ assertEqual [] (n1 == n2) ((nextNDaysOf d n1) == (nextNDaysOf d n2)) 
      | n1 <- [0..6], n2 <- [0..6]
    ]
    where 
      d = favoriteDay
  
  -- There can be only two weekend
  weekendsTest = testGroup "test for weekends"
      [
        testCase ("There should be " ++ show numberOfWeekends ++ " weekends for " ++ show daysAfterWeekends ++ " days after all the weekends")
        $ assertEqual [] numberOfWeekends 
          (Prelude.length . filter  (isoMap . isWeekend) . map (\d -> nextNDaysOf d daysAfterWeekends) $ weekends)
        | (numberOfWeekends, daysAfterWeekends) <-
            [(2, 0), (1, 1), (0, 2), (0, 3), (0, 4), (0, 5), (1, 6)]
      ]

  ---- Test Month ----
  -- implement eq type class for for month
  deriving instance Eq Month

  -- helper
  nextNMonthsOf :: Month -> Int -> Month
  nextNMonthsOf m n
    | n < 0 = undefined  -- do not support previous days
    | n == 0 = m
    | n > 0 = nextNMonthsOf (nextMonth m) (n - 1)

  allMonths :: [Month]
  allMonths = map (nextNMonthsOf partyMonth) [0..11]

  -- The test for month
  monthTest = testGroup "Test all the function on Month"
    [
      monthEqualityTest
      , after12BackToOriginTest
    ]

  -- test for all the equality of month
  -- only the same month should be equal to each other
  -- others should be different 
  monthEqualityTest = testGroup "test the equality of months"
    [
      testCase ("test equality of the "++ show n1 ++ 
        "th month after party month and " ++ show n2 ++ 
        "th month after party month")
      $ assertEqual [] (n1 == n2) ((nextNMonthsOf m n1) == (nextNMonthsOf m n2)) 
      | n1 <- [0..11], n2 <- [0..11]
    ]
    where 
      m = partyMonth

  -- test that for all month, after 12 month it will go back to the original month
  after12BackToOriginTest = testGroup "test after 12 month the it should be the original month" 
    [
      testCase ("12 months after " ++ show m ++ " should still be " ++ show m)
      $ assertEqual [] m (nextNMonthsOf m 12)
      | m <- allMonths
    ]

  ---- Test Point ----
  -- implement Eq type class for Point
  deriving instance Eq Point

  -- test for point
  pointTest = testGroup "test all the function on Points" 
    [
      testUnpackThenPack
      , testPackThenUnpack
      , testManhattanDistance
    ]

  -- test for iso
  testUnpackThenPack = testGroup "test packing and then unpack"
      [
        testCase ("packing with " ++ show n1 ++ " and " ++ show n2 ++ " then unpack")
          $ assertEqual [] (n1, n2) 
            (isoMap . (isoInverse::(Integer, Integer) -> Point) $ (n1, n2))
        | n1 <- [0..2], n2 <- [0..2]
      ]

  testPackThenUnpack = testGroup "test unpack and then pack"
      [
        testCase ("unpacking ("++ show n1 ++ ", " ++ show n2 ++ ") then unpack")
          $ assertEqual [] (makePoint (isoInverse n1) (isoInverse n2))
            ((isoInverse::(Integer, Integer) -> Point) . isoMap $ (makePoint (isoInverse n1) (isoInverse n2)))
        | n1 <- [0..2] :: [Integer], n2 <- [0..2] :: [Integer]
      ]
  
  -- test for manhattanDistance
  manhattanTemp :: (Integer, Integer) -> (Integer, Integer) -> Integer
  manhattanTemp (a1, b1) (a2, b2)= abs (a1 - a2) + abs (b1 - b2)
  testManhattanDistance = testGroup "test for manhattan distance"
    [
      testTwoArgFuncByIso ("testing manhattanDistance between " ++ show (a1, b1) ++ " and " ++ show (a2, b2)) 
        manhattanDistance manhattanTemp 
        ((isoInverse::(Integer, Integer) -> Point) (a1, b1))
        ((isoInverse::(Integer, Integer) -> Point) (a2, b2))  
      | a1 <- [0..2], a2 <- [0..2], b1 <- [0..2], b2 <- [0..2]
    ]
  