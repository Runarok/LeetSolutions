function maximumHappinessSum(happiness: number[], k: number): number {
    // Sort the happiness array in descending order
    // This ensures we always pick the child with the highest happiness first
    happiness.sort((a, b) => b - a);

    let totalSum = 0; // This will store the final answer

    // Loop through the first k children (we pick exactly k children)
    for (let i = 0; i < k; i++) {
        // After i selections, all remaining children have lost i happiness
        // So the effective happiness of the current child is:
        // happiness[i] - i

        const currentHappiness = happiness[i] - i;

        // Happiness cannot go below 0
        // If it becomes negative, we treat it as 0
        if (currentHappiness > 0) {
            totalSum += currentHappiness;
        } else {
            // Once happiness hits 0, all further picks will also be 0
            // because the array is sorted in descending order
            break;
        }
    }

    // Return the maximum achievable happiness sum
    return totalSum;
}
