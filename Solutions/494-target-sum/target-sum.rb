# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def find_target_sum_ways(nums, target)
  memo = {}  # Memoization hash: [index, current_sum] => ways

  # Use a lambda for recursion
  dfs = ->(i, current_sum) {
    # Base case: all numbers processed
    if i == nums.length
      return current_sum == target ? 1 : 0
    end

    key = [i, current_sum]
    return memo[key] if memo.key?(key)

    # Choose +nums[i] or -nums[i]
    count = dfs.call(i + 1, current_sum + nums[i]) + dfs.call(i + 1, current_sum - nums[i])
    memo[key] = count
    count
  }

  dfs.call(0, 0)  # Start from index 0 and sum 0
end
