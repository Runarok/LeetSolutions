from typing import List

class Solution:
    def triangleNumber(self, nums: List[int]) -> int:
        # First, sort the array to simplify comparison
        nums.sort()
        
        count = 0  # This will store the total number of valid triangles
        n = len(nums)
        
        # Loop from the end to the third element
        # We're treating nums[k] as the longest side of the triangle
        for k in range(n - 1, 1, -1):
            i = 0           # Left pointer (smallest side)
            j = k - 1       # Right pointer (middle side)
            
            # Two-pointer approach
            while i < j:
                # If the sum of the two smaller sides > longest side
                if nums[i] + nums[j] > nums[k]:
                    # All values from i to j-1 will also satisfy the condition with j and k
                    count += j - i
                    j -= 1  # Move the middle pointer left
                else:
                    i += 1  # Increase the smallest side to try and satisfy the condition

        return count
