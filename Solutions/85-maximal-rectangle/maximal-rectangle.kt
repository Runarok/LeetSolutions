class Solution {
    fun maximalRectangle(matrix: Array<CharArray>): Int {

        // If the matrix is empty, there is no rectangle.
        if (matrix.isEmpty() || matrix[0].isEmpty()) {
            return 0
        }

        val rows = matrix.size
        val cols = matrix[0].size

        // heights[col] represents the number of consecutive
        // '1's ending at the current row in this column.
        //
        // Example:
        //
        // matrix:
        // 1 0 1
        // 1 1 1
        //
        // After processing the second row:
        //
        // heights:
        // 2 1 2
        //
        // This can now be treated as a histogram.
        val heights = IntArray(cols)

        // Keep track of the largest rectangle found so far.
        var maxArea = 0

        // Process the matrix one row at a time.
        for (row in 0 until rows) {

            // Update the histogram heights for this row.
            for (col in 0 until cols) {

                if (matrix[row][col] == '1') {

                    // This cell continues the vertical sequence
                    // of 1s from the previous row.
                    heights[col]++

                } else {

                    // A zero breaks the sequence.
                    // Therefore, there can be no rectangle
                    // containing this column at this height.
                    heights[col] = 0
                }
            }

            // Once we have the histogram for this row,
            // find the largest rectangle inside it.
            maxArea = maxOf(
                maxArea,
                largestRectangleInHistogram(heights)
            )
        }

        return maxArea
    }

    private fun largestRectangleInHistogram(heights: IntArray): Int {

        // The stack stores indices of bars.
        //
        // The heights of the bars represented by the stack
        // are maintained in increasing order.
        //
        // This allows us to quickly determine the width of
        // a rectangle when we encounter a smaller bar.
        val stack = java.util.ArrayDeque<Int>()

        // We will use an extra iteration with a height of 0.
        //
        // This forces all remaining bars in the stack to be
        // processed at the end.
        var maxArea = 0

        for (i in 0..heights.size) {

            // When i == heights.size, we are outside the
            // actual array.
            //
            // Treat this imaginary bar as height 0 so that
            // all remaining bars are removed from the stack.
            val currentHeight =
                if (i == heights.size) {
                    0
                } else {
                    heights[i]
                }

            // If the current bar is smaller than the bar
            // at the top of the stack, the taller bar can
            // no longer extend to the right.
            //
            // Therefore, we calculate its largest possible
            // rectangle now.
            while (stack.isNotEmpty() &&
                heights[stack.peek()] > currentHeight
            ) {

                // Index of the bar whose rectangle we are
                // calculating.
                val heightIndex = stack.pop()

                // Height of the rectangle.
                val height = heights[heightIndex]

                // After removing heightIndex from the stack:
                //
                // - The new stack top is the first smaller
                //   bar on the LEFT.
                //
                // - i is the first smaller bar on the RIGHT.
                //
                // Therefore, the rectangle extends between
                // those two boundaries.
                val width =
                    if (stack.isEmpty()) {
                        i
                    } else {
                        i - stack.peek() - 1
                    }

                // Calculate the area of the rectangle.
                val area = height * width

                // Keep the largest area found.
                maxArea = maxOf(maxArea, area)
            }

            // Add the current index to the stack.
            //
            // The stack remains monotonic because all taller
            // bars have already been removed above.
            if (i < heights.size) {
                stack.push(i)
            }
        }

        return maxArea
    }
}