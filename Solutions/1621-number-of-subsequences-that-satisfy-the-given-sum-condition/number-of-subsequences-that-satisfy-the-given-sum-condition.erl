-export([num_subseq/2]).

% Define the modulo constant as specified in the problem
-define(MOD, 1000000007).

% Public API: num_subseq/2
% Takes a list of integers (Nums) and a Target value,
% and returns the number of valid subsequences modulo 1e9+7.
num_subseq(Nums, Target) ->

    % Step 1: Sort the list to make two-pointer technique possible
    SortedList = lists:sort(Nums),

    % Step 2: Compute the length of the sorted list
    Len = length(SortedList),

    % Step 3: Convert the list to a tuple for fast indexed access (1-based)
    Sorted = list_to_tuple(SortedList),

    % Step 4: Precompute powers of 2 up to Len (used for counting subsequences)
    % Wrap the result in a tuple for fast access
    Powers = list_to_tuple(precompute_powers(Len)),

    % Step 5: Start the main loop using a two-pointer approach
    loop(Sorted, Target, Powers, 0, Len - 1, Len, 0).


% precompute_powers/1
% Returns a list of powers of 2 modulo MOD, i.e., [2^0, 2^1, ..., 2^(N-1)]
precompute_powers(N) ->
    precompute_powers(N, 0, []).

% Helper for precompute_powers with index tracking
precompute_powers(N, N, Acc) ->
    lists:reverse(Acc); % Done, reverse accumulated list
precompute_powers(N, I, Acc) ->
    P = pow(2, I, ?MOD),                    % Compute 2^I mod MOD
    precompute_powers(N, I + 1, [P | Acc]). % Append to accumulator and continue


% pow/3
% Fast modular exponentiation: computes (A^B) mod M
pow(_, 0, _) -> 1;
pow(A, B, M) when B rem 2 == 1 ->
    A * pow(A, B - 1, M) rem M;
pow(A, B, M) ->
    T = pow(A, B div 2, M),
    T * T rem M.


% loop/7
% Two-pointer loop to count valid subsequences
% Params:
%   Sorted - tuple of sorted numbers
%   Target - target sum for min + max
%   Powers - precomputed powers of 2 (as tuple)
%   Left, Right - indices of the current window (0-based)
%   Len - length of list
%   Acc - accumulator for valid subsequence count
loop(_Sorted, _Target, _Powers, Left, Right, _Len, Acc) when Left > Right ->
    Acc; % All pairs processed, return the result

loop(Sorted, Target, Powers, Left, Right, Len, Acc) ->

    % Tuple is 1-based: so we add 1 to the index
    Min = element(Left + 1, Sorted),
    Max = element(Right + 1, Sorted),

    % Check if current [Min, Max] pair is valid
    case Min + Max =< Target of
        true ->
            % If valid, all subsets of elements between Left and Right are valid
            % There are 2^(Right - Left) such subsequences
            PowVal = element(Right - Left + 1, Powers),

            % Update accumulator with modulo
            NewAcc = (Acc + PowVal) rem ?MOD,

            % Move left pointer to right to try next min value
            loop(Sorted, Target, Powers, Left + 1, Right, Len, NewAcc);
        false ->
            % If not valid, decrease max by moving right pointer left
            loop(Sorted, Target, Powers, Left, Right - 1, Len, Acc)
    end.
