-spec rotate_string(S :: unicode:unicode_binary(), Goal :: unicode:unicode_binary()) -> boolean().
rotate_string(S, Goal) ->
    % First, check if lengths are the same. If not, impossible to match.
    if
        byte_size(S) =/= byte_size(Goal) -> false;
        true ->
            % Concatenate S with itself. Any rotation of S will appear in this new string.
            DoubleS = <<S/binary, S/binary>>,
            % Check if Goal is a substring of DoubleS
            contains(DoubleS, Goal)
    end.

% Helper function: checks if Goal is a substring of DoubleS
-spec contains(Haystack :: binary(), Needle :: binary()) -> boolean().
contains(Haystack, Needle) ->
    case binary:match(Haystack, Needle) of
        {_, _} -> true;  % Found match
        nomatch -> false % Not found
    end.
