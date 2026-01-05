# Function to find the single number in an array where every other number appears three times
# @param {Integer[]} nums - input array
# @return {Integer} - the single number that appears exactly once
def single_number(nums)
  # Initialize variables to keep track of bits appearing once and twice
  # These will simulate a finite state machine for counting bits modulo 3
  ones = 0   # bits that have appeared 1 time modulo 3
  twos = 0   # bits that have appeared 2 times modulo 3

  # Iterate through each number in the array
  nums.each do |num|
    # Update twos first: add the bits that are already in 'ones' AND in current number
    # These are the bits that have appeared twice now
    twos |= ones & num

    # XOR num with ones: bits that appear first time or third time toggle in ones
    ones ^= num

    # mask for bits appearing three times
    # When a bit has appeared three times, it should be removed from both ones and twos
    threes = ones & twos

    # Remove bits that have appeared three times from ones and twos
    ones &= ~threes
    twos &= ~threes
  end

  # After processing all numbers:
  # 'ones' contains the bits of the number that appeared exactly once
  return ones
end

