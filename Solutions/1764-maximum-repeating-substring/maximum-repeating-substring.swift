class Solution {
    func maxRepeating(_ sequence: String, _ word: String) -> Int {

        // This variable keeps track of how many times
        // the word can be repeated consecutively
        // and still be found inside the sequence
        var count = 0

        // This string will store the word repeated
        // count + 1 times during each iteration
        var repeated = word

        // As long as the repeated string exists
        // as a substring of the sequence,
        // we can increase the repeating count
        while sequence.contains(repeated) {

            // We found a valid k-repeating substring
            count += 1

            // Append the word again to check
            // for the next higher k value
            repeated += word
        }

        // When the loop ends, count contains
        // the maximum k-repeating value
        return count
    }
}
