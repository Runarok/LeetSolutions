class Solution {
    fun numWaterBottles(numBottles: Int, numExchange: Int): Int {
        // Total number of bottles you can drink
        var totalDrank = numBottles
        
        // After drinking the initial bottles, you have that many empty bottles
        var emptyBottles = numBottles

        // Keep exchanging empty bottles for full ones while possible
        while (emptyBottles >= numExchange) {
            // How many new full bottles can we get from the empty ones?
            val newFull = emptyBottles / numExchange
            
            // Add the new full bottles to total drank
            totalDrank += newFull
            
            // Update empty bottles:
            // - we used (newFull * numExchange) empty bottles in exchange
            // - we get newFull full bottles, and after drinking them they become empty
            emptyBottles = emptyBottles % numExchange + newFull
        }

        return totalDrank
    }
}
