function longestValidParentheses(s: string): number {
    // Result variable: stores the maximum length found
    let maxLen = 0;

    // Stack to store indices of '(' characters
    // We also push a sentinel index -1 to handle base cases
    const stack: number[] = [];
    stack.push(-1);

    // Loop over the string
    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char === '(') {
            // Push the index of '(' onto the stack
            stack.push(i);
        } else { // char === ')'
            // Pop the last '(' index
            stack.pop();

            if (stack.length === 0) {
                // Stack empty → no matching '(' for current ')'
                // Push current index as new base for future matches
                stack.push(i);
            } else {
                // Valid substring found between current index and
                // the index on top of the stack
                const currentLen = i - stack[stack.length - 1];
                maxLen = Math.max(maxLen, currentLen);
            }
        }
    }

    return maxLen;
}
