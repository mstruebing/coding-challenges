module Lib
    ( move 
    , run_first
    , run_second
    , distance
    , getSmaller
    , myIntersect
    , Direction(..)
    , Movement(..)
    , Point(..)
    ) where

import Data.List (intersect, elemIndex)
import Data.Maybe (fromJust)

data Direction = Right | Left | Up | Down 
    deriving (Show)

data Movement = Movement Direction Int 
    deriving (Show)

type Point = (Int, Int)

run_first :: [[Movement]] -> Int
run_first movements = distance (0, 0) . 
    foldr (\curr acc -> 
        if acc == (0, 0) 
           then curr 
           else if curr == (0, 0) 
           then acc 
           else getSmaller curr acc) (0,0) . 
        myIntersect $ 
            map movePoints movements

-- run_second :: [[Movement]] -> Int
run_second movements = do 
    let visited_points = map movePoints movements
    let visited_points_one = visited_points !! 0
    let visited_points_two = visited_points !! 1
    let intersection_points = filter (/= (0,0)) . myIntersect $ visited_points
    let stuff = map (\point -> (elemIndex point visited_points_one, elemIndex point visited_points_two)) intersection_points
    minimum $ calcRunTime stuff

calcRunTime :: [(Maybe Int, Maybe Int)] -> [Int]
calcRunTime xs = [fromJust x + fromJust y | (x, y) <- xs ]

movePoints :: [Movement] -> [Point]
movePoints movements = foldl (\acc movement -> 
    if length acc == 1 
       then move (last acc) movement else 
       acc ++ move (last acc) movement) [(0, 0)] movements

move :: Point -> Movement -> [Point]
move (sx, sy) (Movement Lib.Up up) = [(sx, y) | y <- [sy .. sy + up]]
move (sx, sy) (Movement Lib.Right right) = [(x, sy) | x <- [sx .. sx + right]]
move (sx, sy) (Movement Lib.Down down) = reverse [(sx, y) | y <- [sy - down .. sy]]
move (sx, sy) (Movement Lib.Left left) = reverse [(x, sy) | x <- [sx - left .. sx]]

getSmaller :: Point -> Point -> Point
getSmaller (x1, y1) (x2, y2) = if abs x1 + abs y1 < abs x2 + abs y2 then (x1, y1) else (x2, y2)

distance :: Point -> Point -> Int
distance (x1, y1) (x2,y2) = abs (x1 - x2) + abs (y1 - y2)

myIntersect :: [[Point]] -> [Point]
myIntersect (x:y:[]) = intersect x y
