class Solution:
    # Modulo constant to prevent integer overflow
    MOD = 10 ** 9 + 7

    def minMaxSums(self, nums: List[int], k: int) -> int:
        # Sort the array so we can reason about min/max positions
        nums.sort()
        
        # Number of elements
        n = len(nums)
        
        # This will store the final answer
        total = 0
        
        # --------------------------------------------------
        # STEP 1: Precompute combinations (nCr)
        # dp[i][j] = number of ways to choose j elements from i elements
        # --------------------------------------------------
        
        # Create a DP table of size (n+1) x (k+1)
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        
        # Base case:
        # There is exactly 1 way to choose 0 elements from any number of elements
        for i in range(n + 1):
            dp[i][0] = 1
        
        # Fill the combination table using Pascal's identity:
        # C(i, j) = C(i-1, j) + C(i-1, j-1)
        for i in range(1, n + 1):
            # j cannot exceed i or k
            for j in range(1, min(i + 1, k + 1)):
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % self.MOD
        
        # --------------------------------------------------
        # STEP 2: Calculate contribution of each element
        # --------------------------------------------------
        
        # For each element nums[i]:
        # 1) Count how many subsets make it the MIN
        # 2) Count how many subsets make it the MAX
        for i in range(n):
            for j in range(1, k + 1):
                # --------------------------------------------------
                # nums[i] as the MAX element
                # We choose (j-1) elements from the left side [0 ... i-1]
                # so total subset size becomes j
                # --------------------------------------------------
                total = (total + nums[i] * dp[i][j - 1]) % self.MOD
                
                # --------------------------------------------------
                # nums[i] as the MIN element
                # We choose (j-1) elements from the right side [i+1 ... n-1]
                # --------------------------------------------------
                total = (total + nums[i] * dp[n - i - 1][j - 1]) % self.MOD
        
        # Return final result modulo MOD
        return total
