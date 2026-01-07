# @param {Integer} n
# @param {Integer} k
# @return {Integer}
def kth_factor(n, k)
  factors = []

  # Iterate up to sqrt(n) to find small factors
  (1..Math.sqrt(n).to_i).each do |i|
    if n % i == 0
      factors << i          # small factor
      factors << n / i if i != n / i  # paired factor (avoid duplicate if perfect square)
    end
  end

  # Sort the factors in ascending order
  factors.sort!

  # Return kth factor if exists
  factors[k - 1] || -1
end
