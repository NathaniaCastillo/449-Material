
--try and see if this is correct

middleNumber :: Int -> Int -> Int -> Int
middleNumber x y z
    | between y x z = x
    | between x y z = y
    | otherwise = z

between :: Int -> Int -> Int -> Bool
between x y z
    | (x <= y) && (y <= z) = True
    | (x >= y) && (y >= z) = True
    | otherwise = False
    