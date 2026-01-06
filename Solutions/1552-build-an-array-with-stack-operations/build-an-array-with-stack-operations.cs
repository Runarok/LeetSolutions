public class Solution {
    public IList<string> BuildArray(int[] target, int n) {
        // List to store the stack operations
        IList<string> operations = new List<string>();

        // Pointer for the target array
        int index = 0;

        // Iterate through the stream of numbers from 1 to n
        for (int num = 1; num <= n; num++) {
            // Always push the current number
            operations.Add("Push");

            if (num == target[index]) {
                // Number is needed, move to next target element
                index++;

                // If we've built the entire target, stop
                if (index == target.Length) {
                    break;
                }
            } else {
                // Number is not needed, pop it
                operations.Add("Pop");
            }
        }

        // Return the list of operations
        return operations;
    }
}
