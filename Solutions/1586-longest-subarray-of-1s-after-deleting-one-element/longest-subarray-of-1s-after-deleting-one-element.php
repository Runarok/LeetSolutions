class Solution {

    /**
     * Finds the length of the longest subarray of 1s after deleting one element.
     *
     * @param Integer[] $nums - An array of binary digits (0s and 1s)
     * @return Integer - The length of the longest subarray
     */
    function longestSubarray($nums) {
        // Count of zeroes in the current window
        $zeroCount = 0;

        // Maximum length of a valid subarray found so far
        $longestWindow = 0;

        // Left boundary of the sliding window
        $start = 0;

        // Iterate through the array with the right boundary of the window
        for ($i = 0; $i < count($nums); $i++) {
            // If the current element is 0, increase zeroCount
            if ($nums[$i] == 0) {
                $zeroCount++;
            }

            // If there are more than one 0 in the window,
            // move the left side (start) forward to remove 0s
            while ($zeroCount > 1) {
                if ($nums[$start] == 0) {
                    $zeroCount--;
                }
                $start++; // Shrink the window from the left
            }

            // Calculate the current valid window length
            // We subtract start from i, not i - start + 1,
            // because we are supposed to remove one element
            $longestWindow = max($longestWindow, $i - $start);
        }

        return $longestWindow;
    }
}
