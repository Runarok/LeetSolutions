# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  # This hash will store the last seen index of each character.
  # Key: character, Value: index of the character in the string
  char_index = {}

  # Left pointer of the sliding window (start of the current substring)
  left = 0

  # Keeps track of the maximum length of substring found with unique characters
  max_length = 0

  # Iterate over each character in the string along with its index
  s.each_char.with_index do |char, right|
    # If the character has been seen before and is inside the current window,
    # move the 'left' pointer to one position after its last seen position.
    # This ensures we remove the duplicate from the window.
    if char_index.key?(char) && char_index[char] >= left
      # Shift the window to the right to exclude the repeating character
      left = char_index[char] + 1
    end

    # Update or add the current character's index to the hash
    char_index[char] = right

    # Calculate the current window size and update max_length if it's larger
    current_window_size = right - left + 1
    max_length = [max_length, current_window_size].max
  end

  # After iterating through the string, return the longest found substring length
  max_length
end
