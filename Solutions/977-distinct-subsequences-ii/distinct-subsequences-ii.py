class Solution:
    def distinctSubseqII(self, s: str) -> int:
        MOD = 10**9 + 7

        # dp[i] = number of distinct subsequences we can form
        # using the first i characters, INCLUDING the empty subsequence.
        #
        # We start with dp[0] = 1 because the empty string is
        # the only subsequence of an empty string.
        dp = [0] * (len(s) + 1)
        dp[0] = 1

        # last[c] stores the dp value from the last time
        # character c appeared.
        #
        # This helps us remove subsequences that would be
        # counted twice because of repeated characters.
        last = [0] * 26

        for i, ch in enumerate(s, 1):
            c = ord(ch) - ord('a')

            # Every existing subsequence can either:
            # 1. Stay as it is
            # 2. Add the current character to its end
            #
            # Therefore, without worrying about duplicates,
            # we would have:
            #
            #     dp[i] = 2 * dp[i - 1]
            #
            # However, if this character appeared before,
            # some of these new subsequences have already
            # been created previously.
            #
            # last[c] contains exactly the number of subsequences
            # that were present before the previous occurrence
            # of this character. Those are the duplicates.
            dp[i] = 2 * dp[i - 1] - last[c]

            # Keep the value modulo MOD.
            dp[i] %= MOD

            # For the next occurrence of this character, the
            # subsequences that existed BEFORE the current
            # character are exactly dp[i - 1].
            last[c] = dp[i - 1]

        # dp[n] includes the empty subsequence.
        # The problem asks for NON-EMPTY subsequences,
        # so subtract 1.
        return (dp[len(s)] - 1) % MOD
