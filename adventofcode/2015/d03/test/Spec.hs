import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "countOccurences" $ do
    it "(  (()) shouldBe 2" $
      Lib.countOccurences '(' "(())" `shouldBe` 2
