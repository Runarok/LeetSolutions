object Solution {
    def countOperations(num1: Int, num2: Int): Int = {
        // We'll use mutable variables to repeatedly perform operations.
        var a = num1
        var b = num2
        
        // Count how many operations we perform.
        var count = 0
        
        // Continue until either number becomes 0.
        while (a != 0 && b != 0) {
            if (a >= b) {
                // Instead of subtracting b one-by-one, we can optimize
                // by subtracting as many times as possible in one step.
                count += a / b        // Number of full subtractions we can perform
                a = a % b             // Equivalent to performing those subtractions
            } else {
                // Same logic as above, but with roles swapped.
                count += b / a
                b = b % a
            }
        }
        
        // Return total number of operations performed
        count
    }
}
