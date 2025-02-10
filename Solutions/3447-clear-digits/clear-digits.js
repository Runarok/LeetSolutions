/**
 * @param {string} s
 * @return {string}
 */
var clearDigits = function(s) {
    // Create a stack to hold characters as we process them
    let stack = [];
    
    // Traverse through the string character by character
    for (let char of s) {
        if (/\d/.test(char)) {  // If the character is a digit
            // Remove the last non-digit character from the stack (if exists)
            stack.pop();
        } else {
            // Otherwise, add the character to the stack
            stack.push(char);
        }
    }
    
    // Join the stack back into a string and return
    return stack.join('');
};
