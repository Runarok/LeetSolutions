class Solution {
    fun countBinarySubstrings(s: String): Int {
        // prevRunLength: length of the previous group of same characters
        var prevRunLength = 0
        // curRunLength: length of the current group of same characters
        var curRunLength = 1
        // count: total number of valid substrings
        var count = 0

        // iterate through the string starting from index 1
        for (i in 1 until s.length) {
            if (s[i] == s[i - 1]) {
                // same character as previous → increase current run length
                curRunLength++
            } else {
                // character changed → add min(prevRunLength, curRunLength)
                // because that’s the number of valid substrings between these two groups
                count += minOf(prevRunLength, curRunLength)
                // update prevRunLength to the run we just finished
                prevRunLength = curRunLength
                // start new run
                curRunLength = 1
            }
        }

        // add the last pair’s contribution
        count += minOf(prevRunLength, curRunLength)
        return count
    }
}
