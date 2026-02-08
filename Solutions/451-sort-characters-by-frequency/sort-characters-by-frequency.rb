# 451. Sort Characters By Frequency (medium)
# https://leetcode.com/problems/sort-characters-by-frequency/description/
# @param {String} s
# @return {String}

=begin
Approach: Hash + Sorting

Time Complexity: O(n log n)
- Counting characters takes O(n)
- Sorting the hash by frequency takes O(n log n)

Space Complexity: O(n)
- In the worst case, all characters are unique and stored in the hash
- We also build a new output string

Idea:
- Use a hash to count how many times each character appears
- Sort the hash by frequency (descending)
- Rebuild the string by repeating each character according to its count
=end

def frequency_sort(s)
  # Hash to store character frequencies
  # Default value is 0 so we can increment safely
  hash = Hash.new(0)

  # Result string
  string = ""

  # Count occurrences of each character
  s.chars.each do |c|
    hash[c] += 1
  end

  # Sort characters by frequency in descending order
  # hash.sort_by returns an array of [key, value] pairs
  hash.sort_by { |k, v| -v }.each do |arr|
    # Append the character arr[0], arr[1] times
    arr[1].times do
      string << arr[0]
    end
  end

  # Return the sorted string
  string
end
