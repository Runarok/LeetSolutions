import scala.collection.mutable

object Solution {
  def findXSum(nums: Array[Int], k: Int, x: Int): Array[Long] = {

    // ---- Data structures ----
    val freq = mutable.Map[Int, Int]() // element -> frequency

    // Custom ordering: ascending by freq, then ascending by num
    // (so smallest pair is at the head)
    implicit val occOrdering: Ordering[(Int, Int)] = new Ordering[(Int, Int)] {
      def compare(a: (Int, Int), b: (Int, Int)): Int = {
        val (occA, numA) = a
        val (occB, numB) = b
        if (occA != occB) occA.compare(occB)
        else numA.compare(numB)
      }
    }

    // Two TreeSets:
    val small = mutable.TreeSet.empty[(Int, Int)](occOrdering) // remaining elements
    val large = mutable.TreeSet.empty[(Int, Int)](occOrdering) // top x most frequent elements

    var largeSum = 0L // running x-sum (sum of occ * num for all elements in 'large')

    // ---- Helper functions ----

    // Move smallest from large -> small, if size > x
    def rebalanceDown(): Unit = {
      if (large.size > x) {
        val smallestInLarge = large.head
        large.remove(smallestInLarge)
        small.add(smallestInLarge)
        largeSum -= smallestInLarge._1.toLong * smallestInLarge._2
      }
    }

    // Move largest from small -> large, if large.size < x
    def rebalanceUp(): Unit = {
      if (large.size < x && small.nonEmpty) {
        val largestInSmall = small.last
        small.remove(largestInSmall)
        large.add(largestInSmall)
        largeSum += largestInSmall._1.toLong * largestInSmall._2
      }
    }

    // Move one element from small to large if needed
    def rebalance(): Unit = {
      // Ensure ordering property: everything in large >= everything in small
      while (small.nonEmpty && large.nonEmpty && (small.last._1 > large.head._1 ||
              (small.last._1 == large.head._1 && small.last._2 > large.head._2))) {
        val smallTop = small.last
        val largeBottom = large.head
        small.remove(smallTop)
        large.remove(largeBottom)

        small.add(largeBottom)
        large.add(smallTop)

        largeSum += (smallTop._1.toLong * smallTop._2) - (largeBottom._1.toLong * largeBottom._2)
      }
    }

    // Insert or update element
    def add(num: Int): Unit = {
      val old = freq.getOrElse(num, 0)
      if (old > 0) {
        val pair = (old, num)
        if (large.contains(pair)) {
          large.remove(pair)
          largeSum -= old.toLong * num
        } else if (small.contains(pair)) {
          small.remove(pair)
        }
      }

      val now = old + 1
      freq(num) = now
      val newPair = (now, num)

      if (large.size < x) {
        large.add(newPair)
        largeSum += now.toLong * num
      } else if (occOrdering.lt(newPair, large.head)) {
        small.add(newPair)
      } else {
        val smallestInLarge = large.head
        large.remove(smallestInLarge)
        small.add(smallestInLarge)
        large.add(newPair)
        largeSum += (now.toLong * num) - (smallestInLarge._1.toLong * smallestInLarge._2)
      }

      rebalance()
    }

    // Remove one occurrence
    def remove(num: Int): Unit = {
      val old = freq(num)
      val pair = (old, num)

      if (large.contains(pair)) {
        large.remove(pair)
        largeSum -= old.toLong * num
      } else {
        small.remove(pair)
      }

      if (old == 1) freq.remove(num)
      else {
        val now = old - 1
        freq(num) = now
        val newPair = (now, num)
        // Re-insert with new frequency
        if (large.size < x) {
          large.add(newPair)
          largeSum += now.toLong * num
        } else if (occOrdering.lt(newPair, large.head)) {
          small.add(newPair)
        } else {
          val smallestInLarge = large.head
          large.remove(smallestInLarge)
          small.add(smallestInLarge)
          large.add(newPair)
          largeSum += (now.toLong * num) - (smallestInLarge._1.toLong * smallestInLarge._2)
        }
      }

      rebalanceUp()
      rebalance()
    }

    // ---- Main sliding window ----
    val n = nums.length
    val res = new Array[Long](n - k + 1)

    // Initialize first window
    for (i <- 0 until k) add(nums(i))
    res(0) = largeSum

    for (i <- 1 until n - k + 1) {
      remove(nums(i - 1))
      add(nums(i + k - 1))
      res(i) = largeSum
    }

    res
  }
}
