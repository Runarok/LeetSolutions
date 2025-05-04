class Solution {
    /**
     * @param Integer[][] $dominoes
     * @return Integer
     */
    function numEquivDominoPairs($dominoes) {
        $count = [];
        
        // Normalize each domino and count the occurrences
        foreach ($dominoes as $domino) {
            // Sort the domino to ensure the smaller number is always first
            $normalized = [$domino[0], $domino[1]];
            sort($normalized);
            $key = implode(",", $normalized);  // Create a string key for the pair
            if (!isset($count[$key])) {
                $count[$key] = 0;
            }
            $count[$key]++;
        }
        
        // Calculate the number of equivalent pairs
        $pairs = 0;
        foreach ($count as $freq) {
            if ($freq > 1) {
                $pairs += $freq * ($freq - 1) / 2;  // Combination of 2 from freq items
            }
        }
        
        return $pairs;
    }
}
