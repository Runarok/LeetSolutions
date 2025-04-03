class Solution {
    fun canBeValid(s: String, locked: String): Boolean {
        // If the length is odd, it's impossible to form a valid parentheses string
        if (s.length % 2 != 0) return false

        // First pass: left to right to check for unmatched closing parentheses
        var balance = 0
        for (i in s.indices) {
            // If it's an open parenthesis or we can change it to one
            if (s[i] == '(' || locked[i] == '0') {
                balance += 1
            } else {
                balance -= 1
            }
            
            // If balance goes negative, there are more closing parentheses than opening ones
            if (balance < 0) {
                return false
            }
        }

        // Second pass: right to left to check for unmatched opening parentheses
        balance = 0
        for (i in s.indices.reversed()) {
            // If it's a closing parenthesis or we can change it to one
            if (s[i] == ')' || locked[i] == '0') {
                balance += 1
            } else {
                balance -= 1
            }
            
            // If balance goes negative, there are more opening parentheses than closing ones
            if (balance < 0) {
                return false
            }
        }

        return true
    }
}
