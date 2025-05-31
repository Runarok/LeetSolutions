class Solution {

    /**
     * Convert a cell number (1-based) to board coordinates (row, col).
     * The board numbering goes from bottom-left, left-to-right on the first row,
     * then right-to-left on the second row, alternating direction each row.
     * 
     * For example:
     * If n = 6, the bottom row is row index 5, top row is 0.
     * The numbering zig-zags upwards.
     *
     * @param int $s Cell number (1 to n*n)
     * @param int $n Board size
     * @return array [$row, $col]
     */
    private function getCoords($s, $n) {
        // Calculate which row from bottom (0-based)
        $quotient = intval(($s - 1) / $n);
        // Position within that row
        $remainder = ($s - 1) % $n;

        // Row index counting from top: bottom row is $n-1, so invert the quotient
        $row = $n - 1 - $quotient;

        // If this row (from bottom) is odd, the columns go right to left
        // Otherwise (even row), columns go left to right
        if ($quotient % 2 == 1) {
            $col = $n - 1 - $remainder; // reverse direction
        } else {
            $col = $remainder;
        }
        return [$row, $col];
    }

    /**
     * Main function to solve the Snakes and Ladders problem.
     * Uses BFS to find the minimum number of dice rolls to reach the last cell.
     *
     * @param Integer[][] $board The game board with ladders and snakes
     * @return Integer Minimum dice rolls to reach last cell, or -1 if unreachable
     */
    function snakesAndLadders($board) {
        $n = count($board);          // Board dimension (n x n)
        $target = $n * $n;           // The last square number

        // Array to keep track of visited squares to prevent loops and repeated states
        // Initialize with false for all squares
        $visited = array_fill(1, $target, false);

        // Use a queue to perform BFS traversal
        // Each queue element holds: [current square, number of dice rolls so far]
        $queue = new SplQueue();

        // Start from square 1 with 0 dice rolls
        $queue->enqueue([1, 0]);
        $visited[1] = true;          // Mark the first square as visited

        // BFS loop: explore reachable squares layer by layer
        while (!$queue->isEmpty()) {
            // Get the current position and moves count from the front of the queue
            list($curr, $moves) = $queue->dequeue();

            // If we have reached the target square, return the number of moves taken
            if ($curr == $target) {
                return $moves;
            }

            // From current square, try all possible dice rolls (1 to 6 steps ahead)
            // but do not exceed the last square number
            for ($next = $curr + 1; $next <= min($curr + 6, $target); $next++) {
                // Convert the next square number into (row, col) coordinates on the board
                list($r, $c) = $this->getCoords($next, $n);

                // If the board cell is -1, no ladder or snake; stay on next
                // Otherwise, move to the destination of ladder or snake indicated by the board
                $dest = $board[$r][$c] == -1 ? $next : $board[$r][$c];

                // If we haven't visited the destination square yet,
                // add it to the queue for exploration and mark as visited
                if (!$visited[$dest]) {
                    $visited[$dest] = true;
                    $queue->enqueue([$dest, $moves + 1]);
                }
            }
        }

        // If we have explored all reachable squares and didn't get to target,
        // return -1 indicating it is impossible to reach the last square
        return -1;
    }
}
