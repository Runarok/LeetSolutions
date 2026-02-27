public class Solution 
{
    public int NumSteps(string s) 
    {
        // Number of steps required
        int steps = 0;
        
        // This variable represents whether we have a carry
        // caused by a previous "add 1" operation
        int carry = 0;
        
        // Traverse from right to left (ignore the first bit for now)
        // because we stop once we reach the most significant bit
        for (int i = s.Length - 1; i > 0; i--)
        {
            // Convert current character to integer (0 or 1)
            int currentBit = (s[i] - '0') + carry;
            
            // If currentBit is even (0 or 2)
            if (currentBit % 2 == 0)
            {
                // Even number → divide by 2
                // This costs 1 step
                steps += 1;
            }
            else
            {
                // Odd number → we must add 1
                // Adding 1 costs 1 step
                // After adding 1, number becomes even
                // Then we divide by 2 → another step
                steps += 2;
                
                // Since we added 1 to a 1-bit,
                // we generate a carry for the next position
                carry = 1;
            }
        }
        
        // After finishing all bits except the first:
        // If carry == 1, we need one extra step
        // Example: "111" → becomes "1000"
        return steps + carry;
    }
}