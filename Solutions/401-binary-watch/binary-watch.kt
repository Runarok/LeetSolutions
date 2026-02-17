class Solution {
    fun readBinaryWatch(turnedOn: Int): List<String> {
        // Result list to store all valid times
        val result = mutableListOf<String>()

        // Iterate through all possible hours (0 to 11)
        for (hour in 0..11) {
            // Count the number of 1s in the binary representation of the hour
            val hourOnes = Integer.bitCount(hour)

            // Iterate through all possible minutes (0 to 59)
            for (minute in 0..59) {
                // Count the number of 1s in the binary representation of the minute
                val minuteOnes = Integer.bitCount(minute)

                // If the total number of LEDs turned on equals turnedOn
                if (hourOnes + minuteOnes == turnedOn) {
                    // Format the time string properly:
                    // - Hour: no leading zero
                    // - Minute: always two digits
                    val time = "$hour:" + String.format("%02d", minute)
                    result.add(time)
                }
            }
        }

        // Return all valid times
        return result
    }
}
