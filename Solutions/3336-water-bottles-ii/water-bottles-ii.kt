class Solution {
    fun maxBottlesDrunk(numBottles: Int, numExchange: Int): Int {
        // Initial number of full bottles you can drink
        var full = numBottles

        // Keep track of total bottles drunk
        var totalDrunk = 0

        // Track how many empty bottles you have after drinking
        var empty = 0

        // Track the current exchange cost (starts with initial numExchange)
        var exchangeCost = numExchange

        // Loop until you cannot drink or exchange anymore
        while (full > 0) {
            // Drink all current full bottles
            totalDrunk += full  // Add to total
            empty += full       // They become empty after drinking
            full = 0            // No more full bottles left now

            // Check if we have enough empty bottles to exchange
            if (empty >= exchangeCost) {
                // Exchange once (only once per round as per problem)
                empty -= exchangeCost     // Remove used empty bottles
                full = 1                  // Gain 1 full bottle
                exchangeCost += 1         // Increase cost for next exchange
            } else {
                // Can't exchange anymore, break the loop
                break
            }
        }

        // Return the total number of bottles drunk
        return totalDrunk
    }
}
