defmodule Solution do
  @spec max_matrix_sum(matrix :: [[integer]]) :: integer
  def max_matrix_sum(matrix) do
    # Flatten the 2D matrix into a 1D list
    flat = List.flatten(matrix)

    # Sum of absolute values of all elements
    sum_abs =
      flat
      |> Enum.map(&abs/1)
      |> Enum.sum()

    # Count how many negative numbers exist
    neg_count =
      flat
      |> Enum.count(&(&1 < 0))

    # Find the smallest absolute value in the matrix
    min_abs =
      flat
      |> Enum.map(&abs/1)
      |> Enum.min()

    # If number of negatives is even,
    # we can flip everything to positive
    if rem(neg_count, 2) == 0 do
      sum_abs
    else
      # If odd, one number must remain negative
      # Subtract twice the smallest absolute value
      sum_abs - 2 * min_abs
    end
  end
end
