class Solution:
    def largestPerimeter(self, nums: List[int]) -> int:
        # Sort the list in descending order to try largest sides first
        nums.sort(reverse=True)

        # Get the number of elements in the list
        n = len(nums)

        # Iterate through the list, considering each triplet
        for i in range(n - 2):
            # Select the three sides
            a = nums[i]
            b = nums[i + 1]
            c = nums[i + 2]

            # Check if they can form a triangle (triangle inequality)
            if b + c > a:
                # If valid, return the perimeter
                return a + b + c

        # If no valid triangle found, return 0
        return 0
