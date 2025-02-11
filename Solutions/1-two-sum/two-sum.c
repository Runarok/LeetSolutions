/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#include <stdio.h>
#include <stdlib.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    // We will use a hash table (map) to store the numbers we've seen so far.
    // To simplify, we'll use an array with size equal to the range of numbers in nums.
    // For simplicity, let's use a dynamic memory allocation for the result.
    
    *returnSize = 2;  // Since we will always return exactly two indices.
    
    // Create a hash map to store numbers and their indices
    // In a real-world case, we would use a hash map to store this.
    // For simplicity, we use a dynamic array.
    // The key idea is to store numbers seen so far, and check if complement exists.
    
    // Step 1: Allocate an array for the result
    int* result = (int*)malloc(2 * sizeof(int)); 
    
    // Step 2: Create a map to store indices (we could use a simpler array for this)
    // If we assume numbers are in a reasonable range, we could optimize space here.
    // For simplicity, we will use brute-force checking instead of building a full hash map.
    
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }
    
    return NULL;  // In case no solution is found, which should not happen per problem statement
}
