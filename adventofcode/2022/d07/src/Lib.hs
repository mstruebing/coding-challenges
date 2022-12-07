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
  )
where

import Data.List (foldl', isInfixOf)
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

smallDirectoriesSum :: [(String, Int)] -> Int
smallDirectoriesSum fs = sum $ map snd $ filter (\(_, size) -> size <= 100000) fs

-- Create Filesystem

constructFileSystem :: [Instruction] -> [(String, Int)]
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
                  (reverse $ dropWhile (/= '/') $ tail $ reverse currentPath, fs)
                "/" -> ("/", fs)
                _ -> (currentPath ++ dir ++ "/", fs)
            _ -> (currentPath, fs)
        )
        ("/", Map.empty)
        (tail instructions)

augmentSubFolderSizes :: Map.Map String Int -> [(String, Int)]
augmentSubFolderSizes fs = map (\(path, size) -> (path, size + (sum $ map (\(_, s) -> s) (matchingPaths path)))) $ Map.assocs fs
  where
    matchingPaths path = filter (\(p, _) -> isInfixOf path p && path /= p) $ Map.assocs fs

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
