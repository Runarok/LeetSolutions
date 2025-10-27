object Solution {
    def numberOfBeams(bank: Array[String]): Int = {
        // Step 1: Convert each row (string) into the count of '1's it contains.
        // Example: "011001" -> 3
        val deviceCounts = bank.map(row => row.count(_ == '1'))

        // Step 2: Filter out all rows that have 0 devices (they break beams).
        // Example: Array(3, 0, 2, 1) -> Array(3, 2, 1)
        val nonEmptyRows = deviceCounts.filter(_ > 0)

        // Step 3: Initialize a variable to hold the total number of beams.
        var totalBeams = 0

        // Step 4: Go through each *pair of consecutive* non-empty rows.
        // Multiply the number of devices in row i by row i+1
        for (i <- 0 until nonEmptyRows.length - 1) {
            val beamsBetweenRows = nonEmptyRows(i) * nonEmptyRows(i + 1)
            totalBeams += beamsBetweenRows
        }

        // Step 5: Return the total count of beams.
        totalBeams
    }
}
