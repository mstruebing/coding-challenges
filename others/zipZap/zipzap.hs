-- https://www.reddit.com/r/dailyprogrammer/comments/56mfgz/weekly_26_mini_challenges/d8lesvq
-- 

import Data.Char

zipZap :: String -> IO ()
zipZap input = print $ (fst processedInput == snd processedInput)
    where
        processedInput = processInput input

processInput :: String -> (Int, Int)
processInput input = (numberOfWord input "zip", numberOfWord input "zap")

numberOfWord :: String -> String -> Int
numberOfWord input word
    | length droppedInput < 3 || length word < 3 = 0
    | checkForWord droppedInput word = 1 + (numberOfWord (tail droppedInput) word) 
    | otherwise = 0 + (numberOfWord (tail droppedInput) word)
        where
            droppedInput = dropToZ input

checkForWord :: String -> String -> Bool
checkForWord input word = length input > 2 
                        && length word > 2 
                        && head input == head word 
                        && (head $ tail input) == (head $ tail word) 
                        && (head $ tail $ tail input) == (head $ tail $ tail word)

dropToZ :: String -> String
dropToZ input = dropWhile (/= 'z') input

lowerCase :: String -> String
lowerCase input = map toLower input
