# @param {Integer[]} nums
# @return {Integer}
def find_gcd(nums)
  min_val = nums.min  # smallest number in array
  max_val = nums.max  # largest number in array

  min_val.gcd(max_val)  # return their greatest common divisor
end
