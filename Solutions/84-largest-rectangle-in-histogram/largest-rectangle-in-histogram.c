#include <stdlib.h>

/*
 * Function: largestRectangleArea
 * ------------------------------
 * Computes the area of the largest rectangle in a histogram.
 *
 * heights: an array of non-negative integers representing bar heights
 * heightsSize: the number of bars in the histogram
 *
 * returns: the area of the largest rectangle
 */
int largestRectangleArea(int* heights, int heightsSize) {
    // Allocate a stack to store indices of bars
    // Size is heightsSize + 1 to handle sentinel at the end
    int* stack = (int*)malloc(sizeof(int) * (heightsSize + 1));
    
    int top = -1;       // Top of the stack (-1 means stack is empty)
    int maxArea = 0;    // Stores the maximum rectangle area found

    // Loop through all bars, plus one extra iteration as a sentinel
    for (int i = 0; i <= heightsSize; i++) {
        // Use 0 as a sentinel height at the end to clear remaining bars
        int h = (i == heightsSize) ? 0 : heights[i];

        // If current bar is shorter than the bar at stack's top,
        // we need to calculate area for the bar at stack[top]
        while (top != -1 && h < heights[stack[top]]) {
            // Pop the top index from stack
            int height = heights[stack[top--]]; // Height of the rectangle

            // Width calculation:
            // If stack is empty after popping, width is i (extends to start)
            // Else, width is distance between current index i and new top of stack - 1
            int width = (top == -1) ? i : (i - stack[top] - 1);

            // Calculate area with popped bar as height
            int area = height * width;

            // Update maxArea if this area is larger
            if (area > maxArea) {
                maxArea = area;
            }
        }

        // Push current index onto the stack
        // Stack always stores indices of bars in increasing height order
        stack[++top] = i;
    }

    // Free allocated memory for the stack
    free(stack);

    // Return the largest rectangle area found
    return maxArea;
}
