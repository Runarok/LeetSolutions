class Solution:
    def distanceSum(self, m: int, n: int, k: int) -> int:
        # --------------------------------------------------
        # We are working under modulo to avoid overflow
        # --------------------------------------------------
        MOD = 10**9 + 7

        # --------------------------------------------------
        # Total number of cells in the grid
        # --------------------------------------------------
        total_cells = m * n

        # --------------------------------------------------
        # PART 1: Sum of vertical distances
        #
        # For rows:
        # The sum of |i - j| for all row pairs in a column is:
        #   (m - 1) * m * (m + 1) / 6
        #
        # Since there are n columns and each column has n^2
        # possible column pairings, multiply by n^2
        # --------------------------------------------------
        vertical_sum = (
            (n * n) *                # number of column pairings
            (m - 1) * m * (m + 1) // 6
        )

        # --------------------------------------------------
        # PART 2: Sum of horizontal distances
        #
        # Same logic as above, but now for columns:
        #   (n - 1) * n * (n + 1) / 6
        #
        # Since there are m rows and each row has m^2
        # possible row pairings, multiply by m^2
        # --------------------------------------------------
        horizontal_sum = (
            (m * m) *                # number of row pairings
            (n - 1) * n * (n + 1) // 6
        )

        # --------------------------------------------------
        # Combine vertical and horizontal distance contributions
        # --------------------------------------------------
        total_distance = (vertical_sum + horizontal_sum) % MOD

        # --------------------------------------------------
        # PART 3: Combinatorics
        #
        # For every pair of cells, we need to choose the
        # remaining (k - 2) cells from the remaining (mn - 2)
        # cells to form a group of size k.
        #
        # Number of such ways:
        #   C(mn - 2, k - 2)
        # --------------------------------------------------
        ways = comb(total_cells - 2, k - 2) % MOD

        # --------------------------------------------------
        # Final result:
        # Each pair's distance contributes to all valid
        # k-sized subsets that include that pair
        # --------------------------------------------------
        return (total_distance * ways) % MOD
