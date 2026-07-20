class Solution {

    /**
     * @param String $s
     * @return String
     */
    function smallestSubsequence($s) {

        // Store how many times each character appears.
        $count = [];

        // Count the frequency of every character.
        for ($i = 0; $i < strlen($s); $i++) {
            $ch = $s[$i];

            if (!isset($count[$ch])) {
                $count[$ch] = 0;
            }

            $count[$ch]++;
        }

        // Keeps track of characters already in the stack.
        $visited = [];

        // Stack used to build the answer.
        $stack = [];

        // Traverse every character in the string.
        for ($i = 0; $i < strlen($s); $i++) {

            $ch = $s[$i];

            // One occurrence of this character has now been used.
            $count[$ch]--;

            // If this character is already in the stack,
            // skip it because every distinct character
            // should appear exactly once.
            if (isset($visited[$ch]) && $visited[$ch]) {
                continue;
            }

            // While:
            // 1. Stack is not empty.
            // 2. Current character is smaller than stack top.
            // 3. Stack top appears again later.
            // Remove the stack top.
            while (!empty($stack)) {

                // Get the character on top of the stack.
                $top = end($stack);

                // If top is already the best choice,
                // stop removing.
                if ($top <= $ch) {
                    break;
                }

                // If top will not appear again,
                // we cannot remove it.
                if ($count[$top] == 0) {
                    break;
                }

                // Remove the top character.
                array_pop($stack);

                // Mark it as no longer in the stack.
                $visited[$top] = false;
            }

            // Add current character to the stack.
            $stack[] = $ch;

            // Mark it as visited.
            $visited[$ch] = true;
        }

        // Join all characters in the stack into a string.
        return implode("", $stack);
    }
}