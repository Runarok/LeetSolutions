function minimumBoxes(apple: number[], capacity: number[]): number {
    // ------------------------------------------------------------
    // Step 1: Calculate the total number of apples
    // ------------------------------------------------------------
    // Since apples from different packs can be mixed freely,
    // we only need to know the total count of apples.
    let totalApples = 0;
    for (let i = 0; i < apple.length; i++) {
        totalApples += apple[i];
    }

    // ------------------------------------------------------------
    // Step 2: Sort box capacities in descending order
    // ------------------------------------------------------------
    // To minimize the number of boxes used, we should always
    // choose the largest available boxes first (greedy strategy).
    capacity.sort((a, b) => b - a);

    // ------------------------------------------------------------
    // Step 3: Keep selecting boxes until we can hold all apples
    // ------------------------------------------------------------
    let usedBoxes = 0;       // Number of boxes selected
    let currentCapacity = 0; // Total capacity of selected boxes

    for (let i = 0; i < capacity.length; i++) {
        // Add this box's capacity
        currentCapacity += capacity[i];
        usedBoxes++;

        // Check if we can store all apples now
        if (currentCapacity >= totalApples) {
            return usedBoxes;
        }
    }

    // ------------------------------------------------------------
    // Step 4: Return result
    // ------------------------------------------------------------
    // The problem guarantees that a solution is always possible,
    // so this return is just a safety fallback.
    return usedBoxes;
}
