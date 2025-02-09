/**
 * @param {number[]} nums
 * @param {number} limit
 * @return {number[]}
 */
class DisjointSetUnion {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, index) => index);
        this.rank = Array(n).fill(0);
    }
    
    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);  // Path compression
        }
        return this.parent[x];
    }
    
    union(x, y) {
        let rootX = this.find(x);
        let rootY = this.find(y);
        
        if (rootX !== rootY) {
            // Union by rank
            if (this.rank[rootX] > this.rank[rootY]) {
                this.parent[rootY] = rootX;
            } else if (this.rank[rootX] < this.rank[rootY]) {
                this.parent[rootX] = rootY;
            } else {
                this.parent[rootY] = rootX;
                this.rank[rootX]++;
            }
        }
    }
}

var lexicographicallySmallestArray = function(nums, limit) {
    let n = nums.length;
    let uf = new DisjointSetUnion(n);
    
    // Step 1: Create an array of indices sorted by the values in nums
    let indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums[a] - nums[b]);

    // Step 2: Union the indices based on the sorted order and the limit condition
    for (let i = 0; i < n - 1; i++) {
        let current = indices[i];
        let next = indices[i + 1];
        
        // If we can swap current and next (i.e., their absolute difference is <= limit)
        if (Math.abs(nums[current] - nums[next]) <= limit) {
            uf.union(current, next);
        }
    }

    // Step 3: Group indices by their root
    let groups = {};
    for (let i = 0; i < n; i++) {
        let root = uf.find(i);
        if (!(root in groups)) {
            groups[root] = [];
        }
        groups[root].push(i);
    }

    // Step 4: Sort values within each group and assign back to the result array
    let result = [...nums];
    for (let group of Object.values(groups)) {
        let values = group.map(i => nums[i]);
        values.sort((a, b) => a - b);
        
        for (let i = 0; i < group.length; i++) {
            result[group[i]] = values[i];
        }
    }

    return result;
};
