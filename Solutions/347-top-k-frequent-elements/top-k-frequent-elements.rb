# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}

def top_k_frequent(nums, k)
  # Hash to count how many times each number appears
  # Default value is 0 so we can increment directly
  number_frequency = Hash.new { |h, key| h[key] = 0 }

  # Bucket array where:
  # index = frequency
  # value = array of numbers that appear with that frequency
  #
  # Size is nums.size + 1 because the maximum possible frequency
  # of any number is nums.size
  bucket = Array.new(nums.size + 1) { [] }

  # Count the frequency of each number
  nums.each do |num|
    number_frequency[num] += 1
  end

  # Result array to store the top k frequent elements
  result = []

  # Place each number into the bucket corresponding to its frequency
  number_frequency.each do |num, frequency|
    bucket[frequency] << num
  end

  # Traverse the buckets from highest frequency to lowest
  (bucket.size - 1).downto(1) do |i|
    # Each bucket may contain multiple numbers
    bucket[i].each do |num|
      # Add the number to the result
      result << num

      # Stop as soon as we have k elements
      return result if result.size == k
    end
  end
end
