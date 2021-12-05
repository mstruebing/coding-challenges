import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "hasWon" $ do
    it "First Row Wins" $
      hasWon winningBoardFirstRow `shouldBe` True
    it "Later Row Wins" $
      hasWon winningBoardLaterRow `shouldBe` True
    it "First Column Wins" $
      hasWon winningBoardFirstColumn `shouldBe` True
    it "Later Column Wins" $
      hasWon winningBoardLaterColumn `shouldBe` True
    it "Later Column Wins" $
      hasWon winningBoardLaterColumn `shouldBe` True
    it "Losing Row" $
      hasWon losingBoardRow `shouldBe` False
    it "Losing Column" $
      hasWon losingBoardColumn `shouldBe` False
    it "Losing Mixed" $
      hasWon losingBoardMixed `shouldBe` False
    it "Losing losingBoardLaterColumn" $
      hasWon losingBoardLaterColumn `shouldBe` False
  describe "set" $ do
    it "Sets not setted value single row" $
      set [[(1, False), (2, True), (3, True)]] 1 `shouldBe` [[(1, True), (2, True), (3, True)]]
    it "Dont modify alrady set valued single row" $
      set [[(1, False), (2, True), (3, True)]] 2 `shouldBe` [[(1, False), (2, True), (3, True)]]
    it "losingBoardRow" $
      set losingBoardRow 4 `shouldBe` winningBoardFirstRow
    it "losingBoardColumn" $
      set losingBoardColumn 2 `shouldBe` winningBoardFirstColumn
    it "losingBoardLaterColumn" $
      set losingBoardLaterColumn 3 `shouldBe` winningBoardLaterColumn
  describe "getUnmarkedSum" $ do
    it "calculates the correct score" $
      getUnmarkedSum realWinningBoard `shouldBe` 188
  describe "getScore" $ do
    it "calculates the correct score" $
      getScore realWinningBoard 24 `shouldBe` 4512
  describe "parse" $ do
    it "Gives correct instructions" $
      fst (parse parseInput) `shouldBe` expectedInstructions
    it "parseRow" $
      parseRow "22 13 17 11  0" `shouldBe` [(22, False), (13, False), (17, False), (11, False), (0, False)]
    it "parseBoards" $
      parseBoards (tail parseInput) `shouldBe` expectedBoards

