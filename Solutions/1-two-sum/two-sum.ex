defmodule Solution do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    two_sum(nums, target, %{}, 0)
  end

  defp two_sum([], _, _, _), do: []  # If no pair is found, return empty list

  defp two_sum([head | tail], target, map, index) do
    complement = target - head  # Calculate complement
    case Map.get(map, complement) do
      nil -> # If complement is not found, add number and index to map
        two_sum(tail, target, Map.put(map, head, index), index + 1)
      found_index -> # If complement found, return the pair of indices
        [found_index, index]
    end
  end
end
