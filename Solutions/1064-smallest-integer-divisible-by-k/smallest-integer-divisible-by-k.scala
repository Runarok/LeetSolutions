import scala.util.boundary
import scala.util.boundary.break

object Solution {
    def smallestRepunitDivByK(k: Int): Int = {

        // If k is divisible by 2 or 5, repunits (111...) cannot be divisible
        if (k % 2 == 0 || k % 5 == 0) then
            return -1

        boundary {
            var remainder = 0

            // Only need to test lengths up to k due to pigeonhole principle
            for length <- 1 to k do
                // Compute new remainder of the repunit modulo k
                remainder = (remainder * 10 + 1) % k

                // Found a repunit divisible by k → break early with result
                if remainder == 0 then
                    break(length)

            // If we finish the loop with no break, result does not exist
            -1
        }
    }
}
