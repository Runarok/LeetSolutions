defmodule Solution do
  @spec plus_one(digits :: [integer]) :: [integer]
  def plus_one(digits) do
    # We want to add 1 starting from the LAST digit
    # because that's how normal addition works.
    #
    # Example:
    #   [1,2,9]
    #       ↑ start here
    #
    # If the digit is < 9 → just add 1 and we're done
    # If the digit is 9 → it becomes 0 and we carry 1 to the left

    # We reverse the list so we can process from least significant digit
    digits
    |> Enum.reverse()
    |> add_one_with_carry(1)   # start with carry = 1 (since we add one)
    |> Enum.reverse()          # reverse back to original order
  end

  # -------------------------------------------------------
  # Helper function that handles addition with carry
  # -------------------------------------------------------

  # Case 1:
  # We still have digits left AND a carry to process
  defp add_one_with_carry([digit | rest], carry) do
    # Add the current digit and the carry
    sum = digit + carry

    # New digit is sum modulo 10
    new_digit = rem(sum, 10)

    # New carry is 1 only if sum >= 10, otherwise 0
    new_carry = div(sum, 10)

    # Recursively process remaining digits
    [new_digit | add_one_with_carry(rest, new_carry)]
  end

  # Case 2:
  # No digits left BUT we still have a carry
  #
  # Example:
  #   [9,9,9]
  # becomes
  #   [0,0,0] with carry = 1
  # so we must add an extra digit [1]
  defp add_one_with_carry([], 1) do
    [1]
  end

  # Case 3:
  # No digits left AND no carry left
  # Nothing more to add
  defp add_one_with_carry([], 0) do
    []
  end
end
