-- https://www.reddit.com/r/dailyprogrammer/comments/56mfgz/weekly_26_mini_challenges/d8lesvq
-- starStruck, read a string and return the amount of '*' which are followed or
-- predicate of another '*'

countStars :: String -> Int
countStars input = sum [1 | x <- [0 .. length input - 1], checkChar input x]

checkChar :: String -> Int -> Bool
checkChar input x
    | x == 0 = input !! x == '*' && input !! (x + 1) == '*'
    | x == length input - 1 = input !! x == '*' && input !! (x - 1) == '*'
    | otherwise = input !! x == '*' && 
        (input !! (x + 1) == '*' || input !! (x - 1) == '*')
