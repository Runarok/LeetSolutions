class Solution {
    func canSeePersonsCount(_ heights: [Int]) -> [Int] {
        let n = heights.count
        
        // Result array initialized with 0s
        var answer = Array(repeating: 0, count: n)
        
        // Stack will store heights of people to the right
        var stack: [Int] = []
        
        // Traverse from right to left
        for i in stride(from: n - 1, through: 0, by: -1) {
            
            var count = 0
            
            // Step 1: Pop all shorter people
            // These are visible because no one blocks them from current person
            while !stack.isEmpty && heights[i] > stack.last! {
                stack.removeLast()
                count += 1
            }
            
            // Step 2: If stack is not empty, we can see one more person
            // (the first taller or equal person blocking the view)
            if !stack.isEmpty {
                count += 1
            }
            
            // Store result
            answer[i] = count
            
            // Step 3: Push current person into stack
            stack.append(heights[i])
        }
        
        return answer
    }
}