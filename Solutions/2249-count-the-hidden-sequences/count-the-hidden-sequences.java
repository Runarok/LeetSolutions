public class Solution {
    
    // This function computes the number of valid hidden sequences
    public int numberOfArrays(int[] differences, int lower, int upper) {
        
        // Initialize variables to track the min (x) and max (y) cumulative sums
        // `cur` keeps track of the current cumulative sum as we go through the differences
        int x = 0, y = 0, cur = 0;

        // Iterate through the differences array to compute cumulative sums
        for (int d : differences) {
            // Update the cumulative sum
            cur += d;

            // Track the minimum and maximum cumulative sum encountered so far
            x = Math.min(x, cur);  // x will be the smallest cumulative sum
            y = Math.max(y, cur);  // y will be the largest cumulative sum

            // If the range between y (max cumulative sum) and x (min cumulative sum)
            // exceeds the allowed range of the sequence (upper - lower), 
            // it means no valid sequence can be formed.
            if (y - x > upper - lower) {
                return 0;  // Return 0 because it's impossible to form a valid sequence
            }
        }
        
        // The valid range for hidden[0] must satisfy:
        // 1. Hidden[0] + x must be >= lower
        // 2. Hidden[0] + y must be <= upper
        // This translates to: 
        // lower - y <= hidden[0] <= upper - x
        // Thus, the number of valid values for hidden[0] is the difference
        // between upper - x and lower - y, plus 1 (to include both bounds).
        return (upper - lower) - (y - x) + 1;
    }
}
