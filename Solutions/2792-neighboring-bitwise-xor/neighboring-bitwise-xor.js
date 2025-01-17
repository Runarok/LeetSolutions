/**
 * @param {number[]} derived
 * @return {boolean}
 */
var doesValidArrayExist = function(derived) {
    const n = derived.length;
    
    // Function to check if an array of original values can form the derived array
    function checkOriginalStartingWith(start) {
        let original = new Array(n);
        original[0] = start;
        
        // Compute the rest of the original array based on the derived array
        for (let i = 1; i < n; i++) {
            original[i] = derived[i - 1] ^ original[i - 1];
        }
        
        // Check if the last element satisfies the circular condition
        return (original[n - 1] ^ original[0]) === derived[n - 1];
    }
    
    // Try both possible values for original[0] (0 or 1)
    return checkOriginalStartingWith(0) || checkOriginalStartingWith(1);
};
