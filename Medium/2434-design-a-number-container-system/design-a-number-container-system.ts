class NumberContainers {
    private numToIndices: Map<number, number[]>;
    private indexToNumber: Map<number, number>;

    constructor() {
        this.numToIndices = new Map();
        this.indexToNumber = new Map();
    }

    /**
     * Fills the container at index with the number. If there is already a number at that index, replace it.
     * @param index The index to store the number.
     * @param number The number to store at the given index.
     */
    change(index: number, number: number): void {
        // If the index already has a number, remove it from the previous number's sorted list
        if (this.indexToNumber.has(index)) {
            const oldNumber = this.indexToNumber.get(index);
            const indices = this.numToIndices.get(oldNumber);
            if (indices) {
                const idx = this.binarySearch(indices, index);
                if (idx !== -1) {
                    indices.splice(idx, 1); // Remove index from the old number's sorted list
                    if (indices.length === 0) {
                        this.numToIndices.delete(oldNumber); // Clean up if no indices remain
                    }
                }
            }
        }

        // Update the number at the given index
        this.indexToNumber.set(index, number);

        // Add the index to the sorted list for the new number
        if (!this.numToIndices.has(number)) {
            this.numToIndices.set(number, []);
        }
        const indices = this.numToIndices.get(number);

        // Insert the index in sorted order using binary search
        const insertIndex = this.binarySearchInsert(indices!, index);
        indices!.splice(insertIndex, 0, index);
    }

    /**
     * Returns the smallest index for the given number, or -1 if there is no index filled with that number.
     * @param number The number to find the smallest index for.
     * @returns The smallest index or -1 if the number is not found.
     */
    find(number: number): number {
        // If there are no indices for the given number, return -1
        const indices = this.numToIndices.get(number);
        if (!indices || indices.length === 0) {
            return -1;
        }

        // The smallest index is the first element in the sorted list
        return indices[0];
    }

    /**
     * Binary search to find the index of the element (returns -1 if not found)
     * @param arr The sorted array
     * @param target The target index to search for
     * @return The index of the target or -1 if not found
     */
    private binarySearch(arr: number[], target: number): number {
        let left = 0, right = arr.length - 1;
        while (left <= right) {
            let mid = left + Math.floor((right - left) / 2);
            if (arr[mid] === target) return mid;
            if (arr[mid] < target) left = mid + 1;
            else right = mid - 1;
        }
        return -1; // Target not found
    }

    /**
     * Binary search to find the insertion point for the target index
     * @param arr The sorted array of indices
     * @param target The index to insert
     * @return The position to insert the index while keeping the array sorted
     */
    private binarySearchInsert(arr: number[], target: number): number {
        let left = 0, right = arr.length;
        while (left < right) {
            let mid = left + Math.floor((right - left) / 2);
            if (arr[mid] < target) left = mid + 1;
            else right = mid;
        }
        return left; // Return the insertion point
    }
}

/**
 * Your NumberContainers object will be instantiated and called as such:
 * var obj = new NumberContainers();
 * obj.change(index, number);
 * var param_2 = obj.find(number);
 */
