class Solution {

    /**
     * Simulates robot collisions and returns the healths of surviving robots.
     *
     * @param Integer[] $positions  // Positions of robots on a line
     * @param Integer[] $healths    // Health of each robot
     * @param String $directions    // Directions: 'L' (left) or 'R' (right)
     * @return Integer[]            // Healths of surviving robots in original order
     */
    public function survivedRobotsHealths(
        array $positions, 
        array $healths,
        string $directions
    ): array 
    {
        /**
         * STEP 1: Combine all robot data into a single array
         * Each robot becomes:
         * [position, health, direction, original_index]
         */
        $robots = array_map(
            null, 
            $positions, 
            $healths, 
            str_split($directions), 
            array_keys($positions)
        );

        /**
         * STEP 2: Sort robots based on position (left → right)
         * This ensures we process collisions in correct spatial order
         */
        usort($robots, fn($a, $b) => $a[0] <=> $b[0]);

        /**
         * This stack keeps robots that are moving RIGHT
         * and may collide with future LEFT-moving robots
         */
        $collisionStack = [];

        /**
         * STEP 3: Process each robot in sorted order
         */
        foreach ($robots as [$pos, $health, $dir, $index]) {

            /**
             * CASE 1: Robot moving RIGHT
             * Just push to stack and wait for possible collision
             */
            if ($dir === 'R') {
                $collisionStack[] = [$pos, $health, $dir, $index];
            } 
            /**
             * CASE 2: Robot moving LEFT
             * It may collide with previous RIGHT-moving robots
             */
            else {

                /**
                 * Keep resolving collisions while:
                 * - This robot is still alive (health > 0)
                 * - Stack is not empty
                 * - Top robot is moving RIGHT
                 */
                while (
                    $health > 0 &&
                    !empty($collisionStack) &&
                    end($collisionStack)[2] === 'R'
                ) {
                    /**
                     * Take the last RIGHT-moving robot
                     */
                    [$lastPos, $lastHealth, $lastDir, $lastIndex] = array_pop($collisionStack);

                    /**
                     * Compare healths:
                     */

                    // Case A: Stack robot is stronger
                    if ($lastHealth > $health) {
                        /**
                         * Stack robot survives but loses 1 health
                         * Current robot dies
                         */
                        $collisionStack[] = [
                            $lastPos,
                            $lastHealth - 1,
                            $lastDir,
                            $lastIndex
                        ];
                        $health = 0;
                    }

                    // Case B: Current robot is stronger
                    elseif ($lastHealth < $health) {
                        /**
                         * Current robot survives but loses 1 health
                         * Stack robot is destroyed (not pushed back)
                         */
                        $health--;
                    }

                    // Case C: Equal health
                    else {
                        /**
                         * Both robots destroy each other
                         */
                        $health = 0;
                    }
                }

                /**
                 * If current robot still alive after all collisions,
                 * add it to stack
                 */
                if ($health > 0) {
                    $collisionStack[] = [$pos, $health, $dir, $index];
                }
            }
        }

        /**
         * STEP 4: Prepare result array
         * Initialize with -1 (means robot died)
         */
        $survivedHealths = array_fill(0, count($positions), -1);
        
        /**
         * Fill surviving robots' health using original indices
         */
        foreach ($collisionStack as [$pos, $health, $dir, $index]) {
            $survivedHealths[$index] = $health;
        }

        /**
         * STEP 5: Remove dead robots (-1) and reindex array
         */
        return array_values(
            array_filter(
                $survivedHealths, 
                fn($health) => $health !== -1
            )
        );
    }
}