function reverseParentheses(s: string): string {
    // Stack stores the string that existed BEFORE each '('.
    //
    // Example:
    // "(u(love)i)"
    //
    // When we see the first '(':
    // stack = [""]
    // current = ""
    //
    // When we see the second '(':
    // stack = ["", "u"]
    // current = ""
    //
    // This lets us return to the previous level after ')'.
    const stack: string[] = [];

    // 'current' represents the characters we are currently
    // building at the current parenthesis level.
    let current = "";

    // Go through every character in the input string.
    for (const char of s) {

        // ---------------------------------------------------------
        // CASE 1: Opening parenthesis '('
        // ---------------------------------------------------------
        if (char === "(") {

            // Save whatever we have built so far.
            //
            // We are about to enter a new/nested level,
            // so we need to remember the string outside this '('.
            stack.push(current);

            // Start with an empty string inside the parentheses.
            current = "";
        }

        // ---------------------------------------------------------
        // CASE 2: Closing parenthesis ')'
        // ---------------------------------------------------------
        else if (char === ")") {

            // We have finished the current parenthesized substring.
            //
            // Reverse it because the problem says that every
            // matching pair of parentheses reverses its contents.
            //
            // split("") -> converts string into an array of chars
            // reverse()  -> reverses the array
            // join("")   -> converts it back into a string
            current = current.split("").reverse().join("");

            // Get the string that existed BEFORE this '('.
            //
            // For example:
            // stack = ["u"]
            // current = "evol"
            //
            // After pop:
            // previous = "u"
            //
            // Then:
            // current = "u" + "evol"
            //
            // This effectively removes the parentheses.
            const previous = stack.pop()!;

            // Put the reversed substring back into the
            // string from the outer level.
            current = previous + current;
        }

        // ---------------------------------------------------------
        // CASE 3: Normal lowercase English letter
        // ---------------------------------------------------------
        else {

            // Just add the character to the current string.
            current += char;
        }
    }

    // At this point all parentheses have been processed,
    // so 'current' contains only lowercase letters.
    return current;
}
