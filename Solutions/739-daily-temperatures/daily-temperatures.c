#include <stdlib.h>

/**
 * Function: dailyTemperatures
 * ---------------------------
 * Given an array of daily temperatures, returns an array where each element
 * tells how many days you have to wait until a warmer temperature.
 *
 * temperatures: array of daily temperatures
 * temperaturesSize: number of days
 * returnSize: pointer to store the size of the returned array
 *
 * returns: dynamically allocated array of days to wait for a warmer temperature
 */
int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    // Allocate result array, initialize all to 0
    int* answer = (int*)malloc(sizeof(int) * temperaturesSize);
    for (int i = 0; i < temperaturesSize; i++) {
        answer[i] = 0; // default 0 if no warmer day exists
    }

    // Stack to store indices of temperatures
    int* stack = (int*)malloc(sizeof(int) * temperaturesSize);
    int top = -1; // stack is empty initially

    // Loop through all days
    for (int i = 0; i < temperaturesSize; i++) {
        // While stack is not empty and current temperature is warmer than the one at stack top
        while (top != -1 && temperatures[i] > temperatures[stack[top]]) {
            int idx = stack[top--];         // pop the index of the cooler day
            answer[idx] = i - idx;          // number of days until warmer temperature
        }
        // Push current day's index onto the stack
        stack[++top] = i;
    }

    free(stack); // free memory used by stack
    *returnSize = temperaturesSize; // set return size
    return answer;
}
