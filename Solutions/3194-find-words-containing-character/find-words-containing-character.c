#include <stdlib.h>  // For malloc
#include <string.h>  // For strchr

/**
 * Finds indices of words that contain a specific character.
 *
 * @param words Pointer to an array of strings (words).
 * @param wordsSize Number of words in the array.
 * @param x Character to search for within each word.
 * @param returnSize Pointer to an int where the function will store
 *                   the number of words that contain the character.
 * @return Pointer to an integer array containing the indices of words
 *         that contain the character `x`. The caller is responsible for freeing this array.
 */
int* findWordsContaining(char** words, int wordsSize, char x, int* returnSize) {
    // Allocate an integer array to store indices of words that contain 'x'.
    // The maximum possible size is wordsSize (if every word contains 'x').
    int* res = (int*)malloc(wordsSize * sizeof(int));
    
    // Initialize returnSize to 0 since we haven't found any words yet.
    *returnSize = 0;
    
    // Iterate over each word in the input array.
    for (int i = 0; i < wordsSize; i++) {
        // strchr returns a pointer to the first occurrence of character 'x' in words[i],
        // or NULL if 'x' is not found.
        if (strchr(words[i], x) != NULL) {
            // If 'x' is found in words[i], store the index 'i' in the result array.
            res[(*returnSize)++] = i;
        }
    }
    
    // Return the array containing the indices of words containing 'x'.
    // The caller can use *returnSize to know how many elements are valid.
    return res;
}
