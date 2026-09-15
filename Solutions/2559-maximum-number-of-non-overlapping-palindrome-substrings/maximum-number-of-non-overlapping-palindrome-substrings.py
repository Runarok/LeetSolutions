class Solution:
    def maxPalindromes(self, s: str, k: int) -> int:
        n = len(s)
        ans = 0
        
        # We process the string using an index 'i' representing the 
        # end boundary of the last selected palindrome.
        last_end = -1
        
        # We iterate over every possible center of a palindrome.
        # Total possible centers = 2 * n - 1 (n single-character centers + n-1 two-character centers)
        for center in range(2 * n - 1):
            # Left and right character indices based on the current center point
            left = center // 2
            right = left + (center % 2)
            
            # Expand outwards from the current center
            while left >= 0 and right < n and s[left] == s[right]:
                current_len = right - left + 1
                
                # Check if this palindrome starts after the last chosen palindrome
                if left > last_end:
                    # If it meets or exceeds the required length k:
                    if current_len >= k:
                        ans += 1
                        last_end = right  # Greedily mark the end of this palindrome
                        break  # Stop expanding this center and move to the next available position
                else:
                    # If the left boundary overlaps with a previously selected palindrome,
                    # expanding further from this center won't help us.
                    break
                
                # Expand outwards
                left -= 1
                right += 1
                
        return ans