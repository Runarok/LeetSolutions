class Solution {
    public boolean doesValidArrayExist(int[] derived) {
        int n = derived.length;

        // Try both possible values for original[0] (0 or 1)
        return checkOriginalStartingWith(derived, 0) || checkOriginalStartingWith(derived, 1);
    }

    // Helper function to check if an array can be valid starting with original[0] = start
    private boolean checkOriginalStartingWith(int[] derived, int start) {
        int n = derived.length;
        int[] original = new int[n];
        original[0] = start;
        
        // Compute the rest of the original array based on the derived array
        for (int i = 1; i < n; i++) {
            original[i] = derived[i - 1] ^ original[i - 1];
        }
        
        // Check if the last element satisfies the circular condition
        return (original[n - 1] ^ original[0]) == derived[n - 1];
    }
}
