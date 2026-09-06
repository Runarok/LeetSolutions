class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        
        # ---------------------------------------------------------
        # dp[j] = number of ways to form t[:j] using the characters
        #         of s that we have processed so far.
        #
        # For example:
        #
        # s = "babgbag"
        # t = "bag"
        #
        # dp[0] = 1 because there is exactly ONE way to form
        #         an empty string: choose nothing.
        #
        # dp[1] = number of ways to form "b"
        # dp[2] = number of ways to form "ba"
        # dp[3] = number of ways to form "bag"
        # ---------------------------------------------------------
        
        m = len(t)
        
        # We only need m + 1 positions because t has m characters.
        # Initially:
        #
        # dp = [1, 0, 0, ..., 0]
        #
        # dp[0] = 1
        # dp[j] = 0 for j > 0
        #
        # This means:
        # - There is 1 way to create ""
        # - There are 0 ways to create a non-empty string
        #   before processing any characters from s.
        dp = [0] * (m + 1)
        dp[0] = 1
        
        # ---------------------------------------------------------
        # Process every character of s one at a time.
        # ---------------------------------------------------------
        for ch in s:
            
            # -----------------------------------------------------
            # We iterate BACKWARDS through t.
            #
            # Why backwards?
            #
            # Because dp[j - 1] represents the number of ways to
            # form t[:j-1] BEFORE using the current character of s.
            #
            # If we went forwards, dp[j - 1] might already have
            # been updated using the current character, which would
            # accidentally allow us to use the same character from
            # s more than once.
            #
            # Example:
            #
            # s = "aa"
            # t = "aa"
            #
            # When processing the second 'a', we want to use the
            # FIRST 'a' to form "a", and the SECOND 'a' to complete
            # "aa".
            #
            # Going backwards guarantees this.
            # -----------------------------------------------------
            for j in range(m, 0, -1):
                
                # -------------------------------------------------
                # If the current character from s matches the
                # character we need in t, we have a choice:
                #
                # 1. USE this character from s
                #
                #    dp[j - 1] ways of forming t[:j-1]
                #    become ways of forming t[:j].
                #
                # 2. DON'T USE this character
                #
                #    dp[j] already contains all the ways we had
                #    before seeing this character.
                #
                # So if characters match:
                #
                # dp[j] += dp[j - 1]
                #
                # -------------------------------------------------
                if ch == t[j - 1]:
                    dp[j] += dp[j - 1]
        
        # ---------------------------------------------------------
        # dp[m] contains the number of ways to form the ENTIRE
        # string t using characters from s.
        # ---------------------------------------------------------
        return dp[m]
