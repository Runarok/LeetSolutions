public class Solution {
    public bool HasValidPath(int[][] grid) {
        int m = grid.Length;
        int n = grid[0].Length;

        // visited array to avoid cycles
        bool[,] visited = new bool[m, n];

        // BFS queue
        Queue<(int, int)> queue = new Queue<(int, int)>();
        queue.Enqueue((0, 0));
        visited[0, 0] = true;

        // direction vectors: up, down, left, right
        int[][] dirs = new int[][] {
            new int[]{-1, 0}, // up
            new int[]{1, 0},  // down
            new int[]{0, -1}, // left
            new int[]{0, 1}   // right
        };

        // Map each street type to allowed directions (indices of dirs)
        Dictionary<int, int[]> streetMap = new Dictionary<int, int[]> {
            {1, new int[]{2, 3}}, // left, right
            {2, new int[]{0, 1}}, // up, down
            {3, new int[]{2, 1}}, // left, down
            {4, new int[]{3, 1}}, // right, down
            {5, new int[]{2, 0}}, // left, up
            {6, new int[]{3, 0}}  // right, up
        };

        // Helper: check if next cell connects back
        bool IsConnected(int fromDir, int nextType) {
            // opposite direction mapping
            int opposite = fromDir switch {
                0 => 1, // up -> down
                1 => 0, // down -> up
                2 => 3, // left -> right
                3 => 2, // right -> left
                _ => -1
            };

            foreach (int d in streetMap[nextType]) {
                if (d == opposite) return true;
            }
            return false;
        }

        // BFS traversal
        while (queue.Count > 0) {
            var (r, c) = queue.Dequeue();

            // If reached bottom-right → success
            if (r == m - 1 && c == n - 1)
                return true;

            int type = grid[r][c];

            // Try all valid directions from current street
            foreach (int d in streetMap[type]) {
                int nr = r + dirs[d][0];
                int nc = c + dirs[d][1];

                // Check boundaries
                if (nr < 0 || nc < 0 || nr >= m || nc >= n)
                    continue;

                // Skip if already visited
                if (visited[nr, nc])
                    continue;

                // Check if neighbor connects back
                if (!IsConnected(d, grid[nr][nc]))
                    continue;

                // Mark visited and push to queue
                visited[nr, nc] = true;
                queue.Enqueue((nr, nc));
            }
        }

        // If BFS ends without reaching destination
        return false;
    }
}