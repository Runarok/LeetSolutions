class Solution {

    /**
     * Calculates the difference between:
     * - The sum of all integers from 1 to n that are NOT divisible by m (num1)
     * and
     * - The sum of all integers from 1 to n that ARE divisible by m (num2)
     *
     * @param Integer $n The upper bound of the range (1 to n)
     * @param Integer $m The divisor used to separate integers into divisible and not divisible
     * @return Integer The difference num1 - num2
     */
    function differenceOfSums($n, $m) {
        // Step 1:
        // Calculate the sum of all integers from 1 to n.
        // Using the arithmetic series formula:
        // sum = n * (n + 1) / 2
        // This is the sum of all numbers regardless of divisibility by m.
        $totalSum = $n * ($n + 1) / 2;

        // Step 2:
        // Find how many integers in [1, n] are divisible by m.
        // This is simply the integer division of n by m,
        // because multiples of m are: m, 2m, 3m, ..., k*m where k = floor(n/m).
        $k = intdiv($n, $m);

        // Step 3:
        // Calculate the sum of all integers divisible by m.
        // Multiples of m: m, 2m, 3m, ..., k*m
        // Sum of these multiples:
        // = m * (1 + 2 + 3 + ... + k)
        // Using the arithmetic series formula again for 1 + 2 + ... + k:
        // sum = k * (k + 1) / 2
        // So,
        // divisibleSum = m * k * (k + 1) / 2
        $divisibleSum = $m * $k * ($k + 1) / 2;

        // Step 4:
        // Calculate the sum of integers NOT divisible by m.
        // Since totalSum = sum of all numbers,
        // and divisibleSum = sum of numbers divisible by m,
        // then
        // notDivisibleSum = totalSum - divisibleSum
        //
        // We don't need to store notDivisibleSum explicitly since
        // the result required is num1 - num2 = notDivisibleSum - divisibleSum
        //
        // Simplify the expression:
        // result = (totalSum - divisibleSum) - divisibleSum
        //        = totalSum - 2 * divisibleSum
        //
        // This reduces computation and uses less memory.
        $result = $totalSum - 2 * $divisibleSum;

        // Step 5:
        // Return the final difference as an integer.
        return (int)$result;
    }
}
