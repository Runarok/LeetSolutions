from typing import List
import heapq

class Solution:
    def minCost(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        # Directions: right, left, down, up
        directions = [
            [0, 1],  # right
            [0, -1], # left
            [1, 0],  # down
            [-1, 0], # up
        ]

        # Check if there is already a valid path with no changes
        def is_valid_path() -> bool:
            visited = [[False] * n for _ in range(m)]
            queue = [(0, 0)]  # starting point
            visited[0][0] = True

            while queue:
                x, y = queue.pop(0)
                dir_idx = grid[x][y] - 1
                dx, dy = directions[dir_idx]
                nx, ny = x + dx, y + dy

                if nx == m - 1 and ny == n - 1:
                    return True  # If we reach bottom-right, return True
                
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    visited[nx][ny] = True
                    queue.append((nx, ny))

            return False

        # If a valid path exists without any changes, return 0
        if is_valid_path():
            return 0

        # If no valid path, use a priority queue approach to find the minimum cost
        cost = [[float('inf')] * n for _ in range(m)]
        cost[0][0] = 0
        pq = [(0, 0, 0)]  # (cost, x, y)
        
        while pq:
            cur_cost, x, y = heapq.heappop(pq)

            # If we've reached the bottom-right corner, return the cost
            if x == m - 1 and y == n - 1:
                return cur_cost

            # Try to follow the current direction (do not change it)
            cur_dir = grid[x][y] - 1
            dx, dy = directions[cur_dir]
            nx, ny = x + dx, y + dy

            # If within bounds and following the direction is cheaper, update
            if 0 <= nx < m and 0 <= ny < n and cur_cost < cost[nx][ny]:
                cost[nx][ny] = cur_cost
                heapq.heappush(pq, (cur_cost, nx, ny))

            # Now, consider changing the direction (each change costs 1)
            for i in range(4):
                if i == cur_dir:
                    continue  # Skip the current direction

                dx, dy = directions[i]
                nx, ny = x + dx, y + dy

                if 0 <= nx < m and 0 <= ny < n and cur_cost + 1 < cost[nx][ny]:
                    cost[nx][ny] = cur_cost + 1
                    heapq.heappush(pq, (cur_cost + 1, nx, ny))

        return -1  # In case there's no path (though this case shouldn't happen in a valid grid)
