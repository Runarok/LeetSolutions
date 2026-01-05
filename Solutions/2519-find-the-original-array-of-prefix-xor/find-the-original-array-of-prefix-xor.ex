defmodule Solution do
  # Import Bitwise module to use bxor for XOR operations
  import Bitwise

  @spec find_array(pref :: [integer]) :: [integer]
  def find_array(pref) do
    # Step 1: Handle the first element separately
    # The first element of arr is always the same as the first element of pref
    arr_first = [hd(pref)]  # hd(pref) returns the head of the list

    # Step 2: Generate consecutive pairs from pref
    # Enum.zip(pref, tl(pref)) pairs each element with the next one
    # Example: pref = [5,2,0,3,1] -> pairs = [{5,2},{2,0},{0,3},{3,1}]
    pairs = Enum.zip(pref, tl(pref))

    # Step 3: XOR each pair to get the remaining elements of arr
    # Formula: arr[i] = pref[i-1] ^ pref[i]
    rest_arr = Enum.map(pairs, fn {prev, curr} -> bxor(prev, curr) end)
    # Note: bxor(a, b) returns a XOR b

    # Step 4: Combine the first element with the rest to form the full array
    arr_first ++ rest_arr
  end
end
