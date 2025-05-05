class Solution {
    // Modulo constant to handle large numbers
    const MOD = 1000000007;

    // Memoization table to store already computed results
    private $memo;

    // Recursive function to compute the number of ways to tile the board
    public function dominoes($i, $n, $possible) {
        // If the current position is equal to the length of the board, return the base case
        if ($i == $n) {
            return $possible ? 0 : 1;
        }
        
        // If we exceed the length of the board, return 0
        if ($i > $n) {
            return 0;
        }

        // Check if the result has already been computed (memoization)
        if (isset($this->memo[$i][$possible])) {
            return $this->memo[$i][$possible];
        }

        // If possible is true, we can either place a vertical domino or a horizontal domino pair
        if ($possible) {
            $result = ($this->dominoes($i + 1, $n, false) + $this->dominoes($i + 1, $n, true)) % self::MOD;
        } else {
            // If possible is false, we can place a vertical domino, two horizontal dominoes, or a tromino
            $result = ($this->dominoes($i + 1, $n, false) + 
                      $this->dominoes($i + 2, $n, false) + 
                      2 * $this->dominoes($i + 2, $n, true)) % self::MOD;
        }

        // Store the computed result for memoization
        $this->memo[$i][$possible] = $result;
        return $result;
    }

    // Main function to call the recursive function
    public function numTilings($n) {
        // Initialize the memoization table as an empty array
        $this->memo = [];
        // Start the recursion with index 0 and possible set to false
        return $this->dominoes(0, $n, false);
    }
}
