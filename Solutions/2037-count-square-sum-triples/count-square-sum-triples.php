class Solution {

    /**
     * @param Integer $n
     * @return Integer
     */
    function countTriples($n) {
        $count = 0;
        
        // Precompute squares to avoid repeated multiplication
        $squares = [];
        for ($i = 1; $i <= $n; $i++) {
            $squares[$i] = $i * $i;
        }
        
        // Check all pairs (a, b)
        for ($a = 1; $a <= $n; $a++) {
            for ($b = 1; $b <= $n; $b++) {
                $sum = $squares[$a] + $squares[$b];

                // Check if sum is a perfect square c²
                $c = (int)sqrt($sum);
                if ($c * $c === $sum && $c <= $n) {
                    $count++;
                }
            }
        }
        
        return $count;
    }
}
// 