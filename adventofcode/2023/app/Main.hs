module Main (main, solutions) where

import Control.Monad ()
import Data.Foldable ()
import qualified Data.Map as Map
import qualified DayXX (solve)
import System.Environment
import System.Exit ()

solutions :: Map.Map String (String -> IO ())
solutions =
  Map.fromList
    [ ("xx", DayXX.solve)
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
