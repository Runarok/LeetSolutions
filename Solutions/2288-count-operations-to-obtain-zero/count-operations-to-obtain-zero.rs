impl Solution {
    pub fn count_operations(mut num1: i32, mut num2: i32) -> i32 {
        // Initialize a counter to keep track of how many subtraction operations we perform.
        // Each "operation" is defined as subtracting the smaller number from the larger one
        // until one of them becomes zero.
        let mut res = 0;

        // Continue looping as long as both numbers are non-zero.
        // When either num1 or num2 becomes zero, we stop.
        while num1 != 0 && num2 != 0 {
            // The key observation:
            // Instead of repeatedly subtracting num2 from num1 (which could take many iterations),
            // we can take advantage of integer division to find out *how many times*
            // num2 fits into num1 directly.
            //
            // For example:
            // If num1 = 15 and num2 = 4,
            // then num1 / num2 = 3, meaning we can subtract 4 from 15 exactly 3 times:
            // 15 - 4 - 4 - 4 = 3.
            //
            // Each of those 3 subtractions counts as a valid "operation" under the problem definition.
            res += num1 / num2;

            // After counting how many times num2 fits into num1,
            // we take the remainder of that division to update num1.
            //
            // This is mathematically equivalent to performing repeated subtraction until
            // num1 becomes less than num2.
            // Using the modulo operator (%) makes this step efficient.
            num1 %= num2;

            // Now we swap the two numbers.
            //
            // Why?
            // Because after the previous step, num1 is now smaller than num2,
            // so for the next iteration, we want to repeat the same process
            // with the new "larger" and "smaller" numbers.
            //
            // This swapping is identical to one iteration of the Euclidean algorithm,
            // which is used to compute the greatest common divisor (GCD).
            std::mem::swap(&mut num1, &mut num2);

            // The loop will now continue with updated values until one number hits zero.
        }

        // When we exit the loop, it means one of the numbers is zero.
        // At this point, all valid subtraction operations have been counted.
        res
    }
}