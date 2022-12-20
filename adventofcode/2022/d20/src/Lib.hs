{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Lib
  ( func,
    move,
    run,
    findIndex,
    solveFirst,
    third3,
    first3,
  )
where

import Control.Monad.State
import Data.Foldable (foldl')
import Data.List (elemIndex, findIndex, sortOn)
import Data.Maybe (fromJust)

func :: Int
func = 1

-- (Number, Moved, OriginalIndex)
-- (Number, Moved)
type MyState = [(Int, Bool, Int)]

solveFirst :: MyState -> Int
solveFirst s = first3 (s !! firstIndex) + first3 (s !! secondIndex) + first3 (s !! thirdIndex)
  where
    zeroIndex = fromJust $ findIndex (\(x, _, _) -> x == 0) s
    firstIndex = mod (zeroIndex + 1000) (length s)
    secondIndex = mod (zeroIndex + 2000) (length s)
    thirdIndex = mod (zeroIndex + 3000) (length s)

run :: [Int] -> MyState
run list = foldl' (\acc _curr -> execState move acc) (zip3 list (repeat False) [0 ..]) [1 .. length list]

-- new index
move :: State MyState ()
move = do
  file <- get
  let lowest_not_moved_item = head $ sortOn third3 $ filter (not . second3) file
  let index = fromJust $ elemIndex lowest_not_moved_item file

  let targetItem = file !! index
  let targetIndex = index + first3 targetItem

  let (first, second) = splitAt index file
  let new = first ++ tail second

  if targetIndex > 0
    then do
      let actualIndex = mod targetIndex (length file - 1)
      let (newFirst, newSecond) = splitAt actualIndex new
      put (newFirst ++ [(first3 targetItem, True, third3 targetItem)] ++ newSecond)
    else do
      let actualIndex = (length file - 1) + targetIndex
      let (newFirst, newSecond) = splitAt actualIndex new
      put (newFirst ++ [(first3 targetItem, True, third3 targetItem)] ++ newSecond)
  return ()

first3 :: (a, b, c) -> a
first3 (a, _, _) = a

second3 :: (a, b, c) -> b
second3 (_, b, _) = b

third3 :: (a, b, c) -> c
third3 (_, _, c) = c
