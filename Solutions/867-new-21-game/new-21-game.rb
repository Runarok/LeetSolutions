# @param {Integer} n
# @param {Integer} k
# @param {Integer} max_pts
# @return {Float}
def new21_game(n, k, max_pts)
  # Edge case: if k == 0, Alice does not draw at all
  return 1.0 if k == 0 || n >= k + max_pts

  # dp[x] = probability of having exactly x points
  dp = Array.new(n + 1, 0.0)
  dp[0] = 1.0

  window_sum = 1.0  # Sum of the last maxPts dp values
  result = 0.0

  (1..n).each do |points|
    # Use the current window_sum to calculate dp[points]
    dp[points] = window_sum / max_pts

    if points < k
      # If still drawing, add dp[points] to window_sum
      window_sum += dp[points]
    else
      # If Alice would stop at this point, add to result
      result += dp[points]
    end

    # Remove dp[points - max_pts] from window_sum if window exceeded
    if points - max_pts >= 0
      window_sum -= dp[points - max_pts]
    end
  end

  result
end
