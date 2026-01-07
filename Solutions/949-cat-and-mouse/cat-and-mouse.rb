# Cat and Mouse game on a graph
# Returns 1 if mouse wins, 2 if cat wins, 0 if draw

def cat_mouse_game(graph)
  n = graph.size
  dp = Array.new(n) { Array.new(n) { Array.new(2, 0) } }  # state results
  degree = Array.new(n) { Array.new(n) { Array.new(2, 0) } } # moves left

  # set degrees (# moves possible for mouse/cat)
  (0...n).each do |m|
    (0...n).each do |c|
      degree[m][c][0] = graph[m].size          # mouse turn
      degree[m][c][1] = graph[c].count { |x| x != 0 } # cat turn
    end
  end

  queue = []

  # base cases: mouse at hole → win
  (0...n).each do |c|
    next if c == 0
    dp[0][c][0] = 1
    dp[0][c][1] = 1
    queue << [0, c, 0, 1]
    queue << [0, c, 1, 1]
  end

  # base cases: cat catches mouse → win
  (1...n).each do |m|
    dp[m][m][0] = 2
    dp[m][m][1] = 2
    queue << [m, m, 0, 2]
    queue << [m, m, 1, 2]
  end

  # BFS to propagate results
  until queue.empty?
    m, c, t, result = queue.shift
    parents = []

    if t == 0
      # mouse just moved → parent is cat's turn
      graph[c].each { |pc| parents << [m, pc, 1] unless pc == 0 }
    else
      # cat just moved → parent is mouse's turn
      graph[m].each { |pm| parents << [pm, c, 0] }
    end

    parents.each do |pm, pc, pt|
      next if dp[pm][pc][pt] != 0
      # current player can force win?
      if (pt == 0 && result == 1) || (pt == 1 && result == 2)
        dp[pm][pc][pt] = result
        queue << [pm, pc, pt, result]
      else
        degree[pm][pc][pt] -= 1
        # all moves bad → opponent wins
        if degree[pm][pc][pt] == 0
          dp[pm][pc][pt] = pt == 0 ? 2 : 1
          queue << [pm, pc, pt, dp[pm][pc][pt]]
        end
      end
    end
  end

  dp[1][2][0]  # start: mouse at 1, cat at 2, mouse turn
end
