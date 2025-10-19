import java.util.*

class Solution {
    fun findLexSmallestString(s: String, a: Int, b: Int): String {
        // Set to store all visited strings to prevent infinite loops
        val visited = mutableSetOf<String>()

        // Queue for BFS traversal starting with the original string
        val queue: Queue<String> = LinkedList()
        queue.offer(s)
        visited.add(s)

        // Variable to keep track of the smallest string found
        var result = s

        // BFS traversal
        while (queue.isNotEmpty()) {
            val current = queue.poll()

            // Update the result if the current string is lexicographically smaller
            if (current < result) {
                result = current
            }

            // ------------------------
            // Operation 1: Add 'a' to all digits at odd indices
            // ------------------------
            val chars = current.toCharArray()  // Convert string to char array for easy manipulation

            // Traverse through odd indices (1, 3, 5, ...)
            for (i in chars.indices) {
                if (i % 2 == 1) {
                    // Convert char to int, add 'a', take modulo 10 to wrap around, and convert back to char
                    val digit = chars[i] - '0'
                    val newDigit = (digit + a) % 10
                    chars[i] = (newDigit + '0'.toInt()).toChar()
                }
            }

            // Construct the new string after add operation
            val added = String(chars)

            // If this string hasn't been seen before, add it to the queue and mark it visited
            if (added !in visited) {
                visited.add(added)
                queue.offer(added)
            }

            // ------------------------
            // Operation 2: Rotate the string to the right by 'b' positions
            // ------------------------
            val n = current.length
            // Right rotation: take the last 'b' characters and move them to the front
            val rotated = current.substring(n - b) + current.substring(0, n - b)

            // If this rotated string hasn't been seen before, process it
            if (rotated !in visited) {
                visited.add(rotated)
                queue.offer(rotated)
            }
        }

        // After BFS completes, return the smallest string found
        return result
    }
}
