using System;
using System.Collections.Generic;

public class Solution
{
    // This method rearranges a special binary string to form
    // the lexicographically largest possible special string.
    // A special string:
    // 1. Has equal number of 1s and 0s
    // 2. For every prefix, number of 1s >= number of 0s
    public string MakeLargestSpecial(string InputString)
    {
        // List to store valid special substrings found in the input
        List<string> SpecialSubstrings = new List<string>();

        // Tracks balance between '1' and '0'
        // Increment for '1', decrement for '0'
        int BalanceCount = 0;

        // Marks the start index of a potential special substring
        int StartIndex = 0;

        // Iterate through the input string
        for (int Index = 0; Index < InputString.Length; Index++)
        {
            // Update balance counter
            if (InputString[Index] == '1')
                BalanceCount++;
            else
                BalanceCount--;

            // When balance becomes zero, we found a valid special substring
            if (BalanceCount == 0)
            {
                // Extract inner part (excluding outer 1 and 0)
                string InnerSubstring = InputString.Substring(StartIndex + 1, Index - StartIndex - 1);

                // Recursively make the inner substring lexicographically largest
                InnerSubstring = MakeLargestSpecial(InnerSubstring);

                // Rebuild the special substring and add to list
                SpecialSubstrings.Add("1" + InnerSubstring + "0");

                // Move start index to next position
                StartIndex = Index + 1;
            }
        }

        // Sort substrings in descending lexicographical order
        // to maximize final string
        SpecialSubstrings.Sort((First, Second) => 
            string.Compare(Second, First, StringComparison.Ordinal));

        // Concatenate all sorted special substrings
        return string.Join("", SpecialSubstrings);
    }
}