defmodule Solution do
  @spec max_length(arr :: [String.t()]) :: integer
  def max_length(arr) do
    # Step 1: Filter out strings with duplicate characters
    # We only keep strings where length of unique chars == length of string
    filtered_arr =
      Enum.filter(arr, fn s ->
        # String.graphemes splits string into list of characters
        chars = String.graphemes(s)
        length(Enum.uniq(chars)) == length(chars)
      end)

    # Step 2: Define a recursive helper function for DFS/backtracking
    # - index: current index in the filtered array
    # - used: MapSet of characters used so far
    # - max_len: maximum length seen so far
    max_len =
      dfs(filtered_arr, 0, MapSet.new(), 0)

    max_len
  end

  # Recursive DFS helper
  defp dfs(arr, index, used, current_len) do
    # Base case: if index reaches end of arr, return current length
    if index == length(arr) do
      current_len
    else
      # Get the string at current index
      s = Enum.at(arr, index)
      chars = MapSet.new(String.graphemes(s))

      # Step 2a: Option 1 - skip current string
      skip_len = dfs(arr, index + 1, used, current_len)

      # Step 2b: Option 2 - include current string if no overlap with used characters
      include_len =
        if MapSet.disjoint?(used, chars) do
          # Merge used characters with current string
          new_used = MapSet.union(used, chars)
          dfs(arr, index + 1, new_used, current_len + MapSet.size(chars))
        else
          # Cannot include, return 0 (will not affect max)
          0
        end

      # Step 3: Return the maximum length between include and skip
      max(skip_len, include_len)
    end
  end
end
