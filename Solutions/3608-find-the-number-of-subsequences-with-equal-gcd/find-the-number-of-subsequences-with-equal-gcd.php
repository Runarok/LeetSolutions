class Solution {

    const MOD = 1000000007;
    private $nums;
    private $n;
    private $memo = [];
    private $gcd = [];

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function subsequencePairCount($nums) {
        $this->nums = $nums;
        $this->n = count($nums);

        // Precompute gcd table.
        for ($i = 0; $i <= 200; $i++) {
            for ($j = 0; $j <= 200; $j++) {
                if ($i == 0) {
                    $this->gcd[$i][$j] = $j;
                } elseif ($j == 0) {
                    $this->gcd[$i][$j] = $i;
                } else {
                    $a = $i;
                    $b = $j;
                    while ($b) {
                        $t = $a % $b;
                        $a = $b;
                        $b = $t;
                    }
                    $this->gcd[$i][$j] = $a;
                }
            }
        }

        return $this->dfs(0, 0, 0);
    }

    private function dfs($idx, $g1, $g2) {
        if ($idx == $this->n) {
            return ($g1 > 0 && $g1 == $g2) ? 1 : 0;
        }

        // Pack state into one integer (faster than string keys).
        $key = ($idx << 16) | ($g1 << 8) | $g2;

        if (isset($this->memo[$key])) {
            return $this->memo[$key];
        }

        $x = $this->nums[$idx];

        // Skip current element.
        $ans = $this->dfs($idx + 1, $g1, $g2);

        // Put into first subsequence.
        $ans += $this->dfs(
            $idx + 1,
            $this->gcd[$g1][$x],
            $g2
        );

        // Put into second subsequence.
        $ans += $this->dfs(
            $idx + 1,
            $g1,
            $this->gcd[$g2][$x]
        );

        $ans %= self::MOD;

        $this->memo[$key] = $ans;
        return $ans;
    }
}