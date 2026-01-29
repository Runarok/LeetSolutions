class Solution:
    def minCost(self, arr: List[int], brr: List[int], k: int) -> int:
        # --------------------------------------------------
        # If both arrays are already identical,
        # no operations are needed
        # --------------------------------------------------
        if arr == brr:
            return 0

        # --------------------------------------------------
        # Count frequencies (not strictly needed for the
        # current logic, but included as in original code)
        # --------------------------------------------------
        count_arr = Counter(arr)
        count_brr = Counter(arr)  # NOTE: appears unused / likely typo

        # --------------------------------------------------
        # OPTION 1: Do NOT rearrange the arrays
        #
        # Cost is simply the sum of absolute differences
        # at each index
        # --------------------------------------------------
        count = 0
        for a, b in zip(arr, brr):
            # Cost to convert a -> b at the same position
            count += abs(a - b)

        # --------------------------------------------------
        # OPTION 2: Rearrange both arrays
        #
        # Rearranging costs k upfront, then we align
        # elements optimally by sorting both arrays
        # --------------------------------------------------
        with_rearrange = k

        # Sort both arrays to minimize sum of absolute differences
        arr.sort()
        brr.sort()

        for a, b in zip(arr, brr):
            # Cost after optimal rearrangement
            with_rearrange += abs(a - b)

        # --------------------------------------------------
        # Return the minimum of the two strategies
        # --------------------------------------------------
        return min(count, with_rearrange)
