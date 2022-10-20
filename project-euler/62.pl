% Most of my time on this challenge was spent searching for things that were backtracking when I
% didn't expect them to. And also discovering why permutation/2 is so slow: It internally uses
% select/3, which means it repeatedly constructs smaller linked lists with elements removed. But
% arbitrarily removing an element from the link list, while fast in an imperative language, can be
% very slow in Prolog because it destroys structure sharing up to the removed item. While the
% sorting-based other_is_permutation/2 I implement here still requires constructing a new linked
% list, at least it only has to construct one!

:- consult("leetcode/reverse-integer.pl").

:- table cube_in_range/3.

gencube(N) :- between(1, inf, A), N is A**3.

cube_in_range(N, Min, Max) :- MinRt is floor(Min**(1/3)), MaxRt is ceil(Max**(1/3)),
			      between(MinRt, MaxRt, A),
			      N is A**3.

% permutation/2 is designed mainly to generate permutations. As a result, it sometimes returns multiple results even when passed concrete arguments.
is_permutation(A, B) :- permutation(A, B), !.

% this seems to be substantially faster than the built-in permutation/2.
other_is_permutation(A, B) :- sort(0, @=<, A, L), sort(0, @=<, B, L).

% N is a number formed by a permutation of digits in D
cube_permutation(D, N) :- le_undigits(D, IN),
			  LowerBound is 10**floor(log(IN)/log(10)), UpperBound is 10**ceil(log(IN)/log(10)),
			  cube_in_range(N, LowerBound, UpperBound), le_digits(N, D2),
			  other_is_permutation(D, D2).

solve_pe(K, N) :- gencube(N), le_digits(N, D), findall(N2, cube_permutation(D, N2), L), length(L, K).
