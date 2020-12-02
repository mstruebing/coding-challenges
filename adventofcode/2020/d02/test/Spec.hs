import Test.Hspec
import Test.QuickCheck

import Lib

main :: IO ()
main = hspec $ do   
    describe "Lib.splitPassword" $ do
        it "split password correctly" $
            splitPassword "1-3 a: abcde" `shouldBe` ["1-3", "a:", "abcde"]
        it "split password correctly" $
            splitPassword "1-3 b: cdefg" `shouldBe` ["1-3", "b:", "cdefg"]
        it "split password correctly" $
            splitPassword "2-9 c: ccccccccc" `shouldBe` ["2-9", "c:", "ccccccccc"]
    describe "Lib.getUpperBound" $ do
        it "" $
            getUpperBound ["1-3", "a:", "abcde"] `shouldBe` 3 
        it "" $
            getUpperBound ["1-3", "b:", "cdefg"] `shouldBe` 3 
        it "" $
            getUpperBound ["2-9", "c:", "ccccccccc"] `shouldBe` 9
    describe "Lib.getLowerBound" $ do
        it "" $
            getLowerBound ["1-3", "a:", "abcde"] `shouldBe` 1 
        it "" $
            getLowerBound ["1-3", "b:", "cdefg"] `shouldBe` 1 
        it "" $
            getLowerBound ["2-9", "c:", "ccccccccc"] `shouldBe` 2
    describe "Lib.getPwChar" $ do
        it "" $
            getPwChar ["1-3", "a:", "abcde"] `shouldBe` 'a' 
        it "" $
            getPwChar ["1-3", "b:", "cdefg"] `shouldBe` 'b'
        it "" $
            getPwChar ["2-9", "c:", "ccccccccc"] `shouldBe` 'c'
    describe "Lib.getPw" $ do
        it "" $
            getPw ["1-3", "a:", "abcde"] `shouldBe` "abcde"
        it "" $
            getPw ["1-3", "b:", "cdefg"] `shouldBe` "cdefg"
        it "" $
            getPw ["2-9", "c:", "ccccccccc"] `shouldBe` "ccccccccc"
    describe "Lib.parsePassword" $ do
        it "" $
            parsePassword "1-3 a: abcde" `shouldBe` Password 1 3 'a' "abcde"
        it "" $
            parsePassword "1-3 b: cdefg" `shouldBe` Password 1 3 'b' "cdefg"
        it "" $
            parsePassword "2-9 c: ccccccccc" `shouldBe` Password 2 9 'c' "ccccccccc"
    describe "Lib.isValidPassword" $ do
        it "" $
            isValidPassword "1-3 a: abcde" `shouldBe` True
        it "" $
            isValidPassword "1-3 b: cdefg" `shouldBe` False
        it "" $
            isValidPassword "2-9 c: ccccccccc" `shouldBe` True
    describe "Lib.isValidPassword2" $ do
        it "" $
            isValidPassword2 "1-3 a: abcde" `shouldBe` True
        it "" $
            isValidPassword2 "1-3 b: cdefg" `shouldBe` False
        it "" $
            isValidPassword2 "2-9 c: ccccccccc" `shouldBe` False
