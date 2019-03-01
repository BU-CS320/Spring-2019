module Main where

  import System.Environment
  import Test.Tasty (defaultMain, testGroup, TestTree)

  import LangTest (langTest)


  main = 
    do 
        setEnv "TASTY_TIMEOUT" "5s"
        setEnv "TASTY_QUICKCHECK_TESTS" "20" --TODO: I never trust less than 10000
        setEnv "TASTY_QUICKCHECK_MAX_SIZE" "50"
        putStrLn "\nTest is not avaliable yet\n"
        unsetEnv "TASTY_TIMEOUT"
        unsetEnv "TASTY_QUICKCHECK_TESTS"
        unsetEnv "TASTY_QUICKCHECK_MAX_SIZE"

  allTests = testGroup "all tests" [
    -- langTest
    ]
