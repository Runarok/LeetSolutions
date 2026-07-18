class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function findGCD($nums) {

        // -----------------------------------------
        // Step 1: Find the smallest and largest
        // numbers in the array.
        // -----------------------------------------

        // Initialize both min and max with
        // the first element of the array.
        $min = $nums[0];
        $max = $nums[0];

        // Traverse the array to update
        // the minimum and maximum values.
        foreach ($nums as $num) {

            // If current number is smaller,
            // update the minimum.
            if ($num < $min) {
                $min = $num;
            }

            // If current number is larger,
            // update the maximum.
            if ($num > $max) {
                $max = $num;
            }
        }

        // -----------------------------------------
        // Step 2: Find the Greatest Common Divisor
        // (GCD) of the smallest and largest numbers.
        //
        // We use the Euclidean Algorithm:
        //
        // gcd(a, b):
        // while b != 0
        //     temp = b
        //     b = a % b
        //     a = temp
        //
        // When b becomes 0,
        // a contains the GCD.
        // -----------------------------------------

        while ($max != 0) {

            // Store current max temporarily.
            $temp = $max;

            // Replace max with the remainder.
            $max = $min % $max;

            // Replace min with previous max.
            $min = $temp;
        }

        // -----------------------------------------
        // Step 3: Return the GCD.
        // -----------------------------------------
        return $min;
    }
}