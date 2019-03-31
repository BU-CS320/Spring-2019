module IsClosedTest where
  
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )
  
  import LambdaCalcImplementation (isClosed)
  import Examples (isClosedRes, Res(..))

  isClosedTest = testGroup "isClosed test"  $
    [testCase ("1 - testing for isClosed of " ++ testStr) $ 
      res @=? isClosed formula | (Res testStr formula res) <- isClosedRes]
