# @param {Integer[]} arr
# @param {Integer} k
# @return {Integer}
def k_concatenation_max_sum(arr, k)
  mod = 10**9 + 7
  total_sum = arr.sum

  # Kadane's algorithm: max subarray sum for single array
  max_ending = 0
  max_subarray_sum = 0
  arr.each do |num|
    max_ending = [num, max_ending + num].max
    max_subarray_sum = [max_subarray_sum, max_ending].max
  end

  # If k == 1, return single array result
  return max_subarray_sum % mod if k == 1

  # Max prefix sum
  prefix_sum = 0
  max_prefix_sum = 0
  arr.each do |num|
    prefix_sum += num
    max_prefix_sum = [max_prefix_sum, prefix_sum].max
  end

  # Max suffix sum
  suffix_sum = 0
  max_suffix_sum = 0
  arr.reverse_each do |num|
    suffix_sum += num
    max_suffix_sum = [max_suffix_sum, suffix_sum].max
  end

  # Max sum when k >= 2
  result = [max_subarray_sum, max_suffix_sum + max_prefix_sum].max
  result = [result, max_suffix_sum + max_prefix_sum + (k - 2) * total_sum].max if total_sum > 0

  result % mod
end
