func ladderLength(beginWord string, endWord string, wordList []string) int {
    // ------------------------------------------------------------
    // BFS SOLUTION TO FIND LENGTH OF SHORTEST TRANSFORMATION SEQUENCE
    // ------------------------------------------------------------

    // Build a set from wordList for O(1) lookups
    wordSet := make(map[string]bool)
    for _, w := range wordList {
        wordSet[w] = true // mark each word as available
    }

    // If endWord not in dictionary, no transformation exists
    if !wordSet[endWord] {
        return 0
    }

    wordLen := len(beginWord) // length of each word

    // BFS queue stores current word and current transformation length
    type pair struct {
        word string
        length int
    }

    queue := []pair{{beginWord, 1}} // start BFS with beginWord length = 1
    visited := make(map[string]bool) // track visited words
    visited[beginWord] = true

    // BFS traversal
    for len(queue) > 0 {
        currPair := queue[0] // dequeue
        queue = queue[1:]

        currWord := currPair.word
        currLen := currPair.length

        // Generate neighbors by changing one letter at each position
        for i := 0; i < wordLen; i++ {
            for c := 'a'; c <= 'z'; c++ {
                if byte(c) == currWord[i] { // skip same character
                    continue
                }

                // Create next word by replacing i-th character
                next := currWord[:i] + string(c) + currWord[i+1:]

                // If next word is the target, return current length + 1
                if next == endWord {
                    return currLen + 1
                }

                // If next word is in wordSet and not visited, enqueue it
                if wordSet[next] && !visited[next] {
                    visited[next] = true
                    queue = append(queue, pair{next, currLen + 1})
                }
            }
        }
    }

    // If BFS completes without finding endWord, return 0
    return 0
}
