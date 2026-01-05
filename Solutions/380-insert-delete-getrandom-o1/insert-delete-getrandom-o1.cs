using System;
using System.Collections.Generic;

public class RandomizedSet
{
    // Dictionary to store value → index in the list
    private Dictionary<int, int> dict;
    
    // List to store the values for O(1) random access
    private List<int> list;
    
    // Random number generator for getRandom
    private Random rand;

    // Constructor: initialize data structures
    public RandomizedSet()
    {
        dict = new Dictionary<int, int>(); // value → index mapping
        list = new List<int>();            // list of values
        rand = new Random();               // random number generator
    }

    // Inserts a value to the set. Returns true if the set did not already contain the specified element
    public bool Insert(int val)
    {
        // If val already exists in dictionary, return false
        if (dict.ContainsKey(val))
            return false;

        // Add val to the end of the list
        list.Add(val);

        // Store the index of val in the dictionary
        dict[val] = list.Count - 1;

        // Successfully inserted
        return true;
    }

    // Removes a value from the set. Returns true if the set contained the specified element
    public bool Remove(int val)
    {
        // If val does not exist in dictionary, return false
        if (!dict.ContainsKey(val))
            return false;

        // Get index of the element to remove
        int idxToRemove = dict[val];

        // Get the last element in the list
        int lastElement = list[list.Count - 1];

        // Move the last element to the position of the element to remove
        list[idxToRemove] = lastElement;

        // Update the dictionary for the moved element
        dict[lastElement] = idxToRemove;

        // Remove the last element from the list
        list.RemoveAt(list.Count - 1);

        // Remove the value from the dictionary
        dict.Remove(val);

        // Successfully removed
        return true;
    }

    // Get a random element from the set
    public int GetRandom()
    {
        // Generate a random index from 0 to list.Count - 1
        int idx = rand.Next(list.Count);

        // Return the value at that random index
        return list[idx];
    }
}

/**
 * Example usage:
 * RandomizedSet obj = new RandomizedSet();
 * Console.WriteLine(obj.Insert(1));   // true
 * Console.WriteLine(obj.Remove(2));   // false
 * Console.WriteLine(obj.Insert(2));   // true
 * Console.WriteLine(obj.GetRandom()); // 1 or 2
 * Console.WriteLine(obj.Remove(1));   // true
 * Console.WriteLine(obj.Insert(2));   // false
 * Console.WriteLine(obj.GetRandom()); // 2
 */
