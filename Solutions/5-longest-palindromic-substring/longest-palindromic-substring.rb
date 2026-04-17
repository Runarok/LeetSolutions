# @param {String} s
# @return {String}
def longest_palindrome(s)
  # Store the best (longest) palindrome found so far
  best_start = 0
  best_len = 1

  # Helper function:
  # Expands around left and right pointers
  # and returns length of palindrome
  expand = lambda do |left, right|
    # Expand while:
    # - inside bounds
    # - characters match (palindrome condition)
    while left >= 0 && right < s.length && s[left] == s[right]
      left -= 1
      right += 1
    end

    # After loop breaks, we expanded too far
    # So actual palindrome is (left+1 ... right-1)
    return [left + 1, right - left - 1]  # start index, length
  end

  # Try every index as center
  (0...s.length).each do |i|

    # ----------------------------------------
    # CASE 1: Odd-length palindrome
    # center = i
    # ----------------------------------------
    start1, len1 = expand.call(i, i)

    # ----------------------------------------
    # CASE 2: Even-length palindrome
    # center = i and i+1
    # ----------------------------------------
    start2, len2 = expand.call(i, i + 1)

    # Pick better of the two
    if len1 > best_len
      best_len = len1
      best_start = start1
    end

    if len2 > best_len
      best_len = len2
      best_start = start2
    end
  end

  # Return substring with best result
  return s[best_start, best_len]
end