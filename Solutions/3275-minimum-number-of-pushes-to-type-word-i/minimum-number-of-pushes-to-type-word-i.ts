function minimumPushes(word: string): number {
    // Number of letters we need to assign.
    // Since every character is unique, only the length matters.
    const n = word.length;

    // Stores the minimum total number of pushes.
    let pushes = 0;

    // Assign letters one by one.
    for (let i = 0; i < n; i++) {

        // There are 8 keys (2-9).
        //
        // First 8 letters:
        // i = 0..7
        // floor(i / 8) = 0
        // cost = 1
        //
        // Next 8 letters:
        // i = 8..15
        // floor(i / 8) = 1
        // cost = 2
        //
        // Next 8 letters:
        // i = 16..23
        // cost = 3
        //
        // Last possible letters:
        // i = 24..25
        // cost = 4
        const cost = Math.floor(i / 8) + 1;

        // Add this letter's cost.
        pushes += cost;
    }

    // Return the minimum number of pushes needed.
    return pushes;
}