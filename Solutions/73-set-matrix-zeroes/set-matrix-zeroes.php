class Solution {

    /**
     * @param Integer[][] $matrix
     * @return NULL
     */
    function setZeroes(&$matrix) {
        // Get the dimensions of the matrix
        $m = count($matrix);
        $n = count($matrix[0]);

        // Step 1: Check if the first row and first column need to be zeroed
        // Flags to track if the first row or the first column should be zeroed
        $firstRowZero = false;
        $firstColZero = false;

        // Check if there is any zero in the first row
        for ($j = 0; $j < $n; $j++) {
            if ($matrix[0][$j] == 0) {
                $firstRowZero = true;  // Mark the first row to be zeroed
                break;
            }
        }

        // Check if there is any zero in the first column
        for ($i = 0; $i < $m; $i++) {
            if ($matrix[$i][0] == 0) {
                $firstColZero = true;  // Mark the first column to be zeroed
                break;
            }
        }

        // Step 2: Use the first row and first column to mark which rows and columns should be zeroed
        for ($i = 1; $i < $m; $i++) {  // Start from 1 to avoid modifying the first row
            for ($j = 1; $j < $n; $j++) {  // Start from 1 to avoid modifying the first column
                if ($matrix[$i][$j] == 0) {
                    // If matrix[i][j] is zero, mark the corresponding row and column in the first row and first column
                    $matrix[0][$j] = 0;  // Mark the column
                    $matrix[$i][0] = 0;  // Mark the row
                }
            }
        }

        // Step 3: Zero out the cells based on the marks in the first row and first column
        for ($i = 1; $i < $m; $i++) {  // Start from 1 to avoid modifying the first row
            for ($j = 1; $j < $n; $j++) {  // Start from 1 to avoid modifying the first column
                if ($matrix[0][$j] == 0 || $matrix[$i][0] == 0) {
                    // If either the corresponding row or column is marked to be zeroed, set the current cell to 0
                    $matrix[$i][$j] = 0;
                }
            }
        }

        // Step 4: Zero out the first row if needed
        if ($firstRowZero) {
            for ($j = 0; $j < $n; $j++) {
                $matrix[0][$j] = 0;  // Set the entire first row to zero
            }
        }

        // Step 5: Zero out the first column if needed
        if ($firstColZero) {
            for ($i = 0; $i < $m; $i++) {
                $matrix[$i][0] = 0;  // Set the entire first column to zero
            }
        }
    }
}
