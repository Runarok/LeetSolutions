function maxCandies(
    status: number[],           // Array indicating whether each box is initially open (1) or closed (0)
    candies: number[],          // Array of candies in each box
    keys: number[][],           // Array of keys contained in each box (keys[i] is the list of keys inside box i)
    containedBoxes: number[][], // Array of boxes contained in each box (containedBoxes[i] is the list of boxes inside box i)
    initialBoxes: number[],     // List of boxes you initially have
): number {
    const n = status.length;    // Total number of boxes
    
    // Track which boxes can currently be opened (true if open or key obtained)
    const canOpen: boolean[] = new Array(n).fill(false);
    // Track which boxes you currently have possession of (either initially or found inside other boxes)
    const hasBox: boolean[] = new Array(n).fill(false);
    // Track which boxes have been opened and their candies collected (to avoid double counting)
    const used: boolean[] = new Array(n).fill(false);

    // Initialize canOpen based on the initial status of boxes
    for (let i = 0; i < n; ++i) {
        canOpen[i] = status[i] === 1;  // true if box i is initially open, false if closed
    }

    // Queue to hold boxes that are ready to be opened and processed
    const q: number[] = [];
    let ans = 0;  // Accumulator for total candies collected

    // Start with the boxes you initially have
    for (const box of initialBoxes) {
        hasBox[box] = true;  // Mark that you possess this box
        
        // If this box can be opened immediately (status 1), process it right away
        if (canOpen[box]) {
            q.push(box);       // Add it to the queue for processing
            used[box] = true;  // Mark it as opened/used
            ans += candies[box];  // Collect candies from this box
        }
    }

    // Process the queue until no more boxes can be opened
    while (q.length > 0) {
        // Take a box from the queue to process
        const bigBox = q.shift()!; 

        // 1) Collect all keys from this box and mark those boxes as openable
        for (const key of keys[bigBox]) {
            canOpen[key] = true;  // Now you can open box 'key'
            
            // If you already have that box but haven't opened it yet, add it to the queue
            if (!used[key] && hasBox[key]) {
                q.push(key);
                used[key] = true;  // Mark as opened
                ans += candies[key];  // Collect candies
            }
        }

        // 2) Collect all boxes found inside this box
        for (const box of containedBoxes[bigBox]) {
            hasBox[box] = true;  // You now possess this inner box
            
            // If you can open it (you have the key or it was initially open) and haven't opened it yet, process it
            if (!used[box] && canOpen[box]) {
                q.push(box);
                used[box] = true;  // Mark as opened
                ans += candies[box];  // Collect candies
            }
        }
    }

    // Return the total number of candies collected after opening all possible boxes
    return ans;
}
