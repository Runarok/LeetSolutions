class Solution {
    fun canReach(arr: IntArray, start: Int): Boolean {

        // Visited array to avoid infinite loops
        val visited = BooleanArray(arr.size)

        // DFS function
        fun dfs(index: Int): Boolean {

            // If index goes out of bounds, return false
            if (index < 0 || index >= arr.size) {
                return false
            }

            // If already visited, no need to process again
            if (visited[index]) {
                return false
            }

            // If we found a 0, return true
            if (arr[index] == 0) {
                return true
            }

            // Mark current index as visited
            visited[index] = true

            // Calculate next possible jumps
            val forward = index + arr[index]
            val backward = index - arr[index]

            // Try both directions
            return dfs(forward) || dfs(backward)
        }

        // Start DFS from given start index
        return dfs(start)
    }
}