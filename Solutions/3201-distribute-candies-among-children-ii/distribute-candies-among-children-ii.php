class Solution {

    /**
     * Calculate combination C(n, 2) = n * (n-1) / 2 if n >= 2, else 0.
     * This is enough since we only need combinations of the form C(x, 2).
     *
     * @param int $n
     * @return int
     */
    private function comb2($n) {
        if ($n < 2) {
            return 0;
        }
        return intdiv($n * ($n - 1), 2);
    }

    /**
     * Count the number of ways to distribute n candies among 3 children
     * such that no child gets more than 'limit' candies.
     *
     * Using Inclusion-Exclusion Principle:
     * Total solutions without limit: C(n+2, 2)
     * Subtract solutions where any child > limit, add back where two children > limit,
     * subtract where all three > limit.
     *
     * @param Integer $n
     * @param Integer $limit
     * @return Integer
     */
    function distributeCandies($n, $limit) {
        // Total ways without any limit: C(n+2, 2)
        $total = $this->comb2($n + 2);

        // Define helper variable for convenience
        $L = $limit + 1;

        // Count ways where one child gets more than limit
        // For a child > limit, redefine that child's count as x = old - L
        // So sum = n - L, and solutions = C(n - L + 2, 2)
        $oneExceed = 3 * $this->comb2($n - $L + 2);

        // Count ways where two children exceed limit
        // Sum reduces by 2*L
        $twoExceed = 3 * $this->comb2($n - 2 * $L + 2);

        // Count ways where all three exceed limit
        // Sum reduces by 3*L
        $threeExceed = $this->comb2($n - 3 * $L + 2);

        // Apply Inclusion-Exclusion
        $result = $total - $oneExceed + $twoExceed - $threeExceed;

        // The count cannot be negative, ensure minimum 0
        return max(0, $result);
    }
}
