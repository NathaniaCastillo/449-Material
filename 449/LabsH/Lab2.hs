{-|
    CPSC 449 - Lab 2 Tutorial
    ----------------------------------------------
    Goal:
    Practice writing very simple functions.
    Nothing here goes beyond numbers, booleans, and very simple single-input functions.
    Do not use guards or if-expressions in your solutions.
-}

-- 1. A function that triples a number
triple :: Int -> Int
triple n = n * 3

-- 2. A function that checks if a number is zero
check :: Int -> Bool 
check 0 = True
check _ = False

-- 3. A function that negates a boolean
negation :: Bool -> Bool
negation True = False
negation False = True

-- 4. A function that makes a number one bigger
plusone :: Int -> Int
plusone n = n + 1

-- 5. A function that checks returns 0 if a number is even and 1 if it is odd
enum :: Int -> Int
enum n = n `mod` 2

-- 6. A function that gives the Roman numeral of a number from 1-9
roman :: Int -> String
roman 1 = "I"
roman 2 = "II"
roman 3 = "III"
roman 4 = "IV"
roman 5 = "V"
roman 6 = "VI"
roman 7 = "VII"
roman 8 = "VIII"
roman 9 = "IX"
roman 10 = "X"
-- 7. A function that returns True if a character is a vowel and False otherwise
vowel :: Char -> Bool
vowel 'a' = True
vowel 'A' = True
vowel 'e' = True
vowel 'E' = True
vowel 'i' = True
vowel 'I' = True
vowel 'u' = True
vowel 'U' = True
vowel 'o' = True
vowel 'O' = True
vowel _ = False


-- 8. A function that gives the binary representation of numbers 0–9
binary :: Int -> Int
binary 1 = 1
binary 2 = 10
binary 3 = 11
binary 4 = 100
binary 5 = 101
binary 6 = 110
binary 7 = 111
binary 8 = 1000
binary 9 = 1001



-- 9. A function that checks if a number between 0 and 100 is a complete square
completeSquare :: Int -> Bool
completeSquare 4 = True
completeSquare 1 = True
completeSquare 9 = True
completeSquare 16 = True
completeSquare 25 = True
completeSquare 36 = True
completeSquare 49 = True
completeSquare 64 = True
completeSquare 81 = True
completeSquare 100 = True
completeSquare _ = False