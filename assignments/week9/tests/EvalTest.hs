module EvalTest where
  
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )

  import LambdaCalcImplementation (eval)
  import Examples (evalRes, Res(..))
  
  evalTest = testGroup "eval test" $
    [testCase ("1 - testing for eval of " ++ testStr) $ 
      res @=? eval formula | (Res testStr formula res) <- evalRes]
