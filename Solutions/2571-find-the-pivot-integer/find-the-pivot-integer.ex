defmodule Solution do
  @spec pivot_integer(n :: integer) :: integer
  def pivot_integer(n) do
    # ------------------------------------------------------------
    # STEP 1: Compute the total sum from 1 to n
    #
    # Formula:
    # sum = n * (n + 1) / 2
    # ------------------------------------------------------------
    total_sum = div(n * (n + 1), 2)

    # ------------------------------------------------------------
    # STEP 2: The pivot x must satisfy:
    #
    # x^2 = total_sum
    #
    # So we take the square root of total_sum
    # ------------------------------------------------------------
    x = :math.sqrt(total_sum) |> trunc()

    # ------------------------------------------------------------
    # STEP 3: Check if x * x equals total_sum
    #
    # If yes → x is the pivot
    # If no  → no pivot exists
    # ------------------------------------------------------------
    if x * x == total_sum do
      x
    else
      -1
    end
  end
end
