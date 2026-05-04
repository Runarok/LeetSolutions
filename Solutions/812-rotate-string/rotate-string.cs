public class Solution {
    public bool RotateString(string s, string goal) {
        
        // -------------------------------
        // STEP 1: LENGTH CHECK
        // -------------------------------
        // If lengths are different, it's impossible
        // to form goal by rotating s
        if (s.Length != goal.Length) {
            return false;
        }

        // -------------------------------
        // STEP 2: CONCATENATE STRING
        // -------------------------------
        // Create a new string that contains all possible rotations
        // Example: "abcde" -> "abcdeabcde"
        string doubled = s + s;

        // -------------------------------
        // STEP 3: CHECK SUBSTRING
        // -------------------------------
        // If goal is a rotation of s,
        // it must appear inside doubled string
        if (doubled.Contains(goal)) {
            return true;
        }

        // Otherwise, not a valid rotation
        return false;
    }
}