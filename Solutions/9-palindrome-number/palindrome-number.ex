defmodule Solution do
  @spec is_palindrome(x :: integer) :: boolean
  def is_palindrome(x) do
    # ------------------------------------------------------------
    # STEP 1: Handle obvious non-palindrome cases
    # ------------------------------------------------------------

    # Negative numbers are NOT palindromes
    # Example: -121 ≠ 121-
    cond do
      x < 0 ->
        false

      # Any number ending with 0 (but not 0 itself) is NOT a palindrome
      # Example: 10 -> 01
      rem(x, 10) == 0 and x != 0 ->
        false

      true ->
        # ------------------------------------------------------------
        # STEP 2: Reverse ONLY half of the number
        # ------------------------------------------------------------

        # We use a helper function to build the reversed half
        check_half(x, 0)
    end
  end

  # ------------------------------------------------------------
  # Helper function to reverse half the digits
  # ------------------------------------------------------------
  defp check_half(original, reversed) do
    # Stop condition:
    # When reversed >= original, we have processed half the digits
    if reversed >= original do
      # ------------------------------------------------------------
      # STEP 3: Compare halves
      # ------------------------------------------------------------

      # Case 1: Even number of digits
      # Example: 1221 -> 12 == 12
      #
      # Case 2: Odd number of digits
      # Example: 121 -> 12 == 1 (middle digit ignored)
      original == reversed or original == div(reversed, 10)
    else
      # ------------------------------------------------------------
      # Extract last digit and build reversed number
      # ------------------------------------------------------------

      last_digit = rem(original, 10)
      new_reversed = reversed * 10 + last_digit
      new_original = div(original, 10)

      check_half(new_original, new_reversed)
    end
  end
end
