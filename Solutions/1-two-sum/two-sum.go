func twoSum(nums []int, target int) []int {
    result := []int{0, 0}  // Array of size 2 to store indices
    
    // Brute force checking to find the solution
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if nums[i] + nums[j] == target {
                result[0] = i
                result[1] = j
                return result
            }
        }
    }

    return nil  // If no solution is found, return nil
}
