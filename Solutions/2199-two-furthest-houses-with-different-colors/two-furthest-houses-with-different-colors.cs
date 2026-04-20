public class Solution {
    public int MaxDistance(int[] colors) {
        
        // n = number of houses
        int n = colors.Length;
        
        // Result will store the maximum distance found
        int maxDistance = 0;

        // ---------------------------------------------
        // Case 1: Fix the first house (index 0)
        // Try to find the farthest house from the right
        // that has a different color than colors[0]
        // ---------------------------------------------
        for (int j = n - 1; j >= 0; j--) 
        {
            // If we find a different color, compute distance
            if (colors[j] != colors[0]) 
            {
                // distance between first and this index
                maxDistance = Math.Max(maxDistance, j - 0);
                
                // We can break here because j is already the farthest possible
                break;
            }
        }

        // ---------------------------------------------
        // Case 2: Fix the last house (index n - 1)
        // Try to find the farthest house from the left
        // that has a different color than colors[n-1]
        // ---------------------------------------------
        for (int i = 0; i < n; i++) 
        {
            // If we find a different color
            if (colors[i] != colors[n - 1]) 
            {
                // distance between this index and last index
                maxDistance = Math.Max(maxDistance, (n - 1) - i);
                
                // Break since i is the farthest from the left
                break;
            }
        }

        // return the best answer found
        return maxDistance;
    }
}