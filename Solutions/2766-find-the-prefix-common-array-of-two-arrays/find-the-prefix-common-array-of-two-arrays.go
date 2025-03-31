func findThePrefixCommonArray(A []int, B []int) []int {
    n := len(A)
    prefixCommonArray := make([]int, n) // Result array to store common counts

    for currentIndex := 0; currentIndex < n; currentIndex++ {
        commonCount := 0

        // Compare elements in A and B within the range of the current prefix
        for aIndex := 0; aIndex <= currentIndex; aIndex++ {
            for bIndex := 0; bIndex <= currentIndex; bIndex++ {
                if A[aIndex] == B[bIndex] {
                    commonCount++         // Increment the count if elements match
                    break                 // Prevent counting duplicates
                }
            }
        }

        // Store the count of common elements for the current prefix
        prefixCommonArray[currentIndex] = commonCount
    }

    return prefixCommonArray
}
