object Solution {
  def minOperations(nums: Array[Int]): Int = {
    import scala.annotation.tailrec

    // Helper function to compute gcd of two numbers
    @tailrec
    def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)

    val n = nums.length

    // Step 1: Check overall gcd
    val overallGCD = nums.reduce(gcd)
    if (overallGCD > 1) return -1 // impossible to get any 1

    // Step 2: If any number is already 1
    val onesCount = nums.count(_ == 1)
    if (onesCount > 0)
      return n - onesCount // need one operation per non-1 element

    // Step 3: Find the shortest subarray with gcd = 1
    var minLen = Int.MaxValue

    for (i <- 0 until n) {
      var g = nums(i)
      var j = i
      while (j < n && g != 1) {
        g = gcd(g, nums(j))
        if (g == 1) {
          minLen = math.min(minLen, j - i + 1)
        }
        j += 1
      }
    }

    // Step 4: Compute result
    // (minLen - 1) to create a 1 + (n - 1) to spread it
    (minLen - 1) + (n - 1)
  }
}
