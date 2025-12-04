{-
Nathania Castillo
UCID:30152619
Dr. Nasri
Nov 17, 2025 (took remaining late days)

Assignment 3:
-}

module A3 where

-- defining the types for thw function that 
processNestedList :: [[Int]] -> [Int]
processNestedList xs = concatMap(\n -> map (n*n)(filter(n `mod` 2 == 0))) xs


