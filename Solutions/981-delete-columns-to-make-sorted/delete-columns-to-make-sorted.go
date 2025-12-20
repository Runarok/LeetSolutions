func minDeletionSize(strs []string) int {
    // Number of strings (rows in the grid)
    n := len(strs)
    
    // Length of each string (number of columns in the grid)
    m := len(strs[0])
    
    // This variable will count how many columns need to be deleted
    deleteCount := 0

    // Loop through each column (from 0 to m-1)
    for col := 0; col < m; col++ {
        
        // Assume the current column is sorted initially
        isSorted := true
        
        // Compare characters vertically within this column
        // We check each row against the previous row
        for row := 1; row < n; row++ {
            
            // If the current character is smaller than the one above it,
            // the column is NOT sorted lexicographically
            if strs[row][col] < strs[row-1][col] {
                isSorted = false
                break // No need to check further rows in this column
            }
        }
        
        // If the column is not sorted, we must delete it
        if !isSorted {
            deleteCount++
        }
    }
    
    // Return the total number of columns that need to be deleted
    return deleteCount
}
