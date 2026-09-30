public class Solution 
{
    /// <summary>
    /// Splits a valid parentheses string (seq) into two valid subsequences A and B 
    /// such that max(depth(A), depth(B)) is minimized.
    /// </summary>
    /// <param name="seq">The input valid parentheses string (VPS).</param>
    /// <returns>An array where answer[i] = 0 (belongs to A) or 1 (belongs to B).</returns>
    public int[] MaxDepthAfterSplit(string seq) 
    {
        int n = seq.Length;
        int[] answer = new int[n];

        // Track the current nesting depth level of the sequence.
        int currentDepth = 0;

        for (int i = 0; i < n; i++) 
        {
            char c = seq[i];

            if (c == '(') 
            {
                // Increment the depth when opening a new nested block.
                currentDepth++;

                // Assign to subsequence A (0) if depth is even, or B (1) if depth is odd.
                // This ensures adjacent nested parentheses alternate between groups A and B,
                // halving the maximum depth experienced by either group.
                answer[i] = currentDepth % 2;
            } 
            else 
            {
                // For a closing parenthesis ')', match the depth of its opening bracket.
                answer[i] = currentDepth % 2;

                // Decrement the current depth level as the nested block ends.
                currentDepth--;
            }
        }

        return answer;
    }
}