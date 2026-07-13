class Solution {

    /**
     * @param Integer $low
     * @param Integer $high
     * @return Integer[]
     */
    function sequentialDigits($low, $high) {

        // Array to store all valid sequential numbers
        $result = [];

        // Base string containing all sequential digits.
        // Every sequential number is simply a substring of this.
        // Examples:
        // "12", "123", "2345", "6789"
        $digits = "123456789";

        // Find the number of digits in low.
        // We don't need to generate numbers with fewer digits.
        $minLength = strlen((string)$low);

        // Find the number of digits in high.
        // We don't need to generate numbers with more digits.
        $maxLength = strlen((string)$high);

        // Try every possible length.
        // Example:
        // length = 2 -> 12,23,34,...,89
        // length = 3 -> 123,234,...,789
        // length = 4 -> 1234,2345,...,6789
        for ($len = $minLength; $len <= $maxLength; $len++) {

            // Starting position of substring.
            //
            // Maximum starting index is:
            // 9 - length
            //
            // Example:
            // length = 3
            // Starts:
            // 0 -> 123
            // 1 -> 234
            // ...
            // 6 -> 789
            //
            // So loop until (9 - len)
            for ($start = 0; $start <= 9 - $len; $start++) {

                // Extract substring of required length
                $num = intval(substr($digits, $start, $len));

                // Ignore numbers smaller than low
                if ($num < $low) {
                    continue;
                }

                // Ignore numbers larger than high
                if ($num > $high) {
                    continue;
                }

                // Valid sequential number
                $result[] = $num;
            }
        }

        // Numbers are already generated in increasing order,
        // but sorting guarantees the required output.
        sort($result);

        // Return final answer
        return $result;
    }
}