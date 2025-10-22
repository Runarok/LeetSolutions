class Solution:
    def maxFrequency(self, nums: List[int], k: int, numOperations: int) -> int:
        # Sort the numbers to simplify window logic
        nums.sort()
        n = len(nums)

        if n == 0: return 0  # Edge case: empty list

        # Sliding window variables
        left = 0             # Left pointer of window
        right = 0            # Right pointer of window
        sumCount = 0         # Number of elements within k distance from current num
        result = 0           # Store max frequency
        left2 = 0            # Another sliding window pointer for second condition
        sumCount2 = 0        # Track elements in second window
        count = 0            # Count of repeated current number
        prev = None          # Track previous number to count duplicates

        for num in nums:
            # Count how many times the current number appears consecutively
            if num == prev:
                count += 1
            else:
                prev = num
                count = 1

            # First sliding window: shrink left if nums[left] is too far from current num
            while nums[left] < num - k:
                sumCount -= 1
                left += 1

            # Expand right window while elements are within [num, num + k]
            while right < n and nums[right] <= num + k:
                sumCount += 1
                right += 1

            # Calculate possible frequency using current count and available operations
            result = max(result, count + min(sumCount - count, numOperations))

            # Second window: track elements within num - 2k
            sumCount2 += 1
            while nums[left2] < num - 2 * k:
                sumCount2 -= 1
                left2 += 1

            # Update result using second window
            result = max(result, min(sumCount2, numOperations))

        return result
