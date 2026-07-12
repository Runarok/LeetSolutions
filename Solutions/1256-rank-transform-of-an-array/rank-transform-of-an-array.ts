function arrayRankTransform(arr: number[]): number[] {
    // If the array is empty, there is nothing to rank.
    if (arr.length === 0) {
        return [];
    }

    // ---------------------------------------------------------
    // STEP 1:
    // Create a copy of the array because sorting changes
    // the original array.
    // ---------------------------------------------------------
    const sorted = [...arr];

    // Sort the numbers in ascending order.
    sorted.sort((a, b) => a - b);

    // ---------------------------------------------------------
    // STEP 2:
    // Assign ranks to each unique number.
    //
    // Example:
    // sorted = [10,20,30,40]
    //
    // Map:
    // 10 -> 1
    // 20 -> 2
    // 30 -> 3
    // 40 -> 4
    //
    // If duplicates exist:
    // [10,10,20]
    //
    // Map:
    // 10 -> 1
    // 20 -> 2
    // ---------------------------------------------------------
    const rankMap = new Map<number, number>();

    // Rank starts from 1.
    let rank = 1;

    // Traverse the sorted array.
    for (let num of sorted) {

        // Only assign a rank if this number
        // hasn't been seen before.
        if (!rankMap.has(num)) {
            rankMap.set(num, rank);

            // Increase rank only for NEW numbers.
            rank++;
        }
    }

    // ---------------------------------------------------------
    // STEP 3:
    // Replace every original number with its rank.
    // ---------------------------------------------------------
    const result: number[] = [];

    for (let num of arr) {
        // Since every number exists in rankMap,
        // get() will always return a value.
        result.push(rankMap.get(num)!);
    }

    // Return the ranked array.
    return result;
}