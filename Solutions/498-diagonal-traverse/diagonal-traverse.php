class Solution {

    /**
     * @param Integer[][] $mat
     * @return Integer[]
     */
    function findDiagonalOrder($mat) {
        // Get dimensions of the matrix
        $m = count($mat);         // Number of rows
        $n = count($mat[0]);      // Number of columns
        
        // Result array to store the diagonal order
        $result = [];
        
        // There will be m + n - 1 diagonals
        for ($d = 0; $d < $m + $n - 1; $d++) {
            $intermediate = []; // Temporary array to hold current diagonal elements
            
            // Determine the starting point of the diagonal
            $row = $d < $n ? 0 : $d - $n + 1;
            $col = $d < $n ? $d : $n - 1;

            // Traverse the diagonal
            while ($row < $m && $col >= 0) {
                $intermediate[] = $mat[$row][$col];
                $row++;
                $col--;
            }

            // If the diagonal index is even, reverse it
            if ($d % 2 == 0) {
                $intermediate = array_reverse($intermediate);
            }

            // Append the intermediate diagonal to the result
            $result = array_merge($result, $intermediate);
        }

        return $result;
    }
}
