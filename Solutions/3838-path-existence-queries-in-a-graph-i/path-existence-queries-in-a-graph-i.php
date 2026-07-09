class Solution {

    /**
     * @param Integer $n
     * @param Integer[] $nums
     * @param Integer $maxDiff
     * @param Integer[][] $queries
     * @return Boolean[]
     */
    function pathExistenceQueries($n, $nums, $maxDiff, $queries) {

        // component[i] = connected component containing node i
        $component = array_fill(0, $n, 0);

        // First node belongs to component 0
        $id = 0;
        $component[0] = 0;

        // Traverse adjacent elements.
        // If the gap is greater than maxDiff, a new component starts.
        for ($i = 1; $i < $n; $i++) {

            if ($nums[$i] - $nums[$i - 1] > $maxDiff) {
                $id++;
            }

            $component[$i] = $id;
        }

        // Answer each query by comparing component IDs.
        $answer = [];

        foreach ($queries as $query) {
            $u = $query[0];
            $v = $query[1];

            $answer[] = ($component[$u] == $component[$v]);
        }

        return $answer;
    }
}