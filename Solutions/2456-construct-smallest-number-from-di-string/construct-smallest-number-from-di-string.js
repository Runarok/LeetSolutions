/**
 * @param {string} pattern
 * @return {string}
 */
var smallestNumber = function(pattern) {
    const n = pattern.length;
    let stack = [];
    let result = [];
    
    // We are filling the numbers from 1 to n+1
    for (let i = 0; i <= n; i++) {
        // Push the current number onto the stack
        stack.push(i + 1);
        
        // When we encounter 'I' or reach the end, pop from the stack
        if (i === n || pattern[i] === 'I') {
            while (stack.length > 0) {
                result.push(stack.pop());
            }
        }
    }
    
    // Join the result array into a string and return
    return result.join('');
};
