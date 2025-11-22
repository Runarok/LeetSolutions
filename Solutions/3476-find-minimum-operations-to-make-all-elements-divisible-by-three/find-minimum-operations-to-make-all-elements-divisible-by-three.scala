object Solution {
    def minimumOperations(nums: Array[Int]): Int = {

        // We want to transform every number in the array so that it becomes divisible by 3.
        // In one operation, we can increase or decrease any element by exactly 1.
        // Therefore, for each number, we only need to check how far it is from 
        // the nearest multiple of 3.

        // The remainder when dividing by 3 tells us how many steps we need:
        //   - If x % 3 == 0, the number is already divisible by 3 → needs 0 operations.
        //   - If x % 3 == 1, we can subtract 1 → needs exactly 1 operation.
        //   - If x % 3 == 2, we can add 1 → needs exactly 1 operation.
        //
        // This works because multiples of 3 are spaced 3 units apart:
        //   ..., -3, 0, 3, 6, 9, 12, ...
        //
        // Any number is always at distance min(r, 3 - r) from a multiple of 3.

        nums
            .map(num => {  // Transform every number into the number of operations needed.
                
                // Compute the remainder when divided by 3.
                val remainder = num % 3

                // The number of operations needed to reach the closest multiple of 3 is:
                //   min(remainder, 3 - remainder)
                // Example:
                //   remainder = 1 → min(1, 2) = 1
                //   remainder = 2 → min(2, 1) = 1
                //   remainder = 0 → min(0, 3) = 0
                val opsForThisNumber = math.min(remainder, 3 - remainder)

                // Return the operations for this number.
                opsForThisNumber
            })
            .sum // Add up all operations for all elements to get the total.

        // The final result is the minimum total number of operations to make
        // all numbers divisible by 3.
    }
}
