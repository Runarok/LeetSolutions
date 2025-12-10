<?php

class Solution {

    // -------------------------------------------------------------
    // MODULO VALUE
    // This constant represents the number 1,000,000,007,
    // which is a large prime. It is commonly used in competitive
    // programming because:
    //   - It prevents integer overflow
    //   - It keeps answers within a manageable range
    //   - Modulo with a prime simplifies combinatorics
    // -------------------------------------------------------------
    const MOD = 1000000007;

    /**
     * Count how many permutations of computers are valid
     * according to the simplified logic used in this method.
     *
     * IMPORTANT:
     *   This is NOT the full correct solution to the unlocking
     *   dependencies problem — it only implements the logic you
     *   wrote in the original Python version.
     *
     * @param Integer[] $complexity
     * @return Integer
     */
    public function countPermutations($complexity) {

        // ---------------------------------------------------------
        // n = number of computers
        // ---------------------------------------------------------
        $n = count($complexity);

        // ---------------------------------------------------------
        // Retrieve the complexity of the first computer (index 0).
        // The user’s simplified logic assumes:
        //
        //   - Computer 0 is the root and is already unlocked.
        //   - All other computers must have *strictly greater*
        //     complexity than computer 0.
        //
        // If any computer’s complexity[i] <= complexity[0],
        // unlocking that computer becomes impossible under the
        // simplified model.
        //
        // ---------------------------------------------------------
        $first = $complexity[0];

        // ---------------------------------------------------------
        // VALIDITY CHECK:
        //
        // Loop through ALL computers except index 0.
        // If ANY computer has complexity ≤ the root’s complexity,
        // we immediately return 0.
        //
        // This is because, in this simplified logic:
        //     - Complexity[i] must be > first for ALL i>0
        //
        // If not, the chain of increasing-complexity unlocks fails.
        // ---------------------------------------------------------
        for ($i = 1; $i < $n; $i++) {

            // If this computer's complexity is NOT strictly larger
            // than the root computer's complexity, there is no way
            // to unlock it (under this simplified assumption),
            // and therefore the answer must be zero.
            if ($complexity[$i] <= $first) {
                return 0;
            }
        }

        // ---------------------------------------------------------
        // FACTORIAL CALCULATION:
        //
        // The logic used here assumes that if ALL complexities are
        // strictly greater than the root’s complexity, then ANY
        // ordering of computers 1..n-1 is valid — meaning that the
        // number of valid permutations is simply:
        //
        //          (n - 1)!
        //
        // Because computer 0 must always be first, the remaining
        // (n - 1) computers can be arranged in ANY order.
        //
        // HOWEVER:
        // This loop actually computes (n - 1)! incorrectly:
        //
        // The loop is:
        //      for i = 2 to (n-1)
        //          factorial *= i
        //
        // This gives:
        //
        //      factorial = 2 × 3 × ... × (n - 1)
        //
        // Which is exactly (n - 1)!.
        //
        // ---------------------------------------------------------
        $fact = 1;

        // The loop multiplies all numbers from 2 up to n-1 inclusive.
        // Note:
        //   - When n = 2 → loop does not execute → returns 1 → correct.
        //   - When n = 3 → multiplies only 2 → result = 2 → correct.
        //   - When n = 4 → multiplies 2*3 = 6 → correct.
        //
        // Each multiplication is taken modulo MOD to avoid overflow.
        for ($i = 2; $i < $n; $i++) {

            // Multiply current factorial by i and take modulo
            $fact = ($fact * $i) % self::MOD;
        }

        // ---------------------------------------------------------
        // Return the computed factorial value.
        // Based on the simplified logic, this represents the total
        // number of valid permutations where:
        //
        //     - Computer 0 is always in position 0
        //     - Remaining (n-1) computers may appear in ANY order
        //
        // ---------------------------------------------------------
        return $fact;
    }
}

?>
