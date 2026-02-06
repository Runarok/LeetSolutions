class Solution:
    def minRemoval(self, nums: List[int], k: int) -> int:
        # Sort the array so we can use a sliding window
        nums.sort()

        # Total number of elements
        n = len(nums)

        # Two pointers for the sliding window
        left = 0      # start of the window
        right = 0     # end of the window

        # This will store the maximum size of a valid window
        maxLen = 0

        # Move the right pointer until it reaches the end
        while right < n:

            # Check if the current window is valid
            # Condition:
            # largest element in window (nums[right])
            # should be <= smallest element in window (nums[left]) * k
            if nums[right] <= nums[left] * k:

                # If valid, update the maximum window length found so far
                maxLen = max(maxLen, right - left + 1)

                # Expand the window by moving the right pointer
                right += 1
            else:
                # If the condition is violated,
                # shrink the window from the left
                left += 1

        # Minimum removals = total elements - largest valid subset size
        return n - maxLen
