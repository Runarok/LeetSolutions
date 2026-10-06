public class Solution
{
    public int MinAddToMakeValid(string s)
    {
        // 'open' keeps track of opening parentheses '('
        // that are currently waiting for a matching ')'.
        int open = 0;

        // 'add' counts how many parentheses we need to insert
        // to make the string valid.
        int add = 0;

        // Go through every character in the string.
        foreach (char c in s)
        {
            if (c == '(')
            {
                // We found an opening parenthesis.
                // It can potentially match a ')' later.
                open++;
            }
            else // c == ')'
            {
                // If there is an unmatched '(' available,
                // this ')' can match with it.
                if (open > 0)
                {
                    open--;
                }
                else
                {
                    // There is no '(' available to match this ')'.
                    // Therefore, we must insert an '(' before it.
                    add++;
                }
            }
        }

        // At this point, 'open' represents '(' characters
        // that never found a matching ')'.
        //
        // Each unmatched '(' needs one ')' inserted after it.
        //
        // 'add' represents the '(' characters we had to insert
        // for unmatched ')'.
        //
        // Therefore, the total number of insertions is:
        return add + open;
    }
}
