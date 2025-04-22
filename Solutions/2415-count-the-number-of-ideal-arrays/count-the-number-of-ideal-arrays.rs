impl Solution {
    pub fn ideal_arrays(n: i32, max_value: i32) -> i32 {
        const MOD: i64 = 1_000_000_007; // The modulus value for the result
        const MAX_N: usize = 10_000 + 10; // Maximum value for sieve
        const MAX_P: usize = 15; // Max number of prime factors for each number

        // Sieve array to store the smallest prime factor for each number
        let mut sieve = vec![0; MAX_N];
        
        // Apply sieve of Eratosthenes to find the smallest prime factors
        for i in 2..MAX_N {
            if sieve[i] == 0 { // If i is a prime number
                for j in (i..MAX_N).step_by(i) {
                    if sieve[j] == 0 {
                        sieve[j] = i as i32; // Mark i as the smallest prime factor of j
                    }
                }
            }
        }

        // Array to store the prime factor counts for each number up to max_value
        let mut prime_factors = vec![vec![]; MAX_N];
        
        // Calculate the prime factorization for each number from 2 to max_value
        for i in 2..=max_value as usize {
            let mut num = i;
            while num > 1 {
                let prime = sieve[num] as usize;
                let mut count = 0;
                // Count how many times 'prime' divides 'num'
                while num % prime == 0 {
                    num /= prime;
                    count += 1;
                }
                // Store the count of the prime factor in the list for i
                prime_factors[i].push(count);
            }
        }

        // Binomial coefficient table for choosing n items from k
        let mut binomial_coeff = vec![vec![0; MAX_P + 1]; n as usize + MAX_P + 1];
        
        // Base case for binomial coefficients: C(n, 0) = 1
        binomial_coeff[0][0] = 1;
        
        // Calculate binomial coefficients using Pascal's identity
        for i in 1..n as usize + MAX_P + 1 {
            binomial_coeff[i][0] = 1;
            for j in 1..=i.min(MAX_P) {
                binomial_coeff[i][j] = (binomial_coeff[i - 1][j] + binomial_coeff[i - 1][j - 1]) % MOD;
            }
        }

        // Final result accumulator
        let mut result = 0i64;
        
        let n = n as usize; // Convert n to usize for indexing
        
        // Iterate over each number from 1 to max_value
        for x in 1..=max_value as usize {
            let mut multiplier = 1i64;
            
            // For each prime factor of x, multiply the appropriate binomial coefficient
            for &count in &prime_factors[x] {
                multiplier = multiplier * binomial_coeff[n + count as usize - 1][count as usize] % MOD;
            }

            // Add the result of this iteration to the final answer
            result = (result + multiplier) % MOD;
        }

        // Return the final result as i32
        result as i32
    }
}
