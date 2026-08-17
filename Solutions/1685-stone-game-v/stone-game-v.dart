class Solution {
  int stoneGameV(List<int> stoneValue) {
    // Number of stones.
    final int n = stoneValue.length;

    // ------------------------------------------------------------
    // prefix[i] stores the sum of the first i stones.
    //
    // Example:
    // stoneValue = [6, 2, 3, 4]
    //
    // prefix = [0, 6, 8, 11, 15]
    //
    // Therefore, the sum from l to r is:
    // prefix[r + 1] - prefix[l]
    // ------------------------------------------------------------
    final List<int> prefix = List<int>.filled(n + 1, 0);

    for (int i = 0; i < n; i++) {
      prefix[i + 1] = prefix[i] + stoneValue[i];
    }

    // ------------------------------------------------------------
    // dp[l][r] represents the maximum score Alice can obtain
    // from the subarray stoneValue[l...r].
    //
    // If l == r, there is only one stone, so the game is already
    // over and Alice gets 0 points.
    // ------------------------------------------------------------
    final List<List<int>> dp = List.generate(
      n,
      (_) => List<int>.filled(n, 0),
    );

    // ------------------------------------------------------------
    // We calculate smaller intervals first.
    //
    // length = 2 means two stones.
    // Then length = 3, 4, ..., n.
    //
    // This guarantees that when calculating dp[l][r], the smaller
    // intervals dp[l][k] and dp[k + 1][r] have already been computed.
    // ------------------------------------------------------------
    for (int length = 2; length <= n; length++) {
      for (int l = 0; l + length <= n; l++) {
        final int r = l + length - 1;

        int best = 0;

        // ----------------------------------------------------------
        // Try every possible place to divide the interval:
        //
        // [l ... k] | [k + 1 ... r]
        //
        // Both sides must be non-empty, so k ranges from l to r - 1.
        // ----------------------------------------------------------
        for (int k = l; k < r; k++) {
          // Sum of the left part.
          final int leftSum = prefix[k + 1] - prefix[l];

          // Sum of the right part.
          final int rightSum = prefix[r + 1] - prefix[k + 1];

          // --------------------------------------------------------
          // Bob throws away the side with the larger sum.
          //
          // If leftSum < rightSum:
          //   - Bob throws away the RIGHT side.
          //   - Alice keeps the LEFT side.
          //   - Alice gets leftSum points.
          //   - The game continues on the left side.
          // --------------------------------------------------------
          if (leftSum < rightSum) {
            final int score = leftSum + dp[l][k];

            if (score > best) {
              best = score;
            }
          }

          // --------------------------------------------------------
          // If rightSum < leftSum:
          //   - Bob throws away the LEFT side.
          //   - Alice keeps the RIGHT side.
          //   - Alice gets rightSum points.
          //   - The game continues on the right side.
          // --------------------------------------------------------
          else if (rightSum < leftSum) {
            final int score = rightSum + dp[k + 1][r];

            if (score > best) {
              best = score;
            }
          }

          // --------------------------------------------------------
          // If both sides have the same sum, Alice gets to choose
          // which side Bob throws away.
          //
          // Therefore, Alice can continue with either side.
          //
          // The immediate score is the common sum.
          // We take whichever continuation gives the better result.
          // --------------------------------------------------------
          else {
            final int leftScore = leftSum + dp[l][k];
            final int rightScore = rightSum + dp[k + 1][r];

            final int score =
                leftScore > rightScore ? leftScore : rightScore;

            if (score > best) {
              best = score;
            }
          }
        }

        // Store the best result for this interval.
        dp[l][r] = best;
      }
    }

    // The answer is the best score for the entire array.
    return dp[0][n - 1];
  }
}