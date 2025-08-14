# @param {String} num
# @return {String}
def largest_good_integer(num)
  max_good = ""  # Stores the maximum "good" integer found so far

  # Loop through the string, considering each substring of length 3
  (0..num.length - 3).each do |i|
    substring = num[i, 3]  # Get the 3-character substring starting at index i

    # Check if all characters in the substring are the same
    if substring[0] == substring[1] && substring[1] == substring[2]
      # Update max_good if this substring is lexicographically larger
      # (e.g., "777" > "333")
      max_good = [max_good, substring].max
    end
  end

  return max_good
end

