# @param {Integer} n  # The nth magical number we want to find
# @param {Integer} a  # First divisor
# @param {Integer} b  # Second divisor
# @return {Integer}
def nth_magical_number(n, a, b)
  mod = 1_000_000_007  # Modulo as required by problem

  # Helper lambda to compute gcd of two numbers using Euclidean algorithm
  gcd = ->(x, y) { y == 0 ? x : gcd.call(y, x % y) }

  # Compute lcm(a, b) safely: lcm = a * b / gcd(a, b)
  lcm = a / gcd.call(a, b) * b

  # Set binary search boundaries
  left = [a, b].min       # Minimum possible magical number
  right = n * [a, b].min  # Maximum possible magical number if all are the smallest divisor
  answer = 0              # Variable to store final answer

  # Start binary search
  while left <= right
    mid = left + (right - left) / 2  # Current middle value to test

    # Count how many numbers <= mid are divisible by a or b
    count = mid / a + mid / b - mid / lcm

    if count < n
      left = mid + 1   # Need larger numbers, move left boundary up
    else
      answer = mid     # mid has at least n magical numbers, store as potential answer
      right = mid - 1  # Search smaller numbers to find the smallest satisfying one
    end
  end

  # Return the answer modulo 10^9 + 7
  answer % mod
end
