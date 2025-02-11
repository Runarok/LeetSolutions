class Solution(object):
    def twoSum(self, nums, target):
        # Array of size 2 to store indices
        result = [0, 0]
        
        # Brute force checking to find the solution
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                if nums[i] + nums[j] == target:
                    result[0] = i
                    result[1] = j
                    return result
        
        return None  # If no solution is found, return None
