{-
Nathania Castillo
UCID:30152619
Dr. Nasri
Sept 29, 2025 (1 late day)

Assignment 1:
-}}

module A1 where

    
--determines if the quadratic expression is a perfect square Trinomial
--defining the types that will be for the input and the type of the expected output
isPerfectSquareTrinomial :: (Int, Int, Int) -> Bool
isPerfectSquareTrinomial (a, b, c)   --Created a guard for my if statements. If the perfect square trinomial discriminant is equal to zero then the equation is a perfect square trinomial
    | (b*b) - 4*a*c == 0 = True
    | otherwise = False             --- Every other statement will be false 

--determines if the number is a complete square
--defining that the input will be an integer and the output will be a true or false
isCompleteSquare :: Integer -> Bool 
isCompleteSquare n 
    | (round(sqrt(fromIntegral n)))^2 == n = True    --changed the the Integer into a float. Rounded the number and then multiplied it by itself to check that it is equal to the original number
    | otherwise = False                              --Every other statement will be false

--determine if sequence A and sequence B are identical 
--defining that the input will be two strings and return a boolean
isIdenticalSequence :: String -> String -> Bool
isIdenticalSequence [] [] = True                    -- base case if both string are empty the answer would still be true
isIdenticalSequence _  [] = False                   -- base case for when one string is empty and the other isn't then the answer would be false
isIdenticalSequence [] _ = False
isIdenticalSequence (n: a) (x: b)                   -- using patern recignition to compare the same letter from both sewuencvesx
    | n == x = isIdenticalSequence a b              -- if both letters are equal then keep on going recursively until there is an empty string
    | otherwise = False 

--determine if word a is an anagram of word b 
--created a helper function that grabs each letter in word a and makes sure that the letter is in word b
-- defining the input to be two strings and it will return a boolean
sameCharSearch :: String -> String -> Bool
sameCharSearch [] [] = True                     -- base case if both string are empty the answer would still be true
sameCharSearch _  [] = False                    -- base case for when one string is empty and the other isn't then the answer would be false
sameCharSearch [] _  = False
sameCharSearch (n: a) (b) = n `elem` b          -- grabs the first element of word a and searches through word b
sameCharSearch a b 
    | sameCharSearch a b == True = sameCharSearch a b  --keeps on recursively checking until word a is empty
    | otherwise = False

--defining the input to be two strings and will return a boolean
isAnagram :: String -> String -> Bool      
isAnagram a b                                    -- creating guards as an if statement
    | length a /= length b = False               -- if the lengths are not the same, it is automatically false
    | sameCharSearch a b == True = True          -- if the helperfunction is true, then the statement is true
    | otherwise = False                          -- any other case would be false