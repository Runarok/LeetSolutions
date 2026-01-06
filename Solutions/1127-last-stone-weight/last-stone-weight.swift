class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        // -----------------------------------------
        // Step 1: Copy stones array into a mutable array
        // We'll be modifying it, so we need a variable
        // -----------------------------------------
        var stones = stones
        
        // -----------------------------------------
        // Step 2: Continue smashing until at most one stone remains
        // -----------------------------------------
        while stones.count > 1 {
            
            // -----------------------------------------
            // Step 2a: Sort stones to find the two heaviest
            // Sorting descending so the largest stones are first
            // stones[0] = heaviest, stones[1] = second heaviest
            // -----------------------------------------
            stones.sort(by: >)
            
            let heaviest = stones[0]        // largest stone
            let secondHeaviest = stones[1]  // second largest stone
            
            // -----------------------------------------
            // Step 2b: Smash the two heaviest stones
            // Case 1: stones are equal -> both destroyed
            // Case 2: stones are different -> largest becomes largest - second
            // -----------------------------------------
            if heaviest == secondHeaviest {
                // Both stones destroyed, remove the first two elements
                stones.removeFirst(2)
            } else {
                // Stones are different
                // Remove the first two stones
                stones.removeFirst(2)
                // Add the new stone with weight (heaviest - secondHeaviest)
                let newStone = heaviest - secondHeaviest
                stones.append(newStone)
            }
            
            // At this point, stones array has one less stone (or same if new stone added)
            // The loop will repeat until only one or zero stones remain
        }
        
        // -----------------------------------------
        // Step 3: Return the weight of the last remaining stone
        // If there are no stones left, return 0
        // -----------------------------------------
        return stones.first ?? 0
    }
}