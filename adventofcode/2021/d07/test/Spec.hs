import Lib
import Test.Hspec
import Test.QuickCheck

input :: [Int]
input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

main :: IO ()
main = hspec $ do
  describe "Part 1" $ do
    it "run" $
      (minimum $ Lib.func input) `shouldBe` 37
