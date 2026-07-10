class Solution {

    /**
     * @param Integer $n
     * @param Integer[] $nums
     * @param Integer $maxDiff
     * @param Integer[][] $queries
     * @return Integer[]
     */
    function pathExistenceQueries($n, $nums, $maxDiff, $queries) {

        // ------------------------------------------------------------
        // Sort nodes by value.
        // We only care about values because edges depend on value
        // differences.
        // ------------------------------------------------------------
        $arr = [];
        for ($i = 0; $i < $n; $i++) {
            $arr[] = [$nums[$i], $i];
        }

        usort($arr, function($a, $b) {
            if ($a[0] == $b[0]) return 0;
            return ($a[0] < $b[0]) ? -1 : 1;
        });

        // value at sorted position
        $values = [];
        // original node -> sorted position
        $pos = array_fill(0, $n, 0);

        for ($i = 0; $i < $n; $i++) {
            $values[$i] = $arr[$i][0];
            $pos[$arr[$i][1]] = $i;
        }

        // ------------------------------------------------------------
        // Component id.
        // Whenever consecutive sorted values differ by more than
        // maxDiff, graph splits into another connected component.
        // ------------------------------------------------------------
        $comp = array_fill(0, $n, 0);
        $cid = 0;
        $comp[0] = 0;

        for ($i = 1; $i < $n; $i++) {
            if ($values[$i] - $values[$i - 1] > $maxDiff) {
                $cid++;
            }
            $comp[$i] = $cid;
        }

        // ------------------------------------------------------------
        // nextReach[i]
        // Farthest sorted position reachable in ONE edge from i.
        //
        // Since values are sorted, use two pointers.
        // ------------------------------------------------------------
        $nextReach = array_fill(0, $n, 0);

        $r = 0;
        for ($i = 0; $i < $n; $i++) {
            if ($r < $i) $r = $i;

            while (
                $r + 1 < $n &&
                $values[$r + 1] - $values[$i] <= $maxDiff
            ) {
                $r++;
            }

            $nextReach[$i] = $r;
        }

        // ------------------------------------------------------------
        // Binary lifting.
        //
        // up[k][i] =
        // after using 2^k jumps greedily,
        // farthest sorted index we can reach.
        // ------------------------------------------------------------
        $LOG = 18; // 2^17 > 100000

        $up = [];
        $up[0] = $nextReach;

        for ($k = 1; $k < $LOG; $k++) {
            $up[$k] = array_fill(0, $n, 0);
            for ($i = 0; $i < $n; $i++) {
                $up[$k][$i] = $up[$k - 1][ $up[$k - 1][$i] ];
            }
        }

        $ans = [];

        foreach ($queries as $q) {

            $u = $pos[$q[0]];
            $v = $pos[$q[1]];

            // work from left to right
            if ($u > $v) {
                $tmp = $u;
                $u = $v;
                $v = $tmp;
            }

            // same node
            if ($u == $v) {
                $ans[] = 0;
                continue;
            }

            // different connected components
            if ($comp[$u] != $comp[$v]) {
                $ans[] = -1;
                continue;
            }

            // direct edge
            if ($nextReach[$u] >= $v) {
                $ans[] = 1;
                continue;
            }

            // --------------------------------------------------------
            // Greedily use largest powers of two without passing v.
            // --------------------------------------------------------
            $cur = $u;
            $steps = 0;

            for ($k = $LOG - 1; $k >= 0; $k--) {
                if ($up[$k][$cur] < $v) {
                    $cur = $up[$k][$cur];
                    $steps += (1 << $k);
                }
            }

            // one more jump reaches (or passes) v
            $ans[] = $steps + 1;
        }

        return $ans;
    }
}