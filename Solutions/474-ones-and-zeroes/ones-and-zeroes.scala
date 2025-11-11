object Solution {
  def findMaxForm(strs: Array[String], m: Int, n: Int): Int = {
    // dp(i)(j): max number of strings that can be formed with at most i zeros and j ones
    val dp = Array.ofDim[Int](m + 1, n + 1)

    // Process each string
    for (s <- strs) {
      val zeros = s.count(_ == '0')
      val ones = s.length - zeros

      // Iterate backwards to avoid using the same string multiple times
      for (i <- m to zeros by -1) {
        for (j <- n to ones by -1) {
          dp(i)(j) = math.max(dp(i)(j), dp(i - zeros)(j - ones) + 1)
        }
      }
    }

    dp(m)(n)
  }
}
