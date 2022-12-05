import Lib

main :: IO ()
main = do
  print "sample: "
  sample
  print "part1: "
  part1

-- print "part2: "
-- part2

sample :: IO ()
sample = print . Lib.first . parse . lines =<< readFile "small.txt"

part1 :: IO ()
part1 = print . Lib.first . parse . lines =<< readFile "input.txt"

-- part2 :: IO ()
-- part2 = print . Lib.second . parse . lines =<< readFile "input.txt"
