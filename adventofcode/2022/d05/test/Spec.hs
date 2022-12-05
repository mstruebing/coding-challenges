import Data.Map (fromList)
import Lib
import Test.Hspec

rawInput :: [String]
rawInput =
  [ "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 ",
    "",
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2"
  ]

rawShip :: [String]
rawShip =
  [ "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 "
  ]

rawMoves :: [String]
rawMoves =
  [ "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2"
  ]

parsedInput :: Ship
parsedInput = fromList [(1, ['N', 'Z']), (2, ['D', 'C', 'M']), (3, ['P'])]

firstMove :: Ship
firstMove = move parsedInput (1, 2, 1)

secondMove :: Ship
secondMove = move firstMove (3, 1, 3)

thirdMove :: Ship
thirdMove = move secondMove (2, 2, 1)

fourthMove :: Ship
fourthMove = move thirdMove (1, 1, 2)

main :: IO ()
main = hspec $ do
  describe "move" $ do
    it "1" $
      firstMove `shouldBe` fromList [(1, ['D', 'N', 'Z']), (2, ['C', 'M']), (3, ['P'])]
    it "2" $
      secondMove `shouldBe` fromList [(1, []), (2, ['C', 'M']), (3, ['Z', 'N', 'D', 'P'])]
    it "3" $
      thirdMove `shouldBe` fromList [(1, ['M', 'C']), (2, []), (3, ['Z', 'N', 'D', 'P'])]
    it "4" $
      fourthMove `shouldBe` fromList [(1, ['C']), (2, ['M']), (3, ['Z', 'N', 'D', 'P'])]
  describe "parseMove" $ do
    it "1" $
      parseMove (rawMoves !! 0) `shouldBe` (1, 2, 1)
    it "2" $
      parseMove (rawMoves !! 1) `shouldBe` (3, 1, 3)
    it "3" $
      parseMove (rawMoves !! 2) `shouldBe` (2, 2, 1)
    it "4" $
      parseMove (rawMoves !! 3) `shouldBe` (1, 1, 2)
  describe "parseShip" $ do
    it "1" $
      parseShip rawShip `shouldBe` parsedInput
  describe "parse" $ do
    it "1" $
      parse rawInput `shouldBe` (parseShip rawShip, map parseMove rawMoves)
  describe "getFirstCrates" $ do
    it "1" $
      getFirstCrates (fromList [(1, ['C']), (2, ['M']), (3, ['Z', 'N', 'D', 'P'])]) `shouldBe` "CMZ"
  describe "first" $ do
    it "1" $
      first (parse rawInput) `shouldBe` "CMZ"
