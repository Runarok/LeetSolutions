class Solution:
    def uniquePaths(self, grid: List[List[int]]) -> int:
        """
        Calculates the number of unique valid paths from (0, 0) to (m - 1, n - 1)
        in a grid containing empty cells (0) and mirrors (1) with reflection rules.
        """
        MOD = 10**9 + 7
        m, n = len(grid), len(grid[0])
        
        # dp[c] will store [ways_moving_right, ways_moving_down] entering column c
        # We use a 1-indexed DP array of size n + 1 for convenience.
        dp = [[0, 0] for _ in range(n + 1)]
        
        # Base setup: Starting at (0, 0)
        # Assuming we can think of coming into the first cell from both directions as 1 initialization,
        # or properly priming the DP table.
        dp[1] = [1, 1]
        
        for r in range(m):
            for c in range(n):
                col_idx = c + 1
                
                # If the current cell is a mirror (1)
                if grid[r][c] == 1:
                    # When hitting a mirror:
                    # - A path coming from the left (moving right) gets reflected down.
                    # - A path coming from above (moving down) gets reflected right.
                    # Thus, the new states swap and pass through based on reflection rules.
                    dp[col_idx] = [dp[col_idx][1], dp[col_idx - 1][0]]
                else:
                    # If it's an empty cell (0), standard grid transitions apply:
                    # - To move right into (r, c), it can come from the left cell moving right.
                    # - To move down into (r, c), it can come from the top cell moving down.
                    ways_right = dp[col_idx - 1][0]
                    ways_down = dp[col_idx][1]
                    
                    total_ways = (ways_right + ways_down) % MOD
                    dp[col_idx] = [total_ways, total_ways]
                    
        # The result is the total paths reaching the bottom-right cell (n-1)
        return dp[n][0]