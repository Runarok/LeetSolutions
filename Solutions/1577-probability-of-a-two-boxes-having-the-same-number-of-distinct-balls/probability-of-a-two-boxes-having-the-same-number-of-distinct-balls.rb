# @param {Integer[]} balls
# @return {Float}
def get_probability(balls)
  # Precompute factorials up to 49 to use in multinomial coefficient calculations
  @factorial = Array.new(50, 1)
  (1...@factorial.size).each do |i|
    @factorial[i] = @factorial[i - 1] * i
  end

  # Total number of balls divided by 2 (both boxes get exactly n balls)
  n = balls.sum / 2

  # Initialize global counters
  @total_ways = 0.0   # Total valid ways to distribute balls into two boxes
  @valid_ways = 0.0   # Number of valid ways where both boxes have same # of distinct colors

  # Recursive DFS function to explore all valid distributions
  def dfs(i, box1, box2, count1, count2, colors1, colors2, balls, n)
    # Base case: all colors have been considered
    if i == balls.size
      # Only consider valid distributions where both boxes have exactly n balls
      if count1 == n && count2 == n
        # Count number of arrangements for each box using multinomial coefficients
        ways1 = multinomial(box1)
        ways2 = multinomial(box2)
        total = ways1 * ways2

        # Add to total ways
        @total_ways += total

        # If both boxes have the same number of distinct colors, it's a valid outcome
        @valid_ways += total if colors1 == colors2
      end
      return
    end

    # Try all ways to split balls of color i between box1 and box2
    (0..balls[i]).each do |j|
      b1 = j                    # Number of color i balls in box1
      b2 = balls[i] - j        # Number of color i balls in box2

      # Prune branches where boxes would exceed n balls
      next if count1 + b1 > n || count2 + b2 > n

      # Track distinct colors: +1 if we add any of color i to the box
      new_colors1 = colors1 + (b1 > 0 ? 1 : 0)
      new_colors2 = colors2 + (b2 > 0 ? 1 : 0)

      # Recurse for next color
      dfs(
        i + 1,
        box1 + [b1],   # Add this split to box1 array
        box2 + [b2],   # Add to box2 array
        count1 + b1,   # Update total ball count for box1
        count2 + b2,   # Update total ball count for box2
        new_colors1,   # Update distinct colors for box1
        new_colors2,   # Update distinct colors for box2
        balls,
        n              # Total balls per box
      )
    end
  end

  # Helper function to compute the multinomial coefficient:
  # This gives the number of ways to arrange balls in a box with the given counts.
  def multinomial(counts)
    sum = counts.sum                     # Total number of balls in the box
    res = @factorial[sum]                # Start with factorial(sum)
    counts.each { |c| res /= @factorial[c] }  # Divide by factorial of each count
    res
  end

  # Start DFS from the first color (index 0)
  dfs(0, [], [], 0, 0, 0, 0, balls, n)

  # Return the probability as the ratio of valid outcomes over total outcomes
  @valid_ways / @total_ways
end
