class Solution:
    def score(self, A: List[str], X: str) -> int:
        """
        Compute the maximum "score" based on pairs involving a target character X.
        
        Parameters:
        A : List[str] - list of 2-character strings (pairs)
        X : str       - target character (the "wild" or focus character)
        
        Returns:
        int - maximum score according to the rules
        """
        
        # -----------------------------
        # Step 1: Count wild pairs and one-sided pairs
        # -----------------------------
        wilds = 0               # Count of pairs where both letters are X (can be used anywhere)
        countL = [0] * 10       # Count of pairs where left letter is X, right is some other (max 10 letters assumed)
        countR = [0] * 10       # Count of pairs where right letter is X, left is some other
        
        for x, y in A:
            if x == y == X:
                # Both letters are X: fully wild, can be matched flexibly
                wilds += 1
            elif x == X:
                # Left letter is X, right is some other
                countL[ord(y) - 97] += 1  # Convert letter to 0-based index ('a' -> 0)
            elif y == X:
                # Right letter is X, left is some other
                countR[ord(x) - 97] += 1

        # -----------------------------
        # Step 2: Calculate max pairs from one-sided counts
        # -----------------------------
        pairs = 0  # Number of pairs formed without using fully wild pairs
        free = 0   # Remaining single letters that can potentially combine with wilds
        
        for count in [countL, countR]:
            s = sum(count)       # Total letters in this side
            m = max(count)       # Max count for any single letter
            # Number of pairs we can form: limited by min of "other letters" and total // 2
            # Explanation: for letters [a,b,c,...], max number of pairs = min(total - max_count, total // 2)
            p = min(s - m, s // 2)
            pairs += p
            free += s - 2 * p    # Letters left unpaired that can later pair with wilds

        # -----------------------------
        # Step 3: Use fully wild pairs to fill free letters
        # -----------------------------
        # First, pair wilds with leftover free letters
        used = min(wilds, free)
        wilds -= used

        # Then, use remaining wilds to form new pairs among themselves
        # Each new pair consumes 2 wilds
        extra = min(pairs, wilds // 2)

        # -----------------------------
        # Step 4: Compute final score
        # -----------------------------
        # Score = pairs from original letters + wilds used with free letters + extra wild pairs
        return pairs + used + extra
