impl Solution {
    pub fn min_bitwise_array(nums: Vec<i32>) -> Vec<i32> {
        // Result array
        let mut ans = Vec::with_capacity(nums.len());

        // Iterate over each prime number in nums
        for &n in nums.iter() {

            // --------------------------------------------------
            // Case 1: Even numbers can never be formed
            // x OR (x + 1) is always odd
            // --------------------------------------------------
            if n % 2 == 0 {
                ans.push(-1);
                continue;
            }

            // --------------------------------------------------
            // Case 2: n is odd
            // Count how many trailing 1-bits n has
            // --------------------------------------------------
            let mut trailing_ones = 0;
            let mut temp = n;

            while temp & 1 == 1 {
                trailing_ones += 1;
                temp >>= 1;
            }

            // The bit position where x has its lowest 0-bit
            let t = trailing_ones - 1;

            // --------------------------------------------------
            // Build mask covering bits [0..=t]
            // Example: t = 2 → mask = 0b111
            // --------------------------------------------------
            let mask = (1 << (t + 1)) - 1;

            // --------------------------------------------------
            // Construct the smallest valid x:
            // 1) Keep higher bits of n
            // 2) Set lower bits [0..t-1] to 1
            // 3) Force bit t to 0
            // --------------------------------------------------
            let x = (n & !mask) | ((1 << t) - 1);

            ans.push(x);
        }

        ans
    }
}
