/*
Nathania Castillo
UCID:30152619
Dr. Nasri
Dec5, 2025 

Assignment 4:
*/

% Prob 1 Pet Ownership
% Facts:

pet(fluffy).
pet(max).
pet(bella).
pet(daisy).

person(alice).
person(bob).
person(carol).

owns(alice, fluffy).
owns(alice, max).
owns(bob, bella).
owns(carol, daisy).
owns(carol, max). 

/* % finds out the what person owns which pet 
owns(Person, Pet):- person(Person), pet(Pet).
*/

% find out who has a shared pet 
shared_pet(Person1, Person2, Pet):- 
owns(Person1, Pet), owns(Person2, Pet), 
Person1 \= Person2.    % I get an error wityh

% a person has more than one pet
has_multiple_pets(Person):-
owns(Person, Pet1), owns(Person, Pet2),
Pet1 \= Pet2.  

% Prob 2 List Comprehension
% Facts:











