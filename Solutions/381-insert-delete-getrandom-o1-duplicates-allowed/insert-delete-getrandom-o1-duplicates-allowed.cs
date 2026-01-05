using System;
using System.Collections.Generic;

public class RandomizedCollection
{
    // List to store all elements (including duplicates)
    // This allows O(1) random access for getRandom
    private List<int> list;

    // Dictionary mapping a value to a set of indices in the list
    // This allows O(1) insertion and O(1) removal of any occurrence
    private Dictionary<int, HashSet<int>> dict;

    // Random number generator for getRandom
    private Random rand;

    // Constructor: initialize the data structures
    public RandomizedCollection()
    {
        list = new List<int>();                 // store all elements
        dict = new Dictionary<int, HashSet<int>>(); // value -> set of indices in list
        rand = new Random();                    // random number generator
    }

    /// <summary>
    /// Inserts a value into the collection.
    /// Returns true if the value was not already present (first occurrence), false otherwise.
    /// </summary>
    public bool Insert(int val)
    {
        // The value is considered new if it has no occurrences in the collection
        bool isNew = !dict.ContainsKey(val) || dict[val].Count == 0;

        // If the key is missing, initialize the HashSet
        if (!dict.ContainsKey(val))
            dict[val] = new HashSet<int>();

        // Add the index of val (at the end of list)
        dict[val].Add(list.Count);

        // Add val to the list
        list.Add(val);

        return isNew;
    }


    /// <summary>
    /// Removes one occurrence of a value from the collection if present.
    /// Returns true if the value was present, false otherwise.
    /// </summary>
    public bool Remove(int val)
    {
        // If val does not exist or has no occurrences, return false
        if (!dict.ContainsKey(val) || dict[val].Count == 0)
            return false;

        // Get an arbitrary index of val to remove
        int idxToRemove = 0;
        foreach (var idx in dict[val])
        {
            idxToRemove = idx;
            break; // take any index
        }

        // Remove that index from the set of indices for val
        dict[val].Remove(idxToRemove);

        // Get the last element in the list
        int lastElement = list[list.Count - 1];

        // Move the last element to the position of the element to remove (if not the same element)
        list[idxToRemove] = lastElement;

        // Update the index set for the last element
        dict[lastElement].Add(idxToRemove);         // add new index
        dict[lastElement].Remove(list.Count - 1);  // remove old index

        // Remove the last element from the list
        list.RemoveAt(list.Count - 1);

        return true;
    }

    /// Returns a random element from the collection.
    /// Each element is returned with probability proportional to its occurrences.
    public int GetRandom()
    {
        // Generate a random index between 0 and list.Count - 1
        int idx = rand.Next(list.Count);

        // Return the value at that index
        return list[idx];
    }
}

/**
 * Example usage:
 * RandomizedCollection obj = new RandomizedCollection();
 * Console.WriteLine(obj.Insert(1));   // true (first occurrence)
 * Console.WriteLine(obj.Insert(1));   // false (duplicate)
 * Console.WriteLine(obj.Insert(2));   // true
 * Console.WriteLine(obj.GetRandom()); // 1 (2/3 probability) or 2 (1/3 probability)
 * Console.WriteLine(obj.Remove(1));   // true (removes one occurrence of 1)
 * Console.WriteLine(obj.GetRandom()); // 1 or 2
 */
