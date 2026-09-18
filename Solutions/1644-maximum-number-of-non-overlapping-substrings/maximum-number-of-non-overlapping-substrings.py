class Solution:
    def maxNumOfSubstrings(self, s: str) -> list[str]:
        n = len(s)
        
        # Step 1: Track the first and last occurrence index for each character 'a' through 'z'
        first = {}
        last = {}
        for idx, char in enumerate(s):
            if char not in first:
                first[char] = idx
            last[char] = idx

        # Helper function to check and expand a valid interval starting at 'i'
        def get_valid_right_bound(start_idx: int) -> int:
            right_bound = last[s[start_idx]]
            curr = start_idx
            
            while curr <= right_bound:
                char = s[curr]
                
                # If a character inside our range started BEFORE start_idx,
                # this interval cannot be a valid candidate starting at start_idx.
                if first[char] < start_idx:
                    return -1
                
                # Extend the right boundary to include all occurrences of current character
                right_bound = max(right_bound, last[char])
                curr += 1
                
            return right_bound

        # Step 2: Collect all minimal valid intervals [l, r]
        valid_intervals = []
        for char in set(s):
            l = first[char]
            r = get_valid_right_bound(l)
            if r != -1:
                valid_intervals.append((l, r))

        # Step 3: Sort valid intervals by their END index (greedy strategy)
        valid_intervals.sort(key=lambda x: x[1])

        # Step 4: Pick non-overlapping intervals greedily
        result = []
        last_end = -1
        
        for l, r in valid_intervals:
            # If the current interval starts after the previously chosen interval ends
            if l > last_end:
                result.append(s[l : r + 1])
                last_end = r

        return result