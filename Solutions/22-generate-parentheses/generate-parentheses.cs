using System.Collections.Generic;
using System.Text;

public class Solution {
    public IList<string> GenerateParenthesis(int n) {
        // Result list to store all valid combinations of well-formed parentheses
        IList<string> result = new List<string>();

        // StringBuilder acts as our mutable tracking buffer (much more efficient than string concatenation)
        StringBuilder currentPath = new StringBuilder();

        // Start the recursive backtracking process:
        // - openCount: tracks how many '(' we have added so far (starts at 0)
        // - closeCount: tracks how many ')' we have added so far (starts at 0)
        // - n: total pairs required
        Backtrack(result, currentPath, 0, 0, n);

        return result;
    }

    private void Backtrack(IList<string> result, StringBuilder currentPath, int openCount, int closeCount, int maxPairs) {
        // BASE CASE:
        // A valid combination is formed when the length of currentPath equals 2 * n
        // (i.e., openCount == maxPairs AND closeCount == maxPairs).
        if (currentPath.Length == maxPairs * 2) {
            // Add a snapshot copy of the current valid string to our result list
            result.Add(currentPath.ToString());
            return; // Backtrack to explore other choices
        }

        // DECISION 1: Can we add an OPENING parenthesis '(' ?
        // Constraint: We can only place '(' if we haven't reached the maximum allowed limit (n).
        if (openCount < maxPairs) {
            // CHOOSE: Append '(' to our build path
            currentPath.Append('(');

            // RECURSE: Move to the next state, incrementing openCount
            Backtrack(result, currentPath, openCount + 1, closeCount, maxPairs);

            // UNCHOOSE (BACKTRACK): Remove the '(' we just added to restore state for alternative paths
            currentPath.Length--;
        }

        // DECISION 2: Can we add a CLOSING parenthesis ')' ?
        // Constraint: We can ONLY place ')' if there are unmatched '(' available.
        // That means closeCount must be STRICTLY LESS than openCount.
        if (closeCount < openCount) {
            // CHOOSE: Append ')' to our build path
            currentPath.Append(')');

            // RECURSE: Move to the next state, incrementing closeCount
            Backtrack(result, currentPath, openCount, closeCount + 1, maxPairs);

            // UNCHOOSE (BACKTRACK): Remove the ')' we just added to restore state for alternative paths
            currentPath.Length--;
        }
    }
}