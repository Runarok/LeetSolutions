# @param {Integer[]} robot
# @param {Integer[][]} factory
# @return {Integer}
def minimum_total_distance(robot, factory)
  # Step 1: Sort robots and factories
  robot.sort!
  factory.sort_by! { |f| f[0] }

  n = robot.length
  m = factory.length

  # Memoization table
  memo = Array.new(n) { Array.new(m, nil) }

  # Recursive DP
  dfs = lambda do |i, j|
    # If all robots are assigned
    return 0 if i == n

    # If no factories left
    return Float::INFINITY if j == m

    return memo[i][j] unless memo[i][j].nil?

    pos, cap = factory[j]

    # Option 1: Skip this factory
    res = dfs.call(i, j + 1)

    # Option 2: Assign up to `cap` robots to this factory
    dist = 0

    (0...cap).each do |k|
      break if i + k >= n

      # Add distance for assigning robot[i+k] to this factory
      dist += (robot[i + k] - pos).abs

      # Recurse for remaining robots and next factory
      res = [res, dist + dfs.call(i + k + 1, j + 1)].min
    end

    memo[i][j] = res
  end

  dfs.call(0, 0)
end