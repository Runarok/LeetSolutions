class Solution {

    // Constant modulus to prevent overflow and ensure results fit within limits.
    static final int mod = 1000000007;

    public int colorTheGrid(int m, int n) {
        // 'valid' map stores all valid row configurations where each key is the row mask
        // and the value is the list of colors for that row.
        Map<Integer, List<Integer>> valid = new HashMap<>();
        
        // Calculate the total number of possible row configurations for a grid with m columns.
        // This is 3^m because each cell in a row can have 3 different colors.
        int maskEnd = (int) Math.pow(3, m);

        // Loop through all possible row configurations from 0 to 3^m-1.
        for (int mask = 0; mask < maskEnd; ++mask) {
            List<Integer> color = new ArrayList<>();
            int mm = mask;
            
            // Convert the current mask into a list of colors for the row (in base 3).
            for (int i = 0; i < m; ++i) {
                color.add(mm % 3);  // The remainder when divided by 3 gives the color.
                mm /= 3;            // Move to the next "digit" in base 3.
            }
            
            // Check if adjacent cells in the row have the same color.
            boolean check = true;
            for (int i = 0; i < m - 1; ++i) {
                if (color.get(i).equals(color.get(i + 1))) {
                    check = false;  // If two adjacent cells have the same color, it's invalid.
                    break;
                }
            }

            // If no adjacent cells have the same color, the row is valid.
            if (check) {
                valid.put(mask, color);  // Store the valid row configuration in the 'valid' map.
            }
        }

        // 'adjacent' map stores pairs of valid row configurations (mask1, mask2),
        // where mask2 can follow mask1 as two adjacent rows without violating the column color constraints.
        Map<Integer, List<Integer>> adjacent = new HashMap<>();

        // Now, we need to check for valid adjacent row configurations.
        for (int mask1 : valid.keySet()) {
            for (int mask2 : valid.keySet()) {
                boolean check = true;

                // Compare each column in mask1 and mask2 to ensure that no two cells in the same column
                // of consecutive rows (mask1 and mask2) have the same color.
                for (int i = 0; i < m; ++i) {
                    if (valid.get(mask1).get(i).equals(valid.get(mask2).get(i))) {
                        check = false;  // If two adjacent rows have the same color in a column, they're invalid.
                        break;
                    }
                }

                // If the two rows are valid adjacent rows, store them in the 'adjacent' map.
                if (check) {
                    adjacent
                        .computeIfAbsent(mask1, k -> new ArrayList<>())  // Initialize list if not already present.
                        .add(mask2);  // Add mask2 as a valid adjacent row configuration after mask1.
                }
            }
        }

        // 'f' is a dynamic programming map where f(mask) holds the number of ways to color the grid up to a given row,
        // using the row configuration represented by 'mask'.
        Map<Integer, Integer> f = new HashMap<>();
        
        // Initialize the dynamic programming map for the first row.
        // Each valid row configuration for the first row has exactly 1 way to color it.
        for (int mask : valid.keySet()) {
            f.put(mask, 1);  // For the first row, there is exactly 1 way to color for each valid row configuration.
        }

        // Now, we compute the number of ways to color the grid row by row.
        // We start from the second row and work our way up to the nth row.
        for (int i = 1; i < n; ++i) {
            Map<Integer, Integer> g = new HashMap<>();  // Temporary map to store ways to color after processing current row.

            // For each valid configuration of the current row (mask2),
            // consider all valid previous row configurations (mask1) that can precede it.
            for (int mask2 : valid.keySet()) {
                for (int mask1 : adjacent.getOrDefault(mask2, new ArrayList<>())) {
                    // Add the number of ways to color the grid for mask1 to the current number of ways for mask2.
                    g.put(
                        mask2,  // For current row configuration mask2.
                        (g.getOrDefault(mask2, 0) + f.getOrDefault(mask1, 0)) % mod  // Update using mod to avoid overflow.
                    );
                }
            }

            // After processing the current row, update f to store the results for the next row.
            f = g;
        }

        // The answer is the sum of the number of ways to color the grid for each valid configuration of the last row.
        // We sum all values in the map f and return the result modulo 1000000007.
        int ans = 0;
        for (int num : f.values()) {
            ans = (ans + num) % mod;  // Sum all valid configurations, modulo mod.
        }

        // Return the final answer.
        return ans;
    }
}
