object Solution {
    def minOperations(nums: Array[Int]): Int = {
        // ===============================================================
        //  Problem Overview:
        //  -----------------
        //  We are given an array 'nums' of non-negative integers.
        //  In one operation, we can select any subarray [i, j] and set all
        //  occurrences of the *minimum non-negative integer* in that subarray to 0.
        //
        //  Goal:
        //  -----
        //  Return the minimum number of operations required to make
        //  ALL elements in the array equal to 0.
        //
        // ===============================================================
        //  Intuition (Monotonic Stack Approach):
        //  -------------------------------------
        //  1. We process the array from left to right.
        //  2. For each non-zero number, we check if it starts a new “layer”
        //     (a number that requires a separate operation).
        //  3. A stack is used to maintain a *monotonic increasing sequence*
        //     of currently active "heights" (values we still need to handle).
        //  4. Whenever we encounter a smaller number, it means higher values
        //     to the left cannot be handled together anymore — we pop them off.
        //  5. Each time we see a new value greater than the top of the stack,
        //     we know it represents a new operation.
        //  6. ZEROS act as separators! When we hit a zero, we can treat the array
        //     as being "split" — we reset the stack, since elements after zero
        //     cannot be handled with elements before it.
        //
        // ===============================================================

        // Mutable stack to store the current active increasing sequence
        val stack = scala.collection.mutable.Stack[Int]()

        // Counter for the total number of operations needed
        var operations = 0

        // ===============================================================
        //  Step-by-step traversal of the array
        // ===============================================================
        for (num <- nums) {

            // ---------------------------------------------------------------
            // Case 1: When the current element is 0
            // ---------------------------------------------------------------
            // Zeros require no operation (already zero).
            // But importantly — they *separate* regions of the array.
            // Any elements after this zero must be handled independently
            // from those before it.
            if (num == 0) {
                // Clear the stack completely to start fresh
                stack.clear()

            } else {
                // ---------------------------------------------------------------
                // Case 2: Current number is non-zero
                // ---------------------------------------------------------------
                // We maintain an increasing stack, meaning:
                // stack.top < num  → we are entering a new height level
                // stack.top > num  → we are descending, so we pop larger ones

                // Pop all elements greater than the current number.
                // This is required because if a smaller number appears,
                // the larger previous ones cannot be part of the same operation.
                while (stack.nonEmpty && stack.top > num) {
                    stack.pop()
                }

                // ---------------------------------------------------------------
                // Case 3: If stack is empty or current num > top of stack
                // ---------------------------------------------------------------
                // - stack.isEmpty ⇒ we are starting a new segment or just after zero.
                // - stack.top < num ⇒ we found a new, higher number that
                //   requires a separate operation.
                if (stack.isEmpty || stack.top < num) {
                    // Push the current number into the stack
                    stack.push(num)

                    // Increment our total operation counter
                    operations += 1
                }

                // ---------------------------------------------------------------
                // Case 4: stack.top == num
                // ---------------------------------------------------------------
                // This means we’ve already counted an operation for this value.
                // Nothing to do — just continue.
            }
        }

        // ===============================================================
        // Return the total number of operations computed
        // ===============================================================
        operations
    }
}
