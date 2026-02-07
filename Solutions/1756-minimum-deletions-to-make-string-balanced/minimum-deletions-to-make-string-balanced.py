class Solution:
    def minimumDeletions(self, s: str) -> int:
        # Length of the string
        n = len(s)

        # count_a[i] will store how many 'a's are to the RIGHT of index i
        count_a = [0] * n

        # count_b[i] will store how many 'b's are to the LEFT of index i
        count_b = [0] * n

        # Counter to keep track of how many 'b's we have seen so far
        b_count = 0

        # --------------------------------------------------
        # First pass (left → right)
        # --------------------------------------------------
        # For each position i:
        #   - store how many 'b's appeared before i
        #   - then update b_count if current char is 'b'
        for i in range(n):
            count_b[i] = b_count   # 'b's to the left of i
            if s[i] == "b":
                b_count += 1

        # Counter to keep track of how many 'a's we have seen so far (from right)
        a_count = 0

        # --------------------------------------------------
        # Second pass (right → left)
        # --------------------------------------------------
        # For each position i:
        #   - store how many 'a's appeared after i
        #   - then update a_count if current char is 'a'
        for i in range(n - 1, -1, -1):
            count_a[i] = a_count   # 'a's to the right of i
            if s[i] == "a":
                a_count += 1

        # Initialize minimum deletions with the worst case (delete everything)
        min_deletions = n

        # --------------------------------------------------
        # Third pass
        # --------------------------------------------------
        # At each index i, imagine splitting the string:
        #   - delete all 'b's on the left side
        #   - delete all 'a's on the right side
        # Total deletions = count_b[i] + count_a[i]
        for i in range(n):
            min_deletions = min(min_deletions, count_a[i] + count_b[i])

        # Return the minimum deletions needed
        return min_deletions
