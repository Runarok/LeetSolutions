-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].
two_sum(Nums, Target) ->
  % Create an empty hash table
  two_sum(Nums, Target, #{}, 0).

two_sum([], _, _, _) -> 
  []; % If no pair is found, return empty list

two_sum([Head | Tail], Target, Map, Index) ->
  Complement = Target - Head, % Calculate complement
  case maps:get(Complement, Map, undefined) of
    undefined -> % If complement not found, add number and index to hash table
      two_sum(Tail, Target, maps:put(Head, Index, Map), Index + 1);
    FoundIndex -> % If complement found, return the pair of indices
      [FoundIndex, Index]
  end.
