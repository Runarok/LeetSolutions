public class Solution {
    public int areaOfMaxDiagonal(int[][] dimensions) {
        // To track the largest diagonal squared and corresponding max area
        int maxDiagonalSq = 0;
        int maxArea = 0;

        // Iterate through each rectangle
        for (int[] rect : dimensions) {
            int length = rect[0];
            int width = rect[1];

            // Calculate diagonal squared using Pythagoras theorem (no need to use sqrt)
            int diagonalSq = length * length + width * width;
            int area = length * width;

            // If current diagonal is longer, update both max diagonal and area
            if (diagonalSq > maxDiagonalSq) {
                maxDiagonalSq = diagonalSq;
                maxArea = area;
            }
            // If diagonals are equal, choose the rectangle with the larger area
            else if (diagonalSq == maxDiagonalSq && area > maxArea) {
                maxArea = area;
            }
        }

        // Return the area of the rectangle with the longest diagonal
        return maxArea;
    }
}
