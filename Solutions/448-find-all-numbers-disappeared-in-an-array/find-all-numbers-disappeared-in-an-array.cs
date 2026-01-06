public class Solution {
    public IList<int> FindDisappearedNumbers(int[] nums) {
        // List to store the missing numbers
        IList<int> result = new List<int>();

        // Step 1: Mark numbers as seen
        for (int i = 0; i < nums.Length; i++) {
            // Get the index corresponding to the value
            int index = Math.Abs(nums[i]) - 1;

            // Mark the number at that index as negative (if not already)
            if (nums[index] > 0) {
                nums[index] = -nums[index];
            }
        }

        // Step 2: Find all indices that are still positive
        for (int i = 0; i < nums.Length; i++) {
            if (nums[i] > 0) {
                // i + 1 is missing
                result.Add(i + 1);
            }
        }

        // Return the list of missing numbers
        return result;
    }
}
