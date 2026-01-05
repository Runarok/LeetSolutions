defmodule Solution do
  @spec can_make_arithmetic_progression(arr :: [integer]) :: boolean
  def can_make_arithmetic_progression(arr) do
    # ------------------------------------------------------------
    # STEP 1: Get basic information
    # ------------------------------------------------------------

    # Number of elements in the array
    n = length(arr)

    # Any array with only 2 elements is always arithmetic
    # because there's only one possible difference
    if n <= 2 do
      true
    else
      # ------------------------------------------------------------
      # STEP 2: Find minimum and maximum values
      # ------------------------------------------------------------

      # We need the smallest and largest numbers to calculate
      # what the common difference SHOULD be
      min_val = Enum.min(arr)
      max_val = Enum.max(arr)

      # ------------------------------------------------------------
      # STEP 3: Check if a valid difference exists
      # ------------------------------------------------------------

      # The formula for arithmetic progression:
      # max = min + (n - 1) * diff
      #
      # So diff = (max - min) / (n - 1)
      #
      # If (max - min) is NOT divisible by (n - 1),
      # then it's impossible to form an arithmetic progression
      total_range = max_val - min_val

      if rem(total_range, n - 1) != 0 do
        false
      else
        # Common difference
        diff = div(total_range, n - 1)

        # ------------------------------------------------------------
        # STEP 4: Use a MapSet for O(1) lookups
        # ------------------------------------------------------------

        # Convert array into a set to check existence quickly
        set = MapSet.new(arr)

        # ------------------------------------------------------------
        # STEP 5: Verify all expected values exist
        # ------------------------------------------------------------

        # We expect these values:
        # min, min + diff, min + 2*diff, ..., max
        #
        # If ANY value is missing → not an arithmetic progression
        Enum.all?(0..(n - 1), fn i ->
          expected_value = min_val + i * diff
          MapSet.member?(set, expected_value)
        end)
      end
    end
  end
end
