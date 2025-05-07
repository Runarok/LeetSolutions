class Solution {

    /**
     * @param Integer[][] $moveTime
     * @return Integer
     */
    function minTimeToReach($moveTime) {
        // Get the number of rows (n) and columns (m)
        $n = count($moveTime);
        $m = count($moveTime[0]);

        // Initialize the distance (d) array, set all distances to infinity
        $d = array_fill(0, $n, array_fill(0, $m, PHP_INT_MAX));
        
        // Initialize the visited (v) array to track which rooms have been processed
        $v = array_fill(0, $n, array_fill(0, $m, false));

        // Directions array (down, up, right, left)
        $dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]];

        // Initialize the priority queue to store rooms with their distances
        $q = new SplPriorityQueue();
        
        // Start at (0, 0) with a distance of 0
        $d[0][0] = 0;
        $q->insert([0, 0, 0], 0); // Element format: [x, y, dist], with dist as priority (min-heap)

        // Process rooms until the queue is empty
        while (!$q->isEmpty()) {
            // Extract the room with the smallest distance
            list($x, $y, $dist) = $q->extract();

            // If the room is already visited, continue
            if ($v[$x][$y]) {
                continue;
            }

            // Mark this room as visited
            $v[$x][$y] = true;

            // Explore all 4 possible directions (down, up, right, left)
            foreach ($dirs as $dir) {
                list($dx, $dy) = $dir;

                // Calculate the new room's coordinates
                $nx = $x + $dx;
                $ny = $y + $dy;

                // Check if the new coordinates are within bounds
                if ($nx >= 0 && $nx < $n && $ny >= 0 && $ny < $m) {
                    // Calculate the new distance: max of the current distance or the time required to move to the new room, plus 1 second to move
                    $newDist = max($d[$x][$y], $moveTime[$nx][$ny]) + 1;

                    // If we found a shorter way to reach the neighbor room, update the distance and add it to the priority queue
                    if ($d[$nx][$ny] > $newDist) {
                        $d[$nx][$ny] = $newDist;
                        $q->insert([$nx, $ny, $newDist], -$newDist); // Inverse the priority to make it a min-heap
                    }
                }
            }
        }

        // Return the minimum distance to reach the bottom-right corner (n-1, m-1)
        return $d[$n - 1][$m - 1];
    }
}
