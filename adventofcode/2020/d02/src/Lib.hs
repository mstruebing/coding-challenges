module Lib
    ( someFunc
    -- , isValidPassword
    , parsePassword
    , splitPassword
    , getUpperBound
    , getLowerBound
    , getPwChar
    , getPw
    , Password(..)
    , isValidPassword
    , isValidPassword2
    ) where

import Data.List.Split (splitOn)

data Password = Password { lowerBound :: Int
                         , upperBound::  Int
                         , char :: Char
                         , password :: String
                         } deriving (Show, Eq)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

isValidPassword2 :: String -> Bool
isValidPassword2 input = xor ((p !! upper) == c) ((p !! lower) == c) 
    where 
        upper = (upperBound pw) - 1
        lower = (lowerBound pw) - 1
        c = char pw
        p = password pw 
        pw = parsePassword input

xor :: Bool -> Bool -> Bool
xor a b = a /= b

isValidPassword :: String -> Bool
isValidPassword input = amount <= upper && amount >= lower
    where
        amount = length . filter (== c) $  p
        upper = upperBound pw
        lower = lowerBound pw
        c = char pw
        p = password pw 
        pw = parsePassword input

parsePassword :: String -> Password
parsePassword input = Password lowerBound upperBound char password
    where
        lowerBound = getLowerBound parts
        upperBound = getUpperBound parts
        char = getPwChar parts
        password = getPw parts
        parts = splitPassword input

getPw :: [String] -> String
getPw parts = parts !! 2

getPwChar :: [String] -> Char
getPwChar parts = head $ takeWhile (/= ':') $ parts !! 1

getUpperBound :: [String] -> Int
getUpperBound = read . tail . dropWhile (/= '-') . head

getLowerBound :: [String] -> Int
getLowerBound = read . takeWhile (/= '-') . head

splitPassword :: String -> [String]
splitPassword = splitOn " "
