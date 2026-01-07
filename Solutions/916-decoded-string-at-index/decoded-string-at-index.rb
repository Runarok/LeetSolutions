# @param {String} s
# @param {Integer} k
# @return {String}
def decode_at_index(s, k)
  size = 0

  # 1. Compute length of decoded string
  s.each_char do |c|
    if c =~ /\d/      # digit
      size *= c.to_i
    else              # letter
      size += 1
    end
  end

  # 2. Iterate backwards to find kth character
  (s.length - 1).downto(0) do |i|
    c = s[i]

    k %= size
    if k == 0 && c =~ /[a-z]/
      return c
    end

    if c =~ /\d/
      size /= c.to_i
    else
      size -= 1
    end
  end
end
