import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "DayXX" $ do
    it "Shoud run the test" $
      1 + 2 `shouldBe` 3
