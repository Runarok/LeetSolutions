class Solution:
    def sortPermutation(self, nums: List[int]) -> int:
        """
        Finds the maximum value of k such that the permutation can be sorted
        using swaps where nums[i] & nums[j] == k.
        """
        # Initialize ans with -1 (which has all bits set to 1 in two's complement).
        # This acts as an identity element for the bitwise AND operation.
        ans = -1
        
        # Track whether we found any misplaced elements
        has_misplaced = False
        
        # Iterate through the array and check each element against its expected index
        for i, x in enumerate(nums):
            # If the element is not in its correct sorted position (nums[i] should be i)
            if i != x:
                has_misplaced = True
                # Accumulate the bitwise AND across all misplaced elements.
                # This ensures k retains only the bits that are 1 in ALL misplaced elements.
                ans &= x
                
        # If the array is already sorted (no elements are misplaced), return 0.
        # Otherwise, return the computed bitwise AND result (ensuring it's non-negative).
        return max(ans, 0) if has_misplaced else 0