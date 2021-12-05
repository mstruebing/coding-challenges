import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "parsing" $ do
    it "parsePoint" $
      parsePoint "0,9" `shouldBe` (0, 9)
    it "parseLine" $
      parseLine "0,9 -> 5,9" `shouldBe` ((0, 9), (5, 9))
    it "parseInput" $
      parseInput testInput `shouldBe` testLinesResult
    it "onlyStraightLines" $
      onlyStraightLines testLinesResult `shouldBe` straightLines
    it "getPoints" $
      getPoints (head straightLines) `shouldBe` [(0, 9), (1, 9), (2, 9), (3, 9), (4, 9), (5, 9)]
    it "getMultiplePointAmount" $
      getMultiplePointAmount straightLines `shouldBe` 5

testInput :: [String]
testInput =
  [ "0,9 -> 5,9",
    "8,0 -> 0,8",
    "9,4 -> 3,4",
    "2,2 -> 2,1",
    "7,0 -> 7,4",
    "6,4 -> 2,0",
    "0,9 -> 2,9",
    "3,4 -> 1,4",
    "0,0 -> 8,8",
    "5,5 -> 8,2"
  ]

testLinesResult :: Lines
testLinesResult =
  [ ((0, 9), (5, 9)),
    ((8, 0), (0, 8)),
    ((9, 4), (3, 4)),
    ((2, 2), (2, 1)),
    ((7, 0), (7, 4)),
    ((6, 4), (2, 0)),
    ((0, 9), (2, 9)),
    ((3, 4), (1, 4)),
    ((0, 0), (8, 8)),
    ((5, 5), (8, 2))
  ]

straightLines :: Lines
straightLines =
  [ ((0, 9), (5, 9)),
    ((9, 4), (3, 4)),
    ((2, 2), (2, 1)),
    ((7, 0), (7, 4)),
    ((0, 9), (2, 9)),
    ((3, 4), (1, 4))
  ]
