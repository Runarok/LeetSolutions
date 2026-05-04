public class Solution {
    public void Rotate(int[][] matrix) {
        int n = matrix.Length;

        // -------------------------------
        // STEP 1: TRANSPOSE THE MATRIX
        // -------------------------------
        // Swap matrix[i][j] with matrix[j][i]
        // Only traverse upper triangle to avoid double swapping
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                
                // Swap elements
                int temp = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = temp;
            }
        }

        // -------------------------------
        // STEP 2: REVERSE EACH ROW
        // -------------------------------
        for (int i = 0; i < n; i++) {
            
            int left = 0;        // start of row
            int right = n - 1;   // end of row

            // Reverse row in-place
            while (left < right) {
                
                int temp = matrix[i][left];
                matrix[i][left] = matrix[i][right];
                matrix[i][right] = temp;

                left++;   // move forward
                right--;  // move backward
            }
        }
    }
}