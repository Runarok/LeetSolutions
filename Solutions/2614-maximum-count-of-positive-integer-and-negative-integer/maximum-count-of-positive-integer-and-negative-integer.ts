function maximumCount(nums: number[]): number {
    // Initialize counters for positive and negative numbers
    let positiveCount = 0;
    let negativeCount = 0;

    // Loop through each number in the array
    for (let num of nums) {
        // Increment positiveCount if the number is positive
        if (num > 0) {
            positiveCount++;
        } 
        // Increment negativeCount if the number is negative
        else if (num < 0) {
            negativeCount++;
        }
    }

    // Return the larger of the two counts: positiveCount or negativeCount
    return Math.max(positiveCount, negativeCount);
}
