public class Solution
{
    public IList<string> RemoveInvalidParentheses(string s)
    {
        // HashSet is used so that duplicate valid strings
        // are automatically removed.
        var result = new HashSet<string>();

        // ------------------------------------------------------------
        // Find how many '(' and ')' must be removed.
        // ------------------------------------------------------------

        int leftToRemove = 0;
        int rightToRemove = 0;

        int balance = 0;

        foreach (char c in s)
        {
            if (c == '(')
            {
                // We have one more opening parenthesis.
                balance++;
            }
            else if (c == ')')
            {
                if (balance > 0)
                {
                    // This ')' can match an earlier '('.
                    balance--;
                }
                else
                {
                    // There is no '(' available to match this ')'.
                    // Therefore this ')' must be removed.
                    rightToRemove++;
                }
            }
        }

        // Any unmatched '(' remaining in balance must be removed.
        leftToRemove = balance;

        // ------------------------------------------------------------
        // Start DFS.
        // ------------------------------------------------------------

        DFS(
            s,
            0,
            leftToRemove,
            rightToRemove,
            0,
            new StringBuilder(),
            result
        );

        return result.ToList();
    }

    private void DFS(
        string s,
        int index,
        int leftToRemove,
        int rightToRemove,
        int balance,
        StringBuilder current,
        HashSet<string> result)
    {
        // ------------------------------------------------------------
        // We have processed the complete string.
        // ------------------------------------------------------------

        if (index == s.Length)
        {
            // A valid answer must:
            //
            // 1. Use all required removals.
            // 2. Have balance == 0.
            //
            // balance == 0 means every '(' has been matched
            // by a corresponding ')'.
            if (leftToRemove == 0 &&
                rightToRemove == 0 &&
                balance == 0)
            {
                result.Add(current.ToString());
            }

            return;
        }

        char c = s[index];

        // ============================================================
        // CASE 1: '('
        // ============================================================

        if (c == '(')
        {
            // --------------------------------------------------------
            // OPTION 1:
            // Remove this '('.
            // --------------------------------------------------------

            if (leftToRemove > 0)
            {
                DFS(
                    s,
                    index + 1,
                    leftToRemove - 1,
                    rightToRemove,
                    balance,
                    current,
                    result
                );
            }

            // --------------------------------------------------------
            // OPTION 2:
            // Keep this '('.
            //
            // It increases our balance by 1.
            // --------------------------------------------------------

            current.Append('(');

            DFS(
                s,
                index + 1,
                leftToRemove,
                rightToRemove,
                balance + 1,
                current,
                result
            );

            // Backtrack.
            current.Length--;
        }

        // ============================================================
        // CASE 2: ')'
        // ============================================================

        else if (c == ')')
        {
            // --------------------------------------------------------
            // OPTION 1:
            // Remove this ')'.
            //
            // IMPORTANT:
            // We do NOT skip duplicate ')' characters here.
            //
            // For input "))", we need to be able to remove:
            //
            // first ')'
            // AND
            // second ')'
            //
            // The HashSet takes care of duplicate resulting strings.
            // --------------------------------------------------------

            if (rightToRemove > 0)
            {
                DFS(
                    s,
                    index + 1,
                    leftToRemove,
                    rightToRemove - 1,
                    balance,
                    current,
                    result
                );
            }

            // --------------------------------------------------------
            // OPTION 2:
            // Keep this ')'.
            //
            // We can only keep ')' if there is an unmatched '('.
            // Otherwise the parentheses would immediately become
            // invalid.
            // --------------------------------------------------------

            if (balance > 0)
            {
                current.Append(')');

                DFS(
                    s,
                    index + 1,
                    leftToRemove,
                    rightToRemove,
                    balance - 1,
                    current,
                    result
                );

                // Backtrack.
                current.Length--;
            }
        }

        // ============================================================
        // CASE 3: Letter
        // ============================================================

        else
        {
            // Letters never affect parentheses balance,
            // so we always keep them.

            current.Append(c);

            DFS(
                s,
                index + 1,
                leftToRemove,
                rightToRemove,
                balance,
                current,
                result
            );

            // Backtrack.
            current.Length--;
        }
    }
}