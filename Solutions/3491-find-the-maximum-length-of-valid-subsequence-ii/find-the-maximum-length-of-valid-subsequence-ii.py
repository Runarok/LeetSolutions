from collections import defaultdict

class Solution:
    def maximumLength(self, nums: list[int], k: int) -> int:
        n = len(nums)
        
        # dp[i] maps: {mod value -> length of longest valid subsequence ending at index i with this mod}
        dp = [defaultdict(int) for _ in range(n)]
        
        max_len = 1  # At least each number alone forms a subsequence of length 1

        # Iterate through all pairs of elements (i, j) where i < j
        for j in range(n):
            for i in range(j):
                # Calculate (nums[i] + nums[j]) % k
                mod = (nums[i] + nums[j]) % k

                # Previous best length at index i for this mod value
                prev_len = dp[i][mod] if mod in dp[i] else 1

                # Update the best length at index j with this mod
                # We extend the sequence by including nums[j]
                dp[j][mod] = max(dp[j][mod], prev_len + 1)

                # Update the overall max length
                max_len = max(max_len, dp[j][mod])
        
        return max_len
