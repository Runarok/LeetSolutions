object Solution {
    def numSub(s: String): Int = {
        val MOD = 1000000007
        var count = 0L   // To count consecutive 1's
        var result = 0L  // To store the total number of substrings

        for (ch <- s) {
            if (ch == '1') {
                // Increment the count of consecutive 1's
                count += 1
                // Add the number of substrings ending at this position
                result = (result + count) % MOD
            } else {
                // Reset count when encountering '0'
                count = 0
            }
        }

        result.toInt
    }
}
