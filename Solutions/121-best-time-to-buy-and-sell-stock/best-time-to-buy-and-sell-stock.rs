impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {

        // Edge case: if array is empty (though constraints guarantee at least 1)
        if prices.is_empty() {
            return 0;
        }

        // Step 1: Track the minimum price seen so far
        let mut min_price = i32::MAX;

        // Step 2: Track the maximum profit
        let mut max_profit = 0;

        // Step 3: Iterate through each price
        for price in prices {

            // Update the minimum price if current price is lower
            if price < min_price {
                min_price = price;
            }

            // Calculate profit if we sell today
            let profit = price - min_price;

            // Update max profit if this is better
            if profit > max_profit {
                max_profit = profit;
            }
        }

        // Step 4: Return the best profit found
        // If no profit possible, this will remain 0
        max_profit
    }
}