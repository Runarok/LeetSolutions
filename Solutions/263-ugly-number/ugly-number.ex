defmodule Solution do
  @spec is_ugly(n :: integer) :: boolean
  def is_ugly(n) do
    # ------------------------------------------------------------
    # STEP 1: Ugly numbers must be POSITIVE
    # ------------------------------------------------------------
    # Zero and negative numbers are NOT ugly
    if n <= 0 do
      false
    else
      # ------------------------------------------------------------
      # STEP 2: Remove all factors of 2, 3, and 5
      # ------------------------------------------------------------
      n
      |> divide_out(2)
      |> divide_out(3)
      |> divide_out(5)
      |> is_one?()
    end
  end

  # ------------------------------------------------------------
  # Helper function:
  # Repeatedly divide n by a given factor
  # ------------------------------------------------------------
  defp divide_out(n, factor) do
    # While n is divisible by factor, keep dividing
    if rem(n, factor) == 0 do
      divide_out(div(n, factor), factor)
    else
      n
    end
  end

  # ------------------------------------------------------------
  # Helper function:
  # Check if final result is exactly 1
  # ------------------------------------------------------------
  defp is_one?(n), do: n == 1
end
