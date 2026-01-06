-spec repeated_string_match(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> integer().
repeated_string_match(A, B) ->
    repeated_string_match(A, B, <<>>, 0).

% Helper recursive function
-spec repeated_string_match(A :: binary(), B :: binary(), Acc :: binary(), Count :: integer()) -> integer().
repeated_string_match(A, B, Acc, Count) ->
    NewAcc = <<Acc/binary, A/binary>>,
    NewCount = Count + 1,
    case binary:match(NewAcc, B) of
        {_, _} -> 
            NewCount; % Found B
        nomatch ->
            if
                byte_size(NewAcc) >= byte_size(B) + byte_size(A) ->
                    -1; % Too long, cannot match even with one extra repetition
                true ->
                    repeated_string_match(A, B, NewAcc, NewCount) % Repeat again
            end
    end.
