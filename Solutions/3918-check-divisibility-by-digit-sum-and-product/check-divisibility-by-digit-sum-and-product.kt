class Solution {
    fun checkDivisibility(n: Int): Boolean {
        // Store the original number because we will modify a copy
        // while extracting its digits.
        var temp = n

        // This will hold the sum of all digits.
        var digitSum = 0

        // Start the product at 1 because 1 is the
        // multiplicative identity.
        var digitProduct = 1

        // Process every digit of n.
        while (temp > 0) {
            // Get the last digit.
            val digit = temp % 10

            // Add the digit to the digit sum.
            digitSum += digit

            // Multiply the digit into the digit product.
            digitProduct *= digit

            // Remove the last digit.
            temp /= 10
        }

        // The required divisor is:
        // digit sum + digit product
        val divisor = digitSum + digitProduct

        // Return true if n is evenly divisible by the divisor.
        return n % divisor == 0
    }
}