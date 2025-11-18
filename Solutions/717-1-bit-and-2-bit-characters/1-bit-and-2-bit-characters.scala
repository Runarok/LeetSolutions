object Solution {
    def isOneBitCharacter(bits: Array[Int]): Boolean = {

        // We use a pointer `i` to walk through the array.
        // The idea is: every time we see a 0, it represents a 1-bit character (just 0).
        // Every time we see a 1, it MUST be the start of a 2-bit character (10 or 11).
        var i = 0

        // We only iterate until the second-to-last element (index < length - 1)
        // because the question is whether we STOP EXACTLY on the last element.
        // If we hit the last index precisely, that last bit is a one-bit character.
        while (i < bits.length - 1) {

            if (bits(i) == 0) {
                // Case 1: bits[i] == 0
                // This is a one-bit character: [0]
                // So we move forward by 1 position.
                i += 1
            } else {
                // Case 2: bits[i] == 1
                // This is the start of a two-bit character: [10] or [11]
                // So we MUST skip 2 bits.
                i += 2
            }
        }

        // After the loop ends, `i` will either be:
        // - EXACTLY at the last index → last character is 1-bit → return true
        // - PAST the last index → last character is 2-bit → return false
        i == bits.length - 1
    }
}
