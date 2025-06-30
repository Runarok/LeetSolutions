# @param {Integer[]} nums
# @return {Integer}
def find_lhs(nums)
  # Step 1: Create a frequency hash to count occurrences of each number
  freq = Hash.new(0)
  nums.each { |num| freq[num] += 1 }

  max_len = 0

  # Step 2: Iterate over the keys and check if key + 1 exists
  freq.each do |num, count|
    if freq.key?(num + 1)
      # Calculate the total length of a harmonious subsequence
      max_len = [max_len, count + freq[num + 1]].max
    end
  end

  return max_len
end
