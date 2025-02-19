/**
 * @param {number} n
 * @param {number} k
 * @return {string}
 */
var getHappyString = function(n, k) {
    let result = [];
    
    // Helper function to generate the happy strings
    function dfs(current) {
        // If the length of the current string is equal to n, add it to result
        if (current.length === n) {
            result.push(current);
            return;
        }
        
        // Try all three characters 'a', 'b', 'c'
        for (let char of ['a', 'b', 'c']) {
            // Ensure the current character is not the same as the previous one
            if (current[current.length - 1] !== char) {
                dfs(current + char);
            }
        }
    }

    // Start DFS with an empty string
    dfs('');
    
    // If there are enough strings, return the k-th string (1-indexed)
    return k <= result.length ? result[k - 1] : "";
};
