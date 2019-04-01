module IsValueTest where
  
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )

  import LambdaCalcImplementation (isValue)
  import Examples (isValRes, Res(..))
  
  isValueTest = testGroup "isValue test" $
    [testCase ("1 - testing for isValue of " ++ testStr) $ 
      res @=? isValue formula | (Res testStr formula res) <- isValRes]
