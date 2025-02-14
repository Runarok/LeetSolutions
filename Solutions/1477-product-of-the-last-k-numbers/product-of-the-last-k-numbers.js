var ProductOfNumbers = function() {
    // Initialize the numbers array and a list to store cumulative products
    this.nums = [];
    this.products = [1]; // Initialize with 1 to make multiplication easier
};

/** 
 * @param {number} num
 * @return {void}
 */
ProductOfNumbers.prototype.add = function(num) {
    // If the number is 0, we need to reset the product array
    if (num === 0) {
        this.nums = [];
        this.products = [1]; // Reset product array to only contain 1
    } else {
        // Otherwise, add the number to the list and update the product array
        this.nums.push(num);
        this.products.push(this.products[this.products.length - 1] * num);
    }
};

/** 
 * @param {number} k
 * @return {number}
 */
ProductOfNumbers.prototype.getProduct = function(k) {
    // If k is larger than the number of elements in the list, return 0
    if (k > this.nums.length) {
        return 0;
    }
    // Get the product of the last k numbers using the product list
    return this.products[this.products.length - 1] / this.products[this.products.length - k - 1];
};

/** 
 * Your ProductOfNumbers object will be instantiated and called as such:
 * var obj = new ProductOfNumbers();
 * obj.add(num);
 * var param_2 = obj.getProduct(k);
 */
