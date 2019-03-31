module FreeVarsTest where
  
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )
  
  import LambdaCalcImplementation (freeVars)
  import Examples (freeVarsRes, Res(..))
  
  freeVarsTest = testGroup "freeVars test" $
    [testCase ("1 - testing for freeVars of " ++ testStr) $ 
      res @=? freeVars formula | (Res testStr formula res) <- freeVarsRes]