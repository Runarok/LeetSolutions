class Solution {

    /**
     * Calculate the minimum sum (area) of the bounding rectangle covering all 1's in the subgrid
     * defined by rows [u, d] and columns [l, r].
     * 
     * @param Integer[][] $grid The grid to process.
     * @param int $u Upper row boundary.
     * @param int $d Lower row boundary.
     * @param int $l Left column boundary.
     * @param int $r Right column boundary.
     * @return int The area of the bounding rectangle containing all 1's or a very large number if none found.
     */
    private function minimumSum2($grid, $u, $d, $l, $r) {
        $min_i = count($grid);
        $max_i = 0;
        $min_j = count($grid[0]);
        $max_j = 0;

        for ($i = $u; $i <= $d; $i++) {
            for ($j = $l; $j <= $r; $j++) {
                if ($grid[$i][$j] == 1) {
                    $min_i = min($min_i, $i);
                    $min_j = min($min_j, $j);
                    $max_i = max($max_i, $i);
                    $max_j = max($max_j, $j);
                }
            }
        }

        if ($min_i <= $max_i) {
            // Calculate area of rectangle enclosing all 1's in this subgrid
            return ($max_i - $min_i + 1) * ($max_j - $min_j + 1);
        } else {
            // If no 1's found in this subgrid, return a large number to avoid choosing this partition
            return PHP_INT_MAX >> 1;  // Equivalent to sys.maxsize // 3 in Python
        }
    }

    /**
     * Rotate the grid 90 degrees clockwise.
     * 
     * @param Integer[][] $vec The grid to rotate.
     * @return Integer[][] The rotated grid.
     */
    private function rotate($vec) {
        $n = count($vec);
        $m = $n > 0 ? count($vec[0]) : 0;

        // Initialize rotated matrix of size m x n with zeros
        $ret = array_fill(0, $m, array_fill(0, $n, 0));

        for ($i = 0; $i < $n; $i++) {
            for ($j = 0; $j < $m; $j++) {
                // Rotate 90 degrees clockwise
                $ret[$m - $j - 1][$i] = $vec[$i][$j];
            }
        }

        return $ret;
    }

    /**
     * Solve for minimum sum by trying different partitions of the grid.
     * 
     * @param Integer[][] $grid The grid to process.
     * @return int The minimum sum found by partitioning.
     */
    private function solve($grid) {
        $n = count($grid);
        $m = $n > 0 ? count($grid[0]) : 0;
        $res = $n * $m;

        // Try splitting the grid with two horizontal partitions and one vertical partition
        for ($i = 0; $i < $n - 1; $i++) {
            for ($j = 0; $j < $m - 1; $j++) {
                $res = min(
                    $res,
                    $this->minimumSum2($grid, 0, $i, 0, $m - 1)
                    + $this->minimumSum2($grid, $i + 1, $n - 1, 0, $j)
                    + $this->minimumSum2($grid, $i + 1, $n - 1, $j + 1, $m - 1)
                );

                $res = min(
                    $res,
                    $this->minimumSum2($grid, 0, $i, 0, $j)
                    + $this->minimumSum2($grid, 0, $i, $j + 1, $m - 1)
                    + $this->minimumSum2($grid, $i + 1, $n - 1, 0, $m - 1)
                );
            }
        }

        // Try splitting the grid with three horizontal partitions
        for ($i = 0; $i < $n - 2; $i++) {
            for ($j = $i + 1; $j < $n - 1; $j++) {
                $res = min(
                    $res,
                    $this->minimumSum2($grid, 0, $i, 0, $m - 1)
                    + $this->minimumSum2($grid, $i + 1, $j, 0, $m - 1)
                    + $this->minimumSum2($grid, $j + 1, $n - 1, 0, $m - 1)
                );
            }
        }

        return $res;
    }

    /**
     * The main function to calculate the minimum sum.
     * It compares the solution on the original grid and on the rotated grid.
     * 
     * @param Integer[][] $grid The input grid.
     * @return int The minimum sum after considering both orientations.
     */
    public function minimumSum($grid) {
        $rgrid = $this->rotate($grid);
        return min($this->solve($grid), $this->solve($rgrid));
    }
}
