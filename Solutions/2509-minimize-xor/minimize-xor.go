func minimizeXor(num1 int, num2 int) int {
    // Start with num1 as the initial result. We will modify this to meet the conditions.
    result := num1
    
    // Count the number of set bits (1's) in num2. This is the target number of set bits we need in the result.
    targetSetBitsCount := countSetBits(num2)
    
    // Count the current number of set bits in result (initially num1).
    setBitsCount := countSetBits(result)
    
    // Start from the least significant bit (bit 0).
    currentBit := 0

    // Step 1: Add set bits if the current result has fewer set bits than required.
    for setBitsCount < targetSetBitsCount {
        // If the current bit is not set in result, set it to 1.
        if !isBitSet(result, currentBit) {
            result = setBit(result, currentBit) // Set the bit.
            setBitsCount++                     // Increase the count of set bits.
        }
        currentBit++ // Move to the next bit position.
    }

    // Step 2: Remove extra set bits if the current result has more set bits than required.
    currentBit = 0 // Reset to the least significant bit.
    for setBitsCount > targetSetBitsCount {
        // If the current bit is set in result, unset it (make it 0).
        if isBitSet(result, currentBit) {
            result = unsetBit(result, currentBit) // Unset the bit.
            setBitsCount--                       // Decrease the count of set bits.
        }
        currentBit++ // Move to the next bit position.
    }

    // Return the final result with the required number of set bits and minimal XOR with num1.
    return result
}

// Helper function to count the number of set bits in an integer.
// It counts how many 1's are present in the binary representation of the number.
func countSetBits(x int) int {
    count := 0
    for x > 0 {
        count += x & 1 // Add 1 if the least significant bit is set.
        x >>= 1        // Right shift to check the next bit.
    }
    return count
}

// Helper function to check if a specific bit is set (i.e., equals 1).
func isBitSet(x int, bit int) bool {
    return (x & (1 << bit)) != 0 // Use bitwise AND to check if the bit is 1.
}

// Helper function to set (turn to 1) a specific bit in the number.
func setBit(x int, bit int) int {
    return x | (1 << bit) // Use bitwise OR to set the bit.
}

// Helper function to unset (turn to 0) a specific bit in the number.
func unsetBit(x int, bit int) int {
    return x & ^(1 << bit) // Use bitwise AND with NOT to clear the bit.
}
