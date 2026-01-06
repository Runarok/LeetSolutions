#include <stdbool.h>

bool validMountainArray(int* arr, int arrSize) {
    // A mountain array must have at least 3 elements
    if (arrSize < 3) return false;

    int i = 0;

    // Walk up: strictly increasing
    while (i + 1 < arrSize && arr[i] < arr[i + 1]) {
        i++;
    }

    // Peak can't be first or last element
    if (i == 0 || i == arrSize - 1) return false;

    // Walk down: strictly decreasing
    while (i + 1 < arrSize && arr[i] > arr[i + 1]) {
        i++;
    }

    // If we reached the end, it's a valid mountain
    return i == arrSize - 1;
}
