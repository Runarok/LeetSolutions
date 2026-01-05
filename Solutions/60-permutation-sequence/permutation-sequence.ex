defmodule Solution do
  @spec get_permutation(n :: integer, k :: integer) :: String.t()
  def get_permutation(n, k) do
    # ------------------------------------------------------------
    # STEP 1: Prepare data
    # ------------------------------------------------------------

    # Convert numbers 1..n into a list
    numbers = Enum.to_list(1..n)

    # Precompute factorials up to n
    # factorials[i] = i!
    factorials = compute_factorials(n)

    # ------------------------------------------------------------
    # STEP 2: Build permutation using 0-based index
    # ------------------------------------------------------------

    # k is 1-based, convert to 0-based
    build_permutation(numbers, factorials, k - 1, n)
    |> Enum.join("")
  end

  # ------------------------------------------------------------
  # Recursive function to build permutation
  #
  # numbers     -> remaining digits
  # factorials  -> precomputed factorials
  # k           -> current index (0-based)
  # size        -> number of remaining digits
  # ------------------------------------------------------------
  defp build_permutation(_numbers, _factorials, _k, 0) do
    []
  end

  defp build_permutation(numbers, factorials, k, size) do
    # ------------------------------------------------------------
    # STEP 3: Determine which digit to pick
    # ------------------------------------------------------------

    # Number of permutations per fixed digit
    block_size = Enum.at(factorials, size - 1)

    # Index of the digit to use
    index = div(k, block_size)

    # Select the digit
    digit = Enum.at(numbers, index)

    # ------------------------------------------------------------
    # STEP 4: Remove used digit
    # ------------------------------------------------------------
    remaining_numbers = List.delete_at(numbers, index)

    # ------------------------------------------------------------
    # STEP 5: Recurse for the rest
    # ------------------------------------------------------------
    [digit | build_permutation(remaining_numbers, factorials, rem(k, block_size), size - 1)]
  end

  # ------------------------------------------------------------
  # Helper function to compute factorials
  # ------------------------------------------------------------
  defp compute_factorials(n) do
    Enum.reduce(0..n, [1], fn i, acc ->
      if i == 0 do
        acc
      else
        acc ++ [Enum.at(acc, i - 1) * i]
      end
    end)
  end
end
