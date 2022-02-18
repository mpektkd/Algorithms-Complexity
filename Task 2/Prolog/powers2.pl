set([A,B,[]], [C,D]):- 
    B =\= 0,
    C is A + 2,
    D is B - 1.
set([A,B|C], [D,E|F]):-
    (B =\= 0 ->
    D is A + 2,
    E is B - 1,
    C = F
    ;D = A,
    set([B|C], [E|F])
).

without_last([K],L):-
    K =\= 0 -> L = [K],!
    ;L = [], !.
without_last([X,0,[]], [X]).
without_last([X|Xs], [X|WithoutLast]):-
    without_last(Xs, WithoutLast).

sum([], 0).
sum([H|T], Sum):-
    sum(T, TailSum),
    Sum is H + TailSum.


word_smallest(X, Y, L):-
    Y > 0 ->
    (set(X, M),
    without_last(M, L1),
    K is Y - 1,
    word_smallest(L1, K, L)
    )
    ;L = X.


transform(0, [0]).
transform(1, [1]).
transform(N, [H|T]):-
    N > 1,
    H is N mod 2,
    Y is N//2,
    transform(Y, T), !.

read_input(File, N, C) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    repeat(Stream, N, [], C).
    

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

repeat(_, 0, List, List).
repeat(Stream, N, C, List):-
    Y is N - 1, 
    read_line(Stream, X),
    append(C, X, L1),
    repeat(Stream, Y, L1, List),!.


enable_written(N, K, L):-
K =:= N -> L = [N]
;K > N -> L = []
;transform(N, M),
sum(M, Sum),
(K < Sum -> L = []
;K = Sum -> L = M
;Y is K - Sum, word_smallest(M, Y, L)
).

powers2(File, Answers):-
    read_input(File, T, List),
    main(T, List, Answers).

main(0, _, []).
main(T, [A,B|T1], [D|T2]):-
    enable_written(A, B, D),
    Y is T - 1,
    main(Y, T1, T2).
    
    