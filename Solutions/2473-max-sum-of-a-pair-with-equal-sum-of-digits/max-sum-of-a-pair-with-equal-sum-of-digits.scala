object Solution {
    def maximumSum(nums: Array[Int]): Int = {
        // Helper function to calculate the sum of digits
        def sumOfDigits(num: Int): Int = {
            var sum = 0
            var n = num
            while (n > 0) {
                sum += n % 10
                n /= 10
            }
            sum
        }

        // Map to store the numbers grouped by their sum of digits
        val digitSumMap = scala.collection.mutable.Map[Int, List[Int]]()

        // Group the numbers by the sum of digits
        for (num <- nums) {
            val sumDigits = sumOfDigits(num)
            digitSumMap(sumDigits) = digitSumMap.getOrElse(sumDigits, List()) :+ num
        }

        // Variable to store the maximum sum found
        var maxSum = -1

        // Iterate through the map and find the maximum sum for each group
        for ((sum, numbers) <- digitSumMap) {
            if (numbers.length >= 2) {
                val sortedNumbers = numbers.sorted(Ordering[Int].reverse)
                maxSum = math.max(maxSum, sortedNumbers(0) + sortedNumbers(1))
            }
        }

        maxSum
    }
}
