class Solution {

    // This method constructs a transformed array based on index jumps
    public int[] constructTransformedArray(int[] nums) {

        // Store the length of the input array
        int length = nums.length;

        // Create a new array to store the result
        int[] result = new int[length];

        // Loop through each index of the array
        for (int index = 0; index < length; index++) {

            // If the current value is 0
            // → no movement is required
            // → directly place 0 in the result array
            if (nums[index] == 0) {
                result[index] = 0;
                continue; // move to the next index
            }

            // Calculate the target position:
            // 1. nums[index] % length limits the jump size
            // 2. index + jump moves forward or backward
            // 3. + length ensures the value is non-negative
            // 4. % length wraps around the array boundaries
            int pos = (index + nums[index] % length + length) % length;

            // Assign the value found at the computed position
            // in the original array to the result array
            result[index] = nums[pos];
        }

        // Return the fully constructed transformed array
        return result;
    }
}
