defmodule Solution do
  @spec self_dividing_numbers(left :: integer, right :: integer) :: [integer]
  def self_dividing_numbers(left, right) do
    # ------------------------------------------------------------
    # STEP 1: Iterate through the range [left, right]
    # ------------------------------------------------------------
    left..right
    |> Enum.filter(fn number ->
      # ------------------------------------------------------------
      # STEP 2: Check if the number is self-dividing
      # ------------------------------------------------------------
      is_self_dividing(number)
    end)
  end

  # ------------------------------------------------------------
  # Helper function to check if a number is self-dividing
  # ------------------------------------------------------------
  defp is_self_dividing(number) do
    # ------------------------------------------------------------
    # We need the original number for modulo checks,
    # so we store it separately
    # ------------------------------------------------------------
    check_digits(number, number)
  end

  # ------------------------------------------------------------
  # Recursive digit-checking function
  #
  # current -> remaining part of the number being processed
  # original -> original full number
  # ------------------------------------------------------------
  defp check_digits(0, _original) do
    # ------------------------------------------------------------
    # If we've checked all digits successfully,
    # the number IS self-dividing
    # ------------------------------------------------------------
    true
  end

  defp check_digits(current, original) do
    # ------------------------------------------------------------
    # Extract the last digit
    # ------------------------------------------------------------
    digit = rem(current, 10)

    # ------------------------------------------------------------
    # Digit rules:
    # - Cannot be 0
    # - Must divide the original number evenly
    # ------------------------------------------------------------
    if digit == 0 or rem(original, digit) != 0 do
      false
    else
      # ------------------------------------------------------------
      # Remove the last digit and continue checking
      # ------------------------------------------------------------
      check_digits(div(current, 10), original)
    end
  end
end
