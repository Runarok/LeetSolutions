class Solution:
    def longestSpecialPath(self, edges: List[List[int]], nums: List[int]) -> List[int]:
        # --------------------------------------------------
        # Build adjacency list for the tree
        # graph[u] = [(v, length), ...]
        # --------------------------------------------------
        graph = {}
        for a, b, l in edges:
            # Ensure both nodes exist in the graph
            graph[a] = graph.get(a, [])
            graph[b] = graph.get(b, [])
            
            # Undirected edge with length l
            graph[a].append((b, l))
            graph[b].append((a, l))

        # --------------------------------------------------
        # maxi[0] = maximum total distance found so far
        # maxi[1] = minimum number of nodes for that distance
        # (used as tie-breaker)
        # --------------------------------------------------
        maxi = [0, 10**13]

        # --------------------------------------------------
        # Keeps track of visited nodes (since this is a tree)
        # --------------------------------------------------
        seen = set()
        seen.add(0)  # start DFS from node 0

        # --------------------------------------------------
        # last_values[val] = last position (order) where
        # this value appeared in the current DFS path
        # Used to enforce uniqueness constraint
        # --------------------------------------------------
        last_values = {}

        # --------------------------------------------------
        # Stack representing the current DFS path
        # Stores nodes in order from root to current node
        # --------------------------------------------------
        seen_stack = []

        # --------------------------------------------------
        # dists[node] = distance from root (node 0)
        # --------------------------------------------------
        dists = {}

        def dfs(n, start_order, total_dist):
            # --------------------------------------------------
            # Record distance from root to current node
            # --------------------------------------------------
            dists[n] = total_dist

            # Push current node onto the DFS path stack
            seen_stack.append(n)

            # Current position in the stack (1-based index)
            order = len(seen_stack)

            # --------------------------------------------------
            # Check if current node's value has appeared before
            # --------------------------------------------------
            occur = last_values.get(nums[n])

            # If this value appeared within the current valid window,
            # move the window start forward
            if occur is not None and occur >= start_order:
                start_order = occur

            # Update last seen position of this value
            last_values[nums[n]] = order

            # --------------------------------------------------
            # Compute the distance and node count of the current
            # valid path segment
            # --------------------------------------------------
            # Distance = distance difference between endpoints
            total_size = dists[n] - dists[seen_stack[start_order]]

            # Number of nodes in the valid segment
            total_nodes = order - start_order

            # --------------------------------------------------
            # Update global answer
            # --------------------------------------------------
            if total_size > maxi[0]:
                maxi[0] = total_size
                maxi[1] = total_nodes
            elif total_size == maxi[0] and total_nodes < maxi[1]:
                maxi[1] = total_nodes

            # --------------------------------------------------
            # DFS to children
            # --------------------------------------------------
            for next_node, l in graph[n]:
                if next_node not in seen:
                    seen.add(next_node)
                    dfs(next_node, start_order, total_dist + l)

            # --------------------------------------------------
            # Backtracking step
            # Restore last_values and stack state
            # --------------------------------------------------
            last_values[nums[n]] = occur
            seen_stack.pop()

        # --------------------------------------------------
        # Start DFS from node 0
        # --------------------------------------------------
        dfs(0, 0, 0)

        # Return [max_distance, min_nodes]
        return maxi
