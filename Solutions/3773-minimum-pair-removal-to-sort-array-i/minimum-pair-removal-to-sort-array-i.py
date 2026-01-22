class Solution:
    def minimumPairRemoval(self, nums: List[int]) -> int:
        # This variable will store the number of operations performed
        operations = 0
        
        # Helper function to check if the array is non-decreasing
        def is_non_decreasing(arr):
            # Traverse the array and ensure every element
            # is greater than or equal to the previous one
            for i in range(1, len(arr)):
                if arr[i] < arr[i - 1]:
                    return False
            return True
        
        # Keep performing operations until the array becomes non-decreasing
        while not is_non_decreasing(nums):
            # Initialize the minimum sum to a very large number
            min_sum = float('inf')
            
            # This will store the index of the leftmost pair
            # that has the minimum sum
            min_index = 0
            
            # Iterate over all adjacent pairs
            for i in range(len(nums) - 1):
                pair_sum = nums[i] + nums[i + 1]
                
                # Update minimum sum and index
                # We use '<' (not '<=') to ensure leftmost selection
                if pair_sum < min_sum:
                    min_sum = pair_sum
                    min_index = i
            
            # Replace the selected adjacent pair with their sum
            # Example: [a, b, c] -> [a+b, c] if min_index == 0
            nums = (
                nums[:min_index] +
                [nums[min_index] + nums[min_index + 1]] +
                nums[min_index + 2:]
            )
            
            # One operation has been performed
            operations += 1
        
        # Return the total number of operations needed
        return operations
