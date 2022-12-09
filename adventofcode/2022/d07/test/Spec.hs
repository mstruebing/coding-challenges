import Lib
import Test.Hspec

sampleInstructions :: [Instruction]
sampleInstructions =
  [ Command (ChangeDirectory "/"),
    Command List,
    Directory "a",
    File ("b.txt", 14848514),
    File ("c.dat", 8504156),
    Directory "d",
    Command (ChangeDirectory "a"),
    Command List,
    Directory "e",
    File ("f", 29116),
    File ("g", 2557),
    File ("h.lst", 62596),
    Command (ChangeDirectory "e"),
    Command List,
    File ("i", 584),
    Command (ChangeDirectory ".."),
    Command (ChangeDirectory ".."),
    Command (ChangeDirectory "d"),
    Command List,
    File ("j", 4060174),
    File ("d.log", 8033020),
    File ("d.ext", 5626152),
    File ("k", 7214296)
  ]

main :: IO ()
main = hspec $ do
  describe "Lib.parseFile" $ do
    it "1" $
      parseFile "14848514 b.txt" `shouldBe` Just (File ("b.txt", 14848514))
    it "2" $
      parseFile "8504156 c.dat" `shouldBe` Just (File ("c.dat", 8504156))
    it "3" $
      parseFile "dir d" `shouldBe` Nothing
    it "4" $
      parseFile "$ cd a" `shouldBe` Nothing
    it "4" $
      parseFile "$ ls" `shouldBe` Nothing
  describe "Lib.parseDirectory" $ do
    it "1" $
      parseDirectory "14848514 b.txt" `shouldBe` Nothing
    it "2" $
      parseDirectory "8504156 c.dat" `shouldBe` Nothing
    it "3" $
      parseDirectory "dir d" `shouldBe` Just (Directory "d")
    it "4" $
      parseDirectory "$ cd a" `shouldBe` Nothing
    it "4" $
      parseDirectory "$ ls" `shouldBe` Nothing
    it "5" $
      parseDirectory "dir abc" `shouldBe` Just (Directory "abc")
  describe "Lib.parseCommand" $ do
    it "1" $
      parseCommand "14848514 b.txt" `shouldBe` Nothing
    it "2" $
      parseCommand "8504156 c.dat" `shouldBe` Nothing
    it "3" $
      parseCommand "dir d" `shouldBe` Nothing
    it "4" $
      parseCommand "$ cd a" `shouldBe` Just (Command $ ChangeDirectory "a")
    it "4" $
      parseCommand "$ ls" `shouldBe` (Just $ Command List)
  describe "Lib.parse" $ do
    it "1" $
      parse sample `shouldBe` sampleInstructions
  describe "Lib.smallDirectoriesSum" $ do
    it "1" $
      smallDirectoriesSum (constructFileSystem (parse sample)) `shouldBe` 95437
