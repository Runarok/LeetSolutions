impl Solution {
    pub fn count_majority_subarrays(nums: Vec<i32>, target: i32) -> i64 {
        let n = nums.len();

        // Prefix sums after converting:
        // target -> +1
        // others -> -1
        let mut pref = Vec::with_capacity(n + 1);
        pref.push(0);

        let mut cur = 0;
        for &x in &nums {
            if x == target {
                cur += 1;
            } else {
                cur -= 1;
            }
            pref.push(cur);
        }

        // Coordinate compression.
        let mut vals = pref.clone();
        vals.sort_unstable();
        vals.dedup();

        // Fenwick Tree (Binary Indexed Tree).
        let mut bit = vec![0i64; vals.len() + 2];

        // Add value at compressed index.
        fn add(bit: &mut Vec<i64>, mut idx: usize) {
            while idx < bit.len() {
                bit[idx] += 1;
                idx += idx & (!idx + 1);
            }
        }

        // Query prefix count.
        fn query(bit: &Vec<i64>, mut idx: usize) -> i64 {
            let mut res = 0;
            while idx > 0 {
                res += bit[idx];
                idx &= idx - 1;
            }
            res
        }

        let mut ans = 0i64;

        for &x in &pref {
            let idx = vals.binary_search(&x).unwrap() + 1;

            // Count previous prefix sums strictly smaller.
            ans += query(&bit, idx - 1);

            add(&mut bit, idx);
        }

        ans
    }
}