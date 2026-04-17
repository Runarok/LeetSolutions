# @param {String} s
# @return {Boolean}
def is_valid(s)
  # Stack to keep track of opening brackets
  stack = []

  # Mapping of closing → opening brackets
  map = {
    ')' => '(',
    '}' => '{',
    ']' => '['
  }

  # Iterate through each character
  s.each_char do |char|

    # ----------------------------------------
    # CASE 1: Opening bracket
    # ----------------------------------------
    if char == '(' || char == '{' || char == '['
      # Push it to stack
      stack.push(char)

    else
      # ----------------------------------------
      # CASE 2: Closing bracket
      # ----------------------------------------

      # If stack is empty → no matching opening
      return false if stack.empty?

      # Pop the last opening bracket
      top = stack.pop

      # Check if it matches current closing bracket
      return false if top != map[char]
    end
  end

  # ----------------------------------------
  # Final check
  # ----------------------------------------
  # If stack is empty → all brackets matched
  # Otherwise → unmatched opening brackets remain
  return stack.empty?
end