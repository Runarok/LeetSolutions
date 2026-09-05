class Solution:
    def firstStableIndex(self, nums: list[int], k: int) -> int:

        # Get the length of the array.
        n = len(nums)

        # ---------------------------------------------------------
        # Step 1:
        # Build a suffix minimum array.
        #
        # suffix_min[i] will store:
        #
        #     min(nums[i], nums[i + 1], ..., nums[n - 1])
        #
        # In other words, it tells us the minimum value starting
        # from index i all the way to the end of the array.
        # ---------------------------------------------------------

        suffix_min = [0] * n

        # The last element's suffix minimum is simply itself,
        # because there are no elements after it.
        suffix_min[n - 1] = nums[n - 1]

        # Build the suffix minimum from right to left.
        for i in range(n - 2, -1, -1):

            # We have two possible values for the minimum:
            #
            # 1. nums[i]              -> current element
            # 2. suffix_min[i + 1]    -> minimum of everything
            #                              to the right
            #
            # Take whichever one is smaller.
            suffix_min[i] = min(nums[i], suffix_min[i + 1])

        # ---------------------------------------------------------
        # Step 2:
        # Traverse the array from left to right.
        #
        # We maintain:
        #
        #     prefix_max = max(nums[0..i])
        #
        # At the same time, suffix_min[i] gives us:
        #
        #     min(nums[i..n-1])
        #
        # Therefore, the instability score at index i is:
        #
        #     prefix_max - suffix_min[i]
        # ---------------------------------------------------------

        # Initially, there is no prefix maximum.
        # We can use a very small value so that nums[0]
        # will become the first maximum.
        prefix_max = 0

        for i in range(n):

            # Update the maximum value seen from index 0
            # through the current index i.
            prefix_max = max(prefix_max, nums[i])

            # Get the minimum value from the current index i
            # through the end of the array.
            suffix_min_value = suffix_min[i]

            # Calculate the instability score:
            #
            # maximum in nums[0..i]
            #              -
            # minimum in nums[i..n-1]
            #
            instability_score = prefix_max - suffix_min_value

            # If the instability score is at most k,
            # this index is stable.
            #
            # Since we are traversing from left to right,
            # the first index we find is automatically
            # the smallest stable index.
            if instability_score <= k:

                # Return immediately because we found
                # the smallest possible stable index.
                return i

        # If we finish the entire loop without finding
        # a stable index, then no index is stable.
        return -1
