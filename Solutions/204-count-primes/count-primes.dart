import 'dart:math'; // Import math library for sqrt function

class Solution {
  int countPrimes(int n) {
    // Step 1: Handle small cases
    // If n <= 2, there are no primes less than n
    if (n <= 2) return 0;

    // Step 2: Create a boolean list to mark prime numbers
    // Initially, assume all numbers 0..n-1 are prime
    List<bool> isPrime = List.filled(n, true);

    // Step 3: 0 and 1 are not prime
    isPrime[0] = false;
    isPrime[1] = false;

    // Step 4: Sieve of Eratosthenes
    // Only need to check numbers up to sqrt(n)
    int limit = sqrt(n).ceil(); // Use sqrt from dart:math

    for (int i = 2; i <= limit; i++) {
      if (isPrime[i]) {
        // Step 4a: Mark all multiples of i as not prime
        // Start from i*i because smaller multiples are already marked
        for (int j = i * i; j < n; j += i) {
          isPrime[j] = false;
        }
      }
    }

    // Step 5: Count primes
    int count = 0;
    for (bool prime in isPrime) {
      if (prime) count++;
    }

    return count;
  }
}
