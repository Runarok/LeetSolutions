object Solution {
  def findXSum(nums: Array[Int], k: Int, x: Int): Array[Int] = {
    val n = nums.length
    val answer = new Array[Int](n - k + 1)

    // Helper function to compute x-sum from frequency map
    def computeXSum(freq: collection.mutable.Map[Int, Int]): Int = {
      // Convert map to sequence of (num, count)
      val sortedFreq = freq.toSeq
        // Sort primarily by frequency descending, then by number descending
        .sortBy { case (num, count) => (-count, -num) }

      // Take top x and compute sum of (num * count)
      sortedFreq.take(x).map { case (num, count) => num * count }.sum
    }

    // Frequency map for current window
    val freq = collection.mutable.Map[Int, Int]()

    // Initialize frequency map for first window
    for (i <- 0 until k) {
      freq(nums(i)) = freq.getOrElse(nums(i), 0) + 1
    }

    // Compute x-sum for first window
    answer(0) = computeXSum(freq)

    // Slide the window across the array
    for (i <- 1 until (n - k + 1)) {
      val outNum = nums(i - 1)        // element leaving window
      val inNum = nums(i + k - 1)     // element entering window

      // Decrease frequency of outgoing number
      freq(outNum) = freq(outNum) - 1
      if (freq(outNum) == 0) freq.remove(outNum)  // clean up if count is zero

      // Increase frequency of incoming number
      freq(inNum) = freq.getOrElse(inNum, 0) + 1

      // Compute x-sum for this window
      answer(i) = computeXSum(freq)
    }

    answer
  }
}
