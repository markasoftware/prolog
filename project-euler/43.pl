:- consult("leetcode/reverse-integer.pl").

pandigital(N) :- permutation([1, 2, 3, 4, 5, 6, 7, 8, 9, 0], D), le_undigits(D, N).

divisors([2, 3, 5, 7, 11, 13, 17]).

check_divisors(_, []).
check_divisors([D1, D2, D3 | DigitsRest], [Divisor | DivisorsRest]) :-
    be_undigits([D1, D2, D3], N), 0 is N mod Divisor,
    check_divisors([D2, D3 | DigitsRest], DivisorsRest).

special_pandigital(N) :- pandigital(N), be_digits(N, [_|D]), divisors(Divisors), check_divisors(D, Divisors).

% no tail recursion:
sum_slow([], 0).
sum_slow([A | R], X) :- sum(R, RX), X is RX+A.

% tail recursion:
% Read sum_tail_helper as asserting "The sum of L is equal to Result minus SoFar"
sum_tail_helper([], X, X).
sum_tail_helper([A|L], Result, SoFar) :- NextSoFar is SoFar+A, sum_tail_helper(L, Result, NextSoFar).
sum(L, N) :- sum_tail_helper(L, N, 0).

% but really there's just a `sumlist`

solve_pe(N) :- findall(P, special_pandigital(P), L), sumlist(L, N).
