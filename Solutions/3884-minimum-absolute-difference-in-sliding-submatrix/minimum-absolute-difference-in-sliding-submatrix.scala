object Solution {
  def minAbsDiff(grid: Array[Array[Int]], k: Int): Array[Array[Int]] = {
    import scala.collection.mutable
    import scala.util.Sorting

    // Number of rows and columns
    val m = grid.length
    val n = grid(0).length

    // Result matrix of size (m - k + 1) x (n - k + 1)
    val res = Array.ofDim[Int](m - k + 1, n - k + 1)

    // Optimization: if k == 1, each submatrix has only one element
    // So min absolute difference is always 0
    if (k == 1) return res

    // Iterate over all possible top-left corners of k x k submatrices
    for (i <- 0 until m - k + 1) {
      for (j <- 0 until n - k + 1) {

        // Use a Set to store distinct elements in the current submatrix
        val uniqueElements = mutable.Set[Int]()

        // Traverse the k x k submatrix starting at (i, j)
        for (l <- i until i + k) {
          for (kk <- j until j + k) {
            uniqueElements += grid(l)(kk) // Add element to set
          }
        }

        // Convert set to array for sorting
        val sorted = uniqueElements.toArray

        // Sort the array in ascending order
        Sorting.quickSort(sorted)

        // Compute minimum absolute difference between adjacent elements
        // If only one or zero unique elements → answer is 0
        val minDiff =
          if (sorted.length <= 1) 0
          else {
            // sliding(2) creates pairs of consecutive elements
            // Example: [1,3,5] → [1,3], [3,5]
            sorted
              .sliding(2)
              .map(pair => pair(1) - pair(0)) // difference between neighbors
              .min // take minimum difference
          }

        // Store result for this submatrix
        res(i)(j) = minDiff
      }
    }

    // Return final result matrix
    res
  }
}