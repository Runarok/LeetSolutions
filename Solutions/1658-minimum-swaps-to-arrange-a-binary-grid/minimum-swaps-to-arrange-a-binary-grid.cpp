class Solution {
public:
    int minSwaps(vector<vector<int>>& grid) {
        int n = grid.size();
        
        // Step 1: Count trailing zeros for each row
        vector<int> trailingZeros(n);
        
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = n - 1; j >= 0; j--) {
                if (grid[i][j] == 0)
                    count++;
                else
                    break;  // stop when first 1 appears
            }
            trailingZeros[i] = count;
        }
        
        int swaps = 0;
        
        // Step 2: For each row position
        for (int i = 0; i < n; i++) {
            
            // Required trailing zeros for this row
            int required = n - 1 - i;
            
            int j = i;
            
            // Find first row below with enough trailing zeros
            while (j < n && trailingZeros[j] < required) {
                j++;
            }
            
            // If not found → impossible
            if (j == n) return -1;
            
            // Bring row j up to position i using adjacent swaps
            while (j > i) {
                swap(trailingZeros[j], trailingZeros[j - 1]);
                j--;
                swaps++;
            }
        }
        
        return swaps;
    }
};