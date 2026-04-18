public class Solution {
    public int MirrorDistance(int n) {
        // We will compute the reverse of n digit by digit.
        // Example: 25 -> 52, 10 -> 1 (leading zeros are ignored in integer form)

        int original = n;
        int reversed = 0;

        // Loop until all digits are processed
        while (n > 0) {
            // Extract the last digit of n
            int digit = n % 10;

            // Append it to the reversed number
            // Multiply current reversed by 10 to shift digits left
            reversed = reversed * 10 + digit;

            // Remove last digit from n
            n /= 10;
        }

        // Compute absolute difference between original and reversed number
        int result = original - reversed;

        // Math.Abs ensures non-negative result
        return Math.Abs(result);
    }
}