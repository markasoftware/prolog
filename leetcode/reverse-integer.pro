% convert number to 
le_digits(0, []).
le_digits(X, [A|R]) :- A is X mod 10, XR is X//10, le_digits(XR, R).

be_digits(X, D) :- le_digits(X, RD), reverse(RD, D).

% convert reversed list 
le_undigits([], 0).
le_undigits([A|R], X) :- le_undigits(R, Y), X is A+10*Y.

be_undigits(RD, X) :- reverse(RD, D), le_undigits(D, X).

solve_leetcode(X, Y) :- le_digits(X, D), be_undigits(D, Y).
