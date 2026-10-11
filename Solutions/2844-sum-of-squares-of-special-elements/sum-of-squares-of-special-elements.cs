public class Solution
{
    public int SumOfSquares(int[] nums)
    {
        // Get the total number of elements in the array.
        // Since the array is 1-indexed in the problem,
        // the positions are considered to be 1, 2, 3, ..., n.
        int n = nums.Length;

        // This variable stores the sum of the squares
        // of all special elements.
        // Initially, the sum is 0 because we have not
        // processed any elements yet.
        int sum = 0;

        // Loop through every element using its 1-based position.
        // i represents the position of the current element.
        // We start at 1 because the problem uses 1-indexing.
        for (int i = 1; i <= n; i++)
        {
            // An element is special if its position divides n.
            // In other words, n % i must equal 0.
            //
            // Example:
            // If n = 4:
            // 4 % 1 == 0  -> Special
            // 4 % 2 == 0  -> Special
            // 4 % 3 != 0  -> Not special
            // 4 % 4 == 0  -> Special
            if (n % i == 0)
            {
                // C# arrays use 0-based indexing.
                // Therefore, the element at the 1-based position i
                // is stored at the array index i - 1.
                int value = nums[i - 1];

                // Square the special element.
                // Squaring means multiplying the value by itself.
                int square = value * value;

                // Add the squared value to our running total.
                sum += square;
            }
        }

        // Return the final sum of the squares
        // of all special elements.
        return sum;
    }
}