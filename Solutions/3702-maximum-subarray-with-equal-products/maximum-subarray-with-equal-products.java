
class Solution {
    public int maxLength(int[] nums) {

        // Store the size of the input array
        int n = nums.length;

        // Stores the maximum length of a valid subarray
        int maxLen = 0;

        // Try every possible starting index
        for (int i = 0; i < n; i++) {

            // Initially, the subarray contains no elements
            long product = 1;

            // GCD and LCM are initialized with the first element
            int gcd = 0;
            long lcm = 1;

            // Extend the subarray from index i to the right
            for (int j = i; j < n; j++) {

                // Include the current element in the product
                product *= nums[j];

                // Update GCD of the current subarray
                gcd = findGCD(gcd, nums[j]);

                // Update LCM of the current subarray
                // LCM(a, b) = (a / GCD(a, b)) * b
                lcm = (lcm / findGCD((int) lcm, nums[j]))
                        * nums[j];

                // Check the product equivalent condition
                if (product == (long) gcd * lcm) {

                    // Update the maximum valid subarray length
                    maxLen = Math.max(maxLen, j - i + 1);
                }
            }
        }

        // Return the longest valid subarray length
        return maxLen;
    }

    // Function to calculate GCD using Euclidean algorithm
    private int findGCD(int a, int b) {

        // Repeat until the remainder becomes zero
        while (b != 0) {

            int remainder = a % b;

            a = b;
            b = remainder;
        }

        // The remaining value is the GCD
        return a;
    }
}
