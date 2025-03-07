/**
 * @param {number} left
 * @param {number} right
 * @return {number[]}
 */

var closestPrimes = function(left, right) {
    // Helper function to find all primes up to `n` using the Sieve of Eratosthenes
    const sieve = (n) => {
        const isPrime = Array(n + 1).fill(true);
        isPrime[0] = isPrime[1] = false;  // 0 and 1 are not primes
        for (let i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                for (let j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        return isPrime;
    };

    // Get all primes up to `right`
    const isPrime = sieve(right);
    const primesInRange = [];
    
    // Collect all primes in the range [left, right]
    for (let i = left; i <= right; i++) {
        if (isPrime[i]) {
            primesInRange.push(i);
        }
    }
    
    // If less than two primes in the range, return [-1, -1]
    if (primesInRange.length < 2) {
        return [-1, -1];
    }

    // Find the pair of primes with the minimum difference
    let minDiff = Infinity;
    let result = [-1, -1];

    for (let i = 1; i < primesInRange.length; i++) {
        const diff = primesInRange[i] - primesInRange[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
            result = [primesInRange[i - 1], primesInRange[i]];
        }
    }

    return result;
};
