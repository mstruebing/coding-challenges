module Main (main, solutions) where

import Control.Monad ()
import Data.Foldable ()
import qualified Data.Map as Map
import qualified DayXX (solve)
import qualified Day01 (solve)
import qualified Day02 (solve)
import qualified Day04 (solve)
import qualified Day05 (solve)
import qualified Day06 (solve)
import qualified Day08 (solve)
import qualified Day15 (solve)
import System.Environment
import System.Exit ()

solutions :: Map.Map String (String -> IO ())
solutions =
  Map.fromList
    [ ("xx", DayXX.solve)
    , ("01", Day01.solve)
    , ("02", Day02.solve)
    , ("04", Day04.solve)
    , ("05", Day05.solve)
    , ("06", Day06.solve)
    , ("08", Day08.solve)
    , ("15", Day15.solve)
    ]

solveSingle :: String -> IO ()
solveSingle s = case Map.lookup s solutions of
  Just f -> readFile (concat ["./data/day", s, ".txt"]) >>= f
  Nothing -> putStrLn $ "Day not implemented: " ++ s

solveProblems :: [String] -> IO ()
solveProblems = mapM_ solveSingle

main :: IO ()
main = do
  args <- getArgs
  if null args
    then solveProblems $ Map.keys solutions
    else solveProblems args
