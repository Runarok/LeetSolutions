class RandomizedSet {

    // Array to store elements for O(1) random access
    private var arr: [Int]
    
    // Dictionary to store value -> index mapping
    private var map: [Int: Int]
    
    /** Initialize your data structure here. */
    init() {
        arr = []
        map = [:]
    }
    
    /**
     * Inserts a value to the set.
     * Returns true if the set did not already contain the specified element.
     */
    func insert(_ val: Int) -> Bool {
        
        // If value already exists, do not insert
        if map[val] != nil {
            return false
        }
        
        // Append value to array
        arr.append(val)
        
        // Store its index in the map
        map[val] = arr.count - 1
        
        return true
    }
    
    /**
     * Removes a value from the set.
     * Returns true if the set contained the specified element.
     */
    func remove(_ val: Int) -> Bool {
        
        // If value does not exist, return false
        guard let index = map[val] else {
            return false
        }
        
        // Get the last element in the array
        let lastElement = arr[arr.count - 1]
        
        // Swap the element to remove with the last element
        arr[index] = lastElement
        
        // Update the index of the last element in the map
        map[lastElement] = index
        
        // Remove the last element from the array
        arr.removeLast()
        
        // Remove the value from the map
        map.removeValue(forKey: val)
        
        return true
    }
    
    /**
     * Get a random element from the set.
     * Each element must have the same probability of being returned.
     */
    func getRandom() -> Int {
        
        // Generate a random index in the array
        let randomIndex = Int.random(in: 0..<arr.count)
        
        // Return the element at that index
        return arr[randomIndex]
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */