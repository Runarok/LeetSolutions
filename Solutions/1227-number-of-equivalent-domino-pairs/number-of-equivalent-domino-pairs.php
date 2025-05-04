class Solution {
    /**
     * @param Integer[][] $dominoes
     * @return Integer
     */
    function numEquivDominoPairs($dominoes) {
        // A 2D array to store the counts of each domino in a normalized form.
        $count = array_fill(0, 10, array_fill(0, 10, 0));
        $pairs = 0;

        // Process each domino
        foreach ($dominoes as $domino) {
            // Ensure that the smaller number comes first (normalized form)
            $a = min($domino[0], $domino[1]);
            $b = max($domino[0], $domino[1]);

            // Add the count of previous equivalent dominoes to the pair count
            $pairs += $count[$a][$b];

            // Increment the count for this domino
            $count[$a][$b]++;
        }

        return $pairs;
    }
}
