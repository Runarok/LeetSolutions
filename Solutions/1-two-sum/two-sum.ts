function twoSum(nums: number[], target: number): number[] | null {
    let result: number[] = [0, 0];  // Array of size 2 to store indices
    
    // Brute force checking to find the solution
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] === target) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    return null;  // If no solution is found, return null
}
