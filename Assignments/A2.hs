{-
Nathania Castillo
UCID:30152619
Dr. Nasri
October 19, 2025 (took 4 late days)

Assignment 2:
-}

module A2 where

--Prob 1
--defining the types that will be for the input and the type of the expected output
iteratedCartesianProduct :: [a] -> Int -> [[a]]
iteratedCartesianProduct l n =                                                                  --creating base case and the recursive function  
  if n == 1 then [[x] | x <- l]                                                                 --This is the base case where length {l} is 1 and would take this list [1,2] and produce [[1],[2]]    
  else [ x:ys | x <- l, ys <- iteratedCartesianProduct l (n-1) ]                                --Builds the full cartesian product by combining each item in the list l with all the possible combinations of the remaining n-1 elements

--Prob2
--defining the types integer for input and output
--important to note that: two sums are considered identical, when they have the same summands
numSums :: Int-> Int 
numSums n = length [x | x <- iteratedCartesianProduct [0 .. n] n, sum x == n, ascending x]      -- using prob 1 to get all ordered lists of ints between 0 to n, if any sum sums up to n, it will be considered one of the num sums

--Helper function to determine the an ascending list with the use of booleans
--defining the type Int for input and Bool for output
ascending :: [Int] -> Bool 
ascending [] = False                                                                            --the empty list equal false
ascending (x:xs)                                                                                --split the list into its first element x and leave the rest in xs    
    | null xs = True                                                                            --the case where the list is only one number, leaving xs to be empty will automatically be true                
    | x <= head xs = ascending xs                                                               --if the first element x is less than or equal to the next element (the head of xs) then everything is in order and continue checking the rest of the list recursively
    | otherwise = False                                                                         --any other case is automatically false 

--Prob 3
--defining ballsIntoBins types for output and input to be Int
ballsIntoBins :: Int -> Int -> Int
ballsIntoBins k n = length [x | x <-iteratedCartesianProduct[1..n] n, sum x == k ]              --checking if the sum of a list equals k, we can confirm it represents a valid way to distribute k balls into bins (each starting with 1 ball) as long as the list meets the validity conditions.              


--Prob 4a 
--defining hasConsecElem types for input to be an Int and output to be a Bool
--checking if the list has to consecutive numbers
hasConsecElem :: Int -> Bool    
hasConsecElem n = consecWrapAround (x ++ [head x])                                              --copys the first element to the end of the list to check for the case of the head and tail being consecutive since the list wraps around

--helper function 
consecElemRec :: [Int] -> Bool
consecElemRec [_] = False                                                                       --base case of only one element automatically is false
consecElemRec [] = False                                                                        --base case of an empty list automatically false
consecElemRec (x:xs)                                                                            --recursively runs through the list to check if two consecutive numbers that are +-1 of eachother
    | abs (x - y) == 1 = True                                                                   -- found consecutive pair 
    | otherwise = consecElemRec xs                                                              --recursively checks the list until it either finds a consecutive pair or runs into one of the base cases

--Prob 4b
--defining twoRunlessArrs types for input to be an Int and output to be a Bool
twoRunLessArrs :: Int -> Int
--generates all ordered lists of Ints from 1 to n using the Cartesian product, keeps only those starting with 1 to remove any list with duplicates in them and then uses hasConsecElem to discard lists containing i-runs
twoRunLessArrs n = length [x | x <- iteratedCartesianProduct [1 .. n] n, head x == 1, allDistinct x, not (hasConsecElem x)]                                         

-- Helper function to recursively check all values are distinct
-- 'Eq a =>' list elements must be comparable
allDiff :: Eq a => [a] -> Bool                                                                 
allDiff [] = True                                                                              -- an empty list has no duplicates meaning it is distinct                                            
allDiff [_] = True                                                                             -- a single element list will be distinct since it has nothinng to compare to
allDiff (x:xs)                                                                                 --recursiive case a list with head x and tail xs 
    | x `elem` xs = False                                                                      --if 'x' is found anywhere in the rest of the list, it is not distinct and therefore false
    | otherwise = allDistinct xs                                                               -- continue checking list recursively 

--Prob 4c
--defining hasConsecSub1 for a list of Ints for input and an output of Ints a True or False statement
hasConsecSubl :: [Int] -> Int -> Bool
hasConsecSubl l i = consecSublRec (l ++ take (i-1) l) i                                        --checks if the given list 'l' contains any i-run (sequence of i consecutive numbers)

-- Helper function 
consecSublRec :: [Int] -> Int -> Bool
consecSublRec [] _ = False                                                                     -- an empty list has no consecutive sequence possible
consecSublRec [_] _ = False                                                                    --cannot form a sequence with a single element
consecSublRec l i                                                                              --recursively looks through the list and checks for i-runs                                                                           
    | length l < i = False
    | linear (take i l) 1 = True
    | linear (take i l) (-1) = True
    | otherwise = consecSublRec (tail l) i

-- Helper function 
linear :: (Num a, Eq a) => [a] -> a -> Bool
linear [] _ = True                                                                          --empty list is trivially linear
linear [_] _ = True                                                                         --single element is also linear (no difference to compare)
linear (x:xs) y                                                                             --checks if a list is linear and is made up of adding the offset a mus support 
    | x + y == head xs = linear xs y                                                        -- If current element + offset equals the next element, keep checking the rest
    | otherwise = False                                                                     --Otherwise, the pattern is broken → not linear

--Prob 4d
iRunLessArrs :: Int -> Int -> Int
--x is one seating arran

 --counts how many circular seating arrangements of n people don’t contain any i-runs by generating all possible lists, keeping only distinct ones starting with 1, and filtering out those that include i-runs.
iRunLessArrs n i = length [x | x <- iteratedCartesianProduct [1 .. n] n, head x == 1, allDistinct x, not (hasConsecSubl x i)]  