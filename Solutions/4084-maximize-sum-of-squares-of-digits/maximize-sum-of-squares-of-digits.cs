public class Solution
{
    public string MaxSumOfSquares(int num, int sum)
    {
        // A number with 'num' digits can have a digit sum
        // between 1 and 9 * num.
        //
        // If the required sum is greater than 9 * num,
        // it is impossible to create such a number.
        if (sum > 9 * num)
        {
            return "";
        }

        // If sum is zero, we could only make a number
        // consisting entirely of zeros.
        //
        // However, the problem requires sum >= 1,
        // so this case is not needed for the given constraints.
        if (sum == 0)
        {
            return "";
        }

        // We use StringBuilder because num can be as large
        // as 200,000 digits. Building a string repeatedly
        // with += would create many unnecessary string objects.
        System.Text.StringBuilder result =
            new System.Text.StringBuilder(num);

        // Keep track of how much digit sum is still needed.
        int remainingSum = sum;

        // Fill the number from left to right.
        // Choosing the largest possible digit at each position
        // ensures the maximum score and, in case of a tie,
        // the largest possible number.
        for (int i = 0; i < num; i++)
        {
            // Each digit can be at most 9.
            // If the remaining sum is greater than 9,
            // place 9 in the current position.
            //
            // Otherwise, place the entire remaining sum
            // into this position.
            //
            // Math.Min ensures that the digit is between 0 and 9.
            int digit = Math.Min(9, remainingSum);

            // Append the chosen digit to our answer.
            result.Append(digit);

            // Subtract the digit we just placed
            // from the remaining sum.
            remainingSum -= digit;
        }

        // If remainingSum is zero, all the required sum
        // has been distributed among the digits.
        //
        // If it is not zero, there was not enough room
        // to represent the requested sum.
        // Return an empty string in that case.
        if (remainingSum != 0)
        {
            return "";
        }

        // Convert the StringBuilder into a string and return it.
        return result.ToString();
    }
}