winningBoardFirstRow :: Lib.Board
winningBoardFirstRow =
  [ [(14, True), (21, True), (17, True), (24, True), (4, True)],
    [(10, False), (16, False), (15, False), (9, False), (19, False)],
    [(18, False), (8, False), (23, False), (26, False), (20, False)],
    [(22, False), (11, False), (13, False), (6, False), (5, False)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

realWinningBoard :: Lib.Board
realWinningBoard =
  [ [(14, True), (21, True), (17, True), (24, True), (4, True)],
    [(10, False), (16, False), (15, False), (9, True), (19, False)],
    [(18, False), (8, False), (23, True), (26, False), (20, False)],
    [(22, False), (11, True), (13, False), (6, False), (5, True)],
    [(2, True), (0, True), (12, False), (3, False), (7, True)]
  ]

winningBoardLaterRow :: Lib.Board
winningBoardLaterRow =
  [ [(10, False), (16, False), (15, False), (9, False), (19, False)],
    [(18, False), (8, False), (23, False), (26, False), (20, False)],
    [(22, False), (11, False), (13, False), (6, False), (5, False)],
    [(14, True), (21, True), (17, True), (24, True), (4, True)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

winningBoardFirstColumn :: Lib.Board
winningBoardFirstColumn =
  [ [(10, True), (16, False), (15, False), (9, False), (19, False)],
    [(18, True), (8, False), (23, False), (26, False), (20, False)],
    [(22, True), (11, False), (13, False), (6, False), (5, False)],
    [(14, True), (21, False), (17, False), (24, False), (4, False)],
    [(2, True), (0, False), (12, False), (3, False), (7, False)]
  ]

winningBoardLaterColumn :: Lib.Board
winningBoardLaterColumn =
  [ [(10, False), (16, False), (15, False), (9, True), (19, False)],
    [(18, False), (8, False), (23, False), (26, True), (20, False)],
    [(22, False), (11, False), (13, False), (6, True), (5, False)],
    [(14, False), (21, False), (17, False), (24, True), (4, False)],
    [(2, False), (0, False), (12, False), (3, True), (7, False)]
  ]

losingBoardLaterColumn :: Lib.Board
losingBoardLaterColumn =
  [ [(10, False), (16, False), (15, False), (9, True), (19, False)],
    [(18, False), (8, False), (23, False), (26, True), (20, False)],
    [(22, False), (11, False), (13, False), (6, True), (5, False)],
    [(14, False), (21, False), (17, False), (24, True), (4, False)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

losingBoardRow :: Lib.Board
losingBoardRow =
  [ [(14, True), (21, True), (17, True), (24, True), (4, False)],
    [(10, False), (16, False), (15, False), (9, False), (19, False)],
    [(18, False), (8, False), (23, False), (26, False), (20, False)],
    [(22, False), (11, False), (13, False), (6, False), (5, False)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

losingBoardColumn :: Lib.Board
losingBoardColumn =
  [ [(10, True), (16, False), (15, False), (9, False), (19, False)],
    [(18, True), (8, False), (23, False), (26, False), (20, False)],
    [(22, True), (11, False), (13, False), (6, False), (5, False)],
    [(14, True), (21, False), (17, False), (24, False), (4, False)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

losingBoardMixed :: Lib.Board
losingBoardMixed =
  [ [(14, True), (21, True), (17, True), (24, True), (4, False)],
    [(10, True), (16, False), (15, False), (9, False), (19, False)],
    [(18, True), (8, False), (23, False), (26, False), (20, False)],
    [(22, True), (11, False), (13, False), (6, False), (5, False)],
    [(2, False), (0, False), (12, False), (3, False), (7, False)]
  ]

parseInput :: [String]
parseInput =
  [ "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
    "",
    "22 13 17 11  0",
    " 8  2 23  4 24",
    "21  9 14 16  7",
    " 6 10  3 18  5",
    " 1 12 20 15 19",
    "",
    " 3 15  0  2 22",
    " 9 18 13 17  5",
    "19  8  7 25 23",
    "20 11 10 24  4",
    "14 21 16 12  6",
    "",
    "14 21 17 24  4",
    "10 16 15  9 19",
    "18  8 23 26 20",
    "22 11 13  6  5",
    " 2  0 12  3  7"
  ]

expectedInstructions :: [Int]
expectedInstructions = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1]

expectedBoards :: [Board]
expectedBoards =
  [ [ [(22, False), (13, False), (17, False), (11, False), (0, False)],
      [(8, False), (2, False), (23, False), (4, False), (24, False)],
      [(21, False), (9, False), (14, False), (16, False), (7, False)],
      [(6, False), (10, False), (3, False), (18, False), (5, False)],
      [(1, False), (12, False), (20, False), (15, False), (19, False)]
    ],
    [ [(3, False), (15, False), (0, False), (2, False), (22, False)],
      [(9, False), (18, False), (13, False), (17, False), (5, False)],
      [(19, False), (8, False), (7, False), (25, False), (23, False)],
      [(20, False), (11, False), (10, False), (24, False), (4, False)],
      [(14, False), (21, False), (16, False), (12, False), (6, False)]
    ],
    [ [(14, False), (21, False), (17, False), (24, False), (4, False)],
      [(10, False), (16, False), (15, False), (9, False), (19, False)],
      [(18, False), (8, False), (23, False), (26, False), (20, False)],
      [(22, False), (11, False), (13, False), (6, False), (5, False)],
      [(2, False), (0, False), (12, False), (3, False), (7, False)]
    ]
  ]
