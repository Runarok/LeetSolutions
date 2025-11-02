object Solution {
    def countUnguarded(m: Int, n: Int, guards: Array[Array[Int]], walls: Array[Array[Int]]): Int = {
        // ---------------------------------------------------------------
        // \U0001f9f1 STEP 1: Setup data structures
        // ---------------------------------------------------------------
        // We use Sets for guards and walls since they allow O(1) lookup.
        // Each cell is represented by a tuple (row, col).
        val guardSet = guards.map(g => (g(0), g(1))).toSet  // Set of all guard positions
        val wallSet  = walls.map(w => (w(0), w(1))).toSet   // Set of all wall positions

        // We'll store all the guarded cells in a mutable Set.
        // This ensures we don't double-count cells if multiple guards see the same spot.
        import scala.collection.mutable
        val guarded = mutable.Set[(Int, Int)]()

        // ---------------------------------------------------------------
        // \U0001f440 STEP 2: Sweep across rows (left → right)
        // ---------------------------------------------------------------
        // For each row, we simulate the guard’s line of sight.
        for (r <- 0 until m) {
            var seen = false // Tracks if a guard’s vision is active in this direction
            for (c <- 0 until n) {
                val pos = (r, c)

                if (wallSet(pos)) {
                    // If we hit a wall, guard’s vision is blocked.
                    seen = false
                } else if (guardSet(pos)) {
                    // If we find a guard, vision starts from here onward.
                    seen = true
                } else if (seen) {
                    // If a guard’s vision is active and this cell isn’t blocked,
                    // mark it as guarded.
                    guarded += pos
                }
            }
        }

        // ---------------------------------------------------------------
        // \U0001f440 STEP 3: Sweep across rows again (right → left)
        // ---------------------------------------------------------------
        // We do the same thing but in the opposite direction,
        // because a guard can also see to their left.
        for (r <- 0 until m) {
            var seen = false
            for (c <- (n - 1) to 0 by -1) {
                val pos = (r, c)

                if (wallSet(pos)) {
                    // Wall blocks the view in this direction too.
                    seen = false
                } else if (guardSet(pos)) {
                    // Found a guard, vision turns on again.
                    seen = true
                } else if (seen) {
                    // Guard sees this cell from the right side.
                    guarded += pos
                }
            }
        }

        // ---------------------------------------------------------------
        // \U0001f440 STEP 4: Sweep down columns (top → bottom)
        // ---------------------------------------------------------------
        // Same principle, but now we look vertically.
        for (c <- 0 until n) {
            var seen = false
            for (r <- 0 until m) {
                val pos = (r, c)

                if (wallSet(pos)) {
                    seen = false // Wall blocks downward vision
                } else if (guardSet(pos)) {
                    seen = true  // Guard spotted, start vision
                } else if (seen) {
                    guarded += pos // Mark as guarded if seen
                }
            }
        }

        // ---------------------------------------------------------------
        // \U0001f440 STEP 5: Sweep up columns (bottom → top)
        // ---------------------------------------------------------------
        for (c <- 0 until n) {
            var seen = false
            for (r <- (m - 1) to 0 by -1) {
                val pos = (r, c)

                if (wallSet(pos)) {
                    seen = false // Wall blocks upward vision
                } else if (guardSet(pos)) {
                    seen = true  // Guard found
                } else if (seen) {
                    guarded += pos // Cell seen by guard looking upward
                }
            }
        }

        // ---------------------------------------------------------------
        // \U0001f9ee STEP 6: Compute unguarded cell count
        // ---------------------------------------------------------------
        // Total number of cells = m * n
        // Subtract the guards and walls because they occupy those spaces.
        val totalEmpty = m * n - guards.length - walls.length

        // Guarded cells are stored in the 'guarded' Set.
        // The remaining cells are unguarded empty ones.
        val unguarded = totalEmpty - guarded.size

        // ---------------------------------------------------------------
        // ✅ STEP 7: Return the result
        // ---------------------------------------------------------------
        unguarded
    }
}
