{-|
  Examples showing that a function's return value can be a lambda (anonymous function).
  Function as first-class citizens: they can be returned from other functions.
  Functions can be parameter of other functions and can be returned as results.
-}

-- 1) Returns a lambda that adds the captured value.
makeAdder :: Int -> (Int -> Int)
makeAdder x = \ y -> x + y 


  --use lambda functions to input and define a function and what it needs to do (kinda like higher order functions)
-- Example:
-- > let add3 = makeAdder 3
-- > add3 7
-- 10

-- 2) Take an Integer and return its multiplier function
makeMultiplier :: Int -> (Int -> Int)
makeMultiplier x  = \y-> x * y 
-- Example:
-- > (makeMultiplier 4) 5
-- 20

-- 3) Return a function that uses two arguments (shows nested lambdas)
makePairAdder :: Int -> (Int -> Int -> Int)
makePairAdder a = \b c -> a + b + c
--makePairAdder a = \b -> (\c -> a + b + c)


--makePairAdder x = (\z -> (\y -> x + y) + z) --no because we are adding a function
-- Example:
-- > let f = makePairAdder 1
-- > f 2 3
-- 6

-- 4) Function factory: builds a predicate (returns a lambda)
greaterThan :: Ord a => a -> (a -> Bool)
greaterThan threshold = \x -> x > threshold


-- Example:
-- > let gt10 = greaterThan 10
-- > filter gt10 [5,12,15,8]
-- [12,15]


-- 5) Key extractor comparator factory: returns an Ordering function
makeCompareBy :: Ord b => (a -> b) -> (a -> a -> Ordering)
makeCompareBy key = \x y -> compare (key x) (key y)
-- Example:
-- > let cmp = makeCompareBy length
-- > cmp "hi" "there"
-- LT

-- 6) Returning a function that operates on a given input (partial application via return)
buildFormatter :: String -> (String -> String)
buildFormatter = undefined
-- Example:
-- > let fmt = buildFormatter "INFO"
-- > fmt "started"
-- "INFO: started"

-- 7) Returning a function that captures a list snapshot
filterFactory :: (a -> Bool) -> ([a] -> [a])
filterFactory p = \xs -> filter p xs

-- Example:
-- > let evenFilter = filterFactory even
-- > evenFilter [1..6]
-- [2,4,6]

-- 8) Return a function that itself returns a lambda (multi-level)
makeAccumulator :: Int -> (Int -> (Int -> Int))
makeAccumulator = undefined
-- Example:
-- > let a = makeAccumulator 5
-- > let b = a 2
-- > b 3
-- 10

-- 10) Returning a function that maps over two lists in parallel (returns a zipWith-style lambda)
makeZipAdder :: Num a => (a -> a -> a) -> ([a] -> [a] -> [a])
makeZipAdder f = \xs ys -> zipWith f xs ys 
-- Example:
-- > let addz = makeZipAdder (+)
-- > addz [1,2,3] [4,5,6]
-- [5,7,9]

-- 11) Returning a function that captures an environment (multiple captured values)
makeScalerAndAdder :: Int -> Int -> (Int -> Int)
makeScalerAndAdder = undefined
-- Example:
-- > let f = makeScalerAndAdder 3 4
-- > f 2
-- 10

-- 12) Build a configurable mapper from a list of functions
buildMapper :: [a -> a] -> (a -> a)
buildMapper = undefined
-- Example:
-- > let fs = [(+1),(*2),(^2)]
-- > (buildMapper fs) 2
-- 36    -- ((2+1)*2)^2 = 36
