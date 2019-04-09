module Main where

  import System.Environment
  import Test.Tasty (defaultMain, testGroup, TestTree)

  import LangParserTest (parserTest)
  import LangEvalTest (errorTest, evalTest, stdLibTest)

  main = 
    do 
        setEnv "TASTY_TIMEOUT" "5s"
        setEnv "TASTY_QUICKCHECK_TESTS" "1000" --TODO: I never trust less than 10000
        setEnv "TASTY_QUICKCHECK_MAX_SIZE" "100"
        defaultMain allTests
        unsetEnv "TASTY_TIMEOUT"
        unsetEnv "TASTY_QUICKCHECK_TESTS"
        unsetEnv "TASTY_QUICKCHECK_MAX_SIZE"

  allTests =
    testGroup
      "allTests"
      [
        errorTest,
        evalTest,
        stdLibTest,
        parserTest
      ]
