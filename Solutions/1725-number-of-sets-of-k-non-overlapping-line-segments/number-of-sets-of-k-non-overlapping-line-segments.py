class Solution:
    def numberOfSets(self, n: int, k: int) -> int:
        """
        Calculates the number of ways to draw k non-overlapping segments using n points.
        
        Complexity:
            - Time Complexity: O(k) using math.comb or modular inverse.
            - Space Complexity: O(1) auxiliary space.
        """
        MOD = 10**9 + 7
        
        # Total items (n + k - 1) choose (2 * k)
        N = n + k - 1
        R = 2 * k
        
        # If 2k > N, it's impossible to draw k segments.
        if R > N:
            return 0
            
        # Compute combinations nCr modulo 10^9 + 7
        num = 1
        den = 1
        
        for i in range(1, R + 1):
            num = (num * (N - i + 1)) % MOD
            den = (den * i) % MOD
            
        # Using Fermat's Little Theorem for modular division: den^(-1) ≡ den^(MOD-2) mod MOD
        return (num * pow(den, MOD - 2, MOD)) % MOD