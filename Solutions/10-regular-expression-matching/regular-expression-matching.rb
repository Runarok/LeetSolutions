# Determines whether the string s matches the pattern p
# Pattern supports:
#   '.'  -> matches any single character
#   '*'  -> matches zero or more of the preceding element
#
# The match must cover the ENTIRE string (not partial)
#
# Example:
#   s = "aa", p = "a*"  => true
#   s = "ab", p = ".*"  => true
#   s = "aa", p = "a"   => false
#
def is_match(s, p)
  # Lengths of the input string and the pattern
  m = s.length
  n = p.length

  # dp[i][j] will be true if:
  #   s[0...i] matches p[0...j]
  #
  # i ranges from 0..m
  # j ranges from 0..n
  #
  # dp dimensions: (m+1) x (n+1)
  dp = Array.new(m + 1) { Array.new(n + 1, false) }

  # Base case:
  # Empty string matches empty pattern
  dp[0][0] = true

  # Handle patterns like:
  #   a*, a*b*, a*b*c*
  #
  # These can match an empty string
  (1..n).each do |j|
    if p[j - 1] == '*'
      # '*' can eliminate the preceding character
      # So we look two steps back in the pattern
      dp[0][j] = dp[0][j - 2]
    end
  end

  # Fill the DP table
  (1..m).each do |i|
    (1..n).each do |j|
      # Case 1: Current characters match directly
      # This happens when:
      #   - characters are equal
      #   - or pattern character is '.'
      if p[j - 1] == s[i - 1] || p[j - 1] == '.'
        dp[i][j] = dp[i - 1][j - 1]

      # Case 2: Pattern character is '*'
      elsif p[j - 1] == '*'
        # '*' can represent ZERO occurrences of the previous char
        # So we ignore the previous char and '*'
        dp[i][j] = dp[i][j - 2]

        # '*' can also represent ONE OR MORE occurrences
        # This is valid if:
        #   - the previous pattern character matches current string char
        #   - or the previous pattern character is '.'
        if p[j - 2] == s[i - 1] || p[j - 2] == '.'
          dp[i][j] ||= dp[i - 1][j]
        end
      end
    end
  end

  # Final answer:
  # Does the entire string match the entire pattern?
  dp[m][n]
end
