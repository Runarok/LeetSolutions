public class Solution {
    public int RotatedDigits(int n) {
        int count = 0; // Stores number of good numbers
        
        // Loop from 1 to n
        for (int i = 1; i <= n; i++) {
            if (IsGood(i)) {
                count++; // Increment if number is good
            }
        }
        
        return count;
    }
    
    // Helper method to check if a number is good
    private bool IsGood(int num) {
        bool hasDifferentDigit = false; 
        // This ensures the rotated number is DIFFERENT
        
        while (num > 0) {
            int digit = num % 10; // Get last digit
            
            // If digit is invalid after rotation → return false
            if (digit == 3 || digit == 4 || digit == 7) {
                return false;
            }
            
            // If digit changes after rotation → mark flag
            if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                hasDifferentDigit = true;
            }
            
            num /= 10; // Remove last digit
        }
        
        // Valid only if:
        // 1. No invalid digits
        // 2. At least one digit changes
        return hasDifferentDigit;
    }
}