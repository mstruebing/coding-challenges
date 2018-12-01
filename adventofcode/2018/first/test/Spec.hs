import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import Lib

main :: IO ()
main = hspec $ do 
    describe "Lib.removeEmptyLines" $ do
        it "should return an empty list for one empty line" $
            removeEmptyLines [""] `shouldBe` []
        it "should return an empty list for more empty lines" $
            removeEmptyLines ["", "", ""] `shouldBe` []
        it "should return the same list if no empty line is in there" $
            removeEmptyLines ["1"] `shouldBe` ["1"]
        it "should return the same list if no empty line is in there" $
            removeEmptyLines ["1", "2"] `shouldBe` ["1", "2"]
        it "should return only non empty lines" $
            removeEmptyLines ["1", "",  "2", "", "3"] `shouldBe` ["1", "2", "3"]

    describe "Lib.removePlus" $ do
        it "should return the same string if string is empty" $
            removePlus "" `shouldBe` ""
        it "should return the same string if string doesn't conain '+''" $
            removePlus "1" `shouldBe` "1"
        it "should return the same string if string doesn't conain '+''" $
            removePlus "a" `shouldBe` "a"
        it "should return the same string if string doesn't conain '+''" $
            removePlus "9" `shouldBe` "9"
        it "should return the string without '+' if string contains '+'" $
            removePlus "+1" `shouldBe` "1"
        it "should return the string without '+' if string contains '+'" $
            removePlus "+a" `shouldBe` "a"
        it "should return the string without '+' if string contains '+'" $
            removePlus "+9" `shouldBe` "9"
        it "should return the same string if string contains no '+' but '-'" $
            removePlus "-9" `shouldBe` "-9"

    describe "Lib.convertStringListToIntList" $ do
        it "should convert [Int] to [String]" $
            convertStringListToIntList ["1"] `shouldBe` [1]
        it "should return empty list for empty list" $
            convertStringListToIntList [] `shouldBe` []
        it "should convert [Int] to [String]" $
            convertStringListToIntList ["1", "2", "-3"] `shouldBe` [1, 2, -3]
