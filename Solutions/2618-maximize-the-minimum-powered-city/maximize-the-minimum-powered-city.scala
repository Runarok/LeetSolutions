import scala.util.boundary, boundary.break

object Solution {
  def maxPower(stations: Array[Int], r: Int, k: Int): Long = {
    val n = stations.length

    // Prefix sum of original stations to compute initial power efficiently
    val prefix = new Array[Long](n + 1)
    for (i <- stations.indices)
      prefix(i + 1) = prefix(i) + stations(i)

    // Precompute the initial power each city currently has
    val initPower = new Array[Long](n)
    for (i <- 0 until n) {
      val left = math.max(0, i - r)
      val right = math.min(n - 1, i + r)
      initPower(i) = prefix(right + 1) - prefix(left)
    }

    // Check if we can make all cities have at least 'target' power
    def canAchieve(target: Long): Boolean = boundary {
      val diff = new Array[Long](n + 1)
      var added = 0L
      var currAdd = 0L

      for (i <- 0 until n) {
        currAdd += diff(i)
        val currPower = initPower(i) + currAdd

        if (currPower < target) {
          val need = target - currPower
          added += need
          if (added > k) break(false)  // Early exit safely

          currAdd += need
          val end = math.min(n, i + 2 * r + 1)
          if (end < n) diff(end) -= need
        }
      }
      true
    }

    // Binary search for the maximum possible minimum power
    var lo = 0L
    var hi = prefix(n) + k
    var ans = 0L

    while (lo <= hi) {
      val mid = lo + (hi - lo) / 2
      if (canAchieve(mid)) {
        ans = mid
        lo = mid + 1
      } else {
        hi = mid - 1
      }
    }

    ans
  }
}
