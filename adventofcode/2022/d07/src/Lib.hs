module Lib
  ( someFunc,
    parseFile,
    parseDirectory,
    parseCommand,
    parse,
    Command (..),
    Instruction (..),
    constructFileSystem,
    smallDirectoriesSum,
    sample,
    directoryToBeDeleted,
  )
where

import Data.List (foldl')
import qualified Data.Map as Map
import Data.Maybe (catMaybes, fromJust, isJust)
import Text.Read (readMaybe)

data Instruction
  = Command !Command
  | File !(String, Int)
  | Directory !String
  deriving (Show, Eq)

data Command
  = List
  | ChangeDirectory !String
  deriving (Show, Eq)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

fsSize :: Int
fsSize = 70000000

neededSize :: Int
neededSize = 30000000

smallDirectoriesSum :: Map.Map [String] Int -> Int
smallDirectoriesSum fs = sum $ map snd $ filter (\(_, size) -> size <= 100000) (Map.assocs fs)

directoryToBeDeleted :: Map.Map [String] Int -> Int
directoryToBeDeleted fs = minimum $ filter (> neededSpace) $ map snd $ Map.assocs fs
  where
    neededSpace = neededSize - (fsSize - usedSpace)
    usedSpace = Map.findWithDefault 0 ["/"] fs

-- Create Filesystem

constructFileSystem :: [Instruction] -> Map.Map [String] Int
constructFileSystem instructions =
  augmentSubFolderSizes $
    snd $
      foldl'
        ( \(currentPath, fs) instruction -> case instruction of
            File (_, size) ->
              (currentPath, Map.insert currentPath (Map.findWithDefault 0 currentPath fs + size) fs)
            Command (ChangeDirectory dir) ->
              case dir of
                ".." ->
                  (init currentPath, fs)
                "/" -> (["/"], fs)
                _ -> (currentPath ++ [dir], fs)
            _ -> (currentPath, fs)
        )
        (["/"], Map.singleton ["/"] 0)
        (tail instructions)

augmentSubFolderSizes :: Map.Map [String] Int -> Map.Map [String] Int
augmentSubFolderSizes fs = foldr (\(path, size) fss -> Map.union (foldl' (\acc index -> Map.insert (remove index path) (currentSize (remove index path) fss + size) acc) fss [1 .. length path - 1]) fss) fs $ Map.assocs fs
  where
    currentSize path fss = Map.findWithDefault 0 path fss
    remove i p = reverse $ drop i $ reverse p

-- Parsing

parse :: [String] -> [Instruction]
parse = map (\instruction -> head $ catMaybes [parseFile instruction, parseDirectory instruction, parseCommand instruction])

parseFile :: String -> Maybe Instruction
parseFile input =
  if isJust size
    then Just $ File (getAfterSpace input, fromJust size)
    else Nothing
  where
    size = readMaybe (getUntilSpace input) :: Maybe Int

parseDirectory :: String -> Maybe Instruction
parseDirectory input =
  if isDirectory input
    then Just $ Directory $ getAfterSpace input
    else Nothing

parseCommand :: String -> Maybe Instruction
parseCommand input
  | isList = Just $ Command List
  | isChangeDirectory = Just $ Command (ChangeDirectory (getAfterSpace (getAfterSpace input)))
  | otherwise = Nothing
  where
    isList = isCommand input && "ls" == getAfterSpace input
    isChangeDirectory = isCommand input && "cd" == getUntilSpace (getAfterSpace input)

isDirectory :: String -> Bool
isDirectory input = "dir" == getUntilSpace input

isCommand :: String -> Bool
isCommand input = "$" == getUntilSpace input

getUntilSpace :: String -> String
getUntilSpace = takeWhile (/= ' ')

getAfterSpace :: String -> String
getAfterSpace = tail . dropWhile (/= ' ')

sample :: [String]
sample =
  [ "$ cd /",
    "$ ls",
    "dir a",
    "14848514 b.txt",
    "8504156 c.dat",
    "dir d",
    "$ cd a",
    "$ ls",
    "dir e",
    "29116 f",
    "2557 g",
    "62596 h.lst",
    "$ cd e",
    "$ ls",
    "584 i",
    "$ cd ..",
    "$ cd ..",
    "$ cd d",
    "$ ls",
    "4060174 j",
    "8033020 d.log",
    "5626152 d.ext",
    "7214296 k"
  ]
