module Days.Day01 (runDay, inputParser, partA, partB) where

{- ORMOLU_DISABLE -}
import Data.List

import Data.Map.Strict (Map)
import Control.Applicative ((<|>))
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Vector (Vector)
import qualified Data.Vector as Vec
import qualified Util.Util as U

import qualified Program.RunDay as R (runDay, Day)
import Data.Attoparsec.Text
import Data.Void
{- ORMOLU_ENABLE -}

runDay :: R.Day
runDay = R.runDay inputParser partA partB

------------ PARSER ------------
inputParser :: Parser Input
inputParser = do
  pairs <- many' $ do
    skipSpace
    a <- decimal
    skipSpace
    b <- decimal
    endOfLine <|> endOfInput
    return (a, b)
  let (as, bs) = unzip pairs
  return (as, bs)

------------ TYPES ------------
type Input = ([Int], [Int])

type OutputA = Int

type OutputB = Int

------------ PART A ------------
partA :: Input -> OutputA
partA (as, bs) = foldl (\acc curr -> acc + (abs ((sortedAs !! curr)  - (sortedBs !! curr))) ) 0 [0..length as - 1]
    where
        (sortedAs, sortedBs) = (sort as, sort bs)

------------ PART B ------------
partB :: Input -> OutputB
partB (as, bs) = foldl (\acc curr -> acc + (curr * (length $ filter (\x -> x == curr ) bs))) 0 as

sortLists :: ([Int], [Int]) -> ([Int], [Int])
sortLists (as, bs) = (sort as, sort bs)
