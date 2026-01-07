# @param {Integer[]} nums
# @return {Integer}
def maximum_prime_difference(nums)
  # Precompute primes up to 100
  primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 
            53, 59, 61, 67, 71, 73, 79, 83, 89, 97].to_set

  first_prime_idx = nil
  last_prime_idx = nil

  nums.each_with_index do |num, idx|
    next unless primes.include?(num)  # skip non-primes

    first_prime_idx ||= idx          # set first prime index if not yet set
    last_prime_idx = idx             # always update last prime index
  end

  last_prime_idx - first_prime_idx
end
