class Solution {
    fun minimumEffort(tasks: Array<IntArray>): Int {

        /*
            Greedy Idea:
            ------------
            Each task = [actual, minimum]

            actual  -> energy spent after completing task
            minimum -> minimum energy required before starting task

            We want the MINIMUM initial energy.

            Key Observation:
            ----------------
            Suppose we have two tasks:
                A = [a1, m1]
                B = [a2, m2]

            Which should come first?

            If we do A before B:
                required = max(m1, a1 + m2)

            If we do B before A:
                required = max(m2, a2 + m1)

            Optimal ordering:
                Sort by (minimum - actual) descending.

            Why?
            -----
            Tasks with larger "extra requirement"
            should be done earlier while we still
            have high energy.

            Example:
                [4, 8]  -> diff = 4
                [1, 2]  -> diff = 1

            Do [4,8] first.

            After sorting:
            We simulate the process.

            Let:
                energy = current available energy
                answer = minimum initial energy needed

            For each task:
                if energy < minimum:
                    add extra energy to answer

                then spend actual energy.
         */

        // Sort by (minimum - actual) descending
        tasks.sortByDescending { it[1] - it[0] }

        var currentEnergy = 0
        var initialEnergyNeeded = 0

        for (task in tasks) {

            val actual = task[0]
            val minimum = task[1]

            /*
                If current energy is not enough
                to start this task,
                increase initial energy.
             */
            if (currentEnergy < minimum) {

                val extraNeeded = minimum - currentEnergy

                initialEnergyNeeded += extraNeeded
                currentEnergy += extraNeeded
            }

            // Complete the task
            currentEnergy -= actual
        }

        return initialEnergyNeeded
    }
}