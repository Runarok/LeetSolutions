class Solution {

    /**
     * @param Integer[][] $grid
     * @param Integer $k
     * @return Integer[][]
     */
    function shiftGrid($grid, $k) {

        $m = count($grid);
        $n = count($grid[0]);

        $total = $m * $n;
        $k %= $total;

        // Initialize the answer grid
        $ans = array_fill(0, $m, array_fill(0, $n, 0));

        for ($i = 0; $i < $m; $i++) {
            for ($j = 0; $j < $n; $j++) {

                // Current 1D index
                $idx = $i * $n + $j;

                // New 1D index after shifting
                $newIdx = ($idx + $k) % $total;

                // Convert back to row and column
                $newRow = intdiv($newIdx, $n);
                $newCol = $newIdx % $n;

                // Place the value
                $ans[$newRow][$newCol] = $grid[$i][$j];
            }
        }

        return $ans;
    }
}