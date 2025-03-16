/**
 * @param {number[]} ranks
 * @param {number} cars
 * @return {number}
 */
var repairCars = function(ranks, cars) {
    // Helper function to check if we can repair all cars within a given time limit
    const canRepairInTime = (timeLimit) => {
        let totalCarsRepaired = 0;
        
        // For each mechanic, calculate the number of cars they can repair within the time limit
        for (let rank of ranks) {
            totalCarsRepaired += Math.floor(Math.sqrt(timeLimit / rank)); // max cars each mechanic can repair in the given time
            if (totalCarsRepaired >= cars) {
                return true; // if we already repaired enough cars, return true
            }
        }
        return totalCarsRepaired >= cars; // check if all cars can be repaired
    };

    // Binary search for the minimum time
    let left = 1, right = Math.min(...ranks) * cars * cars; // start with the upper bound
    let result = right;
    
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        
        if (canRepairInTime(mid)) {
            result = mid; // update result if mid time is feasible
            right = mid - 1; // try for a smaller time
        } else {
            left = mid + 1; // try for a larger time
        }
    }
    
    return result; // return the minimum time
};
