class Solution:
    def minOperations(self, nums: List[int], k: int, queries: List[List[int]]) -> List[int]:
        n = len(nums)  # Length of input array
        
        # -------- 1. Feasibility Check (Prefix Sum Trick) --------
        # Some queries are impossible to solve (differences in mod k values)
        bad = [0]  # Prefix array: bad[i] counts number of consecutive changes in nums[i] % k
        pv = -1    # Previous modulo value
        p = 0      # Counter of changes
        for x in nums:
            v = x % k
            p += (v != pv)  # Increment when modulo changes
            bad.append(p)   # bad[i] will be > 0 if impossible
            pv = v

        # -------- 2. Discretization & Mo’s Setup --------
        # Convert values to integers for efficient frequency BIT handling
        vals = [x // k for x in nums]             # Normalize numbers by k
        sorted_vals = sorted(list(set(vals)))     # Unique sorted values for ranking
        rank_map = {v: i for i, v in enumerate(sorted_vals, 1)}  # Map values to 1-based ranks
        m = len(sorted_vals)                      # Number of unique values

        # Determine block size for Mo’s algorithm (approx n / sqrt(q))
        block_size = max(1, n // int(len(queries)**0.5 or 1))
        
        # Sort queries for Mo’s order: (block_index, right, left, original_index)
        sorted_queries = [(s // block_size, t, s, i) for i, (s, t) in enumerate(queries)]
        # Odd-even trick: even blocks sorted by right ascending, odd blocks descending
        sorted_queries.sort(key=lambda x: (x[0], x[1] if x[0] & 1 else -x[1]))

        # -------- 3. Fenwick Tree (BIT) & State --------
        cnt_bit = [0] * (m + 1)  # BIT for frequencies of ranks
        sum_bit = [0] * (m + 1)  # BIT for sum of values for ranks
        curr_cnt = 0              # Current total count in window
        curr_sum = 0              # Current total sum in window

        # Helper to update BIT when adding/removing a value
        def update(i, delta):
            nonlocal curr_cnt, curr_sum
            v = vals[i]                    # Value at index i
            rank = rank_map[v]             # Rank of value
            
            val_delta = delta * v          # Delta for sum
            curr_cnt += delta              # Update total count
            curr_sum += val_delta          # Update total sum
            
            # Standard BIT update
            while rank <= m:
                sum_bit[rank] += val_delta
                cnt_bit[rank] += delta
                rank += rank & -rank      # Move to next index in BIT

        # -------- 4. Process Queries using Mo’s Algorithm --------
        ans = [-1] * len(queries)
        l, r = 0, -1                       # Current window [l, r]
        highest_bit = 1 << (m.bit_length() - 1)  # Used for binary lifting to find median

        for _, q_end, q_start, q_idx in sorted_queries:
            # --- Prune impossible queries ---
            if bad[q_end + 1] - bad[q_start + 1]:
                continue  # If there’s a modulo change, this range is impossible

            # --- Adjust current window to [q_start, q_end] ---
            while l > q_start:
                l -= 1
                update(l, 1)  # Add element at left
            while r < q_end:
                r += 1
                update(r, 1)  # Add element at right
            while l < q_start:
                update(l, -1) # Remove element from left
                l += 1
            while r > q_end:
                update(r, -1) # Remove element from right
                r -= 1

            # --- Find Median using Binary Lifting on BIT ---
            # Goal: find largest prefix where count <= curr_cnt / 2
            idx = 0
            prefix_cnt = 0  # Count of elements <= current idx
            prefix_sum = 0  # Sum of elements <= current idx
            mask = highest_bit
            target = curr_cnt >> 1  # Half the total elements
            
            while mask:
                next_idx = idx + mask
                if next_idx <= m and prefix_cnt + cnt_bit[next_idx] <= target:
                    idx = next_idx
                    prefix_cnt += cnt_bit[idx]
                    prefix_sum += sum_bit[idx]
                mask >>= 1  # Move to smaller bit

            # Median value for current window
            median = sorted_vals[idx]

            # Split into left and right sums relative to median
            suf_sum = curr_sum - prefix_sum   # Sum of elements > median
            suf_cnt = curr_cnt - prefix_cnt   # Count of elements > median

            # --- Calculate minimum operations to equalize to median ---
            # Cost formula: 
            # sum((x - median) for x > median) + sum((median - x) for x < median)
            ans[q_idx] = (suf_sum - median * suf_cnt + median * prefix_cnt - prefix_sum)

        return ans
