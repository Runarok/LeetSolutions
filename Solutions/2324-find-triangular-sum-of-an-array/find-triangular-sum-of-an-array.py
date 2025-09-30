from typing import List

class Solution:
    def triangularSum(self, nums: List[int]) -> int:
        # Continue the process until only one element is left in the list
        while len(nums) > 1:
            # Create a new list to store the result of summing adjacent elements
            newNums = []
            
            # Iterate through the current list up to the second-to-last element
            for i in range(len(nums) - 1):
                # Add current element and the next one, then take modulo 10
                # Append the result to the new list
                newNums.append((nums[i] + nums[i + 1]) % 10)
            
            # Replace the original list with the new list
            nums = newNums
        
        # When only one element is left, return it as the triangular sum
        return nums[0]
