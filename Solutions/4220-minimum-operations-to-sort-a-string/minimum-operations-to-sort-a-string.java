class Solution {
    public int minOperations(String s) {
        int n = s.length();
        boolean isSorted = true;
        
        char mn = s.charAt(0);
        char mx = s.charAt(0);
        
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) < s.charAt(i - 1)) {
                isSorted = false;
            }
            mn = (char) Math.min(mn, s.charAt(i));
            mx = (char) Math.max(mx, s.charAt(i));
        }
        
        // Case 1: Already sorted
        if (isSorted) {
            return 0;
        }
        
        // Case 2: Length 2 cannot be sorted with proper substrings
        if (n == 2) {
            return -1;
        }
        
        // Case 3: Min is already at the start or max is already at the end
        if (s.charAt(0) == mn || s.charAt(n - 1) == mx) {
            return 1;
        }
        
        // Case 4: Min or max is in the interior
        for (int i = 1; i < n - 1; i++) {
            if (s.charAt(i) == mn || s.charAt(i) == mx) {
                return 2;
            }
        }
        
        // Case 5: Fallback when min is at the end and max is at the start
        return 3;
    }
}