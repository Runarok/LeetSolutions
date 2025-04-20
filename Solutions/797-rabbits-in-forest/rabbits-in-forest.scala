object Solution {
    def numRabbits(answers: Array[Int]): Int = {
        // Create a map to count the occurrences of each answer
        val countMap = scala.collection.mutable.Map[Int, Int]()
        
        // Count how many rabbits gave each answer
        for (answer <- answers) {
            countMap(answer) = countMap.getOrElse(answer, 0) + 1
        }

        // Initialize the minimum number of rabbits
        var totalRabbits = 0
        
        // For each unique answer, calculate the number of rabbits required
        for ((answer, count) <- countMap) {
            // Each group consists of answer + 1 rabbits
            val groupSize = answer + 1
            // Calculate how many full groups can be formed
            val fullGroups = (count + groupSize - 1) / groupSize
            // Add fullGroups * groupSize to the total number of rabbits
            totalRabbits += fullGroups * groupSize
        }

        totalRabbits
    }
}
