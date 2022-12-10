import Lib 
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Lib" $ do
    it "" $
      1 `shouldBe` 1
