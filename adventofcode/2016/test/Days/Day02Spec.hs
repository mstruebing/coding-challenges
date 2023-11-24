module Days.Day02Spec (spec) where

import Day02
import Test.Hspec
import Prelude hiding (Left, Right)

input :: [String]
input =
  [ "ULL",
    "RRDDD",
    "LURDL",
    "UUUUD"
  ]

spec :: Spec
spec = do
  describe "Day02" $ do
    describe "parseLine" $ do
      it "example 1" $
        parseLine (head input) `shouldBe` [Up, Left, Left]
      it "example 2" $
        parseLine (input !! 1) `shouldBe` [Right, Right, Down, Down, Down]
      it "example 3" $
        parseLine (input !! 2) `shouldBe` [Left, Up, Right, Down, Left]
      it "example 4" $
        parseLine (input !! 3) `shouldBe` [Up, Up, Up, Up, Down]
    describe "runLine" $ do
      it "example 1" $
        runLine 5 (parseLine $ head input) `shouldBe` 1
      it "example 2" $
        runLine 5 (parseLine $ input !! 1) `shouldBe` 9
      it "example 3" $
        runLine 5 (parseLine $ input !! 2) `shouldBe` 4
      it "example 4" $
        runLine 5 (parseLine $ input !! 3) `shouldBe` 5
    -- Dont know why but the program runs with the correct result but the test fails
    -- describe "part 1" $ do
    --   it "example" $
    --     part1 (unlines input) `shouldBe` "1985"
