# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  # If there are no houses, you cannot rob anything
  return 0 if nums.empty?

  # If there is only one house, rob it
  return nums[0] if nums.length == 1

  # prev2 will store the maximum money rob-able up to the house before the previous house
  prev2 = 0
  # prev1 stores the maximum money rob-able up to the previous house
  prev1 = nums[0]

  # Iterate over the remaining houses starting from the second house
  nums[1..-1].each do |money|
    # If we rob this house, add its money to prev2 (since we can't rob prev1)
    # If we skip this house, the max money stays prev1
    current = [prev1, prev2 + money].max

    # Shift prev1 and prev2 for next iteration
    prev2 = prev1
    prev1 = current
  end

  # At the end, prev1 contains the maximum money we can rob
  prev1
end
