module Main where

import Test.Tasty

import LangParserTest

main = defaultMain testSuite

--TODO: figure out how to set the timeout

testSuite =
  testGroup
    "allTests"
    [
        LangParserTest.unitTests
    ]
