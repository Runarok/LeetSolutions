class Solution {

    /**
     * Determine if the robot returns to the origin (0, 0)
     *
     * @param String $moves  String containing moves: 'U', 'D', 'L', 'R'
     * @return Boolean       True if robot ends at origin, otherwise false
     */
    function judgeCircle($moves) {
        
        // Initialize coordinates
        // x represents horizontal position (left/right)
        // y represents vertical position (up/down)
        $x = 0;
        $y = 0;

        // Loop through each character in the moves string
        for ($i = 0; $i < strlen($moves); $i++) {
            
            // Get the current move
            $move = $moves[$i];

            // Update coordinates based on the move
            if ($move === 'U') {
                // Move up → increase y
                $y++;
            } 
            elseif ($move === 'D') {
                // Move down → decrease y
                $y--;
            } 
            elseif ($move === 'R') {
                // Move right → increase x
                $x++;
            } 
            elseif ($move === 'L') {
                // Move left → decrease x
                $x--;
            }
        }

        // After processing all moves:
        // If both x and y are 0, robot is back at origin
        if ($x === 0 && $y === 0) {
            return true;
        }

        // Otherwise, it's not at the origin
        return false;
    }
}