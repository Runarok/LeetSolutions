class Solution {

    fun addBinary(a: String, b: String): String {

        // Determine the maximum length between the two binary strings.
        // We will iterate up to this size to ensure we process all digits.
        val size = if (a.length > b.length) a.length else b.length

        // StringBuilder is used for efficient string construction.
        // We append digits in reverse order and reverse at the end.
        val builder = StringBuilder()

        // 'temp' will store the carry value during addition.
        // It acts as both:
        // 1) The running sum of current bits
        // 2) The carry for the next iteration
        var temp = 0

        // Loop through each digit starting from the least significant bit (rightmost)
        for (i in 0 until size) {

            // If current index exists in string 'a',
            // take the digit from the end (right side)
            // Convert Char to Int using - '0'
            if (i < a.length) {
                temp += a[a.lastIndex - i] - '0'
            }

            // If current index exists in string 'b',
            // take the digit from the end (right side)
            // Convert Char to Int using - '0'
            if (i < b.length) {
                temp += b[b.lastIndex - i] - '0'
            }

            // Append the current result bit.
            // temp % 2 gives the binary digit (0 or 1)
            builder.append(temp % 2)

            // Update carry.
            // temp / 2 keeps only the carry (either 0 or 1)
            temp /= 2
        }

        // After processing all digits,
        // if carry still remains (temp == 1),
        // append it to the result.
        if (temp == 1) {
            builder.append(temp)
        }

        // Since we built the string from LSB to MSB,
        // reverse it to get the correct binary order.
        return builder.reverse().toString()
    }
}
