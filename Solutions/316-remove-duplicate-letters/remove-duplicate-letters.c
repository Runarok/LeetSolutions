#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/**
 * Function: removeDuplicateLetters
 * --------------------------------
 * Removes duplicate letters from a string so that every letter appears once,
 * and the result is the smallest in lexicographical order.
 *
 * s: input string
 *
 * returns: dynamically allocated string with duplicates removed in smallest lexicographical order
 */
char* removeDuplicateLetters(char* s) {
    int n = strlen(s);
    int lastIndex[26];  // Stores last occurrence of each character
    bool inStack[26] = {0}; // Tracks if character is already in stack

    // Record last occurrence of each character
    for (int i = 0; i < n; i++) {
        lastIndex[s[i] - 'a'] = i;
    }

    char* stack = (char*)malloc(sizeof(char) * (n + 1)); // Stack to build result
    int top = -1; // Stack is empty initially

    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';

        // Skip if character is already in stack
        if (inStack[c]) continue;

        // Pop characters from stack if:
        // 1. They are greater than current character (to get smaller lexicographical order)
        // 2. They will appear later again (so we can add them back later)
        while (top >= 0 && stack[top] > s[i] && lastIndex[stack[top] - 'a'] > i) {
            inStack[stack[top] - 'a'] = false; // Mark popped character as not in stack
            top--;
        }

        // Push current character to stack
        stack[++top] = s[i];
        inStack[c] = true; // Mark character as in stack
    }

    stack[top + 1] = '\0'; // Null-terminate the string
    return stack;
}
