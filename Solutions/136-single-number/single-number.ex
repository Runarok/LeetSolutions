defmodule Solution do
  @moduledoc """
  Find the single number in a list where every other number appears twice.
  
  - Linear runtime: O(n)
  - Constant extra space: O(1)
  
  Uses XOR to cancel out duplicates.
  """

  # Import Bitwise so we can use ^^^ for XOR
  import Bitwise

  @spec single_number(nums :: [integer]) :: integer
  def single_number(nums) do
    # Start with 0 as the initial accumulator
    # We'll XOR each number with this accumulator
    nums
    |> Enum.reduce(0, fn num, acc ->
      # Bitwise XOR: duplicates cancel each other out
      acc ^^^ num
    end)
  end
end

