class Solution {

    /**
     * @param String $dominoes
     * @return String
     */
    function pushDominoes($dominoes) {
        $n = strlen($dominoes);  // Get the length of the input string

        // Step 1: Track positions of 'L' and 'R'
        $indexes = [-1];  // Start with an initial boundary (-1) for easier processing
        $symbols = ['L'];  // Initially, assume that 'L' is at the boundary to handle cases where the dominoes start with 'L'
        
        // Loop through the dominoes and track positions of 'L' and 'R'
        for ($i = 0; $i < $n; ++$i) {
            if ($dominoes[$i] !== '.') {  // Only track 'L' and 'R', ignore '.' positions
                $indexes[] = $i;  // Add the position of 'L' or 'R'
                $symbols[] = $dominoes[$i];  // Add the force type ('L' or 'R')
            }
        }

        // Add the right boundary to mark the end of the dominoes string
        $indexes[] = $n;  // End boundary is at position n
        $symbols[] = 'R';  // Right boundary is marked by 'R'

        // Step 2: Initialize the result array with the input dominoes as a list of characters
        $result = str_split($dominoes);  // Convert the string into an array for easier manipulation

        // Step 3: Process each interval between two forces (i.e., between 'L' and 'R' or 'R' and 'L')
        $len = count($indexes);  // Total number of intervals
        for ($index = 0; $index < $len - 1; ++$index) {
            $i = $indexes[$index];  // Starting position of the current force
            $j = $indexes[$index + 1];  // Ending position of the next force
            $x = $symbols[$index];  // Force at the start of the interval (either 'L' or 'R')
            $y = $symbols[$index + 1];  // Force at the end of the interval (either 'L' or 'R')

            // Case 1: Both sides have the same force, so the whole interval will fall in that direction
            if ($x == $y) {
                for ($k = $i + 1; $k < $j; ++$k) {
                    $result[$k] = $x;  // Fill the interval with the same force ('L' or 'R')
                }
            } 
            // Case 2: 'R' on the left and 'L' on the right (conflicting forces), determine the direction
            else if ($x > $y) {  // This corresponds to 'R' on the left and 'L' on the right
                for ($k = $i + 1; $k < $j; ++$k) {
                    // Determine the direction based on proximity to the forces
                    if ($k - $i == $j - $k) {
                        $result[$k] = '.';  // If equidistant, the domino stays upright
                    } else if ($k - $i < $j - $k) {
                        $result[$k] = 'R';  // Closer to 'R', so it falls to the right
                    } else {
                        $result[$k] = 'L';  // Closer to 'L', so it falls to the left
                    }
                }
            }
        }

        // Step 4: Convert the result array back into a string and return it
        return implode('', $result);  // Join the array of characters into a single string and return
    }
}
