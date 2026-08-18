class Solution {
    fun minRemoveToMakeValid(s: String): String {
        // Convert the string into a mutable character array.
        // We will mark invalid parentheses as characters to remove.
        val chars = s.toCharArray()

        // This keeps track of how many unmatched '(' we currently have.
        var open = 0

        // First pass:
        // Find ')' that cannot possibly have a matching '(' before it.
        for (i in chars.indices) {

            // If we see an opening parenthesis,
            // it can potentially match a future ')'.
            if (chars[i] == '(') {
                open++
            }

            // If we see a closing parenthesis...
            else if (chars[i] == ')') {

                // If there is an available '(' to match it,
                // use that '('.
                if (open > 0) {
                    open--
                }

                // Otherwise this ')' is invalid because
                // there is no '(' before it.
                else {
                    // Mark this character for removal.
                    chars[i] = '#'
                }
            }
        }

        // At this point, every ')' is valid.
        // However, there may still be unmatched '('.
        //
        // Example:
        // "((abc"
        //
        // We need to remove those extra '(' characters.
        //
        // We scan from right to left because an unmatched '('
        // should be removed from the rightmost available positions.
        for (i in chars.indices.reversed()) {

            // If there are still unmatched '(' characters...
            if (open > 0 && chars[i] == '(') {

                // Remove this unmatched '('.
                chars[i] = '#'

                // One fewer unmatched '(' remains.
                open--
            }
        }

        // Build the final answer while skipping
        // all characters marked with '#'.
        val result = StringBuilder()

        for (c in chars) {
            if (c != '#') {
                result.append(c)
            }
        }

        return result.toString()
    }
}