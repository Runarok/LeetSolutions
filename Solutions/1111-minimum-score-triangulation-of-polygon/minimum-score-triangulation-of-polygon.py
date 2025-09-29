from typing import List

class Solution:
    def minScoreTriangulation(self, values: List[int]) -> int:
        n = len(values)
        
        # Initialize DP table with 0s
        # dp[i][j] will store the minimum score to triangulate the polygon from vertex i to j
        dp = [[0] * n for _ in range(n)]
        
        # We consider all sub-polygons with length >= 3 (i.e., j - i >= 2)
        # l is the length of the subpolygon
        for length in range(3, n + 1):  # from 3 to n
            for i in range(n - length + 1):
                j = i + length - 1
                dp[i][j] = float('inf')  # Initialize with infinity
                # Try all possible k to form triangle (i, k, j)
                for k in range(i + 1, j):
                    # cost of the triangle (i, k, j)
                    cost = values[i] * values[k] * values[j]
                    # total cost = triangle cost + cost of triangulating left and right parts
                    total = cost + dp[i][k] + dp[k][j]
                    dp[i][j] = min(dp[i][j], total)
                    # Debug print to trace computation (optional)
                    # print(f"dp[{i}][{j}] trying k={k}: cost={cost}, left={dp[i][k]}, right={dp[k][j]}, total={total}")
        
        # The final answer is the minimum cost to triangulate the full polygon
        return dp[0][n - 1]
