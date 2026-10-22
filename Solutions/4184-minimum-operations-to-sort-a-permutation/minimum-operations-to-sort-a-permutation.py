class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        
        # Find the index where element 0 is located in the array
        zero = nums.index(0)
        
        # Helper function to check if the array elements form a valid 
        # increasing sequence starting from 0 with a given step direction (+1 or -1)
        def check(step: int) -> bool:
            for i in range(1, n):
                # Calculate previous and current indices based on the direction (step)
                prev = (zero + (i - 1) * step) % n
                curr = (zero + i * step) % n
                
                # Each subsequent element must be greater than the previous one
                if nums[prev] > nums[curr]:
                    return False
            return True
        
        ans = float('inf')
        
        # Case 1: The sequence increases to the right (clockwise / step = 1)
        if check(1):
            # Option A: Left-rotate the array directly by 'zero' positions
            ans = min(ans, zero)
            # Option B: Reverse the array, rotate by 'n - zero' positions, and reverse back (+2 operations)
            ans = min(ans, n - zero + 2)
            
        # Case 2: The sequence increases to the left (counter-clockwise / step = -1)
        if check(-1):
            # Option C: Rotate left by 'zero' positions, then reverse the array (+2 operations)
            ans = min(ans, zero + 2)
            # Option D: Reverse the array, then rotate left by 'n - zero' positions
            ans = min(ans, n - zero)
            
        # If ans was never updated, it is impossible to sort using the given operations
        return ans if ans != float('inf') else -1