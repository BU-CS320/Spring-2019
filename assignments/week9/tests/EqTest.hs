module EqTest where
  
    import Test.Tasty (defaultMain, testGroup, TestTree)
    import Test.Tasty.HUnit (assertEqual, assertBool, testCase, (@=?))
    import Test.Tasty.QuickCheck (testProperty,Arbitrary, oneof,arbitrary )
    
    import LambdaCalcImplementation (Term)
    import Examples (eqRes, ResTwo(..))
    
    eqTest = testGroup "eq test" $ 
      [testCase ("1 - testing for alpha equavalence of " ++ testStrL ++ " and " ++ testStrR) $
        res @=? (l == r) | (ResTwo (testStrL, testStrR) (l, r) res) <- eqRes]