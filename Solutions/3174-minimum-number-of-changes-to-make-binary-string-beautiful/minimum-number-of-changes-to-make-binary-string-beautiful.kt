
class Solution {
    fun minChanges(s: String): Int {
        var changes = 0

        for (i in s.indices step 2) {
            if (s[i] != s[i + 1]) {
                changes++
            }
        }

        return changes
    }
}
