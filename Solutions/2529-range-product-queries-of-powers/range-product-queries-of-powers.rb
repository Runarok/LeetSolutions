# Function to process product queries on the powers of 2 from binary representation of n
# @param {Integer} n
# @param {Integer[][]} queries
# @return {Integer[]}
def product_queries(n, queries)
  # Use a local variable instead of a constant to avoid syntax errors
  mod = 1_000_000_007

  # Step 1: Get all powers of 2 corresponding to set bits in n
  powers = []
  power = 1

  while n > 0
    powers << power if n % 2 == 1
    n /= 2
    power *= 2
  end

  # Step 2: Precompute product of subarrays in a 2D array
  m = powers.length
  results = Array.new(m) { Array.new(m, 0) }

  (0...m).each do |i|
    cur = 1
    (i...m).each do |j|
      cur = (cur * powers[j]) % mod
      results[i][j] = cur
    end
  end

  # Step 3: Answer each query using precomputed results
  queries.map do |query|
    l, r = query
    results[l][r]
  end
end
