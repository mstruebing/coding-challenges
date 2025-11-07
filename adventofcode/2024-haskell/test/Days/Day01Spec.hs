module Days.Day01Spec (spec) where

import qualified Data.Text as T
import Days.Day01 (inputParser, partA, partB)
import Data.Attoparsec.Text (parseOnly)
import Test.Hspec

input :: T.Text
input = T.pack "\n3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"

parsedInput :: ([Int], [Int])
parsedInput = ([3,4,2,1,3,3],[4,3,5,3,9,3])

spec :: Spec
spec = do
    describe "inputParser" $ do
      it "parses the sample input correctly" $ do
            parseOnly inputParser input `shouldBe` Right parsedInput
    describe "Day01PartA" $ do
      it "Returns sample result" $ do
            partA parsedInput `shouldBe` 11
    describe "Day01PartB" $ do
      it "Returns sample result" $ do
            partB parsedInput `shouldBe` 31
