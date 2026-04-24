public class Solution {
    public int FurthestDistanceFromOrigin(string moves) {
        
        // Count number of Left, Right, and Underscore moves
        int left = 0;
        int right = 0;
        int blank = 0;
        
        foreach (char c in moves) {
            if (c == 'L') {
                left++;   // move left → -1
            }
            else if (c == 'R') {
                right++;  // move right → +1
            }
            else {
                blank++;  // can be either -1 or +1
            }
        }
        
        // Current position without using '_'
        // Right moves push +1, Left moves push -1
        int position = right - left;
        
        // To maximize distance:
        // Use all '_' in the same direction as current displacement
        // OR choose one direction entirely if position is 0
        
        // Final answer is absolute position + all blanks
        return Math.Abs(position) + blank;
    }
}