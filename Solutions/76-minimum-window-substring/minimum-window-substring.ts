function minWindow(s: string, t: string): string {
    // if t is longer than s, no valid window can exist
    if (t.length > s.length) return "";

    // frequency map for characters in t
    const need: Map<string, number> = new Map();

    // populate the need map with character counts from t
    for (const char of t) {
        need.set(char, (need.get(char) || 0) + 1);
    }

    // number of unique characters in t that must be satisfied
    let required = need.size;

    // sliding window frequency map
    const window: Map<string, number> = new Map();

    // number of characters that currently satisfy the required frequency
    let formed = 0;

    // left and right pointers for the sliding window
    let left = 0;
    let right = 0;

    // array to store the best window found: [windowLength, leftIndex, rightIndex]
    let ans: [number, number, number] = [Infinity, 0, 0];

    // expand the window by moving the right pointer
    while (right < s.length) {
        const char = s[right];

        // add current character to the window frequency map
        window.set(char, (window.get(char) || 0) + 1);

        // if the current character's frequency matches the required frequency
        if (need.has(char) && window.get(char) === need.get(char)) {
            formed++;
        }

        // try to contract the window while it remains valid
        while (left <= right && formed === required) {
            // update the answer if this window is smaller than previously found ones
            if (right - left + 1 < ans[0]) {
                ans = [right - left + 1, left, right];
            }

            const leftChar = s[left];

            // remove the leftmost character from the window
            window.set(leftChar, (window.get(leftChar) || 0) - 1);

            // if removing this character breaks the required condition
            if (need.has(leftChar) && window.get(leftChar)! < need.get(leftChar)!) {
                formed--;
            }

            // move the left pointer forward to shrink the window
            left++;
        }

        // move the right pointer forward to expand the window
        right++;
    }

    // if no valid window was found, return empty string
    if (ans[0] === Infinity) return "";

    // return the minimum window substring
    return s.substring(ans[1], ans[2] + 1);
}
