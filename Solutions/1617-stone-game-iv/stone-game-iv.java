class Solution {
    public boolean winnerSquareGame(int n) {

        // dp[i] tells us whether the current player
        // can win when there are exactly i stones.
        //
        // dp[i] = true  -> current player can force a win
        // dp[i] = false -> current player will lose
        boolean[] dp = new boolean[n + 1];

        // We calculate the result for every number
        // of stones from 1 up to n.
        for (int i = 1; i <= n; i++) {

            // Try removing every possible perfect square.
            //
            // j = 1 -> remove 1 stone
            // j = 2 -> remove 4 stones
            // j = 3 -> remove 9 stones
            // etc.
            //
            // We stop when j*j becomes greater than i,
            // because we cannot remove more stones than exist.
            for (int j = 1; j * j <= i; j++) {

                // If we remove j*j stones, there will be
                // (i - j*j) stones remaining.
                //
                // If that remaining position is losing
                // for the next player, then the current
                // player has found a winning move.
                if (!dp[i - j * j]) {

                    // Mark this position as winning.
                    dp[i] = true;

                    // No need to try other squares because
                    // we already found a move that guarantees
                    // a win.
                    break;
                }
            }
        }

        // Return whether Alice can win starting with n stones.
        return dp[n];
    }
}