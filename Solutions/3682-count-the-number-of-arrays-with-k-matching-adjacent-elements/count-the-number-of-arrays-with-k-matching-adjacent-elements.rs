// The modulus to be used for all modular arithmetic operations.
// This is a large prime number commonly used in competitive programming
// to avoid integer overflow and to have good modular inverse properties.
const MOD: i64 = 1_000_000_007;

// The maximum size for factorial precomputation arrays.
// This sets an upper bound on the values of `n` for which we can compute combinations.
const MX: usize = 100000;

// Static mutable arrays to hold factorials and inverse factorials modulo MOD.
// These are global and initialized once for performance reasons.
// Unsafe access is required because Rust normally forbids mutation of statics.
static mut FACT: [i64; MX] = [0; MX];
static mut INV_FACT: [i64; MX] = [0; MX];

// Fast modular exponentiation function (binary exponentiation).
// Computes x^n mod MOD efficiently in O(log n) time.
// Parameters:
// - x: base (modular integer)
// - n: exponent (should be non-negative)
// Returns: (x^n) % MOD
fn qpow(mut x: i64, mut n: i32) -> i64 {
    // Initialize result to 1 (neutral element of multiplication)
    let mut res = 1;
    
    // Loop while exponent is positive
    while n > 0 {
        // If the lowest bit of n is set, multiply result by current base x
        if n & 1 == 1 {
            res = res * x % MOD; // modulo multiplication
        }
        
        // Square the base for the next bit of the exponent
        x = x * x % MOD;
        
        // Shift exponent right by 1 bit to process next bit
        n >>= 1;
    }
    res
}

// Initialization function to precompute factorials and inverse factorials.
// This speeds up combination calculations drastically by allowing O(1) queries.
// Uses Fermat's little theorem to compute modular inverses.
// This function uses unsafe blocks to mutate static mutable arrays.
fn init() {
    unsafe {
        // Check if already initialized by checking if FACT[0] != 0 (because factorial(0) = 1)
        if FACT[0] != 0 { return; }
        
        // Initialize factorial of 0 to 1 (base case)
        FACT[0] = 1;
        
        // Compute factorials iteratively from 1 to MX-1 modulo MOD
        for i in 1..MX {
            FACT[i] = FACT[i - 1] * (i as i64) % MOD;
        }
        
        // Compute inverse factorial of MX-1 using modular inverse (Fermat's little theorem)
        INV_FACT[MX - 1] = qpow(FACT[MX - 1], MOD as i32 - 2);
        
        // Compute inverse factorials iteratively backward
        // Based on the property: inv_fact[i-1] = inv_fact[i] * i (mod MOD)
        for i in (1..MX).rev() {
            INV_FACT[i - 1] = INV_FACT[i] * (i as i64) % MOD;
        }
    }
}

// Function to compute combinations n choose m modulo MOD.
// Uses precomputed factorials and inverse factorials for O(1) query time.
// Parameters:
// - n: total number of items
// - m: number of chosen items
// Returns: nCr % MOD
fn comb(n: usize, m: usize) -> i64 {
    unsafe {
        // Calculate factorial(n) * inv_fact(m) * inv_fact(n-m) modulo MOD
        FACT[n] * INV_FACT[m] % MOD * INV_FACT[n - m] % MOD
    }
}

// Implementation block presumably for some problem's solution struct.
impl Solution {
    // Main function to count the number of "good arrays" given parameters n, m, k.
    // The exact problem context is likely about arrays with certain constraints.
    // Parameters:
    // - n: length of the array
    // - m: number of possible values for each element
    // - k: number of "special" positions or changes
    // Returns: count of good arrays modulo MOD as i32.
    pub fn count_good_arrays(n: i32, m: i32, k: i32) -> i32 {
        // Initialize factorials and inverse factorials if not done yet.
        init();
        
        // Apply the formula:
        // count = C(n-1, k) * m * (m-1)^(n-k-1) % MOD
        // Explanation:
        // - Choose k positions among the last n-1 where certain conditions hold
        // - m choices for the first element
        // - (m-1) choices for each of the remaining n-k-1 positions
        (comb((n - 1) as usize, k as usize) * m as i64 % MOD * qpow((m - 1) as i64, (n - k - 1) as i32) % MOD) as i32
    }
}
