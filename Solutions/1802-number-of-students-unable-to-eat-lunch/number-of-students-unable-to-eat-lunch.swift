class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        // Count how many students prefer circular (0) sandwiches
        var count0 = students.filter { $0 == 0 }.count
        // The rest of the students must prefer square (1) sandwiches
        var count1 = students.count - count0
        
        // Go through each sandwich in order (top of the stack first)
        for sandwich in sandwiches {
            if sandwich == 0 {
                // If there's at least one student who likes circular sandwiches
                if count0 > 0 {
                    count0 -= 1 // student takes the sandwich
                } else {
                    break // no student wants this sandwich, stop the process
                }
            } else { // sandwich == 1
                // If there's at least one student who likes square sandwiches
                if count1 > 0 {
                    count1 -= 1 // student takes the sandwich
                } else {
                    break // no student wants this sandwich, stop the process
                }
            }
        }
        
        // Remaining students who couldn't eat are those left preferring 0 or 1
        return count0 + count1
    }
}
