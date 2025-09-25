from typing import List

class Solution:
    def minimumTotal(self, triangle: List[List[int]]) -> int:
        # Edge case: if the triangle is empty
        if not triangle:
            return 0

        # Number of rows in the triangle
        n = len(triangle)

        # Initialize a 1D DP array with the last row of the triangle
        # We do this because the minimum path sum at the bottom is the value itself
        dp = triangle[-1][:]  # Make a copy to avoid modifying the original triangle

        # Start from the second-last row and move upwards
        for row in range(n - 2, -1, -1):
            # Iterate over each element in the current row
            for col in range(len(triangle[row])):
                # Update dp[col] with the minimum path sum from this cell to the bottom
                # Choose the minimum between the two adjacent numbers in the row below
                dp[col] = triangle[row][col] + min(dp[col], dp[col + 1])

        # After processing all rows, dp[0] will contain the minimum path sum
        return dp[0]
