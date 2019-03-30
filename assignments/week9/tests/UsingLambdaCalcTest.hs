module UsingLambdaCalcTest  where

  import Test.Tasty (defaultMain, testGroup)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase)
  import Test.Tasty.QuickCheck (testProperty )

  import UsingLambdaCalc(true, false, not, and, or, xor, zero, one, two, three, seven, add, mult, isEven)

  toStandardBool b = b True False

  toStandardInteger n = n (+1) 0

  fromStandardInteger :: Integer -> (a -> a) -> a -> a
  fromStandardInteger 0 f s = s
  fromStandardInteger n f s = f (fromStandardInteger (n-1) f s )

  usingLambdaCalcTest = testGroup "UsingLambdaCalc test" [
      testCase "1 - true returns first" $ assertEqual [] "then" $ true "then" "else",
      testCase "1 - false returns 2nd" $ assertEqual [] "else" $ false "then" "else",

      testCase "1 - (not true) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.not true),
      testCase "1 - (not false) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.not false),

      testCase "1 - (and true true) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.and true true),
      testCase "1 - (and true false) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.and true false),
      testCase "1 - (and false true) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.and false true),
      testCase "1 - (and false false) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.and false false),

      testCase "1 - 0 ok" $ assertEqual [] 0 $ toStandardInteger zero,
      testCase "1 - 1 ok" $ assertEqual [] 1 $ toStandardInteger one,
      testCase "1 - 2 ok" $ assertEqual [] 2 $ toStandardInteger two,
      testCase "1 - 3 ok" $ assertEqual [] 3 $ toStandardInteger three,
      testCase "1 - 7 ok" $ assertEqual [] 7 $ toStandardInteger seven,

      testProperty "5 - add is correct" $ (((\n m -> if m >= 0 && n >= 0
                                                    then  (n + m == (toStandardInteger $ add (fromStandardInteger n) (fromStandardInteger m)))
                                                    else True)):: (Integer -> Integer -> Bool)),

      testProperty "5 - mult is correct" $ (((\n m -> if m >= 0 && n >= 0
                                                    then  (n * m == (toStandardInteger $ mult (fromStandardInteger n) (fromStandardInteger m)))
                                                    else True)):: (Integer -> Integer -> Bool)) ,

      testCase "1 - isEven 0 ok" $ assertEqual [] True $ toStandardBool $ isEven zero,
      testCase "1 - isEven 1 ok" $ assertEqual [] False $ toStandardBool $ isEven one,
      testCase "1 - isEven 2 ok" $ assertEqual [] True $  toStandardBool $ isEven two,
      testProperty "5 - isEven is correct" $ (((\n -> if n >= 0
                                                    then  ((mod n 2) == 0) == (toStandardBool $ isEven $ fromStandardInteger n)--isEven (fromStandardInteger n)))
                                                    else True)):: ( Integer -> Bool)),

      testCase "1 - (or true true) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.or true true),
      testCase "1 - (or true false) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.or true false),
      testCase "1 - (or false true) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.or false true),
      testCase "1 - (or false false) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.or false false),
    
      testCase "1 - (xor true true) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.xor true true),
      testCase "1 - (xor true false) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.xor true false),
      testCase "1 - (xor false true) -> true" $ assertEqual [] True $ toStandardBool (UsingLambdaCalc.xor false true),
      testCase "1 - (xor false false) -> false" $ assertEqual [] False $ toStandardBool (UsingLambdaCalc.xor false false)
                                                  
    ]



    