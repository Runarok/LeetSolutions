# @param {String} s
# @param {Integer} k
# @return {String}
def remove_duplicates(s, k)
  # Stack will store pairs: [character, count]
  # Example: [["a", 2], ["b", 1]]
  stack = []

  # Iterate through each character in the string
  s.each_char do |char|

    # ----------------------------------------
    # CASE 1: Stack is NOT empty AND top char matches current char
    # ----------------------------------------
    if !stack.empty? && stack[-1][0] == char
      # Increase count of the top character
      stack[-1][1] += 1

      # If count reaches k → remove it
      if stack[-1][1] == k
        stack.pop
      end

    else
      # ----------------------------------------
      # CASE 2: New character (not matching top)
      # ----------------------------------------
      # Push new character with count = 1
      stack.push([char, 1])
    end
  end

  # ----------------------------------------
  # Build final string from stack
  # ----------------------------------------
  result = ""

  stack.each do |char, count|
    # Repeat character 'count' times
    result << char * count
  end

  return result
end