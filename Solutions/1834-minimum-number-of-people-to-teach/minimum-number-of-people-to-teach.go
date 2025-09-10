func minimumTeachings(n int, languages [][]int, friendships [][]int) int {
    // Step 1: Build a map from user to set of languages they know
    userLangs := make(map[int]map[int]bool)
    for i := 0; i < len(languages); i++ {
        userLangs[i+1] = make(map[int]bool)
        for _, lang := range languages[i] {
            userLangs[i+1][lang] = true
        }
    }

    // Step 2: Identify users in problematic friendships (cannot currently communicate)
    toTeach := make(map[int]bool) // set of users we might need to teach
    for _, pair := range friendships {
        u, v := pair[0], pair[1]
        // Check if u and v share any common language
        canCommunicate := false
        for lang := range userLangs[u] {
            if userLangs[v][lang] {
                canCommunicate = true
                break
            }
        }
        // If not, mark both users as needing possible teaching
        if !canCommunicate {
            toTeach[u] = true
            toTeach[v] = true
        }
    }

    // Step 3: Try teaching each language to fix all problematic friendships
    minTeachCount := len(languages) // worst case: teach everyone
    for lang := 1; lang <= n; lang++ {
        count := 0
        for user := range toTeach {
            // If user does not already know this language, we need to teach them
            if !userLangs[user][lang] {
                count++
            }
        }
        if count < minTeachCount {
            minTeachCount = count
        }
    }

    return minTeachCount
}
