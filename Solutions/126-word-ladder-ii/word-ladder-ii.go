func findLadders(beginWord string, endWord string, wordList []string) [][]string {
    // ------------------------------------------------------------
    // OPTIMIZED BFS + DFS SOLUTION FOR WORD LADDER II
    // ------------------------------------------------------------

    // Build a set of words from wordList for O(1) lookups
    wordSet := make(map[string]bool)
    for _, w := range wordList {
        wordSet[w] = true // mark each word as available
    }

    // If endWord is not in the dictionary, no solution exists
    if !wordSet[endWord] {
        return [][]string{}
    }

    wordLen := len(beginWord) // length of each word

    // Preprocess wildcard patterns for efficient neighbor generation
    wildcard := make(map[string][]string)
    addWord := func(word string) {
        for i := 0; i < wordLen; i++ {
            key := word[:i] + "*" + word[i+1:] // wildcard pattern: replace i-th letter with *
            wildcard[key] = append(wildcard[key], word) // map pattern to word
        }
    }

    // Add all words from wordList and beginWord
    for _, w := range wordList {
        addWord(w) // map wildcards for each word
    }
    addWord(beginWord) // include beginWord in wildcard map

    // BFS setup
    queue := []string{beginWord}      // queue for BFS traversal
    distance := make(map[string]int)  // shortest distance from beginWord to each word
    distance[beginWord] = 0           // beginWord distance is 0
    parents := make(map[string][]string) // track parents for reconstructing paths

    found := false // flag to stop BFS after reaching shortest path to endWord
    level := 0     // current BFS level

    // BFS: traverse level by level
    for len(queue) > 0 && !found {
        level++ // increment BFS level
        size := len(queue)                  // number of nodes at current level
        visitedThisLevel := make(map[string]bool) // track words visited in this level

        for i := 0; i < size; i++ {
            curr := queue[0] // current word
            queue = queue[1:] // dequeue

            // Generate neighbors using wildcard patterns
            for j := 0; j < wordLen; j++ {
                key := curr[:j] + "*" + curr[j+1:] // wildcard for position j

                for _, next := range wildcard[key] { // all words matching this pattern

                    // If next word not visited before
                    if _, ok := distance[next]; !ok {
                        distance[next] = level          // record its distance
                        parents[next] = append(parents[next], curr) // add parent
                        visitedThisLevel[next] = true  // mark visited in this level
                        queue = append(queue, next)    // enqueue next word

                        if next == endWord { // found shortest path to endWord
                            found = true // stop BFS after current level
                        }

                    } else if distance[next] == level { // already seen this level
                        parents[next] = append(parents[next], curr) // another shortest parent
                    }
                }
            }
        }
    }

    // If endWord is unreachable, return empty result
    if !found {
        return [][]string{}
    }

    // ------------------------------------------------------------
    // DFS BACKTRACKING FROM endWord TO beginWord TO RECONSTRUCT PATHS
    // ------------------------------------------------------------
    results := [][]string{} // final results
    path := []string{endWord} // current path being explored

    var dfs func(word string) // recursive DFS function
    dfs = func(word string) {
        if word == beginWord { // base case: reached start
            seq := make([]string, len(path)) // create new slice for path
            // reverse path to start from beginWord
            for i := 0; i < len(path); i++ {
                seq[i] = path[len(path)-1-i] // reverse copy
            }
            results = append(results, seq) // store result
            return
        }

        // iterate over all parent words on shortest path
        for _, p := range parents[word] {
            path = append(path, p) // add parent to current path
            dfs(p)                  // recurse
            path = path[:len(path)-1] // backtrack
        }
    }

    dfs(endWord) // start DFS from endWord

    return results // return all shortest transformation sequences
}
