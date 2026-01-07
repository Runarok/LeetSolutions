# @param {Integer[]} ratings
# @return {Integer}
def candy(ratings)
  n = ratings.length
  candies = Array.new(n, 1)  # Every child gets at least 1 candy

  # Pass 1: left to right
  # If the current child has a higher rating than the previous child,
  # give them one more candy than the previous child
  (1...n).each do |i|
    if ratings[i] > ratings[i - 1]
      candies[i] = candies[i - 1] + 1
    end
  end

  # Pass 2: right to left
  # If the current child has a higher rating than the next child,
  # ensure they have more candies than the next child
  (n - 2).downto(0) do |i|
    if ratings[i] > ratings[i + 1]
      candies[i] = [candies[i], candies[i + 1] + 1].max
    end
  end

  # The minimum number of candies is the sum of all candies
  candies.sum
end
