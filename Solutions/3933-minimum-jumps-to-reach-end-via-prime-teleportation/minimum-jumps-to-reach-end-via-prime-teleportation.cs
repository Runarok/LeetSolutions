public class Solution
{
    public int MinJumps(int[] nums)
    {
        int n = nums.Length;

        // If array has only one element,
        // we are already at the destination.
        if (n == 1)
            return 0;

        // ------------------------------------------------------------
        // STEP 1:
        // Build smallest prime factor (SPF) sieve up to max value.
        //
        // This helps us:
        // 1. Check if a number is prime quickly.
        // 2. Get prime factors efficiently.
        // ------------------------------------------------------------

        int maxVal = 0;

        foreach (int x in nums)
            maxVal = Math.Max(maxVal, x);

        int[] spf = new int[maxVal + 1];

        // Initialize SPF
        for (int i = 0; i <= maxVal; i++)
            spf[i] = i;

        // Sieve
        for (int i = 2; i * i <= maxVal; i++)
        {
            if (spf[i] == i) // i is prime
            {
                for (int j = i * i; j <= maxVal; j += i)
                {
                    if (spf[j] == j)
                        spf[j] = i;
                }
            }
        }

        // ------------------------------------------------------------
        // STEP 2:
        // Build:
        //
        // prime -> list of indices divisible by that prime
        //
        // Example:
        // nums = [2,4,6]
        //
        // primeToIndices[2] = [0,1,2]
        // primeToIndices[3] = [2]
        //
        // This allows instant teleport lookup.
        // ------------------------------------------------------------

        Dictionary<int, List<int>> primeToIndices = new Dictionary<int, List<int>>();

        for (int i = 0; i < n; i++)
        {
            int value = nums[i];

            // Get unique prime factors
            HashSet<int> factors = GetPrimeFactors(value, spf);

            foreach (int p in factors)
            {
                if (!primeToIndices.ContainsKey(p))
                    primeToIndices[p] = new List<int>();

                primeToIndices[p].Add(i);
            }
        }

        // ------------------------------------------------------------
        // STEP 3:
        // BFS (shortest path in unweighted graph)
        //
        // Each index = node
        // Adjacent moves cost 1
        // Teleport moves cost 1
        //
        // BFS guarantees minimum jumps.
        // ------------------------------------------------------------

        Queue<int> queue = new Queue<int>();

        // Distance array
        int[] dist = new int[n];

        for (int i = 0; i < n; i++)
            dist[i] = -1;

        // Start from index 0
        dist[0] = 0;
        queue.Enqueue(0);

        // ------------------------------------------------------------
        // To avoid processing the SAME prime teleportation
        // multiple times, we keep a set:
        //
        // Example:
        // If prime 2 teleport list has already been used once,
        // we should never scan it again.
        //
        // Otherwise complexity can explode.
        // ------------------------------------------------------------

        HashSet<int> usedPrimeTeleport = new HashSet<int>();

        // ------------------------------------------------------------
        // BFS LOOP
        // ------------------------------------------------------------

        while (queue.Count > 0)
        {
            int i = queue.Dequeue();

            int currentSteps = dist[i];

            // If we reached the end, return answer.
            if (i == n - 1)
                return currentSteps;

            // --------------------------------------------------------
            // OPTION 1:
            // Move to i - 1
            // --------------------------------------------------------

            int left = i - 1;

            if (left >= 0 && dist[left] == -1)
            {
                dist[left] = currentSteps + 1;
                queue.Enqueue(left);
            }

            // --------------------------------------------------------
            // OPTION 2:
            // Move to i + 1
            // --------------------------------------------------------

            int right = i + 1;

            if (right < n && dist[right] == -1)
            {
                dist[right] = currentSteps + 1;
                queue.Enqueue(right);
            }

            // --------------------------------------------------------
            // OPTION 3:
            // Prime teleportation
            //
            // We can teleport ONLY IF nums[i] itself is prime.
            //
            // A number is prime if:
            // nums[i] > 1 AND spf[value] == value
            // --------------------------------------------------------

            int value = nums[i];

            bool isPrime = value > 1 && spf[value] == value;

            if (isPrime)
            {
                int prime = value;

                // If we already used this prime teleport once,
                // skip it.
                //
                // Important optimization.
                if (!usedPrimeTeleport.Contains(prime))
                {
                    usedPrimeTeleport.Add(prime);

                    // Teleport to all indices divisible by prime
                    if (primeToIndices.ContainsKey(prime))
                    {
                        foreach (int nextIndex in primeToIndices[prime])
                        {
                            // Cannot teleport to same index
                            if (nextIndex == i)
                                continue;

                            if (dist[nextIndex] == -1)
                            {
                                dist[nextIndex] = currentSteps + 1;
                                queue.Enqueue(nextIndex);
                            }
                        }
                    }
                }
            }
        }

        // Problem guarantees reachability through adjacent moves,
        // but return -1 for safety.
        return -1;
    }

    // ------------------------------------------------------------
    // Returns UNIQUE prime factors of a number
    //
    // Example:
    // 12 -> {2,3}
    // ------------------------------------------------------------
    private HashSet<int> GetPrimeFactors(int x, int[] spf)
    {
        HashSet<int> factors = new HashSet<int>();

        while (x > 1)
        {
            int p = spf[x];

            factors.Add(p);

            while (x % p == 0)
                x /= p;
        }

        return factors;
    }
}