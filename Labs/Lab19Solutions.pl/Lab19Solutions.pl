% Exercises:
% Facts:

likes(susan, pasta).
likes(susan, ice_cream).
likes(susan, sushi).
likes(jane, chocolate).
likes(jane, cookie).
likes(john, pizza).
likes(john, pasta).
likes(mary, salad).
likes(mary, pasta).
likes(tom, pizza).
likes(tom, sushi).
likes(tom, cookie).

% Using the facts above, write queries for questoins below:

% Who likes pasta?
?- likes(Person, pasta).
% What does Susan like?
?- likes(susan, X).

% Attributes of foods
healthy(salad).
healthy(sushi).
healthy(pasta).
unhealthy(pizza).
unhealthy(cookie).

sweet(ice_cream).
sweet(cookie).

% Write the following queries:
% List all people who like unhealthy food:
?- likes(Person, Food), unhealthy(Food).
% List all people who like unhealthy food:
?- likes(Person, Food), unhealthy(Food).
% Who likes at least one healthy and one unhealthy food?:
?- likes(Person, Food1), healthy(Food1), likes(Person, Food2), unhealthy(Food2).

% Conjuction (AND)
% Write a rule that finds the people who like healthy food or not.
likes_healthy_food(Person) :- 
    likes(Person, Food), 
    healthy(Food).

% Disjunction (OR)
% Write a rule that finds the people who like unhealthy or sweet food.

likes_unhealthy_or_sweet_food(Person) :- 
    likes(Person, Food), 
    (unhealthy(Food); sweet(Food)).


% Define a rule to find people who like varied foods, meaning that they like more than one type (healthy or unhealthy) of food
likes_varied_foods(Person) :- 
    likes(Person, Food1), 
    likes(Person, Food2), 
    Food1 \= Food2,
    (healthy(Food1); unhealthy(Food1)),
    (healthy(Food2); unhealthy(Food2)).

% Define a rule to find people who like only healthy foods
%  The \+ operator is used for negation, meaning "not". This rule checks if a person likes at least one healthy food and does not like any unhealthy food.
likes_only_healthy_food(Person) :- 
    likes(Person, Food), 
    healthy(Food),
    \+ (likes(Person, OtherFood), unhealthy(OtherFood)).


% Define a rule that finds people who like more than one type of food but don’t like both healthy and unhealthy.
likes_more_than_one_type_but_not_both(Person) :-
    likes(Person, Food1),
    likes(Person, Food2),
    Food1 \= Food2,
    ((healthy(Food1), healthy(Food2));
    (unhealthy(Food1), unhealthy(Food2))).
