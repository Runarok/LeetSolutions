public class Solution {
    // INF is used to represent an initially very high value, indicating unreachable positions.
    private const int INF = 0x3f3f3f3f;

    // The State class represents the state of a point in the grid.
    // It contains the coordinates (x, y) and the distance traveled to reach that point.
    class State : IComparable<State> {
        public int x, y, dis;
        
        // Constructor to initialize the State with x, y coordinates and the distance
        public State(int x, int y, int dis) {
            this.x = x;
            this.y = y;
            this.dis = dis;
        }

        // Compare method to help with sorting the state based on the 'dis' value.
        public int CompareTo(State other) {
            return dis.CompareTo(other.dis);
        }
    }

    // The main function calculates the minimum time to reach the bottom-right corner of the grid.
    public int MinTimeToReach(int[][] moveTime) {
        int n = moveTime.Length;  // Number of rows in the grid.
        int m = moveTime[0].Length;  // Number of columns in the grid.

        // Initialize the distance array 'd' to hold the minimum time to reach each cell.
        // Initially, set every cell's distance to INF.
        int[,] d = new int[n, m];
        bool[,] v = new bool[n, m];  // Boolean array to track whether a cell has been visited.

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                d[i, j] = INF;  // Set all initial distances to INF (infinity).
            }
        }

        // Directions for movement in the grid (right, left, down, up).
        int[][] dirs = new int[][] { new int[] { 1, 0 }, new int[] { -1, 0 },
                                     new int[] { 0, 1 }, new int[] { 0, -1 } };

        // Set the starting point (top-left corner) with a distance of 0.
        d[0, 0] = 0;

        // Priority queue to store states. It will automatically sort based on the distance.
        var q = new PriorityQueue<State, int>();

        // Enqueue the starting point with its initial distance (0).
        q.Enqueue(new State(0, 0, 0), 0);

        // Run a modified Dijkstra's algorithm to find the shortest path.
        while (q.Count > 0) {
            // Dequeue the state with the minimum distance.
            State s = q.Dequeue();

            // If the current cell is already visited, skip it.
            if (v[s.x, s.y]) {
                continue;
            }

            // If we've reached the bottom-right corner, break the loop.
            if (s.x == n - 1 && s.y == m - 1) {
                break;
            }

            // Mark the current cell as visited.
            v[s.x, s.y] = true;

            // Try to move to each neighboring cell.
            foreach (var dir in dirs) {
                int nx = s.x + dir[0];  // New x-coordinate after moving.
                int ny = s.y + dir[1];  // New y-coordinate after moving.

                // If the new coordinates are out of bounds, skip this move.
                if (nx < 0 || nx >= n || ny < 0 || ny >= m)
                    continue;

                // Calculate the new distance based on the current state and move time.
                // The cost to move to (nx, ny) is the maximum of the current cell's distance 
                // and the move time for the destination cell, plus an additional cost based on parity.
                int dist = Math.Max(d[s.x, s.y], moveTime[nx][ny]) + 
                           (s.x + s.y) % 2 + 1;

                // If the new calculated distance is shorter, update the distance and enqueue the new state.
                if (d[nx, ny] > dist) {
                    d[nx, ny] = dist;
                    q.Enqueue(new State(nx, ny, dist), dist);
                }
            }
        }

        // Return the minimum time to reach the bottom-right corner.
        return d[n - 1, m - 1];
    }
}