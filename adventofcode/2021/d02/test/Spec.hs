import Lib
import Test.Hspec
import Test.QuickCheck

input :: [String]
input =
  [ "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2"
  ]

main :: IO ()
main = hspec $ do
  describe "Part 1" $ do
    it "Parses single instruction" $
      Lib.parse "forward 5" `shouldBe` (Forward, 5)
    it "Parses single instruction 2" $
      Lib.parse "down 5" `shouldBe` (Down, 5)
    it "Parses single instruction 3" $
      Lib.parse "forward 8" `shouldBe` (Forward, 8)
    it "Parses single instruction 4" $
      Lib.parse "up 3" `shouldBe` (Up, 3)
    it "Parses single instruction 4" $
      Lib.parse "down 8" `shouldBe` (Down, 8)
    it "Parses single instruction 5" $
      Lib.parse "forward 2" `shouldBe` (Forward, 2)
    it "Should calc correct Postion" $
      Lib.calc (0, 0) (map Lib.parse input) `shouldBe` (15, 10)
