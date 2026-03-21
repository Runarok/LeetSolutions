class Solution {
    func maxArea(_ height: [Int]) -> Int {
        
        // Two pointers:
        // left starts at beginning
        // right starts at end
        var left = 0
        var right = height.count - 1
        
        // Variable to keep track of the maximum area found so far
        var maxArea = 0
        
        // Loop until the two pointers meet
        while left < right {
            
            // Heights at both pointers
            let leftHeight = height[left]
            let rightHeight = height[right]
            
            // Width between the two lines
            let width = right - left
            
            // The height of the container is limited by the shorter line
            let minHeight = min(leftHeight, rightHeight)
            
            // Calculate current area
            let currentArea = minHeight * width
            
            // Update maximum area if current is larger
            if currentArea > maxArea {
                maxArea = currentArea
            }
            
            // Move the pointer pointing to the shorter line
            // Reason:
            // - The area is limited by the shorter height
            // - Moving the taller line inward won't help increase area
            // - We try to find a taller line by moving the shorter one
            if leftHeight < rightHeight {
                left += 1
            } else {
                right -= 1
            }
        }
        
        // Return the maximum area found
        return maxArea
    }
}