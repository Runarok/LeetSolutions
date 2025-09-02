class Solution {
    fun numberOfPairs(points: Array<IntArray>): Int {
        var count = 0                      // This will store the total number of valid pairs
        val n = points.size               // Number of points in the input

        // Iterate over all possible pairs (A, B)
        for (i in 0 until n) {
            val ax = points[i][0]         // x-coordinate of point A
            val ay = points[i][1]         // y-coordinate of point A

            for (j in 0 until n) {
                if (i == j) continue      // Skip if A and B are the same point

                val bx = points[j][0]     // x-coordinate of point B
                val by = points[j][1]     // y-coordinate of point B

                // Check if point A is on the upper-left side of point B
                // This means A.x <= B.x and A.y >= B.y
                if (ax <= bx && ay >= by) {
                    var isValid = true    // Assume the pair is valid until we find a blocking point

                    // Now check all other points to see if one lies inside the rectangle (or on its border)
                    for (k in 0 until n) {
                        if (k == i || k == j) continue  // Skip A and B themselves

                        val px = points[k][0]           // x-coordinate of the third point
                        val py = points[k][1]           // y-coordinate of the third point

                        // Check if this point lies inside or on the border of the rectangle
                        // The rectangle is defined from A to B (inclusive of borders)
                        if (px in ax..bx && py in by..ay) {
                            // If a point lies in the rectangle, the pair is invalid
                            isValid = false
                            break
                        }
                    }

                    // If no point was found in the rectangle, count this pair as valid
                    if (isValid) count++
                }
            }
        }

        // Return the total number of valid pairs found
        return count
    }
}
