/**
 * @param {number[]} arr
 * @return {number}
 */

var numOfSubarrays = function(arr) {
    const MOD = 1e9 + 7;
    let odd_count = 0, even_count = 1; // even_count starts at 1 to account for the sum of an empty subarray being even
    let current_sum = 0;
    let result = 0;

    for (let num of arr) {
        current_sum += num;
        
        // Check if current_sum is odd or even
        if (current_sum % 2 === 0) {
            result += odd_count; // Add odd_count subarrays that would make the sum odd
            even_count++; // Update the even_count
        } else {
            result += even_count; // Add even_count subarrays that would make the sum odd
            odd_count++; // Update the odd_count
        }
        
        result %= MOD; // Take the result modulo 10^9 + 7
    }

    return result;
};
