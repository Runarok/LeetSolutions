class Solution {
    fun finalValueAfterOperations(operations: Array<String>): Int {
        // Step 1: Initialize X to 0
        var X = 0

        // Step 2: Loop through each operation in the input array
        for (operation in operations) {
            // Check if the operation is an increment or decrement
            // All increment operations contain "++"
            if (operation.contains("++")) {
                // If it's an increment, add 1 to X
                X += 1
            } else {
                // If it's not an increment, it's a decrement (contains "--")
                X -= 1
            }

            // Optional: Print the current value of X after each operation (for debugging)
            // println("After operation $operation, X = $X")
        }

        // Step 3: Return the final value of X
        return X
    }
}
