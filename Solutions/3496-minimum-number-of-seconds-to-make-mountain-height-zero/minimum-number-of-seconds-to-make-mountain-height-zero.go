// minNumberOfSeconds calculates the minimum number of seconds required
// to remove a mountain of height `mountainHeight` using workers with
// different work times.
//
// Each worker takes workerTimes[i] seconds for the first unit,
// 2 * workerTimes[i] for the second unit, 3 * workerTimes[i] for the third,
// and so on.
//
// So removing h units takes:
// workerTimes[i] * (1 + 2 + 3 + ... + h)
// = workerTimes[i] * sumOneToN(h)
//
// We binary search on the number of seconds required.
func minNumberOfSeconds(mountainHeight int, workerTimes []int) int64 {

	// Sort workers by time so faster workers are used first.
	// This helps reduce remaining height faster during simulation.
	sort.Ints(workerTimes)

	// Helper function that checks:
	// "Is it possible to remove the entire mountain within `seconds`?"
	isPossible := func(seconds int) bool {

		// Remaining height of the mountain.
		height := mountainHeight

		// Try assigning work to each worker
		for i := 0; i < len(workerTimes) && height > 0; i++ {

			// successCondition checks if worker i can remove `h` units
			// within the given number of seconds.
			successCondition := func(h int) bool {
				// Time required:
				// workerTimes[i] * (1 + 2 + ... + h)
				return workerTimes[i]*sumOneToN(h) <= seconds
			}

			// Binary search to find the maximum h such that
			// worker i can remove h units within `seconds`.
			//
			// sort.Search finds the first index where the condition is TRUE.
			// Here we invert the logic:
			// we search for the first h where successCondition(h) is FALSE.
			maxRemovable := sort.Search(height+1, func(h int) bool {
				return !successCondition(h)
			}) - 1

			// Reduce the mountain height by the amount removed.
			// max(...,0) prevents negative removal.
			height -= max(maxRemovable, 0)
		}

		// If height <= 0, we successfully removed the mountain
		// within the allowed seconds.
		return height <= 0
	}

	// Upper bound for binary search.
	// Worst case: the fastest worker removes the entire mountain alone.
	//
	// Time needed:
	// workerTimes[0] * (1 + 2 + ... + mountainHeight)
	hi := sumOneToN(mountainHeight) * workerTimes[0]

	// Binary search the minimum seconds needed.
	//
	// sort.Search finds the smallest i such that isPossible(i) == true
	return int64(sort.Search(hi, func(i int) bool {
		return isPossible(i)
	}))
}

// sumOneToN calculates the sum:
// 1 + 2 + 3 + ... + n
//
// Formula:
// n * (n + 1) / 2
func sumOneToN(n int) int {
	return (n * (n + 1)) / 2
}