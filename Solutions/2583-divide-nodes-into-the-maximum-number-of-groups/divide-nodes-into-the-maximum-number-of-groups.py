from collections import deque
from typing import List

class Solution:
    def magnificentSets(self, n: int, edges: List[List[int]]) -> int:
        # Create adjacency list for the graph
        adj_list = [[] for _ in range(n)]
        for u, v in edges:
            u -= 1  # Convert to 0-based index
            v -= 1
            adj_list[u].append(v)
            adj_list[v].append(u)

        # Initialize color array for bipartiteness check
        colors = [-1] * n
        visited = [False] * n
        max_groups = 0

        # Check if graph is bipartite and process each connected component
        for node in range(n):
            if visited[node]:  # Skip already processed components
                continue

            # Collect nodes in this component
            component = []
            if not self._is_bipartite(adj_list, node, colors, component):
                return -1  # Not bipartite, return -1

            # Compute max shortest-path depth in this component
            max_depth = max(self._get_longest_shortest_path(adj_list, start, n) for start in component)
            max_groups += max_depth  # Add max groups in this component

            # Mark component nodes as visited
            for v in component:
                visited[v] = True

        return max_groups

    def _is_bipartite(self, adj_list: List[List[int]], start: int, colors: List[int], component: List[int]) -> bool:
        """ Checks if the graph is bipartite using BFS and collects component nodes. """
        queue = deque([start])
        colors[start] = 0
        component.append(start)

        while queue:
            node = queue.popleft()
            for neighbor in adj_list[node]:
                if colors[neighbor] == colors[node]:  # Conflict detected, not bipartite
                    return False
                if colors[neighbor] == -1:
                    colors[neighbor] = 1 - colors[node]
                    queue.append(neighbor)
                    component.append(neighbor)

        return True

    def _get_longest_shortest_path(self, adj_list: List[List[int]], src: int, n: int) -> int:
        """ Computes the longest shortest path (height of BFS tree) from src. """
        queue = deque([src])
        visited = [-1] * n
        visited[src] = 0
        max_dist = 0

        while queue:
            node = queue.popleft()
            for neighbor in adj_list[node]:
                if visited[neighbor] == -1:
                    visited[neighbor] = visited[node] + 1
                    max_dist = max(max_dist, visited[neighbor])
                    queue.append(neighbor)

        return max_dist + 1  # Convert to 1-based count

        