import Lib
import Test.Hspec
import Test.QuickCheck

input :: [String]
input =
  [ "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010"
  ]

main :: IO ()
main = hspec $ do
  describe "Part 1" $ do
    it "getLeastCommonBit" $
      Lib.getLeastCommonBit [1, 0, 0, 1, 1] `shouldBe` 0
    it "getLeastCommonBit" $
      Lib.getMostCommonBit [1, 0, 0, 1, 1] `shouldBe` 1
    it "getSingleIndexBits" $
      Lib.getSingleIndexBits input 0 `shouldBe` [0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0]
    it "getIndexBits" $
      Lib.getIndexBits input
        `shouldBe` [ [0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0],
                     [0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
                     [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
                     [0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1],
                     [0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0]
                   ]
    it "binaryIntListToDigit" $
      Lib.binaryIntListToDigit [1, 0, 1, 1, 0] `shouldBe` 22
    it "calc" $
      Lib.calc input `shouldBe` 198
