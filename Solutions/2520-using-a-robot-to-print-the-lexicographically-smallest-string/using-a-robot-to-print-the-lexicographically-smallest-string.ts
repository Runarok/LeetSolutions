function robotWithString(s: string): string {
    // Length of input string s
    const n = s.length;

    // Stack to simulate the string 't' held by the robot
    const t: string[] = [];

    // Result string 'p' which is the lexicographically smallest output written on paper
    let result = '';

    // Array to store the minimum character from index i to the end of s
    // This helps decide when to pop from t
    const minCharFrom = new Array(n);

    // Initialize the last element of minCharFrom as the last character of s
    minCharFrom[n - 1] = s[n - 1];
    // Starting from the second last character down to the first
    for (let i = n - 2; i >= 0; i--) {
        // For each position i, store the minimum character from s[i] to s[n-1]
        // Compare current character s[i] with minCharFrom[i+1] to find the smallest
        minCharFrom[i] = s[i] < minCharFrom[i + 1] ? s[i] : minCharFrom[i + 1];
    }
    // At this point, minCharFrom array is fully populated:
    // minCharFrom[i] gives lex smallest character from s[i] onward.

    // Iterate over each character in s to simulate pushing characters to t
    for (let i = 0; i < n; i++) {
        // Push the current character s[i] into the stack t
        t.push(s[i]);

        // Check if we can pop from t and write to paper (result string)
        // Conditions:
        // - Stack t is not empty
        // - The top character of t is less than or equal to the smallest remaining character in s
        //   (or no characters left in s to compare with when i is at the end)
        // This ensures popping won't make the output lexicographically larger
        while (
            t.length > 0 &&
            (
                // If we're at the last character in s, no more characters left to compare
                i === n - 1 ||
                // Otherwise, compare top of stack with minCharFrom[i + 1]
                t[t.length - 1] <= minCharFrom[i + 1]
            )
        ) {
            // Pop from t and append to result string p
            // This simulates writing the character on paper
            result += t.pop();
        }
    }

    // After processing all characters in s, there might still be characters in t
    // Pop all remaining characters from t and append to result
    // This finalizes the output string p
    while (t.length > 0) {
        result += t.pop();
    }

    // Return the constructed lexicographically smallest string written on paper
    return result;
}
