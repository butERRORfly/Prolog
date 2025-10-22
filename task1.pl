my_length([], 0).
my_length([_|T], N) :- my_length(T, N1), N is N1 + 1.

my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

my_append([], L, L).
my_append([H|T], L, [H|R]) :- my_append(T, L, R).

my_remove(X, [X|T], T).
my_remove(X, [H|T], [H|R]) :- my_remove(X, T, R).

my_permute([], []).
my_permute(L, [H|T]) :- my_remove(H, L, R), my_permute(R, T).

my_sublist(S, L) :- my_append(_, T, L), my_append(S, _, T).

% Реализация пункта 4 с помощью стандартных предикатов.
remove_n_first_std(N, List, Result) :-
    my_append(FirstN, Result, List),
    my_length(FirstN, N).

% Реализация пункта 4 без стандартных предикатов.
remove_n_first_base(0, List, List).
remove_n_first_base(N, [_|T], Result) :-
    N > 0,
    N1 is N - 1,
    remove_n_first_base(N1, T, Result).

% Реализация пункта 5 с помощью стандартных предикатов.
lex_comparison_of_lists_std([], [], equal).
lex_comparison_of_lists_std([_|_], [], greater).
lex_comparison_of_lists_std([], [_|_], less).

lex_comparison_of_lists_std([H1|T1], [H2|T2], R) :-
    H1 > H2 -> R = greater ;
    H1 < H2 -> R = less ;
    lex_comparison_of_lists_std(T1, T2, R).

% Реализация пункта 5 без стандартных предикатов.
compare_list_elements(X, Y, equal) :- X == Y.
compare_list_elements(X, Y, greater) :- X > Y.
compare_list_elements(X, Y, less) :- X < Y.

lex_comparison_of_lists([], [], equal).
lex_comparison_of_lists([_|_], [], greater).
lex_comparison_of_lists([], [_|_], less).

lex_comparison_of_lists([H1|T1], [H2|T2], R1) :-
    compare_list_elements(H1, H2, R2),
    (R2 = equal -> lex_comparison_of_lists(T1, T2, R1) ;
    R1 = R2).

% Реализация содержательного примера, основанного на 4-5 пунктах.
% Реализация предиката лексикографического сравнения элементов 2 списков без первых N элементов.
lex_comparison_after_first_n_removing(N, L1, L2, R) :-
    remove_n_first_std(N, L1, R1),
    remove_n_first_std(N, L2, R2),
    lex_comparison_of_lists_std(R1, R2, R).