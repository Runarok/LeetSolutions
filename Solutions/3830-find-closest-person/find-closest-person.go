import "math"

// findClosest compares the absolute differences between z and x, and z and y.
// It returns:
//   1 if x is closer to z,
//   2 if y is closer to z,
//   0 if both are equally close.
func findClosest(x int, y int, z int) int {
	// Calculate the absolute difference between x and z
	dxz := int(math.Abs(float64(x - z)))
	
	// Calculate the absolute difference between y and z
	dyz := int(math.Abs(float64(y - z)))

	// Compare the differences
	if dxz < dyz {
		return 1 // x is closer to z
	} else if dxz > dyz {
		return 2 // y is closer to z
	} else {
		return 0 // Both are equally close to z
	}
}
