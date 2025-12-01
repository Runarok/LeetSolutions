import scala.util.boundary
import scala.util.boundary.break

object Solution {
    def maxRunTime(n: Int, batteries: Array[Int]): Long = {

        // -------------------------------------------------------------
        // canRun(T): returns true if we can run all n computers for T minutes
        // -------------------------------------------------------------
        def canRun(T: Long): Boolean = {
            var total: Long = 0

            // The boundary block lets us "break" out like early return.
            boundary {
                for (b <- batteries) {
                    // Each battery can contribute at most T minutes.
                    total += math.min(b.toLong, T)

                    // Early exit: if total is already enough, break out.
                    if (total >= T * n) break(true)
                }
            }

            // If we didn't early-break with true, we check normally
            total >= T * n
        }

        // -------------------------------------------------------------
        // Binary search for the maximum T
        // -------------------------------------------------------------
        val totalEnergy = batteries.map(_.toLong).sum

        // Upper bound: cannot run for more than totalEnergy / n
        var left: Long = 0
        var right: Long = totalEnergy / n

        while (left < right) {
            // Mid biased upward to avoid infinite loop
            val mid = (left + right + 1) / 2

            if (canRun(mid)) {
                // If mid is feasible, try longer time
                left = mid
            } else {
                // Otherwise try shorter time
                right = mid - 1
            }
        }

        // left == best achievable T
        left
    }
}
