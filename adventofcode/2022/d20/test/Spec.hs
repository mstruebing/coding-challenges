import Lib
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "" $ do
    it "" $
      1 `shouldBe` 1
