defmodule Solution do
  @spec repeated_n_times(nums :: [integer]) :: integer
  def repeated_n_times(nums) do
    # ------------------------------------------------------------
    # Problem recap:
    # - The list has length 2 * n
    # - There are n + 1 unique elements
    # - Exactly ONE element is repeated n times
    # - All other elements appear exactly once
    #
    # Our goal:
    # - Find and return the element that appears n times
    # ------------------------------------------------------------

    # ------------------------------------------------------------
    # Strategy:
    # We will count how many times each number appears.
    # As soon as a number appears more than once,
    # we know it must be the repeated element.
    #
    # Why this works:
    # - All other elements appear only once
    # - Only ONE element appears many times (n times)
    # ------------------------------------------------------------

    # ------------------------------------------------------------
    # We use Enum.reduce_while/3 so we can:
    # - Walk through the list
    # - Keep track of counts in a map
    # - Stop early as soon as we find the repeated number
    # ------------------------------------------------------------

    Enum.reduce_while(nums, %{}, fn num, counts ->
      # --------------------------------------------------------
      # Get the current count of this number from the map
      # If it does not exist yet, default to 0
      # --------------------------------------------------------
      current_count = Map.get(counts, num, 0)

      # --------------------------------------------------------
      # If we have already seen this number before,
      # then this must be the repeated element.
      # We can immediately stop and return it.
      # --------------------------------------------------------
      if current_count >= 1 do
        {:halt, num}
      else
        # ------------------------------------------------------
        # Otherwise, this is the first time we see this number.
        # We store it in the map with count = 1
        # and continue processing the list.
        # ------------------------------------------------------
        {:cont, Map.put(counts, num, 1)}
      end
    end)
  end
end
