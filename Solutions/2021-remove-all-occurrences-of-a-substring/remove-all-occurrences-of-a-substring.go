func removeOccurrences(s string, part string) string {
    for {
        // Find the leftmost occurrence of 'part'
        index := strings.Index(s, part)
        if index == -1 {
            // If 'part' is not found, break the loop
            break
        }
        // Remove the first occurrence of 'part'
        s = s[:index] + s[index+len(part):]
    }
    return s
}
