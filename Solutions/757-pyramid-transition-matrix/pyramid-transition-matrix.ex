defmodule Solution do
  @spec pyramid_transition(String.t(), [String.t()]) :: boolean
  def pyramid_transition(bottom, allowed) do
    # Build a transition map from allowed patterns
    #
    # Example:
    # allowed = ["ABC", "ABD"]
    # transitions = %{
    #   "AB" => ["C", "D"]
    # }
    #
    # This allows O(1) lookup of possible top blocks
    transitions =
      Enum.reduce(allowed, %{}, fn <<a::binary-size(1), b::binary-size(1), c::binary-size(1)>>, acc ->
        Map.update(acc, a <> b, [c], &[c | &1])
      end)

    # Start DFS with memoization
    # memo maps: row_string => true | false
    {result, _memo} = dfs(bottom, transitions, %{})
    result
  end

  # ---------------------------------------------------------------------------
  # DFS + Memoization
  # ---------------------------------------------------------------------------

  # Base case:
  # If the row has length 1, we successfully built the pyramid
  defp dfs(row, _transitions, memo) when byte_size(row) == 1 do
    {true, memo}
  end

  # Memoization hit:
  # If this row was already computed, reuse the stored result
  defp dfs(row, _transitions, memo) when is_map_key(memo, row) do
    {memo[row], memo}
  end

  # Recursive DFS
  defp dfs(row, transitions, memo) do
    # Try to build all possible rows above the current one
    #
    # Enum.reduce_while allows early stopping:
    # - stop immediately when a valid pyramid is found
    # - continue otherwise
    {result, memo} =
      row
      |> next_rows(transitions)
      |> Enum.reduce_while({false, memo}, fn next_row, {_res, memo} ->
        # Recursively try to build pyramid from the next row
        {ok, memo} = dfs(next_row, transitions, memo)

        if ok do
          # Found a valid path → stop immediately
          {:halt, {true, memo}}
        else
          # This path failed → continue searching
          {:cont, {false, memo}}
        end
      end)

    # Store the result for this row in memo
    # This is CRITICAL to avoid TLE
    {result, Map.put(memo, row, result)}
  end

  # ---------------------------------------------------------------------------
  # Generate all valid next rows from the current row
  # ---------------------------------------------------------------------------

  defp next_rows(row, transitions) do
    # Convert row into list of single-character strings
    chars = String.graphemes(row)

    # For each adjacent pair, find possible top blocks
    #
    # Example:
    # row = "BCD"
    # pairs = ["BC", "CD"]
    # options = [["C"], ["E"]]
    options =
      chars
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] ->
        Map.get(transitions, a <> b, [])
      end)

    # If any adjacent pair has no valid top block,
    # this row cannot lead to a valid pyramid
    if Enum.any?(options, &(&1 == [])) do
      []
    else
      # Otherwise, generate all combinations of the options
      combine(options)
    end
  end

  # ---------------------------------------------------------------------------
  # Cartesian product helper
  # ---------------------------------------------------------------------------

  # Example:
  # combine([["C", "D"], ["E"]]) => ["CE", "DE"]
  defp combine([head | tail]) do
    for c <- head,
        rest <- combine(tail),
        do: c <> rest
  end

  # Base case for combination building
  defp combine([]), do: [""]
end
