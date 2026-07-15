class Solution {

    /**
     * @param Integer $n
     * @return Integer
     */
    function gcdOfOddEvenSums($n) {

        // The sum of the first n odd numbers is n^2.
        // Example:
        // n = 4
        // 1 + 3 + 5 + 7 = 16 = 4^2

        // The sum of the first n even numbers is n(n + 1).
        // Example:
        // n = 4
        // 2 + 4 + 6 + 8 = 20 = 4 * 5

        // We need:
        // gcd(n^2, n(n + 1))

        // Factor out n:
        // gcd(n^2, n(n + 1))
        // = n * gcd(n, n + 1)

        // Since consecutive numbers are always coprime,
        // gcd(n, n + 1) = 1.

        // Therefore the answer is simply n.
        return $n;
    }
}