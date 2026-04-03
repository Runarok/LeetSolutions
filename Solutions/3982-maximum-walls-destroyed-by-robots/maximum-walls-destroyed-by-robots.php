class Solution {

    /**
     * Binary search: first index >= target
     */
    private function lowerBound($arr, $target) {
        $l = 0;
        $r = count($arr);
        while ($l < $r) {
            $mid = intdiv($l + $r, 2);
            if ($arr[$mid] < $target) $l = $mid + 1;
            else $r = $mid;
        }
        return $l;
    }

    /**
     * Binary search: first index > target
     */
    private function upperBound($arr, $target) {
        $l = 0;
        $r = count($arr);
        while ($l < $r) {
            $mid = intdiv($l + $r, 2);
            if ($arr[$mid] <= $target) $l = $mid + 1;
            else $r = $mid;
        }
        return $l;
    }

    /**
     * Count walls in [L, R]
     */
    private function countRange($walls, $L, $R) {
        if ($L > $R) return 0;
        return $this->upperBound($walls, $R) - $this->lowerBound($walls, $L);
    }

    function maxWalls($robots, $distance, $walls) {

        $n = count($robots);

        // Map robot -> distance
        $map = [];
        for ($i = 0; $i < $n; $i++) {
            $map[$robots[$i]] = $distance[$i];
        }

        // Sort robots and walls
        sort($robots);
        sort($walls);

        // Arrays
        $left = array_fill(0, $n, 0);
        $right = array_fill(0, $n, 0);
        $num = array_fill(0, $n, 0); // walls between robots

        // Precompute
        for ($i = 0; $i < $n; $i++) {

            $pos = $robots[$i];
            $dist = $map[$pos];

            // LEFT RANGE
            if ($i > 0) {
                $L = max($pos - $dist, $robots[$i - 1] + 1);
            } else {
                $L = $pos - $dist;
            }
            $R = $pos;

            $left[$i] = $this->countRange($walls, $L, $R);

            // RIGHT RANGE
            if ($i < $n - 1) {
                $L2 = $pos;
                $R2 = min($pos + $dist, $robots[$i + 1] - 1);
            } else {
                $L2 = $pos;
                $R2 = $pos + $dist;
            }

            $right[$i] = $this->countRange($walls, $L2, $R2);

            // walls between robots
            if ($i > 0) {
                $num[$i] = $this->countRange(
                    $walls,
                    $robots[$i - 1],
                    $robots[$i]
                );
            }
        }

        // DP initialization
        $subLeft = $left[0];
        $subRight = $right[0];

        // DP iteration
        for ($i = 1; $i < $n; $i++) {

            // current robot shoots LEFT
            $currentLeft = max(
                $subLeft + $left[$i],
                $subRight - $right[$i - 1] +
                min($right[$i - 1] + $left[$i], $num[$i])
            );

            // current robot shoots RIGHT
            $currentRight = max(
                $subLeft + $right[$i],
                $subRight + $right[$i]
            );

            // update
            $subLeft = $currentLeft;
            $subRight = $currentRight;
        }

        return max($subLeft, $subRight);
    }
}