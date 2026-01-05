defmodule Solution do
  @spec closest_primes(left :: integer, right :: integer) :: [integer]
  def closest_primes(left, right) do
    # Step 1: Generate all primes in the range [left..right]
    primes = Enum.filter(left..right, &is_prime?/1)

    # Step 2: If fewer than 2 primes, return [-1, -1]
    if length(primes) < 2 do
      [-1, -1]
    else
      # Step 3: Create consecutive prime pairs
      chunks = Enum.chunk_every(primes, 2, 1, :discard)

      # Step 4: Find the pair with the minimum gap
      min_pair =
        chunks
        |> Enum.min_by(fn [a, b] -> b - a end, fn -> [-1, -1] end) # fallback just in case

      min_pair
    end
  end

  # Helper function to check if a number is prime
  defp is_prime?(n) when n < 2, do: false
  defp is_prime?(2), do: true
  defp is_prime?(n) when rem(n, 2) == 0, do: false
  defp is_prime?(n) do
    max_check = :math.sqrt(n) |> floor()
    Enum.all?(3..max_check//2, fn x -> rem(n, x) != 0 end)
  end
end
