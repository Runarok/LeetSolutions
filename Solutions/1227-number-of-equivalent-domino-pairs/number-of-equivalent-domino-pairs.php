class Solution {
    /**
     * @param Integer[][] $dominoes
     * @return Integer
     */
    function numEquivDominoPairs($dominoes) {
        $count = [];
        $pairs = 0;

        foreach ($dominoes as $domino) {
            // Ensure that the smaller number is first
            if ($domino[0] > $domino[1]) {
                $temp = $domino[0];
                $domino[0] = $domino[1];
                $domino[1] = $temp;
            }

            // Create a tuple key and update the count in the hashmap
            $key = $domino[0] * 10 + $domino[1]; // We can use the two numbers to create a unique key

            // Count how many times we've seen this domino
            if (isset($count[$key])) {
                $pairs += $count[$key];
                $count[$key]++;
            } else {
                $count[$key] = 1;
            }
        }

        return $pairs;
    }
}
