public class Solution
{
    public bool SumGame(string num)
    {
        int half = num.Length / 2;

        // Difference between the known digit sums:
        //
        //     diff = leftSum - rightSum
        //
        // '?' characters are not included yet because
        // their values will be chosen during the game.
        int diff = 0;

        // Count '?' characters in each half.
        int leftQuestions = 0;
        int rightQuestions = 0;

        // ------------------------------------------------------------
        // Process the left half.
        // ------------------------------------------------------------
        for (int i = 0; i < half; i++)
        {
            if (num[i] == '?')
            {
                // This position can later contribute 0..9.
                leftQuestions++;
            }
            else
            {
                // Digits in the left half increase the difference.
                diff += num[i] - '0';
            }
        }

        // ------------------------------------------------------------
        // Process the right half.
        // ------------------------------------------------------------
        for (int i = half; i < num.Length; i++)
        {
            if (num[i] == '?')
            {
                // This position can later contribute 0..9
                // to the right sum, which decreases diff.
                rightQuestions++;
            }
            else
            {
                // Digits in the right half decrease the difference.
                diff -= num[i] - '0';
            }
        }

        // ------------------------------------------------------------
        // Bob can win only if the existing difference can be
        // exactly compensated by the unmatched '?' characters.
        //
        // Each pair of unmatched '?' moves can contribute
        // a maximum difference of 9.
        //
        // The exact condition is:
        //
        //     2 * diff == 9 * (rightQuestions - leftQuestions)
        //
        // Notice that we MUST NOT use absolute values here.
        // The direction of the difference matters.
        // ------------------------------------------------------------

        bool bobCanWin =
            2 * diff == 9 * (rightQuestions - leftQuestions);

        // If Bob can force equality, Alice loses.
        // Otherwise Alice can force the sums to be different.
        return !bobCanWin;
    }
}
