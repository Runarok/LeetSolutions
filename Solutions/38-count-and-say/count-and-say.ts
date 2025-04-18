function countAndSay(n: number): string {
    // Base case
    let result = "1";

    // Generate the sequence up to n
    for (let i = 2; i <= n; i++) {
        let nextResult = "";
        let count = 1;

        // Loop through the current result string and generate the next one
        for (let j = 1; j < result.length; j++) {
            if (result[j] === result[j - 1]) {
                count++;  // Increment count if the same character repeats
            } else {
                nextResult += count.toString() + result[j - 1]; // Append the count and the previous character
                count = 1;  // Reset count for the new character
            }
        }
        // Append the count and the last character
        nextResult += count.toString() + result[result.length - 1];
        
        // Update the result for the next iteration
        result = nextResult;
    }

    return result;
}
