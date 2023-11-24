module Days.Day01Spec (spec) where

import Day01
import Test.Hspec
import Prelude hiding (Left, Right)

spec :: Spec
spec = do
  describe "Day01" $ do
    describe "parseInstruction" $ do
      it "Shoud parse a single instruction Left, single digit" $
        (parseInstruction "L3") `shouldBe` (Instruction Left 3)
      it "Shoud parse a single instruction Right, single digit" $
        (parseInstruction "R5") `shouldBe` (Instruction Right 5)
      it "Shoud parse a single instruction Right, multiple digit" $
        (parseInstruction "R13") `shouldBe` (Instruction Right 13)
      it "Shoud parse a single instruction Left, multiple digit" $
        (parseInstruction "L33") `shouldBe` (Instruction Left 33)
    describe "parseInstructions" $ do
      it "Shoud parse a set of instructions" $
        (parseInstructions "R5, L5, R5, R3") `shouldBe` [Instruction Right 5, Instruction Left 5, Instruction Right 5, Instruction Right 3]
    describe "run" $ do
      it "Should produce the correct state first" $
        (run $ parseInstructions "R2, L3") `shouldBe` ((2, 3), North)
      it "Should produce the correct state second" $
        (run $ parseInstructions "R2, R2, R2") `shouldBe` ((0, -2), West)
      it "Should produce the correct state third" $
        (run $ parseInstructions "R5, L5, R5, R3") `shouldBe` ((10, 2), South)
    describe "part1" $ do
      it "Should produce the correct distance first" $
        (part1 "R2, L3") `shouldBe` "5"
      it "Should produce the correct distance second" $
        (part1 "R2, R2, R2") `shouldBe` "2"
      it "Should produce the correct distance third" $
        (part1 "R5, L5, R5, R3") `shouldBe` "12"
