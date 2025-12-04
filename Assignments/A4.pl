{-
Nathania Castillo
UCID:30152619
Dr. Nasri
Dec5, 2025 

Assignment 4:
-}

% Prob 1
/*Facts:
owns(alice, fluffy).
owns(alice,max).
owns(Bob, Bella).
owns(carol, max).
owns(carol, daisy).
*/

pet(fluffy).
pet(max).
pet(bella).
pet(daisy).

person(alice).
person(bob).
person(carol).

% finds out the what person owns which pet 
owns (Person, Pet):- person(Person), pet(Pet)

















