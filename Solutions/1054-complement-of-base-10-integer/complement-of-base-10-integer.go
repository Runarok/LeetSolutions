func bitwiseComplement(N int) int {

    // This will store the final complemented number
    result := 0

    // This tracks the current bit position
    // (0 for least significant bit, 1 for next, etc.)
    helper := 0
    
    // Special case:
    // If N is 0, its binary representation is "0"
    // Complement of "0" is "1"
    if N == 0 {
        return 1
    }
    
    // Process each bit of N until no bits remain
    for N != 0 {

        // Extract the last bit of N using (N & 1)
        // Example:
        // 5 (101) & 1 = 1
        // 4 (100) & 1 = 0
        // Then flip the bit using XOR with 1
        // 1 ^ 1 = 0
        // 0 ^ 1 = 1
        character := (N & 1) ^ 1

        // Shift N right by 1 to process the next bit
        // Example:
        // 101 -> 10 -> 1 -> 0
        N = N >> 1

        // Place the flipped bit back into the result
        // at the correct bit position
        result = result | (character << helper)

        // Move to the next bit position
        helper++
    }

    // Return the final complemented number
    return result
}