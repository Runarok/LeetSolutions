func findAllPeople(n int, meetings [][]int, firstPerson int) []int {

    // ------------------------------------------------------------
    // Step 1: Track who knows the secret
    // ------------------------------------------------------------
    // known[i] == true means person i currently knows the secret
    known := make([]bool, n)

    // Person 0 starts with the secret
    known[0] = true

    // Person firstPerson receives the secret at time 0
    known[firstPerson] = true

    // ------------------------------------------------------------
    // Step 2: Sort meetings by time
    // ------------------------------------------------------------
    // This allows us to process meetings chronologically
    sort.Slice(meetings, func(i, j int) bool {
        return meetings[i][2] < meetings[j][2]
    })

    // ------------------------------------------------------------
    // Step 3: Process meetings grouped by the same time
    // ------------------------------------------------------------
    i := 0
    for i < len(meetings) {

        // All meetings with the same time will be processed together
        time := meetings[i][2]

        // --------------------------------------------------------
        // Temporary graph for THIS time only
        // --------------------------------------------------------
        graph := make(map[int][]int)

        // Collect all people involved at this time
        participants := make(map[int]bool)

        j := i
        for j < len(meetings) && meetings[j][2] == time {
            x := meetings[j][0]
            y := meetings[j][1]

            // Undirected edge (meeting allows sharing both ways)
            graph[x] = append(graph[x], y)
            graph[y] = append(graph[y], x)

            participants[x] = true
            participants[y] = true

            j++
        }

        // --------------------------------------------------------
        // Step 4: BFS from people who already know the secret
        // --------------------------------------------------------
        queue := []int{}

        // Initialize BFS queue with participants who already know
        for person := range participants {
            if known[person] {
                queue = append(queue, person)
            }
        }

        // Standard BFS
        for len(queue) > 0 {
            curr := queue[0]
            queue = queue[1:]

            for _, neighbor := range graph[curr] {
                // If neighbor doesn't know yet, teach them
                if !known[neighbor] {
                    known[neighbor] = true
                    queue = append(queue, neighbor)
                }
            }
        }

        // Move to the next group of meetings
        i = j
    }

    // ------------------------------------------------------------
    // Step 5: Collect all people who know the secret
    // ------------------------------------------------------------
    result := []int{}
    for i := 0; i < n; i++ {
        if known[i] {
            result = append(result, i)
        }
    }

    return result
}
