module IsClosedTest where
  
  import Test.Tasty (defaultMain, testGroup, TestTree)
  import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
  import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )
  
  import LambdaCalcImplementation
  import LambdaTestTypes
  
  isClosedTest = testGroup "isClosed test" [
    ]