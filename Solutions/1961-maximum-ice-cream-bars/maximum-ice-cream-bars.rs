impl Solution {
    pub fn max_ice_cream(costs: Vec<i32>, mut coins: i32) -> i32 {
        // ---------------------------------------------------------
        // The problem specifically asks us to solve it using
        // COUNTING SORT.
        //
        // Constraints:
        // 1 <= costs[i] <= 100000
        //
        // Since the maximum possible cost is only 100000,
        // we can count how many ice cream bars exist for
        // each cost value.
        // ---------------------------------------------------------

        // Maximum possible cost according to constraints.
        const MAX_COST: usize = 100_000;

        // freq[c] = number of ice cream bars that cost c coins.
        let mut freq = vec![0; MAX_COST + 1];

        // Count frequencies of every cost.
        for cost in costs {
            freq[cost as usize] += 1;
        }

        // This will store the number of bars purchased.
        let mut answer = 0;

        // ---------------------------------------------------------
        // Traverse costs from cheapest to most expensive.
        //
        // This mimics the behavior of sorting, but without
        // actually sorting the array.
        //
        // Greedy idea:
        // Always buy the cheapest available ice cream first.
        // ---------------------------------------------------------
        for cost in 1..=MAX_COST {
            // No ice cream bars with this cost.
            if freq[cost] == 0 {
                continue;
            }

            // -----------------------------------------------------
            // Determine how many bars of this price we can afford.
            //
            // Example:
            // cost = 3
            // freq[3] = 5
            // coins = 10
            //
            // We can afford at most:
            // 10 / 3 = 3 bars
            //
            // But if only 2 bars exist, we can buy only 2.
            // -----------------------------------------------------
            let can_buy = std::cmp::min(freq[cost], coins / cost as i32);

            // Add purchased bars to answer.
            answer += can_buy;

            // Deduct spent coins.
            coins -= can_buy * cost as i32;

            // -----------------------------------------------------
            // If we cannot afford even one bar of the current cost,
            // we also cannot afford any more expensive bars.
            // So we can stop early.
            // -----------------------------------------------------
            if coins < cost as i32 {
                break;
            }
        }

        answer
    }
}