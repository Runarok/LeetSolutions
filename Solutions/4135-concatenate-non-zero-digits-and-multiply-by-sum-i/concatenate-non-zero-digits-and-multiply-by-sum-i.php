class Solution {

    /**
     * @param Integer $n
     * @return Integer
     */
    function sumAndMultiply($n) {

        // Convert the number into a string so that
        // we can process each digit one by one.
        $num = strval($n);

        // This will store the newly formed number (x)
        // containing only non-zero digits.
        $x = "";

        // This will store the sum of the digits of x.
        $sum = 0;

        // Traverse every character (digit) in the string.
        for ($i = 0; $i < strlen($num); $i++) {

            // Get the current digit.
            $digit = $num[$i];

            // Ignore zeros.
            if ($digit != '0') {

                // Append the non-zero digit to x.
                $x .= $digit;

                // Add its numeric value to the sum.
                $sum += intval($digit);
            }
        }

        // If x is still empty, it means there were
        // no non-zero digits in the original number.
        // According to the problem, x should be 0.
        if ($x == "") {
            return 0;
        }

        // Convert x from string to integer.
        $x = intval($x);

        // Return x multiplied by the sum of its digits.
        return $x * $sum;
    }
}