import Lib (findDuplicate, first, getItemPriority, splitInHalf)
import Test.Hspec
import Test.QuickCheck

input :: [String]
input =
  [ "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw"
  ]

main :: IO ()
main = hspec $ do
  describe "Lib" $ do
    it "splitInHalf.0`" $
      splitInHalf (input !! 0) `shouldBe` ("vJrwpWtwJgWr", "hcsFMMfFFhFp")
    it "splitInHalf.1`" $
      splitInHalf (input !! 1) `shouldBe` ("jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL")
    it "findDuplicate.0" $
      (findDuplicate $ splitInHalf $ input !! 0) `shouldBe` 'p'
    it "findDuplicate.1" $
      (findDuplicate $ splitInHalf $ input !! 1) `shouldBe` 'L'
    it "findDuplicate.2" $
      (findDuplicate $ splitInHalf $ input !! 2) `shouldBe` 'P'
    it "findDuplicate.3" $
      (findDuplicate $ splitInHalf $ input !! 3) `shouldBe` 'v'
    it "findDuplicate.4" $
      (findDuplicate $ splitInHalf $ input !! 4) `shouldBe` 't'
    it "findDuplicate.5" $
      (findDuplicate $ splitInHalf $ input !! 5) `shouldBe` 's'
    it "getItemPriority.0" $
      (getItemPriority 'p') `shouldBe` 16
    it "getItemPriority.1" $
      (getItemPriority 'L') `shouldBe` 38
    it "getItemPriority.2" $
      (getItemPriority 'P') `shouldBe` 42
    it "getItemPriority.3" $
      (getItemPriority 'v') `shouldBe` 22
    it "getItemPriority.4" $
      (getItemPriority 't') `shouldBe` 20
    it "getItemPriority.5" $
      (getItemPriority 's') `shouldBe` 19
    it "first" $
      first input `shouldBe` 157
