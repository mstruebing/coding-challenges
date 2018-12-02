import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import Lib

main :: IO ()
main = hspec $ do 
    describe "Lib.lettersOccurNTimes" $ do
        it "abcdef doesn't conain any char three times" $
            lettersOccurNTimes 3 "abcdef" `shouldBe` False
        it "bababc contains a char three times" $
            lettersOccurNTimes 3 "bababc" `shouldBe` True
        it "abbcde doesn't conains a char three times" $
            lettersOccurNTimes 3 "abbcde" `shouldBe` False
        it "abcccd conains a char three times" $
            lettersOccurNTimes 3 "abcccd" `shouldBe` True
        it "aabcdd doesn't contain a char three times" $
            lettersOccurNTimes 3 "aabcdd" `shouldBe` False
        it "abcdee doesn't conains a char three times" $
            lettersOccurNTimes 3 "abcdee" `shouldBe` False
        it "ababab conains a char three times" $
            lettersOccurNTimes 3 "ababab" `shouldBe` True
        it "abcdef doesn't conain any char two times" $
            lettersOccurNTimes 2 "abcdef" `shouldBe` False
        it "bababc conains a char two times" $
            lettersOccurNTimes 2 "bababc" `shouldBe` True
        it "abbcde conains a char two times" $
            lettersOccurNTimes 2 "abbcde" `shouldBe` True
        it "abcccd doesn't conain any char two times" $
            lettersOccurNTimes 2 "abcccd" `shouldBe` False
        it "aabcdd conains a char two times" $
            lettersOccurNTimes 2 "aabcdd" `shouldBe` True
        it "abcdee conains a char two times" $
            lettersOccurNTimes 2 "abcdee" `shouldBe` True
        it "ababab doens't conain any char two times" $
            lettersOccurNTimes 2 "ababab" `shouldBe` False

    describe "Lib.getMultiplesOfBoxIdsHelper" $ do
        it "" $
            getMultiplesOfBoxIdsHelper "aa" (0, 0) `shouldBe` (1, 0)
        it "" $
            getMultiplesOfBoxIdsHelper "aa" (1, 0) `shouldBe` (2, 0)
        it "" $
            getMultiplesOfBoxIdsHelper "aaa" (0, 0) `shouldBe` (0, 1)
        it "" $
            getMultiplesOfBoxIdsHelper "aaa" (0, 1) `shouldBe` (0, 2)
        it "" $
            getMultiplesOfBoxIdsHelper "aaaaaa" (0, 1) `shouldBe` (0, 1)
        it "" $
            getMultiplesOfBoxIdsHelper "aaabb" (0, 1) `shouldBe` (1, 2)

    describe "Lib.getMultiplesOfBoxIds" $ do
        it "" $
            getMultiplesOfBoxIds ["aabbb", "bbbaa"] `shouldBe` (2, 2)
        it "" $
            getMultiplesOfBoxIds ["aaabbb", "bbbaaa"] `shouldBe` (0, 2)
        it "" $
            getMultiplesOfBoxIds ["abc", "def"] `shouldBe` (0, 0)

    describe "Lib.differByOnlyOneChar" $ do
        it "" $
            differByOnlyOneChar "abc" "abc" `shouldBe` False
        it "" $
            differByOnlyOneChar "abc" "abd" `shouldBe` True
        it "" $
            differByOnlyOneChar "bbc" "abd" `shouldBe` False
        it "" $
            differByOnlyOneChar "abcde" "axcye" `shouldBe` False
        it "" $
            differByOnlyOneChar "fghij" "fguij" `shouldBe` True

    describe "Lib.getCommonChars" $ do
        it "" $
            getCommonChars "abc" "abc" "" `shouldBe` "abc"
        it "" $
            getCommonChars "abcd" "abc" "" `shouldBe` "abc"
        it "" $
            getCommonChars "dbcd" "abc" "" `shouldBe` "bc"
