var NumberContainers = function() {
    // Map to store the number and its list of indices
    this.numToIndices = new Map();
    // Map to store the number at each index
    this.indexToNumber = new Map();
};

/** 
 * @param {number} index 
 * @param {number} number
 * @return {void}
 */
NumberContainers.prototype.change = function(index, number) {
    // If the index already has a number, remove it from the previous number's index list
    if (this.indexToNumber.has(index)) {
        const oldNumber = this.indexToNumber.get(index);
        let indices = this.numToIndices.get(oldNumber);
        const idx = binarySearch(indices, index);
        if (idx !== -1) {
            indices.splice(idx, 1); // Remove the index from the list
            if (indices.length === 0) {
                this.numToIndices.delete(oldNumber); // Clean up if no indices remain
            }
        }
    }

    // Update the index with the new number
    this.indexToNumber.set(index, number);
    
    // Add the index to the correct number's list of indices using binary search to insert it in sorted order
    if (!this.numToIndices.has(number)) {
        this.numToIndices.set(number, []);
    }
    let indices = this.numToIndices.get(number);
    let idx = binarySearchInsert(indices, index);
    indices.splice(idx, 0, index); // Insert index at the correct position
};

/** 
 * @param {number} number
 * @return {number}
 */
NumberContainers.prototype.find = function(number) {
    // If no indices for this number, return -1
    if (!this.numToIndices.has(number)) {
        return -1;
    }
    
    // Get the sorted list of indices and return the smallest
    const indices = this.numToIndices.get(number);
    return indices[0]; // The first element is the smallest
};

/** 
 * Binary search to find the index of the element (returns -1 if not found)
 * @param {Array} arr
 * @param {number} target
 * @return {number}
 */
function binarySearch(arr, target) {
    let left = 0, right = arr.length - 1;
    while (left <= right) {
        let mid = left + Math.floor((right - left) / 2);
        if (arr[mid] === target) return mid;
        if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1; // Not found
}

/** 
 * Binary search to find the insertion index (returns the index where the element should be inserted)
 * @param {Array} arr
 * @param {number} target
 * @return {number}
 */
function binarySearchInsert(arr, target) {
    let left = 0, right = arr.length;
    while (left < right) {
        let mid = left + Math.floor((right - left) / 2);
        if (arr[mid] < target) left = mid + 1;
        else right = mid;
    }
    return left; // Return the insertion point
}

/** 
 * Your NumberContainers object will be instantiated and called as such:
 * var obj = new NumberContainers()
 * obj.change(index, number)
 * var param_2 = obj.find(number)
 */
