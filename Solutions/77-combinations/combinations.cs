public class Solution {
    public IList<IList<int>> Combine(int n, int k) {
        // This will store all valid combinations
        var result = new List<IList<int>>();
        // Temporary list to build each combination
        var combination = new List<int>();

        // Start the backtracking process from number 1
        Backtrack(1, n, k, combination, result);

        return result;
    }

    private void Backtrack(int start, int n, int k, List<int> combination, List<IList<int>> result) {
        // Base case: if the current combination has k numbers, it's complete
        if (combination.Count == k) {
            // Add a copy of the current combination to the result
            result.Add(new List<int>(combination));
            return;
        }

        // Loop through numbers from 'start' to 'n'
        // 'start' ensures we only move forward to avoid duplicates
        for (int i = start; i <= n; i++) {
            // Choose the current number by adding it to the combination
            combination.Add(i);
            
            // Explore further by recursively adding the next numbers
            // i + 1 ensures we don't reuse the same number
            Backtrack(i + 1, n, k, combination, result);

            // Un-choose: remove the last number to try the next one
            combination.RemoveAt(combination.Count - 1);
        }
    }
}
