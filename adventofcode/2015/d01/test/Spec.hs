import Lib
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "countOccurences" $ do
    it "(  (()) shouldBe 2" $
      Lib.countOccurences '(' "(())" `shouldBe` 2
    it ")  (()) shouldBe 2" $
      Lib.countOccurences ')' "(())" `shouldBe` 2
    it "( ()() shouldBe 2" $
      Lib.countOccurences '(' "()()" `shouldBe` 2
    it ") ()() shouldBe 2" $
      Lib.countOccurences ')' "()()" `shouldBe` 2
  describe "run" $ do
    it "(())" $
      Lib.run "(())" `shouldBe` 0
    it "()()" $
      Lib.run "()()" `shouldBe` 0
    it "(((" $
      Lib.run "(((" `shouldBe` 3
    it "(()(()(" $
      Lib.run "(()(()(" `shouldBe` 3
    it "))(((((" $
      Lib.run "))(((((" `shouldBe` 3
    it "())" $
      Lib.run "())" `shouldBe` -1
    it "))(" $
      Lib.run "))(" `shouldBe` -1
    it ")))" $
      Lib.run ")))" `shouldBe` -3
    it ")())())" $
      Lib.run ")())())" `shouldBe` -3
