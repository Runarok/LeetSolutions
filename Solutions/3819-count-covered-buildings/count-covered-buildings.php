class Solution {

    /**
     * @param Integer $n
     * @param Integer[][] $buildings
     * @return Integer
     */
    function countCoveredBuildings($n, $buildings) {

        // ---------------------------------------------------------------------
        // STEP 1: Build hash maps:
        //   rows[x] = all y's that have buildings in row x
        //   cols[y] = all x's that have buildings in column y
        // ---------------------------------------------------------------------
        $rows = [];
        $cols = [];

        foreach ($buildings as $b) {
            list($x, $y) = $b;

            // Add to row map
            if (!isset($rows[$x])) $rows[$x] = [];
            $rows[$x][] = $y;

            // Add to column map
            if (!isset($cols[$y])) $cols[$y] = [];
            $cols[$y][] = $x;
        }

        // ---------------------------------------------------------------------
        // STEP 2: Sort each list in rows and columns
        // This allows binary searching for neighbors efficiently
        // ---------------------------------------------------------------------
        foreach ($rows as $x => $_) {
            sort($rows[$x]);
        }
        foreach ($cols as $y => $_) {
            sort($cols[$y]);
        }

        // Helper function: binary search to find the index of target in array
        // Returns the index where target would be inserted.
        // (Essentially PHP's "bisect_left")
        $bisectLeft = function($arr, $target) {
            $low = 0;
            $high = count($arr);
            while ($low < $high) {
                $mid = intdiv($low + $high, 2);
                if ($arr[$mid] < $target) {
                    $low = $mid + 1;
                } else {
                    $high = $mid;
                }
            }
            return $low;
        };

        $covered = 0;

        // ---------------------------------------------------------------------
        // STEP 3: For each building, check if it has neighbors in all 4 directions
        // ---------------------------------------------------------------------
        foreach ($buildings as $b) {
            list($x, $y) = $b;

            $rowList = $rows[$x];  // all columns in this row
            $colList = $cols[$y];  // all rows in this column

            // Binary search to find y's index inside the row
            $posRow = $bisectLeft($rowList, $y);

            // Left exists if index > 0
            $hasLeft  = ($posRow > 0);

            // Right exists if there's a value after this one
            $hasRight = ($posRow < count($rowList) - 1);

            // Binary search for x inside column
            $posCol = $bisectLeft($colList, $x);

            // Above → smaller row exists
            $hasAbove = ($posCol > 0);

            // Below → larger row exists
            $hasBelow = ($posCol < count($colList) - 1);

            // If all four conditions satisfied → covered
            if ($hasLeft && $hasRight && $hasAbove && $hasBelow) {
                $covered++;
            }
        }

        return $covered;
    }
}
