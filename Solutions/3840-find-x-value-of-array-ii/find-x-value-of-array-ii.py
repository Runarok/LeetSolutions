from typing import List

class SegmentTree:
    """
    Segment Tree class to maintain products modulo k and prefix remainder counts.
    
    Since k is very small (1 <= k <= 5), each node in the segment tree stores:
    1. `tree_prod[node]`: The total product of elements in this segment modulo k.
    2. `tree_cnt[node][rem][x]`: The total number of valid non-empty prefixes within 
       this segment such that, if an initial accumulated remainder `rem` enters 
       the segment from the left, the prefix product modulo k equals `x`.
    """
    def __init__(self, data: List[int], k: int):
        self.n = len(data)
        self.k = k
        # Total product modulo k for each node
        self.tree_prod = [1] * (4 * self.n)
        # DP state matrix for each node: shape [4 * n][k][k]
        self.tree_cnt = [[[0] * k for _ in range(k)] for _ in range(4 * self.n)]
        
        # Build the initial segment tree from input array
        self._build(data, 1, 0, self.n - 1)

    def _merge(self, node: int, left_child: int, right_child: int):
        """
        Combines information from left and right child nodes into the parent node.
        """
        k = self.k
        # Total product of combined segment modulo k
        self.tree_prod[node] = (self.tree_prod[left_child] * self.tree_prod[right_child]) % k
        
        # For each possible incoming remainder from the left side
        for rem in range(k):
            for x in range(k):
                # Case 1: Valid non-empty prefix ends strictly within the left child segment.
                left_contribution = self.tree_cnt[left_child][rem][x]
                
                # Case 2: Valid non-empty prefix extends into the right child segment.
                # The remainder entering the right child will be the original incoming `rem` 
                # multiplied by the total product of all elements in the left child.
                new_rem = (rem * self.tree_prod[left_child]) % k
                right_contribution = self.tree_cnt[right_child][new_rem][x]
                
                # Combine both valid prefix occurrences
                self.tree_cnt[node][rem][x] = left_contribution + right_contribution

    def _build(self, data: List[int], node: int, start: int, end: int):
        """
        Recursively builds the segment tree bottom-up.
        """
        # Leaf node base case
        if start == end:
            val = data[start] % self.k
            self.tree_prod[node] = val
            # A leaf represents a single element (a single non-empty prefix)
            for rem in range(self.k):
                resulting_rem = (rem * val) % self.k
                self.tree_cnt[node][rem][resulting_rem] = 1
            return

        mid = (start + end) // 2
        # Recursively construct left and right subtrees
        self._build(data, 2 * node, start, mid)
        self._build(data, 2 * node + 1, mid + 1, end)
        # Combine child states into current parent node
        self._merge(node, 2 * node, 2 * node + 1)

    def update(self, node: int, start: int, end: int, idx: int, val: int):
        """
        Updates a single index `idx` in the array with new value `val`.
        Time Complexity: O(k^2 * log N)
        """
        # Reached target leaf node
        if start == end:
            val_mod = val % self.k
            self.tree_prod[node] = val_mod
            # Clear old state counts
            for rem in range(self.k):
                for x in range(self.k):
                    self.tree_cnt[node][rem][x] = 0
            # Set updated single prefix count
            for rem in range(self.k):
                resulting_rem = (rem * val_mod) % self.k
                self.tree_cnt[node][rem][resulting_rem] = 1
            return

        mid = (start + end) // 2
        # Traverse left or right based on target index
        if start <= idx <= mid:
            self.update(2 * node, start, mid, idx, val)
        else:
            self.update(2 * node + 1, mid + 1, end, idx, val)

        # Re-merge updated child states back up to root
        self._merge(node, 2 * node, 2 * node + 1)

    def query(self, node: int, start: int, end: int, ql: int, qr: int, incoming_rem: int):
        """
        Queries range [ql, qr] starting with `incoming_rem` modulo k.
        Returns:
            - A list of length `k` where index `x` holds the count of valid 
              prefixes resulting in remainder `x`.
            - The overall product of elements in range [ql, qr] modulo k.
        """
        # Always modulo k to handle edge case when k = 1 (where 1 % 1 = 0)
        incoming_rem %= self.k

        # Current segment completely fits inside query range
        if ql <= start and end <= qr:
            return self.tree_cnt[node][incoming_rem], self.tree_prod[node]

        mid = (start + end) // 2
        
        # Range lies purely in left child
        if qr <= mid:
            return self.query(2 * node, start, mid, ql, qr, incoming_rem)
        # Range lies purely in right child
        if ql > mid:
            return self.query(2 * node + 1, mid + 1, end, ql, qr, incoming_rem)

        # Range overlaps across both left and right children
        left_cnts, left_prod = self.query(2 * node, start, mid, ql, qr, incoming_rem)
        
        # New incoming remainder passed into the right segment
        new_incoming_rem = (incoming_rem * left_prod) % self.k
        right_cnts, right_prod = self.query(2 * node + 1, mid + 1, end, ql, qr, new_incoming_rem)

        # Merge prefix counts from both sub-queries
        combined_cnts = [left_cnts[x] + right_cnts[x] for x in range(self.k)]
        combined_prod = (left_prod * right_prod) % self.k

        return combined_cnts, combined_prod


class Solution:
    def resultArray(self, nums: List[int], k: int, queries: List[List[int]]) -> List[int]:
        n = len(nums)
        
        # Initialize segment tree over input array
        seg_tree = SegmentTree(nums, k)
        result = []
        
        # Process each query sequentially
        for index_i, value_i, start_i, x_i in queries:
            # 1. Update nums[index_i] to value_i (persists for subsequent queries)
            seg_tree.update(1, 0, n - 1, index_i, value_i)
            
            # 2. Query range [start_i, n - 1] with initial multiplication factor of 1 (1 % k)
            prefix_counts, _ = seg_tree.query(1, 0, n - 1, start_i, n - 1, 1 % k)
            
            # 3. Retrieve answer count corresponding to target remainder x_i
            result.append(prefix_counts[x_i])
            
        return result