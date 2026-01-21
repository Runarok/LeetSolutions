mod = 10 ** 9 + 7
# Precompute powers of 2
pw = list(accumulate(range(10 ** 5), func=lambda a, _: (a << 1) % mod, initial=1))
# Precompute bit counts (population count)
ppc = list(map(int.bit_count, range(1 << 20)))
# Precompute count trailing zeros for fast subset iteration in brute force
ctz = [(i & -i).bit_length() - 1 for i in range(1 << 20)]

class Solution:
    def countEffective(self, l: List[int]) -> int:
        # Optimization 1: Handle identical elements
        # If all elements are the same, we avoid the heavy DP overhead.
        if len(set(l)) == 1:
            return 1 if l[0] > 0 else 0

        n = len(l)
        m = reduce(or_, l)  # Calculate Total OR
        bl = m.bit_length()  # Determine bit length
        bit = 1 << bl

        # Optimization 2: Brute force for small N
        # If N is smaller than the bit length, O(2^N) is significantly 
        # faster than the O(bl * 2^bl) required for SOS DP.
        if n <= bl:
            bit = 1 << n
            dp = [0] * bit
            # Standard subset iteration DP: dp[mask] = OR sum of subset 'mask'
            for b in range(1, bit):
                # Transition: OR of (subset without lowest bit) | (element at lowest bit index)
                dp[b] = dp[b & (b - 1)] | l[ctz[b]]

            # Complementary counting: Total subsets - Subsets with equal OR
            return bit - sum(v == m for v in dp)

        # Initialize frequency array
        cnt = [0] * bit
        for v in l: cnt[v] += 1

        # SOS DP: Propagate counts
        for k in range(bl):
            b = bb = 1 << k
            # Iterate only masks where k-th bit is 1 (Trick 1)
            while b < bit:
                cnt[b] += cnt[b ^ bb]
                b = (b + 1) | bb

        ans = 0
        sub = m
        # PIE: Iterate over submasks (Trick 2)
        while True:
            # If missing bits (ppc[m^sub]) is odd, subtract; else add.
            term = pw[cnt[sub]]
            if ppc[m ^ sub] & 1:
                ans -= term
            else:
                ans += term

            if sub == 0: break
            sub = (sub - 1) & m

        # Ans now holds the count of subsets with OR == Total OR
        # Result = Total subsets (2^n) - Ineffective subsets
        return (pw[n] - ans) % mod