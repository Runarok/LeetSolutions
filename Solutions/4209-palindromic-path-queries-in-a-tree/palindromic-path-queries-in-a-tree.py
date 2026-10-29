import sys

# Increase recursion depth for deep trees (up to 50,000 nodes)
sys.setrecursionlimit(200000)

class SegmentTree:
    """
    A Segment Tree supporting point updates and range XOR sum queries.
    """
    def __init__(self, size, initial_values):
        self.n = size
        self.tree = [0] * (4 * size)
        if initial_values:
            self._build(1, 0, size - 1, initial_values)

    def _build(self, node, start, end, values):
        if start == end:
            self.tree[node] = values[start]
            return
        mid = (start + end) // 2
        self._build(2 * node, start, mid, values)
        self._build(2 * node + 1, mid + 1, end, values)
        self.tree[node] = self.tree[2 * node] ^ self.tree[2 * node + 1]

    def update(self, node, start, end, idx, val):
        """Update the value at index `idx` to `val`."""
        if start == end:
            self.tree[node] = val
            return
        mid = (start + end) // 2
        if start <= idx <= mid:
            self.update(2 * node, start, mid, idx, val)
        else:
            self.update(2 * node + 1, mid + 1, end, idx, val)
        self.tree[node] = self.tree[2 * node] ^ self.tree[2 * node + 1]

    def query(self, node, start, end, l, r):
        """Query the XOR sum in the range [l, r]."""
        if r < start or end < l:
            return 0
        if l <= start and end <= r:
            return self.tree[node]
        mid = (start + end) // 2
        p1 = self.query(2 * node, start, mid, l, r)
        p2 = self.query(2 * node + 1, mid + 1, end, l, r)
        return p1 ^ p2


class Solution:
    def palindromePath(self, n: int, edges: list[list[int]], s: str, queries: list[str]) -> list[bool]:
        # Step 1: Build adjacency list for the tree
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
        
        # Convert string to mutable list of character codes (0 to 25)
        s_chars = [ord(c) - ord('a') for c in s]
        
        # Arrays for HLD preprocessing
        parent = [0] * n
        depth = [0] * n
        heavy = [-1] * n
        head = [0] * n
        pos = [0] * n
        sub_size = [0] * n
        
        # Step 2: First DFS to compute subtree sizes, depths, parents, and heavy children
        def dfs1(u, p, d):
            parent[u] = p
            depth[u] = d
            sub_size[u] = 1
            max_sub = 0
            for v in adj[u]:
                if v != p:
                    dfs1(v, u, d + 1)
                    sub_size[u] += sub_size[v]
                    if sub_size[v] > max_sub:
                        max_sub = sub_size[v]
                        heavy[u] = v
        
        dfs1(0, -1, 0)
        
        # Step 3: Second DFS to assign segment tree positions and chain heads
        cur_pos = 0
        def dfs2(u, h):
            nonlocal cur_pos
            head[u] = h
            pos[u] = cur_pos
            cur_pos += 1
            
            # Traverse heavy child first so heavy path indices are contiguous
            if heavy[u] != -1:
                dfs2(heavy[u], h)
            
            # Traverse light children
            for v in adj[u]:
                if v != parent[u] and v != heavy[u]:
                    dfs2(v, v)
        
        dfs2(0, 0)
        
        # Step 4: Initialize Segment Tree with initial character bitmasks at HLD positions
        initial_values = [0] * n
        for i in range(n):
            initial_values[pos[i]] = 1 << s_chars[i]
            
        seg_tree = SegmentTree(n, initial_values)
        
        # Helper function to query path XOR sum between u and v using HLD
        def query_path(u, v):
            res = 0
            while head[u] != head[v]:
                if depth[head[u]] < depth[head[v]]:
                    u, v = v, u
                res ^= seg_tree.query(1, 0, n - 1, pos[head[u]], pos[u])
                u = parent[head[u]]
            if depth[u] > depth[v]:
                u, v = v, u
            res ^= seg_tree.query(1, 0, n - 1, pos[u], pos[v])
            return res

        # Step 5: Process all queries
        answer = []
        for q in queries:
            parts = q.split()
            if parts[0] == "update":
                u = int(parts[1])
                c_val = ord(parts[2]) - ord('a')
                s_chars[u] = c_val
                # Update the segment tree at the HLD position of node u
                seg_tree.update(1, 0, n - 1, pos[u], 1 << c_val)
            else:
                u = int(parts[1])
                v = int(parts[2])
                path_mask = query_path(u, v)
                # A bitmask represents a palindrome-rearrangable string if it has <= 1 set bit
                # Bitwise trick: (mask & (mask - 1)) == 0 checks if mask has at most 1 set bit.
                if path_mask == 0 or (path_mask & (path_mask - 1)) == 0:
                    answer.append(True)
                else:
                    answer.append(False)
                    
        return answer