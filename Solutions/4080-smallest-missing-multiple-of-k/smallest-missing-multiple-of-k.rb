# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def missing_multiple(nums, k)
  # Start with k itself because k is the smallest
  # positive multiple of k.
  multiple = k

  # Keep checking multiples of k one by one.
  # For example, if k = 2, we check:
  # 2, 4, 6, 8, 10, 12, ...
  loop do
    # Check whether the current multiple exists
    # somewhere inside the nums array.
    #
    # If it does NOT exist, we have found the
    # smallest missing positive multiple.
    unless nums.include?(multiple)
      return multiple
    end

    # If the current multiple exists in nums,
    # move to the next multiple by adding k.
    #
    # Example:
    # multiple = 2, k = 2
    # next multiple = 2 + 2 = 4
    multiple += k
  end
end
