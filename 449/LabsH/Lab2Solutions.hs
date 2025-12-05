{-|
  CPSC 449 — Lab 2 Tutorial (Solutions)
-}

-- 1. A function that triples a number
triple :: Int -> Int
triple x = 3 * x

-- 2. A function that checks if a number is zero
isZero :: Int -> Bool
isZero 0 = True
isZero _ = False

-- 3. A function that negates a boolean
notBool :: Bool -> Bool
notBool True  = False
notBool False = True

-- 4. A function that makes a number one bigger
increment :: Int -> Int
increment x = x + 1

-- 5. A function that checks returns 0 if a number is even and 1 if it is odd
evenOrOdd :: Int -> Int
evenOrOdd x = x `mod` 2

-- 6. A function that gives the Roman numeral of a number from 1-9
romanDigit :: Char -> String
romanDigit '1' = "I"
romanDigit '2' = "II"
romanDigit '3' = "III"
romanDigit '4' = "IV"
romanDigit '5' = "V"
romanDigit '6' = "VI"
romanDigit '7' = "VII"
romanDigit '8' = "VIII"
romanDigit '9' = "IX"

-- 7. A function that returns True if a character is a vowel and False otherwise
isVowel :: Char -> Bool
isVowel 'a' = True
isVowel 'e' = True
isVowel 'i' = True
isVowel 'o' = True    
isVowel 'u' = True
isVowel 'A' = True
isVowel 'E' = True
isVowel 'I' = True
isVowel 'O' = True
isVowel 'U' = True
isVowel _   = False

-- 8. A function that gives the binary representation of numbers 0–9
toBinary :: Int -> String
toBinary 0 = "0"
toBinary 1 = "1"
toBinary 2 = "10"
toBinary 3 = "11"
toBinary 4 = "100"
toBinary 5 = "101"
toBinary 6 = "110"
toBinary 7 = "111"
toBinary 8 = "1000"
toBinary 9 = "1001"

-- 9. A function that checks if a number between 0 and 100 is a complete square
isSquare :: Int -> Bool
isSquare 0 = True
isSquare 1 = True
isSquare 4 = True
isSquare 9 = True
isSquare 16 = True
isSquare 25 = True
isSquare 36 = True
isSquare 49 = True
isSquare 64 = True
isSquare 81 = True
isSquare 100 = True
isSquare _ = False