class Solution {
    fun groupAnagrams(strs: Array<String>): List<List<String>> {

        // The key will represent the frequency of every
        // lowercase English character.
        //
        // For example:
        //
        // "eat"
        //
        // a -> 1
        // e -> 1
        // t -> 1
        //
        // The key becomes something like:
        //
        // [1, 0, 0, 0, 1, 0, ..., 1, ...]
        //
        // Every anagram will have exactly the same frequency
        // array, so they will get placed into the same group.
        val map = HashMap<List<Int>, MutableList<String>>()

        // Process every string in the input.
        for (str in strs) {

            // There are exactly 26 lowercase English letters.
            //
            // counts[0] = number of 'a'
            // counts[1] = number of 'b'
            // counts[2] = number of 'c'
            // ...
            // counts[25] = number of 'z'
            val counts = IntArray(26)

            // Count the frequency of every character
            // in the current string.
            for (c in str) {

                // Convert the character into an index.
                //
                // For example:
                //
                // 'a' - 'a' = 0
                // 'b' - 'a' = 1
                // 'c' - 'a' = 2
                //
                // So every character maps to a position
                // from 0 to 25.
                counts[c - 'a']++
            }

            // Kotlin's List can be used as a HashMap key.
            //
            // We convert the IntArray into a List so that
            // the frequency information can be used as
            // the key in the map.
            val key = counts.toList()

            // If this key already exists, add the current
            // string to its existing anagram group.
            //
            // Otherwise, create a new group containing
            // the current string.
            map.getOrPut(key) {
                mutableListOf()
            }.add(str)
        }

        // The values of the map are exactly the groups
        // of anagrams that we need to return.
        return map.values.toList()
    }
}