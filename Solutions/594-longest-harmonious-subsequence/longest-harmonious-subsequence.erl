-spec find_lhs(Nums :: [integer()]) -> integer().
find_lhs(Nums) ->
    % Step 1: Build a frequency map of all numbers in the list.
    % For each number, we either increment its count if it exists,
    % or insert it with an initial count of 1.
    FrequencyMap = lists:foldl(
        fun(N, Acc) ->
            maps:update_with(N, fun(X) -> X + 1 end, 1, Acc)
        end,
        #{},  % Start with an empty map
        Nums
    ),

    % Step 2: Iterate through the map to find the longest harmonious subsequence.
    % For each key K, check if K+1 exists in the map.
    % If it does, calculate the combined frequency of K and K+1.
    % Track the maximum length found.
    maps:fold(
        fun(K, V, Max) ->
            case maps:find(K + 1, FrequencyMap) of
                {ok, V2} -> max(Max, V + V2);  % Combine frequencies if K+1 exists
                error -> Max  % Otherwise, keep the current max
            end
        end,
        0,  % Initial max length is 0
        FrequencyMap
    ).
