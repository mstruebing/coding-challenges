import           Data.List

main :: IO ()
main = readFile ("input.txt") >>= print . howManyAreValid . lines


howManyAreValid :: [String] -> Int 
howManyAreValid linesOfFile =
    foldr (\line acc -> if isUnique $ words line then acc + 1 else acc) 0 linesOfFile


isUnique :: [String] -> Bool 
isUnique line = line == makeUnique line

makeUnique :: [String] -> [String]
makeUnique = reverse . nub . reverse
