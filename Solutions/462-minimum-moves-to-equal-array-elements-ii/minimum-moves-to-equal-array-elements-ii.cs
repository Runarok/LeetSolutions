
public class Solution {
    public int MinMoves2(int[] nums) {

        // Step 1: Sort the array in ascending order.
        // Sorting helps us find the median element.
        // The median is the middle element of a sorted array.
        Array.Sort(nums);

        // Step 2: Find the middle index.
        int n = nums.Length;

        // If the array has an odd number of elements,
        // there is exactly one middle element.
        //
        // If the array has an even number of elements,
        // there are two middle elements.
        // We can choose either one as the target value.
        //
        // Integer division automatically gives us
        // the middle index.
        int median = nums[n / 2];

        // Step 3: Calculate the total number of moves.
        //
        // To make every element equal to the median,
        // we need to calculate the distance between
        // each element and the median.
        //
        // Math.Abs() gives us the positive difference.
        //
        // Example:
        // nums = [1, 2, 3]
        // median = 2
        //
        // Moves:
        // |1 - 2| = 1
        // |2 - 2| = 0
        // |3 - 2| = 1
        //
        // Total moves = 1 + 0 + 1 = 2.

        int moves = 0;

        // Loop through every element in the array.
        for (int i = 0; i < n; i++) {

            // Calculate how many increments or decrements
            // are required to make the current element
            // equal to the median.
            moves += Math.Abs(nums[i] - median);
        }

        // Step 4: Return the total minimum moves.
        return moves;
    }
}
