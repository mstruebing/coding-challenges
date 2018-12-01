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

    describe "Lib.giveFirstDuplicateFrequency" $ do
        it "+1, -1 first reaches 0 twice" $
            giveFirstDuplicateFrequency [1, -1] `shouldBe` 0
        it "+1, -2, +3, +1 first reaches 2 twice" $
            giveFirstDuplicateFrequency [1, -2, 3, 1, 1, -2] `shouldBe` 2
        it "+3, +3, +4, -2, -4 first reaches 10 twice" $
            giveFirstDuplicateFrequency [3, 3, 4, -2, -4] `shouldBe` 10
        it "-6, +3, +8, +5, -6 first reaches 5 twice" $
            giveFirstDuplicateFrequency [-6, 3, 8, 5, -6] `shouldBe` 5
        it "+7, +7, -2, -7, -4 first reaches 14 twice" $
            giveFirstDuplicateFrequency [7, 7, -2, -7, -4] `shouldBe` 14
