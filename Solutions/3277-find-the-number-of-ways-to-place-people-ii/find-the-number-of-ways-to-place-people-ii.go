package main

import (
	"math"
	"sort"
)

// numberOfPairs calculates the number of valid point pairs
// based on given geometric constraints.
// Points are sorted and then checked to count pairs that
// follow specific increasing patterns.
func numberOfPairs(points [][]int) int {
	ans := 0

	// Sort points by X ascending, and if X is same, by Y descending.
	// This ensures we always process from left to right, but for equal X,
	// higher Y comes first to avoid duplicate counting.
	sort.Slice(points, func(i, j int) bool {
		if points[i][0] == points[j][0] {
			return points[i][1] > points[j][1]
		}
		return points[i][0] < points[j][0]
	})

	// Outer loop: pick each point as starting point A
	for i := 0; i < len(points)-1; i++ {
		pointA := points[i]

		// Initialize dynamic boundaries for valid next points
		xMin := pointA[0] - 1   // smallest X allowed for next point
		xMax := math.MaxInt32   // no upper limit on X
		yMin := math.MinInt32   // no lower limit on Y initially
		yMax := pointA[1] + 1   // next point must have Y < yMax

		// Inner loop: check all following points for valid point B
		for j := i + 1; j < len(points); j++ {
			pointB := points[j]

			// Check if pointB lies within allowed boundaries
			if pointB[0] > xMin && pointB[0] < xMax &&
				pointB[1] > yMin && pointB[1] < yMax {

				ans++ // Found a valid pair (A, B)

				// Update boundaries to enforce strictly increasing sequence
				xMin = pointB[0]
				yMin = pointB[1]
			}
		}
	}

	return ans
}
