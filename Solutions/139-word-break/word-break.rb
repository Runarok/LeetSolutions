# @param {String} s
# @param {String[]} word_dict
# @return {Boolean}
def word_break(s, word_dict)
  # Convert array to set for O(1) lookups
  word_set = word_dict.to_set

  n = s.length
  # dp[i] = true if s[0..i-1] can be segmented
  dp = Array.new(n + 1, false)
  dp[0] = true  # empty string is always segmentable

  (1..n).each do |i|
    (0...i).each do |j|
      # If s[0..j-1] is segmentable and s[j..i-1] is in dictionary
      if dp[j] && word_set.include?(s[j...i])
        dp[i] = true
        break  # no need to check further splits for this i
      end
    end
  end

  dp[n]  # Can the full string be segmented?
end
