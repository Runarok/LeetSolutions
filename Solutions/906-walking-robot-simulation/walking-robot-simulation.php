class Solution {

    /**
     * @param Integer[] $commands
     * @param Integer[][] $obstacles
     * @return Integer
     */
    function robotSim($commands, $obstacles) {

        // Store obstacles in a hash set for O(1) lookup
        // We'll store them as "x#y" strings
        $obstacleSet = [];
        foreach ($obstacles as $obs) {
            $key = $obs[0] . '#' . $obs[1];
            $obstacleSet[$key] = true;
        }

        // Directions: North, East, South, West
        // Represented as (dx, dy)
        $dirs = [
            [0, 1],   // North
            [1, 0],   // East
            [0, -1],  // South
            [-1, 0]   // West
        ];

        // Start at origin
        $x = 0;
        $y = 0;

        // Initially facing North (index 0)
        $dir = 0;

        // Track maximum squared distance
        $maxDist = 0;

        // Process each command
        foreach ($commands as $cmd) {

            // Turn right
            if ($cmd == -1) {
                // Move to next direction clockwise
                $dir = ($dir + 1) % 4;
            }

            // Turn left
            else if ($cmd == -2) {
                // Move to previous direction (add 3 instead of -1 to avoid negative)
                $dir = ($dir + 3) % 4;
            }

            // Move forward k steps
            else {
                // Move one step at a time
                for ($i = 0; $i < $cmd; $i++) {

                    // Compute next position
                    $nextX = $x + $dirs[$dir][0];
                    $nextY = $y + $dirs[$dir][1];

                    // Check if next position is an obstacle
                    $key = $nextX . '#' . $nextY;
                    if (isset($obstacleSet[$key])) {
                        // Stop moving further for this command
                        break;
                    }

                    // Otherwise, move to next position
                    $x = $nextX;
                    $y = $nextY;

                    // Update max squared distance
                    $maxDist = max($maxDist, $x * $x + $y * $y);
                }
            }
        }

        return $maxDist;
    }
}