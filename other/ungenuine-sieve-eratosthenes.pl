% Sieve of eratosthenes, implemented non-genuinely (ie, it's way slower than the "true" one because you need more complex data structures for that).

:- table possible_prime/2.
:- table nth_prime/2.

% is K not divisible by any of the first primes up to and including prime N (0-indexed)?
possible_prime(_, -1).
possible_prime(K, N) :- nth_prime(N, P), R is K mod P, R>0, N2 is N-1, possible_prime(K, N2).

nth_prime(0, 2) :- !.
nth_prime(N, P) :- N2 is N-1, nth_prime(N2, P2),
		   between(P2, inf, P),
		   possible_prime(P, N2), !. % there can only be one N-th prime
